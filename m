Received: from eggs.gnu.org ([2001:4830:134:3::10]:46932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxbRA-0001u3-4D
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxbR6-0006mm-9h
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:41:04 -0400
Date: Mon, 10 Apr 2017 18:16:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410081646.GT27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-22-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VZEZlOQeSr/zV9d3"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-22-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 21/21] ppc/pnv: Create a default PCI layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--VZEZlOQeSr/zV9d3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:46PM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This creates a legacy PCIe->PCI bridge under the PHB by default to which
> a bunch of standard devices are attached. Currently:
>=20
>   - VGA (as specified by -vga)
>   - USB (with keyboard and mouse if graphcis is enabled)
>   - AHCI
>   - e1000
>=20
> This gives us something close to a standard OpenPower platform.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [clg: updated for qemu-2.9
>       reworked pnv_create_pci_legacy_bridge() ]
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Apart from one nit below.

> ---
>  hw/ppc/pnv.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 111 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index db6e078edcea..766e6cf4bc12 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -48,6 +48,10 @@
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci-host/pnv_phb3.h"
> +#include "hw/usb.h"
> +#include "hw/ide/pci.h"
> +#include "hw/ide/ahci.h"
> +#include "net/net.h"
> =20
>  #include <libfdt.h>
> =20
> @@ -573,6 +577,87 @@ static ISABus *pnv_isa_create(PnvChip *chip)
>      return isa_bus;
>  }
> =20
> +
> +/* Returns whether we want to use VGA or not */
> +static int pnv_vga_init(PCIBus *pci_bus)
> +{
> +    switch (vga_interface_type) {
> +    case VGA_NONE:
> +        return false;
> +    case VGA_DEVICE:
> +        return true;
> +    case VGA_STD:
> +    case VGA_VIRTIO:
> +        return pci_vga_init(pci_bus) !=3D NULL;
> +    default:
> +        fprintf(stderr, "This vga model is not supported,"
> +                "currently it only supports -vga std\n");

This message doesn't appear to be entirely accurate, since virtio-vga
is apparently supported above as well.  Also this should probably be
an error_report().

> +        exit(0);
> +    }
> +}
> +
> +static void pnv_nic_init(PCIBus *pci_bus)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < nb_nics; i++) {
> +        NICInfo *nd =3D &nd_table[i];
> +        DeviceState *dev;
> +        PCIDevice *pdev;
> +        Error *err =3D NULL;
> +
> +        pdev =3D pci_create(pci_bus, -1, "e1000");
> +        dev =3D &pdev->qdev;
> +        qdev_set_nic_properties(dev, nd);
> +        object_property_set_bool(OBJECT(dev), true, "realized", &err);
> +        if (err) {
> +            error_report_err(err);
> +            object_unparent(OBJECT(dev));
> +            exit(1);
> +        }
> +    }
> +}
> +
> +#define MAX_SATA_PORTS     6
> +
> +static void pnv_storage_init(PCIBus *pci_bus)
> +{
> +    DriveInfo *hd[MAX_SATA_PORTS];
> +    PCIDevice *ahci;
> +
> +    /* Add an AHCI device. We use an ICH9 since that's all we have
> +     * at hand for PCI AHCI but it shouldn't really matter
> +     */
> +    ahci =3D pci_create_simple(pci_bus, -1, "ich9-ahci");
> +    g_assert(MAX_SATA_PORTS =3D=3D ICH_AHCI(ahci)->ahci.ports);
> +    ide_drive_get(hd, ICH_AHCI(ahci)->ahci.ports);
> +    ahci_ide_create_devs(ahci, hd);
> +}
> +
> +static PCIBus *pnv_create_pci_legacy_bridge(PnvPhb3State *phb,
> +                                            uint8_t chassis_nr)
> +{
> +    PCIDevice *dev;
> +    PCIHostState *pcih =3D PCI_HOST_BRIDGE(phb);
> +    PCIDevice *pdev;
> +    PCIBus *parent;
> +
> +    /* Add root complex */
> +    pdev =3D pci_create_multifunction(pcih->bus, 0, false, TYPE_PNV_PHB3=
_RC);
> +    qdev_prop_set_uint8(&pdev->qdev, "chassis", phb->chip_id * 4 + phb->=
phb_id);
> +    qdev_prop_set_uint16(&pdev->qdev, "slot", 1);
> +    qdev_init_nofail(&pdev->qdev);
> +
> +    /* Setup bus for that chip */
> +    parent =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> +
> +    dev =3D pci_create_multifunction(parent, 0, false, "pci-bridge");
> +    qdev_prop_set_uint8(&dev->qdev, "chassis_nr", chassis_nr);
> +    dev->qdev.id =3D "pci";
> +    qdev_init_nofail(&dev->qdev);
> +    return pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
> +}
> +
>  static void ppc_powernv_init(MachineState *machine)
>  {
>      PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
> @@ -581,6 +666,8 @@ static void ppc_powernv_init(MachineState *machine)
>      long fw_size;
>      int i;
>      char *chip_typename;
> +    PCIBus *pbus;
> +    bool has_gfx =3D false;
> =20
>      /* allocate RAM */
>      if (machine->ram_size < (1 * G_BYTE)) {
> @@ -682,6 +769,30 @@ static void ppc_powernv_init(MachineState *machine)
>       * host to powerdown */
>      pnv->powerdown_notifier.notify =3D pnv_powerdown_notify;
>      qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
> +
> +    /* Add a PCI switch */
> +    pbus =3D pnv_create_pci_legacy_bridge(pnv->chips[0]->phbs[0], 128);
> +
> +    /* Graphics & USB */
> +    if (pnv_vga_init(pbus)) {
> +        has_gfx =3D true;
> +        machine->usb |=3D defaults_enabled() && !machine->usb_disabled;
> +    }
> +    if (machine->usb) {
> +        pci_create_simple(pbus, -1, "nec-usb-xhci");
> +        if (has_gfx) {
> +            USBBus *usb_bus =3D usb_bus_find(-1);
> +
> +            usb_create_simple(usb_bus, "usb-kbd");
> +            usb_create_simple(usb_bus, "usb-mouse");
> +        }
> +    }
> +
> +    /* Add NIC */
> +    pnv_nic_init(pbus);
> +
> +    /* Add storage */
> +    pnv_storage_init(pbus);
>  }
> =20
>  /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VZEZlOQeSr/zV9d3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6z9uAAoJEGw4ysog2bOSIZgQAIRPCLP6taiVUQgkQnMqBA5X
GW1ZXYZT4ZwNdbhQjwO8UTO53Aa2TkAQbvogkH64sVJWzucJHHMuU4O4m6OxE3l3
00gAUbTx0czdBcFIi7MtFJWM4/JKDhVv846QlnMuYrmH6SjpreuK9wJkKjTRktlW
Bjoh/1a3YL0AWPwKeYbEVnnyH3zuvLzvlB44VLO26rGuZ4I5Wn9jHAtS0lOv9bhs
V3TAy0BlLt04BNceQsweswmruSLeXmGxzh62Z6ogrJvJ98+dqIuDdxA/ZzVPlaso
gONXnut+VuuIucvyyRigNjPaesHJosSOHQq/hrHR4Qkcf1SeiVGfuwDK3I0Z6wOO
AyyGzdnPs5qQHOHA+iEUat+cFZ5Sf+30+zhy1lhNRYqZTb7tkTZRmijL53PURZQA
F2mtgFBgP1VxbL5kAnm7vyBELbqE6SuXupssO7RH0TlxSwqCboSizYpYry1X8BLo
IvZOLamOaCGbtjj8BNXn10G/8tdQB/xhyTgQDnoFnBYCDikXzkVqEQTrvocrYaFh
ePsrseP560xfKUzcWBWKjnTXiUc0QbCx2zGADmfDaN0B/nkp1mRpYOX7yL0YpHHk
FKHmLGQF+wqIL5HIvn1rZmQ5lQR862yOGpeEJJh9vCIB6LbqO/9N3N3OB6sf92G5
2rdNgUuCfM5ZxPRR0gHQ
=Y8B7
-----END PGP SIGNATURE-----

--VZEZlOQeSr/zV9d3--
