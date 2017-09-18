Received: from eggs.gnu.org ([2001:4830:134:3::10]:51065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtS-0001B1-Sm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtQ-0002na-Rm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:42 -0400
Date: Tue, 19 Sep 2017 07:11:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918211129.GB27153@umbus>
References: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
	<150548136111.5945.6437882724141726495.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <150548136111.5945.6437882724141726495.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/4] spapr: introduce helpers to migrate
 HPT chunks and the end marker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 03:16:01PM +0200, Greg Kurz wrote:
> This consolidates some duplicated code in a single helper.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c |   38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f680f28a15ea..841117f6d185 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1708,6 +1708,23 @@ static int htab_save_setup(QEMUFile *f, void *opaq=
ue)
>      return 0;
>  }
> =20
> +static void htab_save_chunk(QEMUFile *f, sPAPRMachineState *spapr,
> +                            int chunkstart, int n_valid, int n_invalid)
> +{
> +    qemu_put_be32(f, chunkstart);
> +    qemu_put_be16(f, n_valid);
> +    qemu_put_be16(f, n_invalid);
> +    if (spapr) {

I like the basic idea, but passing NULL for spapr is *only* valid for
the end marker case.  The general test here is misleading.  I'd prefer
to either see the writes opencoded for the end marker, or have an
assert here (spapr can only be NULL if n_valid =3D=3D n_invalid =3D=3D 0).

> +        qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
> +                        HASH_PTE_SIZE_64 * n_valid);
> +    }
> +}
> +
> +static void htab_save_end_marker(QEMUFile *f)
> +{
> +    htab_save_chunk(f, NULL, 0, 0, 0);
> +}
> +
>  static void htab_save_first_pass(QEMUFile *f, sPAPRMachineState *spapr,
>                                   int64_t max_ns)
>  {
> @@ -1739,11 +1756,7 @@ static void htab_save_first_pass(QEMUFile *f, sPAP=
RMachineState *spapr,
>          if (index > chunkstart) {
>              int n_valid =3D index - chunkstart;
> =20
> -            qemu_put_be32(f, chunkstart);
> -            qemu_put_be16(f, n_valid);
> -            qemu_put_be16(f, 0);
> -            qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
> -                            HASH_PTE_SIZE_64 * n_valid);
> +            htab_save_chunk(f, spapr, chunkstart, n_valid, 0);
> =20
>              if (has_timeout &&
>                  (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - starttime) > m=
ax_ns) {
> @@ -1805,11 +1818,7 @@ static int htab_save_later_pass(QEMUFile *f, sPAPR=
MachineState *spapr,
>              int n_valid =3D invalidstart - chunkstart;
>              int n_invalid =3D index - invalidstart;
> =20
> -            qemu_put_be32(f, chunkstart);
> -            qemu_put_be16(f, n_valid);
> -            qemu_put_be16(f, n_invalid);
> -            qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
> -                            HASH_PTE_SIZE_64 * n_valid);
> +            htab_save_chunk(f, spapr, chunkstart, n_valid, n_invalid);
>              sent +=3D index - chunkstart;
> =20
>              if (!final && (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - star=
ttime) > max_ns) {
> @@ -1872,10 +1881,7 @@ static int htab_save_iterate(QEMUFile *f, void *op=
aque)
>          rc =3D htab_save_later_pass(f, spapr, MAX_ITERATION_NS);
>      }
> =20
> -    /* End marker */
> -    qemu_put_be32(f, 0);
> -    qemu_put_be16(f, 0);
> -    qemu_put_be16(f, 0);
> +    htab_save_end_marker(f);
> =20
>      return rc;
>  }
> @@ -1915,9 +1921,7 @@ static int htab_save_complete(QEMUFile *f, void *op=
aque)
>      }
> =20
>      /* End marker */
> -    qemu_put_be32(f, 0);
> -    qemu_put_be16(f, 0);
> -    qemu_put_be16(f, 0);
> +    htab_save_end_marker(f);
> =20
>      return 0;
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnANn4ACgkQbDjKyiDZ
s5KH2g/+Ng+rdEUhxwBj+X+7VEfWuNDb+AwysuZH8SVdJRvnryMDhnKcbz2hzcF+
CPnvuztzVFV5Q0P38uau95ad3mUkmnstvJwGgudjyEPcv7ZRjmAkHc5/Fx4B4WXi
obu/O+aaqJvF4GfNL1bBYQQCjRHCT/vMRMEL0YGmay5Htv06uLU0muSqrMLiGj37
lve9IzEUtaCGuQYJBn1KrBQ7XqE65QJiP1XJ7QLV69OAinZQVWwKSqfaD3U5m0kb
tfdKAZg3DQNY29ubHTY6LH6N/C65KACuIUCf/vujatChiP/pNdDKAjrL2thsnZFA
Qw4UnedpVGFs0G03pBqdMncvODwsDNr0i6YCLhr+RMubOGCCBY2WQ7McCzUcGjN2
K0KVQeBHs11wDbn2bF/F7ZL6dQsX9xDk2pRWfsS+a+tcNGZDGYHREG+6hwvAW/Z+
VcckeaS7Oo9m5mZ2zlAi7Omy82Y4jnlfhVV0VRuvediGSAWzihfdVkByN2dQ6bFK
7xgCJJV/wSylHqGuUckQBBqZMsMiXsnln9MENdjLXrdSmc6Vq2ctPTgcvDPLE6bp
JNST4Y81MtQ0qhS4pDC7D5Gx76XXgJMQ19aK4+PEfzek+zhsDZD1vEMY2XZlC9yz
RA+F9vqP/Gd8xsk10uw7rTq53rH4TDoDOR7GDRD3V/3B9NNpJ6A=
=4feO
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
