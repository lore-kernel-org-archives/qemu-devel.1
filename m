Received: from eggs.gnu.org ([2001:4830:134:3::10]:39604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1i8-0000U4-PG
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1i5-0008KO-GL
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:20:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1i5-0008Jn-AE
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:20:33 -0500
Date: Thu, 21 Dec 2017 16:20:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171221161949-mutt-send-email-mst@kernel.org>
References: <20171218151244.9975-1-f4bug@amsat.org>
	<20171218151244.9975-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171218151244.9975-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/pci-host/xilinx: QOM'ify the
 AXI-PCIe host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, James Hogan <jhogan@kernel.org>

On Mon, Dec 18, 2017 at 12:12:43PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2: use 'pci_dev' variable, replaced hw_error() -> error_setg()
>=20
>  hw/pci-host/xilinx-pcie.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index 7659253090..681fdf486a 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -267,24 +267,22 @@ static void xilinx_pcie_root_config_write(PCIDevi=
ce *d, uint32_t address,
>      }
>  }
> =20
> -static int xilinx_pcie_root_init(PCIDevice *dev)
> +static void xilinx_pcie_root_realize(PCIDevice *pci_dev, Error **errp)
>  {
> -    BusState *bus =3D qdev_get_parent_bus(DEVICE(dev));
> +    BusState *bus =3D qdev_get_parent_bus(DEVICE(pci_dev));
>      XilinxPCIEHost *s =3D XILINX_PCIE_HOST(bus->parent);
> =20
> -    pci_set_word(dev->config + PCI_COMMAND,
> +    pci_set_word(pci_dev->config + PCI_COMMAND,
>                   PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> -    pci_set_word(dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
> -    pci_set_word(dev->config + PCI_MEMORY_LIMIT,
> +    pci_set_word(pci_dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16=
);
> +    pci_set_word(pci_dev->config + PCI_MEMORY_LIMIT,
>                   ((s->mmio_base + s->mmio_size - 1) >> 16) & 0xfff0);
> =20
> -    pci_bridge_initfn(dev, TYPE_PCI_BUS);
> +    pci_bridge_initfn(pci_dev, TYPE_PCI_BUS);
> =20
> -    if (pcie_endpoint_cap_v1_init(dev, 0x80) < 0) {
> -        hw_error("Failed to initialize PCIe capability");
> +    if (pcie_endpoint_cap_v1_init(pci_dev, 0x80) < 0) {
> +        error_setg(errp, "Failed to initialize PCIe capability");
>      }

This file doesn't include qapi/error.h so this makes build fail on
mingw. Fixed it up, pls take care in the future.

> -
> -    return 0;
>  }
> =20
>  static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data=
)
> @@ -300,7 +298,7 @@ static void xilinx_pcie_root_class_init(ObjectClass=
 *klass, void *data)
>      k->class_id =3D PCI_CLASS_BRIDGE_HOST;
>      k->is_express =3D true;
>      k->is_bridge =3D true;
> -    k->init =3D xilinx_pcie_root_init;
> +    k->realize =3D xilinx_pcie_root_realize;
>      k->exit =3D pci_bridge_exitfn;
>      dc->reset =3D pci_bridge_reset;
>      k->config_read =3D xilinx_pcie_root_config_read;
> --=20
> 2.15.1
