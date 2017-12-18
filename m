Received: from eggs.gnu.org ([2001:4830:134:3::10]:39390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQpdy-0001hM-NH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQpdu-0003qR-NE
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:15:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eQpdu-0003q0-84
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:15:18 -0500
References: <20171217204912.12420-1-f4bug@amsat.org>
	<20171217204912.12420-4-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <50504475-91f6-ec30-0129-394c8ae20952@redhat.com>
Date: Mon, 18 Dec 2017 09:15:02 +0200
MIME-Version: 1.0
In-Reply-To: <20171217204912.12420-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/pci-host/xilinx: QOM'ify the
 AXI-PCIe host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, James Hogan <jhogan@kernel.org>

On 17/12/2017 22:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/pci-host/xilinx-pcie.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index 7659253090..756db39fd5 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -267,24 +267,23 @@ static void xilinx_pcie_root_config_write(PCIDevi=
ce *d, uint32_t address,
>       }
>   }
>  =20
> -static int xilinx_pcie_root_init(PCIDevice *dev)
> +static void xilinx_pcie_root_realize(PCIDevice *pci, Error **errp)
>   {

Same comment here, if "dev" seems not good enough maybe
you can use the pci_dev convention.

> -    BusState *bus =3D qdev_get_parent_bus(DEVICE(dev));
> +    DeviceState *dev =3D DEVICE(pci);
> +    BusState *bus =3D qdev_get_parent_bus(dev);

Not sure the above worth the effort :)

>       XilinxPCIEHost *s =3D XILINX_PCIE_HOST(bus->parent);
>  =20
> -    pci_set_word(dev->config + PCI_COMMAND,
> +    pci_set_word(pci->config + PCI_COMMAND,
>                    PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> -    pci_set_word(dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
> -    pci_set_word(dev->config + PCI_MEMORY_LIMIT,
> +    pci_set_word(pci->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
> +    pci_set_word(pci->config + PCI_MEMORY_LIMIT,
>                    ((s->mmio_base + s->mmio_size - 1) >> 16) & 0xfff0);
>  =20
> -    pci_bridge_initfn(dev, TYPE_PCI_BUS);
> +    pci_bridge_initfn(pci, TYPE_PCI_BUS);
>  =20
> -    if (pcie_endpoint_cap_v1_init(dev, 0x80) < 0) {
> +    if (pcie_endpoint_cap_v1_init(pci, 0x80) < 0) {
>           hw_error("Failed to initialize PCIe capability");

I think here you need to use the error_setg (after/instead hw_error).
It is supposed to return -1 if pcie capability was not added.


Thanks,
Marcel

>       }
> -
> -    return 0;
>   }
>  =20
>   static void xilinx_pcie_root_class_init(ObjectClass *klass, void *dat=
a)
> @@ -300,7 +299,7 @@ static void xilinx_pcie_root_class_init(ObjectClass=
 *klass, void *data)
>       k->class_id =3D PCI_CLASS_BRIDGE_HOST;
>       k->is_express =3D true;
>       k->is_bridge =3D true;
> -    k->init =3D xilinx_pcie_root_init;
> +    k->realize =3D xilinx_pcie_root_realize;
>       k->exit =3D pci_bridge_exitfn;
>       dc->reset =3D pci_bridge_reset;
>       k->config_read =3D xilinx_pcie_root_config_read;
>=20
