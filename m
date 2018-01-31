Received: from eggs.gnu.org ([2001:4830:134:3::10]:53947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1eh21t-0006T7-7l
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 18:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1eh21q-0002e1-1M
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 18:43:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:56265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1eh21p-0002cX-KJ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 18:42:57 -0500
From: "Zhang, Tina" <tina.zhang@intel.com>
Date: Wed, 31 Jan 2018 23:42:49 +0000
Message-ID: <237F54289DF84E4997F34151298ABEBC7C6B260A@SHSMSX101.ccr.corp.intel.com>
References: <20180131121217.13557-1-kraxel@redhat.com>
	<20180131121217.13557-5-kraxel@redhat.com>
In-Reply-To: <20180131121217.13557-5-kraxel@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RfC PATCH v2 4/5] vfio/display: core & wireup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, Kirti Wankhede <kwankhede@nvidia.com>



> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: Wednesday, January 31, 2018 8:12 PM
> To: qemu-devel@nongnu.org
> Cc: Alex Williamson <alex.williamson@redhat.com>; Zhang, Tina
> <tina.zhang@intel.com>; intel-gvt-dev@lists.freedesktop.org; Kirti Wankhe=
de
> <kwankhede@nvidia.com>; Gerd Hoffmann <kraxel@redhat.com>
> Subject: [RfC PATCH v2 4/5] vfio/display: core & wireup
>=20
> Infrastructure for display support.  Must be enabled using 'display' prop=
erty.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/vfio/pci.h         |  3 +++
>  hw/vfio/display.c     | 51
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c         |  9 +++++++++
>  hw/vfio/Makefile.objs |  2 +-
>  4 files changed, 64 insertions(+), 1 deletion(-)  create mode 100644
> hw/vfio/display.c
>=20
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h index a8fb3b3422..8f3295188c
> 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -130,6 +130,7 @@ typedef struct VFIOPCIDevice {  #define
> VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2  #define
> VFIO_FEATURE_ENABLE_IGD_OPREGION \
>                                  (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_B=
IT)
> +    OnOffAuto display;
>      int32_t bootindex;
>      uint32_t igd_gms;
>      uint8_t pm_cap;
> @@ -169,4 +170,6 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>                                 struct vfio_region_info *info,
>                                 Error **errp);
>=20
> +int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> +
>  #endif /* HW_VFIO_VFIO_PCI_H */
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c new file mode 100644 i=
ndex
> 0000000000..4ba93ea251
> --- /dev/null
> +++ b/hw/vfio/display.c
> @@ -0,0 +1,51 @@
> +/*
> + * display support for mdev based vgpu devices
> + *
> + * Copyright Red Hat, Inc. 2017
> + *
> + * Authors:
> + *    Gerd Hoffmann
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> +See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vfio.h>
> +#include <sys/ioctl.h>
> +
> +#include "sysemu/sysemu.h"
> +#include "ui/console.h"
> +#include "pci.h"
> +
> +int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp) {
> +    struct vfio_device_gfx_plane_info probe;
> +    int ret;
> +
> +    memset(&probe, 0, sizeof(probe));
> +    probe.argsz =3D sizeof(probe);
> +    probe.flags =3D VFIO_GFX_PLANE_TYPE_PROBE |
> VFIO_GFX_PLANE_TYPE_DMABUF;
> +    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe=
);
> +    if (ret =3D=3D 0) {
> +        error_setg(errp, "vfio-display: dmabuf support not implemented y=
et");
> +        return -1;
> +    }
> +
> +    memset(&probe, 0, sizeof(probe));
> +    probe.argsz =3D sizeof(probe);
> +    probe.flags =3D VFIO_GFX_PLANE_TYPE_PROBE |
> VFIO_GFX_PLANE_TYPE_REGION;
> +    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe=
);
> +    if (ret =3D=3D 0) {
> +        error_setg(errp, "vfio-display: region support not implemented y=
et");
> +        return -1;
> +    }
> +
> +    if (vdev->display =3D=3D ON_OFF_AUTO_AUTO) {
> +        /* not an error in automatic mode */
> +        return 0;
> +    }
> +
> +    error_setg(errp, "vfio: device doesn't support any (known) display m=
ethod");
> +    return -1;
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 2c71295125..cd5310c7ce
> 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2873,6 +2873,13 @@ static void vfio_realize(PCIDevice *pdev, Error
> **errp)
>          }
>      }
>=20
> +    if (vdev->display !=3D ON_OFF_AUTO_OFF) {
> +        ret =3D vfio_display_probe(vdev, errp);
> +        if (ret) {
> +            goto out_teardown;
> +        }
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> @@ -2977,6 +2984,8 @@ static void vfio_instance_init(Object *obj)  static
> Property vfio_pci_dev_properties[] =3D {
>      DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>      DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> +    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> +                            display, ON_OFF_AUTO_AUTO),
Not "x-display"?

BR,
Tina
>      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                         intx.mmap_timeout, 1100),
>      DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features, diff --git
> a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs index
> c3ab9097f1..a2e7a0a7cf 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,6 +1,6 @@
>  ifeq ($(CONFIG_LINUX), y)
>  obj-$(CONFIG_SOFTMMU) +=3D common.o
> -obj-$(CONFIG_PCI) +=3D pci.o pci-quirks.o
> +obj-$(CONFIG_PCI) +=3D pci.o pci-quirks.o display.o
>  obj-$(CONFIG_VFIO_CCW) +=3D ccw.o
>  obj-$(CONFIG_SOFTMMU) +=3D platform.o
>  obj-$(CONFIG_VFIO_XGMAC) +=3D calxeda-xgmac.o
> --
> 2.9.3
