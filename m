Received: from eggs.gnu.org ([2001:4830:134:3::10]:48582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1g6zVT-0002Dk-LA
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1g6zVN-0001bu-RT
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:49:06 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:52128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1g6zVN-0001ah-LJ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:49:01 -0400
Received: from player788.ha.ovh.net (unknown [10.109.146.132])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 9693E2EA4C
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 16:48:53 +0200 (CEST)
Date: Mon, 1 Oct 2018 16:48:47 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181001164847.1b63808e@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20181001114421.1377-2-clg@kaod.org>
References: <20181001114421.1377-1-clg@kaod.org>
	<20181001114421.1377-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] ppc440_pcix: convert SysBus
 init method to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>

On Mon,  1 Oct 2018 13:44:20 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/ppc440_pcix.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index 64ed07afa658..42ef76b6f58a 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -466,17 +466,18 @@ const MemoryRegionOps ppc440_pcix_host_data_ops =3D=
 {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> -static int ppc440_pcix_initfn(SysBusDevice *dev)
> +static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      PPC440PCIXState *s;
>      PCIHostState *h;
> =20
>      h =3D PCI_HOST_BRIDGE(dev);
>      s =3D PPC440_PCIX_HOST_BRIDGE(dev);
> =20
> -    sysbus_init_irq(dev, &s->irq);
> +    sysbus_init_irq(sbd, &s->irq);
>      memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64=
_MAX);
> -    h->bus =3D pci_register_root_bus(DEVICE(dev), NULL, ppc440_pcix_set_=
irq,
> +    h->bus =3D pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
>                           ppc440_pcix_map_irq, &s->irq, &s->busmem,
>                           get_system_io(), PCI_DEVFN(0, 0), 1, TYPE_PCI_B=
US);
> =20
> @@ -497,17 +498,14 @@ static int ppc440_pcix_initfn(SysBusDevice *dev)
>      memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_m=
em);
>      memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_m=
em);
>      memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->iome=
m);
> -    sysbus_init_mmio(dev, &s->container);
> -
> -    return 0;
> +    sysbus_init_mmio(sbd, &s->container);
>  }
> =20
>  static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    k->init =3D ppc440_pcix_initfn;
> +    dc->realize =3D ppc440_pcix_realize;
>      dc->reset =3D ppc440_pcix_reset;
>  }
> =20
