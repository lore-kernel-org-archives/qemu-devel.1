Received: from eggs.gnu.org ([2001:4830:134:3::10]:36358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawrD-0003FB-12
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr9-0007sY-AH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:32 -0400
Date: Fri, 28 Jul 2017 13:52:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728035242.GH3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100576156.27487.15628232978800114846.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Content-Disposition: inline
In-Reply-To: <150100576156.27487.15628232978800114846.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 22/26] spapr_pci: provide node
 start offset via spapr_populate_pci_dt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:02:41PM +0200, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> PHB hotplug re-uses PHB device tree generation code and passes
> it to a guest via RTAS. Doing this requires knowledge of where
> exactly in the device tree the node describing the PHB begins.
>=20
> Provide this via a new optional pointer that can be used to
> store the PHB node's start offset.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Blech.  The patch is correct and you can't do much better at the
moment.  I really hope in the next cycle I get a chance to do a bunch
of the DT construction cleanups which should avoid this messy passing
of dt offsets around.

> ---
> Changes since RFC:
> - rebased against ppc-for-2.10
> ---
>  hw/ppc/spapr.c              |    2 +-
>  hw/ppc/spapr_pci.c          |    6 +++++-
>  include/hw/pci-host/spapr.h |    3 ++-
>  3 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 632040f35ecc..1a6cd4efeb97 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1098,7 +1098,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      }
> =20
>      QLIST_FOREACH(phb, &spapr->phbs, list) {
> -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt);
> +        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, NULL);
>          if (ret < 0) {
>              error_report("couldn't setup PCI devices in fdt");
>              exit(1);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index b73e099e0285..79f10ff453d0 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2109,7 +2109,8 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
> =20
>  int spapr_populate_pci_dt(sPAPRPHBState *phb,
>                            uint32_t xics_phandle,
> -                          void *fdt)
> +                          void *fdt,
> +                          int *node_offset)
>  {
>      int bus_off, i, j, ret;
>      char nodename[FDT_NAME_MAX];
> @@ -2166,6 +2167,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      if (bus_off < 0) {
>          return bus_off;
>      }
> +    if (node_offset) {
> +        *node_offset =3D bus_off;
> +    }
> =20
>      /* Write PHB properties */
>      _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 31bae68167f2..7837fb0b1110 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -115,7 +115,8 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
> =20
>  int spapr_populate_pci_dt(sPAPRPHBState *phb,
>                            uint32_t xics_phandle,
> -                          void *fdt);
> +                          void *fdt,
> +                          int *node_offset);
> =20
>  void spapr_pci_rtas_init(void);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6tQoACgkQbDjKyiDZ
s5KXpA//R0KkIOyRjbqo9yXrcTnCgU9XJdz7C9XNZtSYcbkdN4jILRb46i5kY7Ma
SjyhyIGhTRfT+NWT9jO10QhMk4ZQdh+rlQG5PeMz6vE+pTYlPUmxP8CYtxPdJr0W
7MMgF0+4P2HKrNOhU/gZZCSJvO7qTmNGqiLos8XPBCWezvlA+K1TNNpaE1BskUm0
bMcGvakYW56UbEr0bziu8ekTDhTTuNM7iogzVaHeORrA0hosanOtvTU/F3rKOwBk
qnasMkIum8Tf4o0CyQy4uDybwQ9I99iZ3FoiElxjFfSWUlW2mji1hFDp/wc/ewRv
KYKaQ7BeebFQPiieWotp/yB60L7oXDwM2kosABmoNFHaz77VetZ31L/b8S3Dr807
uNRwIaIlCyy/4fUYQPa9/UaCIiqfyW7aK4i8O7tOn7PVKgGrv1wgjUAOtzreYJFZ
u64dUUorsq/V4QODNjIz3q6TnTbOdLKUPYKizYN0NDyDE0XdX5llUpBSGHzWSygT
4k3cNKmdiJod2Pl26E+y0NEgp0gZOy3lqb/qQV5NaP/vAIqEQ8w8ibTMIdDMNgmT
0F8bkdtlAE+nKcTmbhWQiNDhuhmJKOQCY0NLrxiCNIkwJovaFSqqBRIS7c6Ik0co
esdI8ch5MlzVrRJrEfmFmaseBLaAT49PVdZDc3rQTc/wWex/mo4=
=m1Z8
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--
