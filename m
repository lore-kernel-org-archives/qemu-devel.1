Received: from eggs.gnu.org ([209.51.188.92]:56341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gkG8n-0002Zb-Hr
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gkG8m-00029K-NZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:28:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gkG8m-00027e-F1
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:28:00 -0500
Date: Thu, 17 Jan 2019 15:27:56 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190117152756.57c64aee@x1.home>
In-Reply-To: <20190111093116.17188-5-kraxel@redhat.com>
References: <20190111093116.17188-1-kraxel@redhat.com>
	<20190111093116.17188-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] vfio/display: delay link up event
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

On Fri, 11 Jan 2019 10:31:15 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Kick the display link up event with a 0.1 sec delay,
> so the guest has a chance to notice the link down first.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/display.c             | 22 ++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ff5c425048..9e29d5810e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -151,6 +151,7 @@ typedef struct VFIODisplay {
>      struct vfio_region_info *edid_info;
>      struct vfio_region_gfx_edid *edid_regs;
>      uint8_t *edid_blob;
> +    QEMUTimer *edid_link_timer;
>      struct {
>          VFIORegion buffer;
>          DisplaySurface *surface;
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 3a10072823..a3a710b3ee 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -37,6 +37,19 @@
>          goto err;
>  
>  
> +static void vfio_display_edid_link_up(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    VFIODisplay *dpy = vdev->dpy;
> +
> +    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
> +    pwrite_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, link_state);
> +    return;
> +
> +err:
> +    fprintf(stderr, "%s: Oops, pwrite error\n", __func__);

Tracing an error_report again, and patchew found a long line somewhere
below.  Thanks,

Alex

> +}
> +
>  static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled, int prefx, int prefy)
>  {
>      VFIODisplay *dpy = vdev->dpy;
> @@ -47,6 +60,7 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled, int pref
>          .prefy = prefy ?: vdev->display_yres,
>      };
>  
> +    timer_del(dpy->edid_link_timer);
>      dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
>      pwrite_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, link_state);
>  
> @@ -72,8 +86,7 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled, int pref
>          goto err;
>      }
>  
> -    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
> -    pwrite_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, link_state);
> +    timer_mod(dpy->edid_link_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 100);
>      return;
>  
>  err:
> @@ -126,6 +139,9 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
>      if (!vdev->display_yres)
>          vdev->display_yres = dpy->edid_regs->max_yres;
>  
> +    dpy->edid_link_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> +                                        vfio_display_edid_link_up, vdev);
> +
>      vfio_display_edid_update(vdev, true, 0, 0);
>      return;
>  
> @@ -143,6 +159,8 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
>  
>      g_free(dpy->edid_regs);
>      g_free(dpy->edid_blob);
> +    timer_del(dpy->edid_link_timer);
> +    timer_free(dpy->edid_link_timer);
>  }
>  
>  static void vfio_display_update_cursor(VFIODMABuf *dmabuf,
