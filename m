Received: from eggs.gnu.org ([2001:4830:134:3::10]:54217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu6BB-0007lA-Fq
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 19:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu6B8-000632-Ae
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 19:46:37 -0500
Date: Fri, 9 Mar 2018 11:32:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180309003238.GR3083@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OrT4iOlIQZp3kw4S"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-4-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 03/19] uninorth: QOMify PCI and AGP host
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--OrT4iOlIQZp3kw4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:47PM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/pci-host/uninorth.c | 79 ++++++++++++++++++++------------------------=
------
>  1 file changed, 32 insertions(+), 47 deletions(-)
>=20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 710818e355..1d4d3f5705 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -129,72 +129,61 @@ static const MemoryRegionOps unin_data_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> -static int pci_unin_main_init_device(SysBusDevice *dev)
> +static void pci_unin_main_init(Object *obj)
>  {
> -    PCIHostState *h;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
> =20
>      /* Use values found on a real PowerMac */
>      /* Uninorth main bus */
> -    h =3D PCI_HOST_BRIDGE(dev);
> -
>      memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
> -                          dev, "pci-conf-idx", 0x1000);
> -    memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, dev,
> +                          obj, "pci-conf-idx", 0x1000);
> +    memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, obj,
>                            "pci-conf-data", 0x1000);
> -    sysbus_init_mmio(dev, &h->conf_mem);
> -    sysbus_init_mmio(dev, &h->data_mem);
> -
> -    return 0;
> +    sysbus_init_mmio(sbd, &h->conf_mem);
> +    sysbus_init_mmio(sbd, &h->data_mem);
>  }
> =20
> -
> -static int pci_u3_agp_init_device(SysBusDevice *dev)
> +static void pci_u3_agp_init(Object *obj)
>  {
> -    PCIHostState *h;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
> =20
>      /* Uninorth U3 AGP bus */
> -    h =3D PCI_HOST_BRIDGE(dev);
> -
>      memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
> -                          dev, "pci-conf-idx", 0x1000);
> -    memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, dev,
> +                          obj, "pci-conf-idx", 0x1000);
> +    memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, obj,
>                            "pci-conf-data", 0x1000);
> -    sysbus_init_mmio(dev, &h->conf_mem);
> -    sysbus_init_mmio(dev, &h->data_mem);
> -
> -    return 0;
> +    sysbus_init_mmio(sbd, &h->conf_mem);
> +    sysbus_init_mmio(sbd, &h->data_mem);
>  }
> =20
> -static int pci_unin_agp_init_device(SysBusDevice *dev)
> +static void pci_unin_agp_init(Object *obj)
>  {
> -    PCIHostState *h;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
> =20
>      /* Uninorth AGP bus */
> -    h =3D PCI_HOST_BRIDGE(dev);
> -
>      memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
> -                          dev, "pci-conf-idx", 0x1000);
> +                          obj, "pci-conf-idx", 0x1000);
>      memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
> -                          dev, "pci-conf-data", 0x1000);
> -    sysbus_init_mmio(dev, &h->conf_mem);
> -    sysbus_init_mmio(dev, &h->data_mem);
> -    return 0;
> +                          obj, "pci-conf-data", 0x1000);
> +    sysbus_init_mmio(sbd, &h->conf_mem);
> +    sysbus_init_mmio(sbd, &h->data_mem);
>  }
> =20
> -static int pci_unin_internal_init_device(SysBusDevice *dev)
> +static void pci_unin_internal_init(Object *obj)
>  {
> -    PCIHostState *h;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
> =20
>      /* Uninorth internal bus */
> -    h =3D PCI_HOST_BRIDGE(dev);
> -
>      memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
> -                          dev, "pci-conf-idx", 0x1000);
> +                          obj, "pci-conf-idx", 0x1000);
>      memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
> -                          dev, "pci-conf-data", 0x1000);
> -    sysbus_init_mmio(dev, &h->conf_mem);
> -    sysbus_init_mmio(dev, &h->data_mem);
> -    return 0;
> +                          obj, "pci-conf-data", 0x1000);
> +    sysbus_init_mmio(sbd, &h->conf_mem);
> +    sysbus_init_mmio(sbd, &h->data_mem);
>  }
> =20
>  PCIBus *pci_pmac_init(qemu_irq *pic,
> @@ -461,10 +450,8 @@ static const TypeInfo unin_internal_pci_host_info =
=3D {
> =20
>  static void pci_unin_main_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    sbc->init =3D pci_unin_main_init_device;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> =20
> @@ -472,15 +459,14 @@ static const TypeInfo pci_unin_main_info =3D {
>      .name          =3D TYPE_UNI_NORTH_PCI_HOST_BRIDGE,
>      .parent        =3D TYPE_PCI_HOST_BRIDGE,
>      .instance_size =3D sizeof(UNINState),
> +    .instance_init =3D pci_unin_main_init,
>      .class_init    =3D pci_unin_main_class_init,
>  };
> =20
>  static void pci_u3_agp_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    sbc->init =3D pci_u3_agp_init_device;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> =20
> @@ -488,15 +474,14 @@ static const TypeInfo pci_u3_agp_info =3D {
>      .name          =3D TYPE_U3_AGP_HOST_BRIDGE,
>      .parent        =3D TYPE_PCI_HOST_BRIDGE,
>      .instance_size =3D sizeof(UNINState),
> +    .instance_init =3D pci_u3_agp_init,
>      .class_init    =3D pci_u3_agp_class_init,
>  };
> =20
>  static void pci_unin_agp_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    sbc->init =3D pci_unin_agp_init_device;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> =20
> @@ -504,15 +489,14 @@ static const TypeInfo pci_unin_agp_info =3D {
>      .name          =3D TYPE_UNI_NORTH_AGP_HOST_BRIDGE,
>      .parent        =3D TYPE_PCI_HOST_BRIDGE,
>      .instance_size =3D sizeof(UNINState),
> +    .instance_init =3D pci_unin_agp_init,
>      .class_init    =3D pci_unin_agp_class_init,
>  };
> =20
>  static void pci_unin_internal_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    sbc->init =3D pci_unin_internal_init_device;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> =20
> @@ -520,6 +504,7 @@ static const TypeInfo pci_unin_internal_info =3D {
>      .name          =3D TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE,
>      .parent        =3D TYPE_PCI_HOST_BRIDGE,
>      .instance_size =3D sizeof(UNINState),
> +    .instance_init =3D pci_unin_internal_init,
>      .class_init    =3D pci_unin_internal_class_init,
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OrT4iOlIQZp3kw4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqh1iMACgkQbDjKyiDZ
s5KMQxAArQ5+hB0sAHPZY1r9ULFIh0F4YHAFrUWMJnTdXZnB3nalqBXp1SpYCfSM
LTrX8k7WfL8am6j0lfEhZj0g/eEjg1eQR4rOf79tUV+lA8+quzc1T6z4C7BJV8tX
z9z/NAxO7X9CfRFrMizs5zkHXQFYxsPIIR/AZ1Wuz0DAS0iq2o6pK+VZyXD+08dh
839GntJhkZoQOvpD4RoXTIH33IhykP99T0m3+C3vqJSw+G02OxdSchgghlJOg3cL
CWmWHtTtOCtGG7yxcRrPlWDtytGus0MQ1+lDyJwktqEfZZT8s1gCzEuHYpPowE4E
Jt9Ah91wAsgVmaDkHi2bLugf6rKlXx04IpmnVsTaEBLu3vVGnf4CxEj+rl69YQal
Ni1exdANby73hKloP1HsiHiI1dj34nP0osZuGJB1RLd60JM1Py12AaTmhDzoVWsW
xGNANvbwnOuoWhnHaXAc3+OwDyVSE1/wbBCKkciscH9tBUfXXqwdxXy3maik/oIH
OhBLNgWsd49jxTDU+/pF/RPiTzfHTFidnMy/GILGmTZuB/pHL3VHfpucGsIwdJua
pA+Y0FtNPqT95C8L9D8H77a9vdMFiUpruSf3SBSl/UFveYWYgTsQ25HzZfu1bX+G
EjOCy8AyiJIpn/7OFRcapenEw7rLDQrOzwUlIFW1A+1LpfC+jSk=
=0Kfj
-----END PGP SIGNATURE-----

--OrT4iOlIQZp3kw4S--
