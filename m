Received: from eggs.gnu.org ([2001:4830:134:3::10]:47603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fzRKJ-00087P-MY
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fzRKF-0007Dq-EZ
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:54:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fzRKF-0007DS-5X
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B59B87625
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 18:54:17 +0000 (UTC)
Date: Mon, 10 Sep 2018 12:54:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180910125409.2b49be3b@t450s.home>
In-Reply-To: <20180910064340.30745-3-kraxel@redhat.com>
References: <20180910064340.30745-1-kraxel@redhat.com>
	<20180910064340.30745-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, libvir-list@redhat.com

On Mon, 10 Sep 2018 08:43:40 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> So we have a boot display when using a vgpu as primary display.
> 
> Use vfio-pci-ramfb instead of vfio-pci to enable it.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/vfio/display.c             | 12 ++++++++++++
>  hw/vfio/pci.c                 | 15 +++++++++++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 821def0565..0d85a0a6f8 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -26,6 +26,7 @@
>  #include "qemu/queue.h"
>  #include "qemu/notify.h"
>  #include "ui/console.h"
> +#include "hw/display/ramfb.h"
>  #ifdef CONFIG_LINUX
>  #include <linux/vfio.h>
>  #endif
> @@ -146,6 +147,7 @@ typedef struct VFIODMABuf {
>  
>  typedef struct VFIODisplay {
>      QemuConsole *con;
> +    RAMFBState *ramfb;
>      struct {
>          VFIORegion buffer;
>          DisplaySurface *surface;
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 59c0e5d1d7..3901f580c6 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -124,6 +124,9 @@ static void vfio_display_dmabuf_update(void *opaque)
>  
>      primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
>      if (primary == NULL) {
> +        if (dpy->ramfb) {
> +            ramfb_display_update(dpy->con, dpy->ramfb);
> +        }
>          return;
>      }
>  
> @@ -181,6 +184,9 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>      vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
>                                            &vfio_display_dmabuf_ops,
>                                            vdev);
> +    if (strcmp(object_get_typename(OBJECT(vdev)), "vfio-pci-ramfb") == 0) {
> +        vdev->dpy->ramfb = ramfb_setup(errp);
> +    }
>      return 0;
>  }
>  
> @@ -228,6 +234,9 @@ static void vfio_display_region_update(void *opaque)
>          return;
>      }
>      if (!plane.drm_format || !plane.size) {
> +        if (dpy->ramfb) {
> +            ramfb_display_update(dpy->con, dpy->ramfb);
> +        }
>          return;
>      }
>      format = qemu_drm_format_to_pixman(plane.drm_format);
> @@ -300,6 +309,9 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>      vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
>                                            &vfio_display_region_ops,
>                                            vdev);
> +    if (strcmp(object_get_typename(OBJECT(vdev)), "vfio-pci-ramfb") == 0) {
> +        vdev->dpy->ramfb = ramfb_setup(errp);
> +    }
>      return 0;
>  }
>  
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 866f0deeb7..7c0628756e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3258,9 +3258,24 @@ static const TypeInfo vfio_pci_dev_info = {
>      },
>  };
>  
> +static void vfio_pci_ramfb_dev_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->hotpluggable = false;
> +}
> +
> +static const TypeInfo vfio_pci_ramfb_dev_info = {
> +    .name = "vfio-pci-ramfb",
> +    .parent = "vfio-pci",
> +    .instance_size = sizeof(VFIOPCIDevice),
> +    .class_init = vfio_pci_ramfb_dev_class_init,
> +};
> +
>  static void register_vfio_pci_dev_type(void)
>  {
>      type_register_static(&vfio_pci_dev_info);
> +    type_register_static(&vfio_pci_ramfb_dev_info);
>  }
>  
>  type_init(register_vfio_pci_dev_type)


My concern here is still all of the extra tooling that needs to be
added to management layers above QEMU for this device that exists only
because we can't hotplug the primary display in QEMU.  What happens when
we can hotplug the primary display?  Aren't disabling hotplug of a
vfio-pci device and supporting ramfb two separate things?  I think
we're leaking current implementation issues out to the device options
when really we'd rather have a "ramfb" (or perhaps "console") option on
the vfio-pci device and the hotplug capability determined automatically
and available through introspection of the device.  Thanks,

Alex
