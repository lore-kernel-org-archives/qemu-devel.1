Received: from eggs.gnu.org ([2001:4830:134:3::10]:53344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02p-0004F0-5G
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02m-0002DJ-Mv
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:51 -0400
Date: Wed, 14 Mar 2018 16:44:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180314054437.GL4182@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-7-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKtFalx5NIx0HZ72"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-7-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 06/19] uninorth: alter pci_pmac_init() and
 pci_pmac_u3_init() to return uninorth device
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


--tKtFalx5NIx0HZ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:50PM +0000, Mark Cave-Ayland wrote:
> This is in preparation for moving the device wiring into the New World ma=
chine.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.13.

> ---
>  hw/pci-host/uninorth.c | 16 ++++++++--------
>  hw/ppc/mac.h           | 10 ++++++----
>  hw/ppc/mac_newworld.c  | 10 ++++++++--
>  3 files changed, 22 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 600d675573..b081e3c153 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -166,9 +166,9 @@ static void pci_unin_internal_init(Object *obj)
>      sysbus_init_mmio(sbd, &h->data_mem);
>  }
> =20
> -PCIBus *pci_pmac_init(qemu_irq *pic,
> -                      MemoryRegion *address_space_mem,
> -                      MemoryRegion *address_space_io)
> +UNINState *pci_pmac_init(qemu_irq *pic,
> +                         MemoryRegion *address_space_mem,
> +                         MemoryRegion *address_space_io)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -228,12 +228,12 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
>      sysbus_mmio_map(s, 1, 0xf4c00000);
>  #endif
> =20
> -    return h->bus;
> +    return d;
>  }
> =20
> -PCIBus *pci_pmac_u3_init(qemu_irq *pic,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io)
> +UNINState *pci_pmac_u3_init(qemu_irq *pic,
> +                            MemoryRegion *address_space_mem,
> +                            MemoryRegion *address_space_io)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -265,7 +265,7 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
> =20
>      pci_create_simple(h->bus, 11 << 3, "u3-agp");
> =20
> -    return h->bus;
> +    return d;
>  }
> =20
>  static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index a02f797598..fcf13cb757 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -31,6 +31,8 @@
>  #include "hw/ide/internal.h"
>  #include "hw/input/adb.h"
>  #include "hw/misc/mos6522.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/pci-host/uninorth.h"
> =20
>  /* SMP is not enabled, for now */
>  #define MAX_CPUS 1
> @@ -86,12 +88,12 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
>                           MemoryRegion *address_space_io);
> =20
>  /* UniNorth PCI */
> -PCIBus *pci_pmac_init(qemu_irq *pic,
> -                      MemoryRegion *address_space_mem,
> -                      MemoryRegion *address_space_io);
> -PCIBus *pci_pmac_u3_init(qemu_irq *pic,
> +UNINState *pci_pmac_init(qemu_irq *pic,
>                           MemoryRegion *address_space_mem,
>                           MemoryRegion *address_space_io);
> +UNINState *pci_pmac_u3_init(qemu_irq *pic,
> +                            MemoryRegion *address_space_mem,
> +                            MemoryRegion *address_space_io);
> =20
>  /* Mac NVRAM */
>  #define TYPE_MACIO_NVRAM "macio-nvram"
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 3410bb13ad..34908d0dd7 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -152,6 +152,7 @@ static void ppc_core99_init(MachineState *machine)
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
>      hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
>      long kernel_size, initrd_size;
> +    UNINState *uninorth_pci;
>      PCIBus *pci_bus;
>      NewWorldMacIOState *macio;
>      MACIOIDEState *macio_ide;
> @@ -345,10 +346,12 @@ static void ppc_core99_init(MachineState *machine)
> =20
>      if (PPC_INPUT(env) =3D=3D PPC_FLAGS_INPUT_970) {
>          /* 970 gets a U3 bus */
> -        pci_bus =3D pci_pmac_u3_init(pic, get_system_memory(), get_syste=
m_io());
> +        uninorth_pci =3D pci_pmac_u3_init(pic, get_system_memory(),
> +                                        get_system_io());
>          machine_arch =3D ARCH_MAC99_U3;
>      } else {
> -        pci_bus =3D pci_pmac_init(pic, get_system_memory(), get_system_i=
o());
> +        uninorth_pci =3D pci_pmac_init(pic, get_system_memory(),
> +                                     get_system_io());
>          machine_arch =3D ARCH_MAC99;
>      }
> =20
> @@ -361,6 +364,9 @@ static void ppc_core99_init(MachineState *machine)
>          tbfreq =3D TBFREQ;
>      }
> =20
> +    /* init basic PC hardware */
> +    pci_bus =3D PCI_HOST_BRIDGE(uninorth_pci)->bus;
> +
>      /* MacIO */
>      macio =3D NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO=
));
>      dev =3D DEVICE(macio);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tKtFalx5NIx0HZ72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqotsUACgkQbDjKyiDZ
s5L4cBAA2XurxRSd7LV1bfE3wLSX3mxsifw/um5acJpClHi87j1vTWlxB/npZGJS
fT/dzpExzf7wdrBCqyp8mD7t4EKiEjyr3IEwjKrcMKlRbGxlg2sn6G3d0ldQNFAJ
Rjb92iDcBrncJPB28GM1+17GLQpGCjjsYoZgkoLcvOMlWh8gvZQ8wjjRvh/LPFN+
blTQ81+g0c6BnhRaprkHVehvLQ/0I5ehQ/G2LboP0xWv0Qu+ZVjWMmgQHl7/Z2AV
qnGFq10I6ivnDw28vPrVn1V8fJnXm2f3O0XKZb0YPdTKG87JaCxEqy39bQq3HHD0
soE8uZpcGhnmE/84DnHgBWqeuo2qdn5/lJ6IDBzQ2CrGiIHtXaSP0UbVD27IRzse
WQtuvPVJNTQ90LPfv4MiD3G8UHv8LWedU4hJftXBBmW7nvW1gCI/cLAeq2jaLOBd
9UNQzKEuDk0cO/NrwsLQSWcZaCB5eiRsZdYJM3OlRW8o5/21/yDvXRMn5ev0dJgG
QN3+sJgFOJT91ZkVAWGKtNGUMZP49p+Jwen8zLglG4Kf54nEaKUR7gW0axvdQFRf
Gti/0ihdWiWS4E+6mmUNsVpzaFQX4pndqNJPJozjfheIHhqCeCutiaFnp7ptiafW
uQIGG6SSAbHe1gCeeJl7Vzdy/2vS9JGLhkV5n3B50ND3scrBTGM=
=yuja
-----END PGP SIGNATURE-----

--tKtFalx5NIx0HZ72--
