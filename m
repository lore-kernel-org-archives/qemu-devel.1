Received: from eggs.gnu.org ([2001:4830:134:3::10]:58989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIp4w-0001Zr-Oc
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIp4s-0002un-Sc
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:29:50 -0400
Date: Thu, 8 Jun 2017 14:28:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608042848.GA13397@umbus.fritz.box>
References: <1496822093-5700-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1496822093-5700-2-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NSyv3PxMn0vTUI/G"
Content-Disposition: inline
In-Reply-To: <1496822093-5700-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/2] spapr: Add a "no HPT" encoding to
 HTAB migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com


--NSyv3PxMn0vTUI/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 01:24:52PM +0530, Bharata B Rao wrote:
> Add a "no HPT" encoding (using value -1) to the HTAB migration
> stream (in the place of HPT size) when the guest doesn't allocate HPT.
> This will help the target side to match target HPT with the source HPT
> and thus enable successful migration.
>=20
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

As dicussed in the thread on the previous version, I still think you
can use section_hdr =3D=3D 0 as the no-HPT encoding (matching htab_shift
=3D=3D 0.

> ---
>  hw/ppc/spapr.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 86e6228..df27c5c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1557,13 +1557,19 @@ static int htab_save_setup(QEMUFile *f, void *opa=
que)
>      sPAPRMachineState *spapr =3D opaque;
> =20
>      /* "Iteration" header */
> -    qemu_put_be32(f, spapr->htab_shift);
> +    if (!spapr->htab_shift) {
> +        qemu_put_be32(f, -1);
> +    } else {
> +        qemu_put_be32(f, spapr->htab_shift);
> +    }
> =20
>      if (spapr->htab) {
>          spapr->htab_save_index =3D 0;
>          spapr->htab_first_pass =3D true;
>      } else {
> -        assert(kvm_enabled());
> +        if (spapr->htab_shift) {
> +            assert(kvm_enabled());
> +        }
>      }
> =20
> =20
> @@ -1709,7 +1715,12 @@ static int htab_save_iterate(QEMUFile *f, void *op=
aque)
>      int rc =3D 0;
> =20
>      /* Iteration header */
> -    qemu_put_be32(f, 0);
> +    if (!spapr->htab_shift) {
> +        qemu_put_be32(f, -1);
> +        return 0;
> +    } else {
> +        qemu_put_be32(f, 0);
> +    }
> =20
>      if (!spapr->htab) {
>          assert(kvm_enabled());
> @@ -1743,7 +1754,12 @@ static int htab_save_complete(QEMUFile *f, void *o=
paque)
>      int fd;
> =20
>      /* Iteration header */
> -    qemu_put_be32(f, 0);
> +    if (!spapr->htab_shift) {
> +        qemu_put_be32(f, -1);
> +        return 0;
> +    } else {
> +        qemu_put_be32(f, 0);
> +    }
> =20
>      if (!spapr->htab) {
>          int rc;
> @@ -1787,6 +1803,10 @@ static int htab_load(QEMUFile *f, void *opaque, in=
t version_id)
> =20
>      section_hdr =3D qemu_get_be32(f);
> =20
> +    if (section_hdr =3D=3D -1) {

You should free the existing HPT (if any) here.

> +        return 0;
> +    }
> +
>      if (section_hdr) {
>          Error *local_err =3D NULL;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NSyv3PxMn0vTUI/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZONJ/AAoJEGw4ysog2bOStxwP/0+PtXv/3ZgjWCE54gBLmc0Q
1ZSV/4MeTqI6NGk3IxByEIwAxm2RjLdSO92k0oC0wnPJ8RnSdFCYSUFHrVUr7o4L
0OMlpQrdDJinN/NAC16bkVcL4hxaeBmwXy2Wl86eb9OaWSfoAf3ykb7EneDba7q8
A6LBn0pGwbpYpu+qzG2/IBzb5ucjTXjlU9BrEDigvFsSwjj1wSIS3kzk6dJ53ND6
VoftkXXoehJ4DE/g5hpHhFHynmkiMGTK1q+V7gQqa8ZaG4pWTrJsIobcG7f24bgd
ISjrZn1iUNQOMZQPbwcE0p0kvlHgso5Y5Esy/zy+Zx7CyJI73cENH4/Lk3/WwYvD
o8xBFc20frYzuDeD4CbJXl57/AS/BCMZTAGJ0Hb4t72jDSXxDJeQxo4yZ2eMxo8G
C7AAqptplgLGplHCvdCogwg87FA7QxJhmp8Rw+QNtfDLHFHmeIt6Ejza1U5/OxxH
kt0IjSAVx7tRCW2YJ2dU08r+Fe8IN39Llj7InzccOyfqLBH86Ov8e3RW1qUu8eJ6
9fOOsB5jZgwWX3CLYfaDe9g8jYZy6sYxhfm/gu/RyR67cB2MOWZo2BaqFjL8JAvL
fpbxVMYDW9H5+MXgYebqJFdLTpP6zWMmcyWIQ1/U1y6xmORyyfHr1Juy4Q72I8wi
THZHwWx4M9evXdioHtee
=8C8U
-----END PGP SIGNATURE-----

--NSyv3PxMn0vTUI/G--
