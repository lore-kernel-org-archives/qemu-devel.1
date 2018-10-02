Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvi-0004RE-Bc
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvc-0007Fz-Nf
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:46 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7Mva-0007F6-Ma
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:40 -0400
Received: from player729.ha.ovh.net (unknown [10.109.143.223])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5E6AA1012F4
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:49:37 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-6-f4bug@amsat.org>
Message-ID: <93f7d571-5c2e-f654-3c02-b733caf6b718@kaod.org>
Date: Tue, 2 Oct 2018 17:49:30 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/15] hw/sh4/sh_pci: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 10/2/18 12:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Move from the legacy SysBusDevice::init method to using DeviceState::re=
alize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

one question below,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/sh4/sh_pci.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index 4ec2e35500..84c52df067 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -120,16 +120,15 @@ static void sh_pci_set_irq(void *opaque, int irq_=
num, int level)
>      qemu_set_irq(pic[irq_num], level);
>  }
> =20
> -static int sh_pci_device_init(SysBusDevice *dev)
> +static void sh_pci_device_realize(PCIDevice *dev, Error **errp)
>  {
> -    PCIHostState *phb;
> -    SHPCIState *s;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    SHPCIState *s =3D SH_PCI_HOST_BRIDGE(dev);
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
>      int i;
> =20
> -    s =3D SH_PCI_HOST_BRIDGE(dev);
> -    phb =3D PCI_HOST_BRIDGE(s);
>      for (i =3D 0; i < 4; i++) {

is that  PCI_NUM_PINS ?=20

> -        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_init_irq(sbd, &s->irq[i]);
>      }
>      phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
>                                       sh_pci_set_irq, sh_pci_map_irq,
> @@ -143,13 +142,12 @@ static int sh_pci_device_init(SysBusDevice *dev)
>                               &s->memconfig_p4, 0, 0x224);
>      memory_region_init_alias(&s->isa, OBJECT(s), "sh_pci.isa",
>                               get_system_io(), 0, 0x40000);
> -    sysbus_init_mmio(dev, &s->memconfig_p4);
> -    sysbus_init_mmio(dev, &s->memconfig_a7);
> +    sysbus_init_mmio(sbd, &s->memconfig_p4);
> +    sysbus_init_mmio(sbd, &s->memconfig_a7);
>      s->iobr =3D 0xfe240000;
>      memory_region_add_subregion(get_system_memory(), s->iobr, &s->isa)=
;
> =20
>      s->dev =3D pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "sh_pci_ho=
st");
> -    return 0;
>  }
> =20
>  static void sh_pci_host_realize(PCIDevice *d, Error **errp)
> @@ -187,9 +185,9 @@ static const TypeInfo sh_pci_host_info =3D {
> =20
>  static void sh_pci_device_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sdc =3D SYS_BUS_DEVICE_CLASS(klass);
> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> =20
> -    sdc->init =3D sh_pci_device_init;
> +    k->realize =3D sh_pci_device_realize;
>  }
> =20
>  static const TypeInfo sh_pci_device_info =3D {
>=20
