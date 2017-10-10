Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1e217Q-0001PU-Pp
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1e217N-0000Z9-KO
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1e217N-0000Yv-B4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:27:09 -0400
Date: Tue, 10 Oct 2017 14:27:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171010142703.19e50e0d@t450s.home>
In-Reply-To: <20171010140334.8231-6-kraxel@redhat.com>
References: <20171010140334.8231-1-kraxel@redhat.com>
	<20171010140334.8231-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH 5/6] vfio/display: adding region support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

[cc +Kirti]

On Tue, 10 Oct 2017 16:03:33 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Wire up region-based display.  UNTESTED.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/vfio/pci.h     |  6 ++++
>  hw/vfio/display.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 3c1b0a33ab..c03c4b3eb0 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -146,6 +146,12 @@ typedef struct VFIOPCIDevice {
>      bool no_kvm_intx;
>      bool no_kvm_msi;
>      bool no_kvm_msix;
> +    /* vgpu local display */
> +    QemuConsole *display_con;
> +    uint32_t region_index;
> +    uint32_t region_size;
> +    void *region_mmap;
> +    DisplaySurface *region_surface;

A structure for these might be nice.

>  } VFIOPCIDevice;
>  
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 064ec95f3e..8211bcc6d4 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -18,6 +18,99 @@
>  #include "ui/console.h"
>  #include "pci.h"
>  
> +/* ---------------------------------------------------------------------- */
> +
> +static void vfio_display_region_update(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    struct vfio_device_gfx_plane_info plane;
> +    struct vfio_region_info *region = NULL;
> +    pixman_format_code_t format = PIXMAN_x8r8g8b8;
> +    int ret;
> +
> +    memset(&plane, 0, sizeof(plane));
> +    plane.argsz = sizeof(plane);
> +    plane.flags = VFIO_GFX_PLANE_TYPE_REGION;

Let the compiler zero it?

struct vfio_device_gfx_plane_info plane = { .argsz = sizeof(plane), .flags = VFIO_GFX_PLANE_TYPE_REGION };

> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &plane);
> +    if (ret < 0) {
> +        fprintf(stderr, "ioctl VFIO_DEVICE_QUERY_GFX_PLANE: %s\n",
> +                strerror(errno));

%m?

> +        return;
> +    }
> +    if (!plane.drm_format || !plane.size) {
> +        return;
> +    }
> +    format = qemu_drm_format_to_pixman(plane.drm_format);
> +
> +    if (vdev->region_mmap && vdev->region_index != plane.region_index) {
> +        /* region changed */
> +        munmap(vdev->region_mmap, vdev->region_size);
> +        vdev->region_mmap = NULL;
> +        vdev->region_surface = NULL;
> +    }
> +
> +    if (vdev->region_surface &&
> +        (surface_width(vdev->region_surface) != plane.width ||
> +         surface_height(vdev->region_surface) != plane.height ||
> +         surface_format(vdev->region_surface) != format)) {
> +        /* size changed */
> +        vdev->region_surface = NULL;
> +    }
> +
> +    if (vdev->region_mmap == NULL) {
> +        /* mmap region */
> +        ret = vfio_get_region_info(&vdev->vbasedev, plane.region_index,
> +                                   &region);
> +        if (ret != 0) {
> +            fprintf(stderr, "%s: vfio_get_region_info(%d): %s\n",
> +                    __func__, plane.region_index, strerror(-ret));
> +            return;
> +        }
> +        vdev->region_size = region->size;
> +        vdev->region_mmap = mmap(NULL, region->size,
> +                                 PROT_READ, MAP_SHARED,
> +                                 vdev->vbasedev.fd,
> +                                 region->offset);
> +        if (vdev->region_mmap == MAP_FAILED) {
> +            fprintf(stderr, "%s: mmap region %d: %s\n", __func__,
> +                    plane.region_index, strerror(errno));
> +            vdev->region_mmap = NULL;
> +            g_free(region);
> +            return;
> +        }

Seems like we should really try to use a VFIORegion for this.

> +        g_free(region);
> +    }
> +
> +    if (vdev->region_surface == NULL) {
> +        /* create surface */
> +        vdev->region_surface = qemu_create_displaysurface_from
> +            (plane.width, plane.height, format,
> +             plane.stride, vdev->region_mmap);
> +        dpy_gfx_replace_surface(vdev->display_con, vdev->region_surface);
> +    }
> +
> +    /* full screen update */
> +    dpy_gfx_update(vdev->display_con, 0, 0,
> +                   surface_width(vdev->region_surface),
> +                   surface_height(vdev->region_surface));
> +
> +}
> +
> +static const GraphicHwOps vfio_display_region_ops = {
> +    .gfx_update = vfio_display_region_update,
> +};
> +
> +static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    vdev->display_con = graphic_console_init(DEVICE(vdev), 0,
> +                                             &vfio_display_region_ops,
> +                                             vdev);
> +    /* TODO: disable hotplug (there is no graphic_console_close) */
> +    return 0;
> +}
> +
> +/* ---------------------------------------------------------------------- */
> +
>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
>  {
>      struct vfio_device_gfx_plane_info probe;
> @@ -37,8 +130,7 @@ int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
>      probe.flags = VFIO_GFX_PLANE_TYPE_PROBE | VFIO_GFX_PLANE_TYPE_REGION;
>      ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe);
>      if (ret == 0) {
> -        error_setg(errp, "vfio-display: region support not implemented yet");
> -        return -1;
> +        return vfio_display_region_init(vdev, errp);
>      }
>  
>      error_setg(errp, "vfio: device doesn't support any (known) display method");
