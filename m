Received: from eggs.gnu.org ([2001:4830:134:3::10]:40344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1f8Nz1-0000hG-2Q
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1f8Nyw-0004rs-U1
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:37:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:46577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1f8Nyw-0004Ij-AO
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:37:02 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Tue, 17 Apr 2018 10:36:53 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D46A18EE3B@SHSMSX101.ccr.corp.intel.com>
References: <1523340161-8928-1-git-send-email-yulei.zhang@intel.com>
	<82e38b24-8675-c7f5-3f37-c73bb14d7804@nvidia.com>
	<20180416141504.3e82a154@w520.home>
In-Reply-To: <20180416141504.3e82a154@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH V4 1/4] vfio: introduce a new VFIO
 subregion for mdev device migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, April 17, 2018 4:15 AM
> To: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Zhang, Yulei <yulei.zhang@intel.com>; qemu-devel@nongnu.org; Tian,
> Kevin <kevin.tian@intel.com>; joonas.lahtinen@linux.intel.com;
> zhenyuw@linux.intel.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> dgilbert@redhat.com; quintela@redhat.com
> Subject: Re: [RFC PATCH V4 1/4] vfio: introduce a new VFIO subregion for
> mdev device migration support
>=20
> On Mon, 16 Apr 2018 20:14:03 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>=20
> > On 4/10/2018 11:32 AM, Yulei Zhang wrote:
> > > New VFIO sub region VFIO_REGION_SUBTYPE_DEVICE_STATE is added
> > > to fetch and restore the status of mdev device vGPU during the
> > > live migration.
> > >
> > > Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> > > ---
> > >  hw/vfio/pci.c              | 25 ++++++++++++++++++++++++-
> > >  hw/vfio/pci.h              |  2 ++
> > >  linux-headers/linux/vfio.h |  9 ++++++---
> > >  3 files changed, 32 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index c977ee3..f98a9dd 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -32,6 +32,7 @@
> > >  #include "pci.h"
> > >  #include "trace.h"
> > >  #include "qapi/error.h"
> > > +#include "migration/blocker.h"
> > >
> > >  #define MSIX_CAP_LENGTH 12
> > >
> > > @@ -2821,6 +2822,25 @@ static void vfio_realize(PCIDevice *pdev, Erro=
r
> **errp)
> > >          vfio_vga_quirk_setup(vdev);
> > >      }
> > >
> > > +    struct vfio_region_info *device_state;
> > > +    /* device state region setup */
> > > +    if (!vfio_get_dev_region_info(&vdev->vbasedev,
> > > +                VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
>=20
> This is not how VENDOR_TYPE is meant to be used.  We have a 32-bit type
> and 32-bit sub-type.  When bit 31 of type is set (ie. VENDOR_TYPE),
> then the low 16-bits (VENDOR_MASK) defines a vendor specific set of
> sub-types.  Using it as above, you're stomping on vendor 0x0000's
> vendor sub-types.  I would expect non-vendor specific types to leave
> bit 31 of the type field clear.  We could then define a universal type
> for device state with a sub-type specifying the API such that we could
> revise the API by providing an updated sub-type.  Or perhaps there are
> devices that want separate save vs restore regions, we could do that
> with the sub-type.

Got it. For the subtype, can we use it to specify how to use the region,
to indicate it can be mmaped or not.=20

>=20
> > > +                VFIO_REGION_SUBTYPE_DEVICE_STATE, &device_state)) {
> > > +        memcpy(&vdev->device_state, device_state,
> > > +               sizeof(struct vfio_region_info));
> > > +        g_free(device_state);
> > > +    } else {
> > > +        error_setg(&vdev->migration_blocker,
> > > +                "Migration disabled: cannot support device state reg=
ion");
> > > +        migrate_add_blocker(vdev->migration_blocker, &err);
>=20
> This appears as if it's going to be rather verbose and generate errors
> for anything not supporting migration, which is currently everything.
> Maybe there should be an OnOffAuto vfio-pci device option for the user
> to specify migration such that if migration=3Don is specified the device
> will fail if it's not available.  Otherwise the default would be auto.
>=20
We only get this error message when we try to migrate the guest with
vfio-pci device which doesn't contain the device_state region, just like=20
currently we set unmigratable=3D1.

> > > +        if (err) {
> > > +            error_propagate(errp, err);
> > > +            error_free(vdev->migration_blocker);
> > > +            goto error;
> > > +        }
> > > +    }
> > > +
> >
> > I think there should be a _PROBE ioctl before trying to setup region fo=
r
> > migration. If vfio device driver or vendor driver for mdev device
> > supports migration capability, _PROBE ioctl should return success along
> > with region's information <index, size> which can be used to setup the
> > region.
>=20
> How is _PROBE different from _REGION_INFO which already exists to tell
> us information about the region?
>=20
> > >      for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> > >          vfio_bar_quirk_setup(vdev, i);
> > >      }
> > > @@ -2884,6 +2904,10 @@ out_teardown:
> > >      vfio_teardown_msi(vdev);
> > >      vfio_bars_exit(vdev);
> > >  error:
> > > +    if (vdev->migration_blocker) {
> > > +        migrate_del_blocker(vdev->migration_blocker);
> > > +        error_free(vdev->migration_blocker);
> > > +    }
> > >      error_prepend(errp, ERR_PREFIX, vdev->vbasedev.name);
> > >  }
> > >
> > > @@ -3009,7 +3033,6 @@ static Property vfio_pci_dev_properties[] =3D {
> > >
> > >  static const VMStateDescription vfio_pci_vmstate =3D {
> > >      .name =3D "vfio-pci",
> > > -    .unmigratable =3D 1,
> >
> > Based on the result of above _PROBE ioctl, 'unmigratable' should be set
> > if vendor driver doesn't support migration capability.
>=20
> .unmigratable isn't really dynamically settable aiui, thus the
> existence of the migration blocker.
>=20
> > >  };
> > >
> > >  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
> > > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > > index 502a575..0ee1724 100644
> > > --- a/hw/vfio/pci.h
> > > +++ b/hw/vfio/pci.h
> > > @@ -116,6 +116,8 @@ typedef struct VFIOPCIDevice {
> > >      VFIOBAR bars[PCI_NUM_REGIONS - 1]; /* No ROM */
> > >      VFIOVGA *vga; /* 0xa0000, 0x3b0, 0x3c0 */
> > >      void *igd_opregion;
> > > +    struct vfio_region_info device_state;
> > > +    Error *migration_blocker;
> > >      PCIHostDeviceAddress host;
> > >      EventNotifier err_notifier;
> > >      EventNotifier req_notifier;
> > > diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> > > index 4312e96..e3380ad 100644
> > > --- a/linux-headers/linux/vfio.h
> > > +++ b/linux-headers/linux/vfio.h
> > > @@ -297,9 +297,12 @@ struct vfio_region_info_cap_type {
> > >  #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
> > >
> > >  /* 8086 Vendor sub-types */
> > > -#define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
> > > -#define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> > > -#define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> > > +#define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION		(1)
> > > +#define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG		(2)
> > > +#define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG		(3)
> > > +
> > > +/* Mdev sub-type for device state save and restore */
> > > +#define VFIO_REGION_SUBTYPE_DEVICE_STATE	(4)
>=20
> This continues on with the 0x8086 vendor sub-types, which is entirely
> unnecessary as each vendor has an entire sub-type address space and we
> shouldn't be using a vendor type anyway.  Additionally, we need
> significantly more documentation on the API for this region.  Thanks,
>=20
> Alex
>=20
> > >
> > >  /**
> > >   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
> > >
