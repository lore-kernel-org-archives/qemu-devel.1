Received: from eggs.gnu.org ([2001:4830:134:3::10]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enzRn-000525-Gy
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enzRm-0006u3-8H
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:22:31 -0500
Date: Tue, 20 Feb 2018 15:22:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180220042218.GM1109@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-6-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pFpMklMRdxwSC3Yi"
Content-Disposition: inline
In-Reply-To: <20180219181922.21586-6-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 05/11] heathrow: change heathrow_pic_init()
 to return the heathrow device
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


--pFpMklMRdxwSC3Yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 06:19:16PM +0000, Mark Cave-Ayland wrote:
> This enables the device to be made available during the setup of the Old =
World
> machine. In order to pass back the previous set of IRQs we temporarily in=
troduce
> a new pic_irqs parameter until it can be removed.
>=20
> An additional benefit of this change is that it is also possible to remov=
e the
> pic_mem pointer used for macio by accessing the memory region via sysbus.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/heathrow_pic.c | 10 ++++++----
>  hw/ppc/mac.h           |  4 ++--
>  hw/ppc/mac_oldworld.c  |  9 +++++----
>  3 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
> index afe0b08cbb..1cf4db1e79 100644
> --- a/hw/intc/heathrow_pic.c
> +++ b/hw/intc/heathrow_pic.c
> @@ -173,13 +173,15 @@ static void heathrow_reset(DeviceState *d)
>  static void heathrow_init(Object *obj)
>  {
>      HeathrowState *s =3D HEATHROW(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> =20
>      memory_region_init_io(&s->mem, OBJECT(s), &heathrow_ops, s,
>                            "heathrow-pic", 0x1000);
> +    sysbus_init_mmio(sbd, &s->mem);
>  }
> =20
> -qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
> -                            int nb_cpus, qemu_irq **irqs)
> +DeviceState *heathrow_pic_init(int nb_cpus, qemu_irq **irqs,
> +                               qemu_irq **pic_irqs)
>  {
>      DeviceState *d;
>      HeathrowState *s;
> @@ -191,9 +193,9 @@ qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
>      /* only 1 CPU */
>      s->irqs =3D irqs[0];
> =20
> -    *pmem =3D &s->mem;
> +    *pic_irqs =3D qemu_allocate_irqs(heathrow_set_irq, s, HEATHROW_NUM_I=
RQS);
> =20
> -    return qemu_allocate_irqs(heathrow_set_irq, s, HEATHROW_NUM_IRQS);
> +    return d;
>  }
> =20
>  static void heathrow_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 261b519aa5..5b5fffdff3 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -79,8 +79,8 @@ void macio_init(PCIDevice *dev,
>                  MemoryRegion *pic_mem);
> =20
>  /* Heathrow PIC */
> -qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
> -                            int nb_cpus, qemu_irq **irqs);
> +DeviceState *heathrow_pic_init(int nb_cpus, qemu_irq **irqs,
> +                               qemu_irq **pic_irqs);
> =20
>  /* Grackle PCI */
>  #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 4401ce5af2..06a61220cb 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -94,11 +94,11 @@ static void ppc_heathrow_init(MachineState *machine)
>      PCIBus *pci_bus;
>      PCIDevice *macio;
>      MACIOIDEState *macio_ide;
> -    DeviceState *dev;
> +    DeviceState *dev, *pic_dev;
> +    SysBusDevice *sbd;
>      BusState *adb_bus;
>      int bios_size, ndrv_size;
>      uint8_t *ndrv_file;
> -    MemoryRegion *pic_mem;
>      uint16_t ppc_boot_device;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      void *fw_cfg;
> @@ -257,7 +257,7 @@ static void ppc_heathrow_init(MachineState *machine)
>          error_report("Only 6xx bus is supported on heathrow machine");
>          exit(1);
>      }
> -    pic =3D heathrow_pic_init(&pic_mem, 1, heathrow_irqs);
> +    pic_dev =3D heathrow_pic_init(1, heathrow_irqs, &pic);
>      pci_bus =3D pci_grackle_init(0xfec00000, pic,
>                                 get_system_memory(),
>                                 get_system_io());
> @@ -280,7 +280,8 @@ static void ppc_heathrow_init(MachineState *machine)
>      qdev_connect_gpio_out(dev, 5, pic[0x0E]); /* IDE-1 */
>      qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE-1 DMA */
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
> -    macio_init(macio, pic_mem);
> +    sbd =3D SYS_BUS_DEVICE(pic_dev);
> +    macio_init(macio, sysbus_mmio_get_region(sbd, 0));
> =20
>      macio_ide =3D MACIO_IDE(object_resolve_path_component(OBJECT(macio),
>                                                          "ide[0]"));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pFpMklMRdxwSC3Yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqLonoACgkQbDjKyiDZ
s5J4yBAAh8ns2GniFIICJSdasmAP/+2JX1tq4HrLWYDF6eYk1eLYxbv2GGQMrOSq
bTC/AW1l9Yqp0MoGSNmDE1H6TLoY9tLld/uwsRDXWTOnxeUiQxf2Ocis6Q/d+tkb
5NdSlkLg1QuMJUsp21r53q4f73blUwBj9nUDDcbXnqMez1URUPoE1kozPX1aGoSl
3oCJcL89Pqm5B5HScSjg9iadYpg2X0eZLAVeat0cU8Jy4CnKqovru15vlYuDoM1A
S1plkx+hWPAYAOf5PCEuIWETLXN9LBCGE7P/ZoiiKmaTN40PTAugl1CZDF/JxyQF
VCpnBR4bf3iN2OFEA7yr4H/1FSUkTddMjgLJNsbpkjvWgKcw9QvUZLo3BmCy50kW
rHQpzEJeTdnP2Lnl+g20uCt31tsE00daQp1kJcbsK6FkjVXAjXjaUleyAinCFp6Z
uM0LGAtkCwenVea85+jtVxy7aa8MhwGY7F4IbkydmoSR44VWvpCC9wvTkp7lCfAl
u2I0NZrhKaAOSFKdmnfwAaPMyn58V+R/kIErFO+1Vs5XoGzsS+aVQRDzgI7A4LNS
hPZ2OfTdKzvRhHGvDxXeFz4ZhobcpRROUbFTVqkOq42O4yH3KKwEEsRU4fHjHKCU
eOw7TNwqVWKmTSSPmsh/K8H+J69PGIs03TbhfitHeqalv8X4G9Q=
=4MEG
-----END PGP SIGNATURE-----

--pFpMklMRdxwSC3Yi--
