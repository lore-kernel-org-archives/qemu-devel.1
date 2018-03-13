Received: from eggs.gnu.org ([2001:4830:134:3::10]:49265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1evfI0-0004ja-2w
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1evfHw-00085O-4k
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:28:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:63814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1evfHv-00082q-Dl
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:28:04 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Tue, 13 Mar 2018 08:27:42 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D46A0A8E92@SHSMSX101.ccr.corp.intel.com>
References: <1520229653-10658-1-git-send-email-yulei.zhang@intel.com>
	<1520229653-10658-2-git-send-email-yulei.zhang@intel.com>
	<20180309114311.GA3214@work-vm>
In-Reply-To: <20180309114311.GA3214@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V3 1/4] vfio: introduce a new VFIO
 subregion for mdev device migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>



> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Friday, March 9, 2018 7:43 PM
> To: Zhang, Yulei <yulei.zhang@intel.com>
> Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> alex.williamson@redhat.com; kwankhede@nvidia.com;
> zhenyuw@linux.intel.com
> Subject: Re: [Qemu-devel] [PATCH V3 1/4] vfio: introduce a new VFIO
> subregion for mdev device migration support
>=20
> * Yulei Zhang (yulei.zhang@intel.com) wrote:
> > New VFIO sub region VFIO_REGION_SUBTYPE_DEVICE_STATE is added to
> fetch
> > and restore the status of mdev device vGPU during the live migration.
> >
> > Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> > ---
> >  hw/vfio/pci.c              | 14 +++++++++++++-
> >  hw/vfio/pci.h              |  1 +
> >  linux-headers/linux/vfio.h |  9 ++++++---
> >  3 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 31e1edf..2fe20e4
> > 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -37,6 +37,7 @@
> >
> >  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);  static
> > void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
> > +static VMStateDescription vfio_pci_vmstate;
> >
> >  /*
> >   * Disabling BAR mmaping can be slow, but toggling it around INTx can
> > @@ -2813,6 +2814,17 @@ static void vfio_realize(PCIDevice *pdev, Error
> **errp)
> >          vfio_vga_quirk_setup(vdev);
> >      }
> >
> > +    struct vfio_region_info *device_state;
> > +    /* device state region setup */
> > +    if (!vfio_get_dev_region_info(&vdev->vbasedev,
> > +                VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> PCI_VENDOR_ID_INTEL,
> > +                VFIO_REGION_SUBTYPE_DEVICE_STATE, &device_state)) {
> > +        memcpy(&vdev->device_state, device_state,
> > +               sizeof(struct vfio_region_info));
> > +        g_free(device_state);
> > +        vfio_pci_vmstate.unmigratable =3D 0;
> > +    }
>=20
> I don't think we've got any other code that changes the 'unmigratable'
> flag on a vmstate.  If you've got a device that you don't know whether it=
's
> migratable until runtime, then you should add a 'migration blocker'
> if the device isn't migratable.
> See for example the calls to migrate_add_blocker in hw/virtio/vhost.c
>=20
> Dave
>=20
Thanks, I see. We will leave the default value of unmigratable as 0 for=20
vfio pci, and add blocker if the subtype region doesn't exist.=20

> >      for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> >          vfio_bar_quirk_setup(vdev, i);
> >      }
> > @@ -2994,7 +3006,7 @@ static Property vfio_pci_dev_properties[] =3D {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > -static const VMStateDescription vfio_pci_vmstate =3D {
> > +static VMStateDescription vfio_pci_vmstate =3D {
> >      .name =3D "vfio-pci",
> >      .unmigratable =3D 1,
> >  };
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h index a8366bb..6a1d26e
> > 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -116,6 +116,7 @@ typedef struct VFIOPCIDevice {
> >      VFIOBAR bars[PCI_NUM_REGIONS - 1]; /* No ROM */
> >      VFIOVGA *vga; /* 0xa0000, 0x3b0, 0x3c0 */
> >      void *igd_opregion;
> > +    struct vfio_region_info device_state;
> >      PCIHostDeviceAddress host;
> >      EventNotifier err_notifier;
> >      EventNotifier req_notifier;
> > diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> > index 4e7ab4c..c3b8e4a 100644
> > --- a/linux-headers/linux/vfio.h
> > +++ b/linux-headers/linux/vfio.h
> > @@ -296,9 +296,12 @@ struct vfio_region_info_cap_type {
> >  #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
> >
> >  /* 8086 Vendor sub-types */
> > -#define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
> > -#define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> > -#define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> > +#define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION		(1)
> > +#define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG		(2)
> > +#define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG		(3)
> > +
> > +/* Mdev sub-type for device state save and restore */
> > +#define VFIO_REGION_SUBTYPE_DEVICE_STATE	(4)
> >
> >  /**
> >   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
> > --
> > 2.7.4
> >
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
