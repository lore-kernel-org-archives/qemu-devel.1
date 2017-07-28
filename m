Received: from eggs.gnu.org ([2001:4830:134:3::10]:36374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawrD-0003FE-18
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr9-0007sK-8O
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:33 -0400
Date: Fri, 28 Jul 2017 13:50:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728035038.GG3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100574883.27487.14886260798861983416.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline
In-Reply-To: <150100574883.27487.14886260798861983416.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 21/26] qdev: pass an Object * to
 qbus_set_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:02:28PM +0200, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> Certain devices types, like memory/CPU, are now being handled using a
> hotplug interface provided by a top-level MachineClass. Hotpluggable
> host bridges are another such device where it makes sense to use a
> machine-level hotplug handler. However, unlike those devices,
> host-bridges have a parent bus (the main system bus), and devices with
> a parent bus use a different mechanism for registering their hotplug
> handlers: qbus_set_hotplug_handler(). This interface currently expects
> a handler to be a subclass of DeviceClass, but this is not the case
> for MachineClass, which derives directly from ObjectClass.
>=20
> Internally, the interface only requires an ObjectClass, so expose that
> in qbus_set_hotplug_handler().
>=20
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes since RFC:
> - rebased against ppc-for-2.10
> - changed qbus_set_hotplug_handler() declaration and dropped
>   qbus_set_hotplug_handler_internal() (Paolo)
> - updated title and changelog accordingly
> ---
>  hw/acpi/piix4.c               |    2 +-
>  hw/char/virtio-serial-bus.c   |    2 +-
>  hw/core/bus.c                 |   11 ++---------
>  hw/pci/pcie.c                 |    2 +-
>  hw/pci/shpc.c                 |    2 +-
>  hw/ppc/spapr_pci.c            |    2 +-
>  hw/s390x/css-bridge.c         |    2 +-
>  hw/s390x/s390-pci-bus.c       |    6 +++---
>  hw/scsi/virtio-scsi.c         |    2 +-
>  hw/scsi/vmw_pvscsi.c          |    2 +-
>  hw/usb/dev-smartcard-reader.c |    2 +-
>  include/hw/qdev-core.h        |    3 +--
>  12 files changed, 15 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index f276967365c4..f99c7438235e 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -447,7 +447,7 @@ static void piix4_update_bus_hotplug(PCIBus *pci_bus,=
 void *opaque)
> =20
>      /* pci_bus cannot outlive PIIX4PMState, because /machine keeps it al=
ive
>       * and it's not hot-unpluggable */
> -    qbus_set_hotplug_handler(BUS(pci_bus), DEVICE(s), &error_abort);
> +    qbus_set_hotplug_handler(BUS(pci_bus), OBJECT(s), &error_abort);
>  }
> =20
>  static void piix4_pm_machine_ready(Notifier *n, void *opaque)
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index f5bc173844e4..4880236f4258 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -1042,7 +1042,7 @@ static void virtio_serial_device_realize(DeviceStat=
e *dev, Error **errp)
>      /* Spawn a new virtio-serial bus on which the ports will ride as dev=
ices */
>      qbus_create_inplace(&vser->bus, sizeof(vser->bus), TYPE_VIRTIO_SERIA=
L_BUS,
>                          dev, vdev->bus_name);
> -    qbus_set_hotplug_handler(BUS(&vser->bus), DEVICE(vser), errp);
> +    qbus_set_hotplug_handler(BUS(&vser->bus), OBJECT(vser), errp);
>      vser->bus.vser =3D vser;
>      QTAILQ_INIT(&vser->ports);
> =20
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 4651f244864c..e09843f6abea 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -22,22 +22,15 @@
>  #include "hw/qdev.h"
>  #include "qapi/error.h"
> =20
> -static void qbus_set_hotplug_handler_internal(BusState *bus, Object *han=
dler,
> -                                              Error **errp)
> +void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **er=
rp)
>  {
> -
>      object_property_set_link(OBJECT(bus), OBJECT(handler),
>                               QDEV_HOTPLUG_HANDLER_PROPERTY, errp);
>  }
> =20
> -void qbus_set_hotplug_handler(BusState *bus, DeviceState *handler, Error=
 **errp)
> -{
> -    qbus_set_hotplug_handler_internal(bus, OBJECT(handler), errp);
> -}
> -
>  void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp)
>  {
> -    qbus_set_hotplug_handler_internal(bus, OBJECT(bus), errp);
> +    qbus_set_hotplug_handler(bus, OBJECT(bus), errp);
>  }
> =20
>  int qbus_walk_children(BusState *bus,
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 32191f2a55f7..52d9ff947f7c 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -443,7 +443,7 @@ void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
>      dev->exp.hpev_notified =3D false;
> =20
>      qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))=
),
> -                             DEVICE(dev), NULL);
> +                             OBJECT(dev), NULL);
>  }
> =20
>  void pcie_cap_slot_reset(PCIDevice *dev)
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index 69fc14b218d8..feed8a45e535 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -648,7 +648,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRe=
gion *bar,
>      shpc_cap_update_dword(d);
>      memory_region_add_subregion(bar, offset, &shpc->mmio);
> =20
> -    qbus_set_hotplug_handler(BUS(sec_bus), DEVICE(d), NULL);
> +    qbus_set_hotplug_handler(BUS(sec_bus), OBJECT(d), NULL);
> =20
>      d->cap_present |=3D QEMU_PCI_CAP_SHPC;
>      return 0;
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 54533d8a3841..b73e099e0285 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1714,7 +1714,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>                             &sphb->memspace, &sphb->iospace,
>                             PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
>      phb->bus =3D bus;
> -    qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
> +    qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
> =20
>      /*
>       * Initialize PHB address space.
> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> index c4a9735d7108..19eda77979d1 100644
> --- a/hw/s390x/css-bridge.c
> +++ b/hw/s390x/css-bridge.c
> @@ -107,7 +107,7 @@ VirtualCssBus *virtual_css_bus_init(void)
>      cbus->squash_mcss =3D s390_get_squash_mcss();
> =20
>      /* Enable hotplugging */
> -    qbus_set_hotplug_handler(bus, dev, &error_abort);
> +    qbus_set_hotplug_handler(bus, OBJECT(dev), &error_abort);
> =20
>      css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
>                               0, &error_abort);
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 61cfd2138f68..503b7ae05abb 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -566,11 +566,11 @@ static int s390_pcihost_init(SysBusDevice *dev)
>      pci_setup_iommu(b, s390_pci_dma_iommu, s);
> =20
>      bus =3D BUS(b);
> -    qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
> +    qbus_set_hotplug_handler(bus, OBJECT(dev), NULL);
>      phb->bus =3D b;
> =20
>      s->bus =3D S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NU=
LL));
> -    qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
> +    qbus_set_hotplug_handler(BUS(s->bus), OBJECT(s), NULL);
> =20
>      s->iommu_table =3D g_hash_table_new_full(g_int64_hash, g_int64_equal,
>                                             NULL, g_free);
> @@ -678,7 +678,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hot=
plug_dev,
>          pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
> =20
>          bus =3D BUS(&pb->sec_bus);
> -        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
> +        qbus_set_hotplug_handler(bus, OBJECT(s), errp);
> =20
>          if (dev->hotplugged) {
>              pci_default_write_config(pdev, PCI_PRIMARY_BUS, s->bus_no, 1=
);
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index eb639442d192..b4c26d4862b5 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -893,7 +893,7 @@ static void virtio_scsi_device_realize(DeviceState *d=
ev, Error **errp)
>      scsi_bus_new(&s->bus, sizeof(s->bus), dev,
>                   &virtio_scsi_scsi_info, vdev->bus_name);
>      /* override default SCSI bus hotplug-handler, with virtio-scsi's one=
 */
> -    qbus_set_hotplug_handler(BUS(&s->bus), dev, &error_abort);
> +    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
> =20
>      virtio_scsi_dataplane_setup(s, errp);
>  }
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 4a106da85646..036e44caca42 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -1146,7 +1146,7 @@ pvscsi_init(PCIDevice *pci_dev)
>      scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
>                   &pvscsi_scsi_info, NULL);
>      /* override default SCSI bus hotplug-handler, with pvscsi's one */
> -    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(s), &error_abort);
> +    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(s), &error_abort);
>      pvscsi_reset_state(s);
> =20
>      return 0;
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index bef1f03c426b..f2a86de6c556 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1337,7 +1337,7 @@ static void ccid_realize(USBDevice *dev, Error **er=
rp)
>      usb_desc_init(dev);
>      qbus_create_inplace(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(d=
ev),
>                          NULL);
> -    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(dev), &error_abort);
> +    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
>      s->intr =3D usb_ep_get(dev, USB_TOKEN_IN, CCID_INT_IN_EP);
>      s->bulk =3D usb_ep_get(dev, USB_TOKEN_IN, CCID_BULK_IN_EP);
>      s->card =3D NULL;
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9237b6849ff3..ce01ff42850b 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -397,8 +397,7 @@ char *qdev_get_dev_path(DeviceState *dev);
> =20
>  GSList *qdev_build_hotpluggable_device_list(Object *peripheral);
> =20
> -void qbus_set_hotplug_handler(BusState *bus, DeviceState *handler,
> -                              Error **errp);
> +void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **er=
rp);
> =20
>  void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6tI4ACgkQbDjKyiDZ
s5KakRAAimEystRqRvUtuzZM5wYsAbqIhdojJpTvs7i3jcFHYUxtCF4fWP8zugka
6guIjxaBrEMHh/4gyFRUNuhkPsYfoooZDG3RkePRX9+dJcMJFfVvDZJ8Yi/JJzYc
+T5EsWnt/z45isR4SdnyknPsajZs8a8Cyo6GUL4dAV6+osB2Noq2IN12ZEI8qbok
//LEtz+3bvRFyxWeWgy9FNvW8nztAzKZ3AstpAkKQCxRHGwqrs5T0uLUh2QCuIM9
Xwd+M3CdnkokBYblmM4eFbOMsgm5sWE+w+ThBbbhgpPiOlKJ1+UB9r4QyBSXwr7f
LtKU8AFJzaJVF0z1FdT+lwP+qiL6/uJe8admNaFR8UI2OoeBKFwhlAcYaAYjQvD5
/9Bn/KtfSWW+NUy+qS7+09Bzw6xlJYUglQIJaXki3g0QMJutyXLYbtMKZ/JJWv7i
pIGMMWayXxMwYKS1A196EeIx3mWH70cYdNsBTig+OF5hpNtzhqhRcZnv8M6Y6DJS
AvxCPTMU/zzzU4zRq7Xyo1TDBfjMlXZgJ3WFkDv97agvNQuyBwGVb4P3WQi79z9C
bFANeRbpaSVZx2x/6Py6KaLRxcx/AB6K4vd4avLHoJW4aPXXYzZ7qdJ5uCpItoVu
iDduqW7MtHj10Q7pGukCswN3iUPIGvEbMnc7k/8LgAn5VOSE2WU=
=SV7H
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--
