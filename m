Received: from eggs.gnu.org ([208.118.235.92]:53670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eogiL-00030y-1m
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 21:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eoghH-0002sa-2O
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 21:34:28 -0500
Date: Thu, 22 Feb 2018 13:19:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180222021924.GC2164@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-10-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <20180219181922.21586-10-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 09/11] mac_newworld: use object link to
 pass OpenPIC object to macio
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


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 06:19:20PM +0000, Mark Cave-Ayland wrote:
> Also switch macio_newworld_realize() over to use it rather than using the=
 pic_mem
> memory region directly.
>=20
> Now that both Old World and New World macio devices no longer make use of=
 the
> pic_mem memory region directly, we can remove it.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/misc/macio/macio.c         | 14 +++++++++-----
>  hw/ppc/mac_newworld.c         | 20 +++++++++++---------
>  include/hw/misc/macio/macio.h |  4 +++-
>  3 files changed, 23 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index d4c1d190c4..e5288f1084 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -279,10 +279,10 @@ static void macio_newworld_realize(PCIDevice *d, Er=
ror **errp)
>      sysbus_connect_irq(sysbus_dev, 0, ns->irqs[cur_irq++]);
>      sysbus_connect_irq(sysbus_dev, 1, ns->irqs[cur_irq++]);
> =20
> -    if (s->pic_mem) {
> -        /* OpenPIC */
> -        memory_region_add_subregion(&s->bar, 0x40000, s->pic_mem);
> -    }
> +    /* OpenPIC */
> +    sysbus_dev =3D SYS_BUS_DEVICE(ns->pic);
> +    memory_region_add_subregion(&s->bar, 0x40000,
> +                                sysbus_mmio_get_region(sysbus_dev, 0));
> =20
>      /* IDE buses */
>      for (i =3D 0; i < ARRAY_SIZE(ns->ide); i++) {
> @@ -311,6 +311,11 @@ static void macio_newworld_init(Object *obj)
> =20
>      qdev_init_gpio_out(DEVICE(obj), ns->irqs, ARRAY_SIZE(ns->irqs));
> =20
> +    object_property_add_link(obj, "pic", TYPE_OPENPIC,
> +                             (Object **) &ns->pic,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, NULL);
> +
>      for (i =3D 0; i < 2; i++) {
>          macio_init_ide(s, &ns->ide[i], sizeof(ns->ide[i]), i);
>      }
> @@ -441,7 +446,6 @@ void macio_init(PCIDevice *d,
>  {
>      MacIOState *macio_state =3D MACIO(d);
> =20
> -    macio_state->pic_mem =3D pic_mem;
>      /* Note: this code is strongly inspirated from the corresponding code
>         in PearPC */
>      qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequency=
",
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 396216954e..c7960ab67a 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -154,7 +154,7 @@ static void ppc_core99_init(MachineState *machine)
>      hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
>      long kernel_size, initrd_size;
>      PCIBus *pci_bus;
> -    PCIDevice *macio;
> +    NewWorldMacIOState *macio;
>      MACIOIDEState *macio_ide;
>      BusState *adb_bus;
>      MacIONVRAMState *nvr;
> @@ -166,7 +166,7 @@ static void ppc_core99_init(MachineState *machine)
>      void *fw_cfg;
>      int machine_arch;
>      SysBusDevice *s;
> -    DeviceState *dev;
> +    DeviceState *dev, *pic_dev;
>      int *token =3D g_new(int, 1);
>      hwaddr nvram_addr =3D 0xFFF04000;
>      uint64_t tbfreq;
> @@ -333,10 +333,10 @@ static void ppc_core99_init(MachineState *machine)
> =20
>      pic =3D g_new0(qemu_irq, 64);
> =20
> -    dev =3D qdev_create(NULL, TYPE_OPENPIC);
> -    qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_KEYLARGO);
> -    qdev_init_nofail(dev);
> -    s =3D SYS_BUS_DEVICE(dev);
> +    pic_dev =3D qdev_create(NULL, TYPE_OPENPIC);
> +    qdev_prop_set_uint32(pic_dev, "model", OPENPIC_MODEL_KEYLARGO);
> +    qdev_init_nofail(pic_dev);
> +    s =3D SYS_BUS_DEVICE(pic_dev);
>      pic_mem =3D s->mmio[0].memory;
>      k =3D 0;
>      for (i =3D 0; i < smp_cpus; i++) {
> @@ -346,7 +346,7 @@ static void ppc_core99_init(MachineState *machine)
>      }
> =20
>      for (i =3D 0; i < 64; i++) {
> -        pic[i] =3D qdev_get_gpio_in(dev, i);
> +        pic[i] =3D qdev_get_gpio_in(pic_dev, i);
>      }
> =20
>      if (PPC_INPUT(env) =3D=3D PPC_FLAGS_INPUT_970) {
> @@ -369,7 +369,7 @@ static void ppc_core99_init(MachineState *machine)
>      }
> =20
>      /* MacIO */
> -    macio =3D pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO);
> +    macio =3D NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO=
));
>      dev =3D DEVICE(macio);
>      qdev_connect_gpio_out(dev, 0, pic[0x19]); /* CUDA */
>      qdev_connect_gpio_out(dev, 1, pic[0x24]); /* ESCC-B */
> @@ -379,7 +379,9 @@ static void ppc_core99_init(MachineState *machine)
>      qdev_connect_gpio_out(dev, 5, pic[0x0e]); /* IDE */
>      qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE DMA */
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
> -    macio_init(macio, pic_mem);
> +    object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
> +                             &error_abort);
> +    macio_init(PCI_DEVICE(macio), pic_mem);
> =20
>      /* We only emulate 2 out of 3 IDE controllers for now */
>      ide_drive_get(hd, ARRAY_SIZE(hd));
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
> index 843c114c07..4528282b36 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -29,6 +29,7 @@
>  #include "hw/intc/heathrow_pic.h"
>  #include "hw/misc/macio/cuda.h"
>  #include "hw/ppc/mac_dbdma.h"
> +#include "hw/ppc/openpic.h"
> =20
>  #define TYPE_MACIO "macio"
>  #define MACIO(obj) OBJECT_CHECK(MacIOState, (obj), TYPE_MACIO)
> @@ -42,7 +43,6 @@ typedef struct MacIOState {
>      CUDAState cuda;
>      DBDMAState dbdma;
>      ESCCState escc;
> -    MemoryRegion *pic_mem;
>      uint64_t frequency;
>  } MacIOState;
> =20
> @@ -70,6 +70,8 @@ typedef struct NewWorldMacIOState {
>      /*< private >*/
>      MacIOState parent_obj;
>      /*< public >*/
> +
> +    OpenPICState *pic;
>      qemu_irq irqs[7];
>      MACIOIDEState ide[2];
>  } NewWorldMacIOState;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqOKKwACgkQbDjKyiDZ
s5KMgBAArqjmpKYMyFzcrujYo8KD0zNjdRbv4+DEHyMvl8SiieEdMNyZwB7VbvY5
dHyoeiifzyz+fCdL1CUdb/j9smt4IVzrBja0sj9SY9KELK+T1q2WEZrVKtFub2WP
L35RnQDl/4XXcERnLB6Y65szRjTuX1IVlXfnD3tAczh+5TLjtM50lKxpAy89BSAW
Yigim8gXhD+oRpRIhbagitD3x815rt15stYE4MxxvjzZXCSX8lR0zYABXbXBpnZn
ghvkNRPJiC+ouDY4Hzs1DU7HZtEI9r54RhbFh0NwCeGMS+NqdCAertAZJvnDEmfm
MveArnV6WFmlRQM/mjza4W58/cCcNPopMZHolD+nvd/pbDSXPW7EWNHA8dOytzSX
mtVH3inVxLpHLLU7vbTsDOwVVq8q/aEt14uLe8ifzFakCxHLlEoUJXk0RCgM6chN
IfT5J684vTL7fpvXqkrGroskvLkGT2iO/JmywpBG9PfYy4JUWLk9SaB0+Ln2/FPz
UZddGxdfiSe92JpW2VBhgt5eHxxmVY25gpKvov0WKUBviWAnMhhgsZ1OvTqaNOKk
aaqGVlj2AkNx76aVupJLPHVcNEcsT0EKTi6m44aqH5mI/wfgd0U4dszDizo/mhQa
VN8aDbFdYU51Fin3XMikiVUndV8nrtHSN4sufWY++IC9ww2WF6M=
=jaYX
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
