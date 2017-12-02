Received: from eggs.gnu.org ([2001:4830:134:3::10]:58612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLStN-0005kb-GQ
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 06:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLStK-0007vb-Tr
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 06:57:05 -0500
Date: Sun, 3 Dec 2017 10:37:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171202233735.GD2130@umbus.fritz.box>
References: <151224301160.13812.16487624528793386353.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <151224301160.13812.16487624528793386353.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix LSI interrupt specifiers in the
 device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2017 at 08:30:11PM +0100, Greg Kurz wrote:
> PAPR 2.7 C.6.9.1.2 describes the "#interrupt-cells" property of the
> PowerPC External Interrupt Source Controller node as follows:
>=20
> =E2=80=9C#interrupt-cells=E2=80=9D
>=20
>   Standard property name to define the number of cells in an interrupt-
>   specifier within an interrupt domain.
>=20
>   prop-encoded-array: An integer, encoded as with encode-int, that denotes
>   the number of cells required to represent an interrupt specifier in its
>   child nodes.
>=20
>   The value of this property for the PowerPC External Interrupt option sh=
all
>   be 2. Thus all interrupt specifiers (as used in the standard =E2=80=9Ci=
nterrupts=E2=80=9D
>   property) shall consist of two cells, each containing an integer encoded
>   as with encode-int. The first integer represents the interrupt number t=
he
>   second integer is the trigger code: 0 for edge triggered, 1 for level
>   triggered.
>=20
> This patch adds a second cell to the interrupt specifier stored in the
> "interrupts" property of PCI device nodes. This property only exists if
> the Interrupt Pin register is set, ie, the interrupt is level, the extra
> cell is hence set to 1.

Nack.  This format of interrupt specifier is only needed for things
wired directly to the xics.  The PCI INTx interrupts aren't - they go
through the interrupt nexus in the PHB.  The interrupt-map is intended
to remap the simple 1,2,3,4 for INTA..INTD to xics interrupt specifiers.

> This also fixes the interrupt specifiers in the "interrupt-map" property
> of the PHB node, that were setting the second cell to 8 (confusion with
> IRQ_TYPE_LEVEL_LOW ?) instead of 1.

Fixing that is correct, though I think.  As might be the changes in
other places I'll have to check.

> While here, let's introduce defines for the interrupt specifier trigger
> code, and patch other users in spapr.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


> ---
>=20
> This fixes /proc/interrupts in linux guests where LSIs appear as
> Edge instead of Level.
> ---
>  hw/ppc/spapr_events.c  |    2 +-
>  hw/ppc/spapr_pci.c     |    4 +++-
>  hw/ppc/spapr_vio.c     |    3 ++-
>  include/hw/ppc/spapr.h |    3 +++
>  4 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index e377fc7ddea2..4bcb98f948ea 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -283,7 +283,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
>          }
> =20
>          interrupts[0] =3D cpu_to_be32(source->irq);
> -        interrupts[1] =3D 0;
> +        interrupts[1] =3D SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE;
> =20
>          _FDT(node_offset =3D fdt_add_subnode(fdt, event_sources, source_=
name));
>          _FDT(fdt_setprop(fdt, node_offset, "interrupts", interrupts,
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5a3122a9f9f9..91fedbf0929c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1231,6 +1231,8 @@ static void spapr_populate_pci_child_dt(PCIDevice *=
dev, void *fdt, int offset,
>      if (pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)) {
>          _FDT(fdt_setprop_cell(fdt, offset, "interrupts",
>                   pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)));
> +        _FDT(fdt_appendprop_cell(fdt, offset, "interrupts",
> +                                 SPAPR_DT_INTERRUPT_IDENTIFIER_LEVEL));
>      }
> =20
>      if (!is_bridge) {
> @@ -2122,7 +2124,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>              irqmap[3] =3D cpu_to_be32(j+1);
>              irqmap[4] =3D cpu_to_be32(xics_phandle);
>              irqmap[5] =3D cpu_to_be32(phb->lsi_table[lsi_num].irq);
> -            irqmap[6] =3D cpu_to_be32(0x8);
> +            irqmap[6] =3D cpu_to_be32(SPAPR_DT_INTERRUPT_IDENTIFIER_LEVE=
L);
>          }
>      }
>      /* Write interrupt map */
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index ea3bc8bd9e21..29a17651a17c 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -126,7 +126,8 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
>      }
> =20
>      if (dev->irq) {
> -        uint32_t ints_prop[] =3D {cpu_to_be32(dev->irq), 0};
> +        uint32_t ints_prop[] =3D { cpu_to_be32(dev->irq),
> +                                 SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE };
> =20
>          ret =3D fdt_setprop(fdt, node_off, "interrupts", ints_prop,
>                            sizeof(ints_prop));
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9d21ca9bde3a..8f6298bde59b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -590,6 +590,9 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *=
fdt, hwaddr addr);
> =20
>  #define RTAS_EVENT_SCAN_RATE    1
> =20
> +#define SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE  0
> +#define SPAPR_DT_INTERRUPT_IDENTIFIER_LEVEL 1
> +
>  typedef struct sPAPRTCETable sPAPRTCETable;
> =20
>  #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlojOTwACgkQbDjKyiDZ
s5I1IxAA3WGmfLtzeRMUMuCC8JTjWAFKy0TkoXFYPW2wmghS5KgkCND0kcHGcXjq
GXF1F2xCQ+EHGYTrNyvK88/vhGTPfB+wQgwIvJ/FJuHNCHTmWpuO5VdRSV7DZsjE
jVNAS9M2s9RHH0jnxtcaZ15Deg4/WF9CCmDHGBOz1XMr6uLCzSUCLFvRajoW1dGK
WC0c6xg1qxEjtPbDDkX+5E8xFnWh0mzOUC58rU97sJ0y686aUbwwH/19+TwuuBX1
LRtWsVcArJlH62AtSGJfH6zgnbMjLbbqKDNTqdZjKfR/u5jq62rIYYY35KO40/5l
R8lD2Mf+44HEDy85TADHltj4RTxGoEtKM6Iv1uH/70qxvg5+1dcsizqKMx7BOlMw
s+kNAYKxGVJRbi1Zwjj/R6XrNALmAutG9LupZXbCj5Scs0JAIhMe9ACIS0rNpRcW
JkPq4l7UehvBHMpg65wNOGV97M1HFKgu7xcnjg42WxW8dWrpeIV1Az1FrfvZHa4M
Z6Oavop4ziw3X1zMqoUDqMwBm/wP2R4iUt49MVSmuduXZhPJ8uOgVPGFjeLrAAok
8UslBtdXWz4sKghsMx24iSEXyznGMiGK9CXrGJkenI66pwxdHV51hv7zUlPCyXMK
Hhe0QeRQ1U/ogt8N9bfcjrQwbcfZq2A9vCoiybh9IXH23IhaR08=
=f8aX
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
