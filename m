Received: from eggs.gnu.org ([2001:4830:134:3::10]:47696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1ew29e-0004zr-ON
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1ew29J-0008Ru-KD
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:53:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:65237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1ew29J-0008CO-3V
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 04:52:41 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Wed, 14 Mar 2018 08:52:31 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D46A0B04B7@SHSMSX101.ccr.corp.intel.com>
References: <1520229653-10658-1-git-send-email-yulei.zhang@intel.com>
	<1520229653-10658-4-git-send-email-yulei.zhang@intel.com>
	<20180309115928.GB3214@work-vm>
In-Reply-To: <20180309115928.GB3214@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V3 3/4] vfio: Add struct vfio_vmstate_info
 to introduce put/get callback funtion for vfio device status save/restore
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
> Sent: Friday, March 9, 2018 7:59 PM
> To: Zhang, Yulei <yulei.zhang@intel.com>
> Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> alex.williamson@redhat.com; kwankhede@nvidia.com;
> zhenyuw@linux.intel.com
> Subject: Re: [Qemu-devel] [PATCH V3 3/4] vfio: Add struct vfio_vmstate_in=
fo
> to introduce put/get callback funtion for vfio device status save/restore
>=20
> * Yulei Zhang (yulei.zhang@intel.com) wrote:
> > Introduce vfio_device_put/vfio_device_get funtion for vfio device
> > state save/restore usage.
> >
> > For VFIO pci device status migrate, on the source side with funtion
> > vfio_device_put to save the following states 1. pci configuration
> > space addr0~addr5 2. pci configuration space msi_addr msi_data 3. pci
> > device status fetch from device driver
> >
> > And on the target side with funtion vfio_device_get to restore the
> > same states 1. re-setup the pci bar configuration 2. re-setup the pci
> > device msi configuration 3. restore the pci device status
> >
> > Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> > ---
> >  hw/vfio/pci.c              | 137
> +++++++++++++++++++++++++++++++++++++++++++++
> >  linux-headers/linux/vfio.h |   3 +
> >  2 files changed, 140 insertions(+)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 3e2289c..c1676cf
> > 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2982,6 +2982,123 @@ static void
> vfio_vm_change_state_handler(void *pv, int running, RunState state)
> >      vbasedev->device_state =3D dev_state;  }
> >
> > +static int vfio_device_put(QEMUFile *f, void *pv, size_t size,
> > +                           VMStateField *field, QJSON *vmdesc) {
> > +    VFIOPCIDevice *vdev =3D pv;
> > +    PCIDevice *pdev =3D &vdev->pdev;
> > +    int sz =3D vdev->device_state.size - VFIO_DEVICE_STATE_OFFSET;
> > +    uint8_t *buf =3D NULL;
> > +    uint32_t msi_cfg, msi_lo, msi_hi, msi_data, bar_cfg, i;
> > +    bool msi_64bit;
> > +
> > +    for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> > +        bar_cfg =3D pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 +=
 i *
> 4, 4);
> > +        qemu_put_be32(f, bar_cfg);
> > +    }
> > +
> > +    msi_cfg =3D pci_default_read_config(pdev, pdev->msi_cap +
> PCI_MSI_FLAGS, 2);
> > +    msi_64bit =3D !!(msi_cfg & PCI_MSI_FLAGS_64BIT);
> > +
> > +    msi_lo =3D pci_default_read_config(pdev,
> > +                                     pdev->msi_cap + PCI_MSI_ADDRESS_L=
O, 4);
> > +    qemu_put_be32(f, msi_lo);
> > +
> > +    if (msi_64bit) {
> > +        msi_hi =3D pci_default_read_config(pdev,
> > +                                         pdev->msi_cap + PCI_MSI_ADDRE=
SS_HI,
> > +                                         4);
> > +        qemu_put_be32(f, msi_hi);
> > +    }
> > +
> > +    msi_data =3D pci_default_read_config(pdev,
> > +               pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 :
> PCI_MSI_DATA_32),
> > +               2);
> > +    qemu_put_be32(f, msi_data);
> > +
> > +    buf =3D g_malloc(sz);
> > +    if (buf =3D=3D NULL) {
> > +        error_report("vfio: Failed to allocate memory for migrate");
> > +        goto exit;
>=20
> Yet exit does a 'return 0' - so we've not failed the migration and we've
> generated a broken migration stream.
> (same in the other exit cases)
>=20
> > +    }
> > +
> > +    if (pread(vdev->vbasedev.fd, buf, sz,
> > +              vdev->device_state.offset + VFIO_DEVICE_STATE_OFFSET) !=
=3D sz) {
> > +        error_report("vfio: Failed to read Device State Region");
> > +        goto exit;
> > +    }
> > +
> > +    qemu_put_buffer(f, buf, sz);
> > +
> > +exit:
> > +    g_free(buf);
> > +
> > +    return 0;
> > +}
>=20
> We really try and avoid qemu_put_* and qemu_get* as much as possible
> these days.
> Please try building a datastructure (possible in a pre_save) and then
> construction a VMState with all the fields in.
> VMSTATE_WITH_TMP might help you in this case.
>=20
> Doing it that way is much more robust against later changes.
>=20
> Also, I wonder if it'sa good idea to include 'sz' (or at least
> state.size) in the migration stream; if it was different on teh destinati=
on
> then things would go badly wrong. I don't know about mdev
> to know if that can happen.   You'd need to validate it when it's
> loaded.
>=20
> Dave
>=20
Hi Dave, this size is not included in the migration stream, it is reported =
by
device state region when vifo pci initialize, it's value will be varied acc=
ording to=20
different mdev devices.=20

Yulei
> > +
> > +static int vfio_device_get(QEMUFile *f, void *pv,
> > +                           size_t size, VMStateField *field) {
> > +    VFIOPCIDevice *vdev =3D pv;
> > +    PCIDevice *pdev =3D &vdev->pdev;
> > +    int sz =3D vdev->device_state.size - VFIO_DEVICE_STATE_OFFSET;
> > +    uint8_t *buf =3D NULL;
> > +    uint32_t ctl, msi_lo, msi_hi, msi_data, bar_cfg, i;
> > +    bool msi_64bit;
> > +
> > +    /* retore pci bar configuration */
> > +    ctl =3D pci_default_read_config(pdev, PCI_COMMAND, 2);
> > +    vfio_pci_write_config(pdev, PCI_COMMAND,
> > +                          ctl & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY=
)),
> 2);
> > +    for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> > +        bar_cfg =3D qemu_get_be32(f);
> > +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar_cf=
g, 4);
> > +    }
> > +    vfio_pci_write_config(pdev, PCI_COMMAND,
> > +                          ctl | PCI_COMMAND_IO | PCI_COMMAND_MEMORY,
> > + 2);
> > +
> > +    /* restore msi configuration */
> > +    ctl =3D pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAG=
S,
> 2);
> > +    msi_64bit =3D !!(ctl & PCI_MSI_FLAGS_64BIT);
> > +
> > +    vfio_pci_write_config(&vdev->pdev,
> > +                          pdev->msi_cap + PCI_MSI_FLAGS,
> > +                          ctl & (!PCI_MSI_FLAGS_ENABLE), 2);
> > +
> > +    msi_lo =3D qemu_get_be32(f);
> > +    vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
> > + msi_lo, 4);
> > +
> > +    if (msi_64bit) {
> > +        msi_hi =3D qemu_get_be32(f);
> > +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI=
,
> > +                              msi_hi, 4);
> > +    }
> > +    msi_data =3D qemu_get_be32(f);
> > +    vfio_pci_write_config(pdev,
> > +              pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 :
> PCI_MSI_DATA_32),
> > +              msi_data, 2);
> > +
> > +    vfio_pci_write_config(&vdev->pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> > +                          ctl | PCI_MSI_FLAGS_ENABLE, 2);
> > +
> > +    buf =3D g_malloc(sz);
> > +    if (buf =3D=3D NULL) {
> > +        error_report("vfio: Failed to allocate memory for migrate");
> > +        return -1;
> > +    }
> > +
> > +    qemu_get_buffer(f, buf, sz);
> > +    if (pwrite(vdev->vbasedev.fd, buf, sz,
> > +               vdev->device_state.offset + VFIO_DEVICE_STATE_OFFSET) !=
=3D sz) {
> > +        error_report("vfio: Failed to write Device State Region");
> > +        return -1;
> > +    }
> > +
> > +    g_free(buf);
> > +
> > +    return 0;
> > +}
> > +
> >  static void vfio_instance_init(Object *obj)  {
> >      PCIDevice *pci_dev =3D PCI_DEVICE(obj); @@ -3026,9 +3143,29 @@
> > static Property vfio_pci_dev_properties[] =3D {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > +static const VMStateInfo vfio_vmstate_info =3D {
> > +    .name =3D "vfio-state",
> > +    .get =3D vfio_device_get,
> > +    .put =3D vfio_device_put,
> > +};
> > +
> >  static VMStateDescription vfio_pci_vmstate =3D {
> >      .name =3D "vfio-pci",
> >      .unmigratable =3D 1,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        {
> > +            .name         =3D "vfio dev",
> > +            .version_id   =3D 0,
> > +            .field_exists =3D NULL,
> > +            .size         =3D 0,
> > +            .info         =3D &vfio_vmstate_info,
> > +            .flags        =3D VMS_SINGLE,
> > +            .offset       =3D 0,
> > +         },
> > +        VMSTATE_END_OF_LIST()
> > +    },
> >  };
> >
> >  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
> > diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> > index 4ddeebc..4451a8f 100644
> > --- a/linux-headers/linux/vfio.h
> > +++ b/linux-headers/linux/vfio.h
> > @@ -303,6 +303,9 @@ struct vfio_region_info_cap_type {
> >  /* Mdev sub-type for device state save and restore */
> >  #define VFIO_REGION_SUBTYPE_DEVICE_STATE	(4)
> >
> > +/* Offset in region to save device state */
> > +#define VFIO_DEVICE_STATE_OFFSET	1
> > +
> >  #define VFIO_DEVICE_START	0
> >  #define VFIO_DEVICE_STOP	1
> >
> > --
> > 2.7.4
> >
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
