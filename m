Received: from eggs.gnu.org ([2001:4830:134:3::10]:41431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Zsm-000139-MH
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 01:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Zsh-00070B-8i
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 01:39:36 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:59875)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7Zsh-0006zo-1s
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 01:39:31 -0400
Received: from player692.ha.ovh.net (unknown [10.109.159.62])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9A56034AF5
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 07:39:29 +0200 (CEST)
References: <20181002215315.16851-1-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a6d996ce-0ff6-7ff3-f54a-1be747061ff9@kaod.org>
Date: Wed, 3 Oct 2018 07:39:18 +0200
MIME-Version: 1.0
In-Reply-To: <20181002215315.16851-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host/ppce500: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, "open list:ppce500" <qemu-ppc@nongnu.org>

On 10/2/18 11:53 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Move from the legacy SysBusDevice::init method to using DeviceState::re=
alize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

That patch was already reviewed by you and merged by David :)

C.

> ---
>  hw/pci-host/ppce500.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index eb75e080fc..b8f8c112e6 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -436,8 +436,9 @@ static AddressSpace *e500_pcihost_set_iommu(PCIBus =
*bus, void *opaque,
>      return &s->bm_as;
>  }
> =20
> -static int e500_pcihost_initfn(SysBusDevice *dev)
> +static void e500_pcihost_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      PCIHostState *h;
>      PPCE500PCIState *s;
>      PCIBus *b;
> @@ -447,7 +448,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      s =3D PPC_E500_PCI_HOST_BRIDGE(dev);
> =20
>      for (i =3D 0; i < ARRAY_SIZE(s->irq); i++) {
> -        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_init_irq(sbd, &s->irq[i]);
>      }
> =20
>      for (i =3D 0; i < PCI_NUM_PINS; i++) {
> @@ -460,7 +461,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      /* PIO lives at the bottom of our bus space */
>      memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
> =20
> -    b =3D pci_register_root_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq=
,
> +    b =3D pci_register_root_bus(dev, NULL, mpc85xx_pci_set_irq,
>                                mpc85xx_pci_map_irq, s, &s->busmem, &s->=
pio,
>                                PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI=
_BUS);
>      h->bus =3D b;
> @@ -483,10 +484,8 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      memory_region_add_subregion(&s->container, PCIE500_CFGADDR, &h->co=
nf_mem);
>      memory_region_add_subregion(&s->container, PCIE500_CFGDATA, &h->da=
ta_mem);
>      memory_region_add_subregion(&s->container, PCIE500_REG_BASE, &s->i=
omem);
> -    sysbus_init_mmio(dev, &s->container);
> +    sysbus_init_mmio(sbd, &s->container);
>      pci_bus_set_route_irq_fn(b, e500_route_intx_pin_to_irq);
> -
> -    return 0;
>  }
> =20
>  static void e500_host_bridge_class_init(ObjectClass *klass, void *data=
)
> @@ -526,9 +525,8 @@ static Property pcihost_properties[] =3D {
>  static void e500_pcihost_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D e500_pcihost_initfn;
> +    dc->realize =3D e500_pcihost_realize;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->props =3D pcihost_properties;
>      dc->vmsd =3D &vmstate_ppce500_pci;
>=20
