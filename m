Received: from eggs.gnu.org ([209.51.188.92]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gkG8k-0002Z9-36
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gkG8j-00026I-0g
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:27:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gkG8i-00024F-O8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:27:56 -0500
Date: Thu, 17 Jan 2019 15:27:48 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190117152748.258b0db5@x1.home>
In-Reply-To: <20190111093116.17188-3-kraxel@redhat.com>
References: <20190111093116.17188-1-kraxel@redhat.com>
	<20190111093116.17188-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] vfio/display: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org

On Fri, 11 Jan 2019 10:31:13 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> This patch adds EDID support to the vfio display (aka vgpu) code.
> When supported by the mdev driver qemu will generate a EDID blob
> and pass it on using the new vfio edid region.  The EDID blob will
> be updated on UI changes (i.e. window resize), so the guest can
> adapt.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/vfio/vfio-common.h |   3 ++
>  hw/vfio/display.c             | 118 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1b434d02f6..ff5c425048 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -148,6 +148,9 @@ typedef struct VFIODMABuf {
>  typedef struct VFIODisplay {
>      QemuConsole *con;
>      RAMFBState *ramfb;
> +    struct vfio_region_info *edid_info;
> +    struct vfio_region_gfx_edid *edid_regs;
> +    uint8_t *edid_blob;
>      struct {
>          VFIORegion buffer;
>          DisplaySurface *surface;
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index dead30e626..0ef4d77e21 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -15,6 +15,7 @@
>  #include <sys/ioctl.h>
>  
>  #include "sysemu/sysemu.h"
> +#include "hw/display/edid.h"
>  #include "ui/console.h"
>  #include "qapi/error.h"
>  #include "pci.h"
> @@ -24,6 +25,120 @@
>  # define DRM_PLANE_TYPE_CURSOR  2
>  #endif
>  
> +#define pread_field(_fd, _reg, _ptr, _fld)                              \
> +    if (sizeof(_ptr->_fld) !=                                           \
> +        pread(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                   \
> +              _reg->offset + offsetof(typeof(*_ptr), _fld)))            \
> +        goto err;
> +#define pwrite_field(_fd, _reg, _ptr, _fld)                             \
> +    if (sizeof(_ptr->_fld) !=                                           \
> +        pwrite(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                  \
> +               _reg->offset + offsetof(typeof(*_ptr), _fld)))           \
> +        goto err;
> +
> +
> +static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled, int prefx, int prefy)

Patchew noted this line too long, please wrap.

> +{
> +    VFIODisplay *dpy = vdev->dpy;
> +    qemu_edid_info edid = {
> +        .maxx  = dpy->edid_regs->max_xres,
> +        .maxy  = dpy->edid_regs->max_yres,
> +        .prefx = prefx,
> +        .prefy = prefy,
> +    };
> +
> +    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
> +    pwrite_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, link_state);
> +
> +    if (!enabled) {
> +        return;
> +    }
> +
> +    if (edid.maxx && edid.prefx > edid.maxx) {
> +        edid.prefx = edid.maxx;
> +    }
> +    if (edid.maxy && edid.prefy > edid.maxy) {
> +        edid.prefy = edid.maxy;
> +    }
> +    qemu_edid_generate(dpy->edid_blob,
> +                       dpy->edid_regs->edid_max_size,
> +                       &edid);
> +
> +    dpy->edid_regs->edid_size = qemu_edid_size(dpy->edid_blob);
> +    pwrite_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, edid_size);
> +    if (pwrite(vdev->vbasedev.fd, dpy->edid_blob, dpy->edid_regs->edid_size,
> +               dpy->edid_info->offset + dpy->edid_regs->edid_offset)
> +        != dpy->edid_regs->edid_size) {
> +        goto err;
> +    }
> +
> +    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
> +    pwrite_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, link_state);
> +    return;
> +
> +err:
> +    fprintf(stderr, "%s: Oops, pwrite error\n", __func__);

These are not the most helpful error messages and ought to be at least
using error_report() rather than dumping directly to stderr.  How about
some tracing support too?  Tracing feature init and link/resolution
state changes could be useful.

> +    return;
> +}
> +
> +static int vfio_display_edid_ui_info(void *opaque, uint32_t idx,
> +                                     QemuUIInfo *info)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    VFIODisplay *dpy = vdev->dpy;
> +
> +    if (!dpy->edid_regs) {
> +        return 0;
> +    }
> +
> +    if (info->width && info->height) {
> +        vfio_display_edid_update(vdev, true, info->width, info->height);
> +    } else {
> +        vfio_display_edid_update(vdev, false, 0, 0);
> +    }
> +
> +    return 0;
> +}
> +
> +static void vfio_display_edid_init(VFIOPCIDevice *vdev)
> +{
> +    VFIODisplay *dpy = vdev->dpy;
> +    int ret;
> +
> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_GFX,
> +                                   VFIO_REGION_SUBTYPE_GFX_EDID,
> +                                   &dpy->edid_info);
> +    if (ret) {
> +        return;
> +    }
> +
> +    dpy->edid_regs = g_new0(struct vfio_region_gfx_edid, 1);
> +    pread_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, edid_offset);
> +    pread_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, edid_max_size);

Patchew didn't like this long line either.

> +    pread_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, max_xres);
> +    pread_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, max_yres);
> +    dpy->edid_blob = g_malloc0(dpy->edid_regs->edid_max_size);
> +
> +    vfio_display_edid_update(vdev, true, 0, 0);
> +    return;
> +
> +err:
> +    fprintf(stderr, "%s: Oops, pread error\n", __func__);
> +    g_free(dpy->edid_regs);
> +    dpy->edid_regs = NULL;
> +    return;
> +}
> +
> +static void vfio_display_edid_exit(VFIODisplay *dpy)
> +{
> +    if (!dpy->edid_regs)
> +        return;

Excessive curly braces as demanded by our style guide please ;)

Thanks,
Alex

> +
> +    g_free(dpy->edid_regs);
> +    g_free(dpy->edid_blob);
> +}
> +
>  static void vfio_display_update_cursor(VFIODMABuf *dmabuf,
>                                         struct vfio_device_gfx_plane_info *plane)
>  {
> @@ -171,6 +286,7 @@ static void vfio_display_dmabuf_update(void *opaque)
>  
>  static const GraphicHwOps vfio_display_dmabuf_ops = {
>      .gfx_update = vfio_display_dmabuf_update,
> +    .ui_info    = vfio_display_edid_ui_info,
>  };
>  
>  static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
> @@ -187,6 +303,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>      if (vdev->enable_ramfb) {
>          vdev->dpy->ramfb = ramfb_setup(errp);
>      }
> +    vfio_display_edid_init(vdev);
>      return 0;
>  }
>  
> @@ -366,5 +483,6 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
>      graphic_console_close(vdev->dpy->con);
>      vfio_display_dmabuf_exit(vdev->dpy);
>      vfio_display_region_exit(vdev->dpy);
> +    vfio_display_edid_exit(vdev->dpy);
>      g_free(vdev->dpy);
>  }
