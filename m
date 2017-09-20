Received: from eggs.gnu.org ([2001:4830:134:3::10]:58665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duUUB-0002ME-0f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duUU9-0004Ub-Jl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:11:34 -0400
Date: Wed, 20 Sep 2017 10:59:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920005927.GA5520@umbus.fritz.box>
References: <150583026752.26236.7284148199846043137.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <150583026752.26236.7284148199846043137.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: introduce helpers to migrate HPT
 chunks and the end marker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 04:11:07PM +0200, Greg Kurz wrote:
> This consolidates some duplicated code in a dedicated helpers.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
> v2: - open-code writes for the end marker
> ---
>  hw/ppc/spapr.c |   38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f680f28a15ea..c18c36da71d6 100644
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
> +    qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
> +                    HASH_PTE_SIZE_64 * n_valid);
> +}
> +
> +static void htab_save_end_marker(QEMUFile *f)
> +{
> +    qemu_put_be32(f, 0);
> +    qemu_put_be16(f, 0);
> +    qemu_put_be16(f, 0);
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

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnBvW0ACgkQbDjKyiDZ
s5IOHQ/9GtwkzpbgTZ3pEPmTKqjU44KYGVY9sbiL2mj+yeQdjcmFSylm4MSH18Kz
KCtcBroxoCZ0zZlLlGBEPf+6AXxfQV0YrOdIW/zDe5mKlTxD6hKAM+2/Md5sN0t1
nEfCcVhzEeoN1FbmBQgHT9nZX0kuIaeFn+ZdevGl7mLZ7f5jWp2do3RMVfqwS1q9
PoNn84RvZpnHWLbi4D9wajLpEs9ejQRJBAjcg/KFoxOYpSYtE4ATtV5RA0t2Ji4q
CufV9HFIvwkjvQop0cjMxrJJxkfF9Zh70oVr1xxY8MYI/CI5riFsfvWEhsMBqbK1
jIWzcXfY05zEhneRMf6bfe6uoYKvMQZ2RsGBweBdjMNyDBblQLqhXwmcy3CB/FG0
zgJIgKPD5TOShH9TgbIGjmrPCsSHAYgV0vhLoeoyqUCFQNUW0qAneLauqiC/g4GL
HuwgWjYzL3QTdKtjS+Rke0LWsToISnmzM9ATgcKM7PpONVfbRzwRAbsBqjWUi/30
Z1Is9hJ+H08KKNSCDByLde/6oHmiJXnOHoOrowyfhcUJM0dQ3M1E47i+TwM3MdMt
hL9X1RA+jx3JUiANPTosA5IrdlXt88cblWIwr4wQmkFHRMTJmf4X1sS0mKF3IVmN
kVKpGcs5ciE6e7KJTfyeD3d6e455FqXGpI2hoLIYd8FrGIYxj7I=
=x4zR
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
