Received: from eggs.gnu.org ([2001:4830:134:3::10]:42987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKLs0-0006k2-ST
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKLrw-0006EG-Tg
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:42:48 -0400
Date: Mon, 12 Jun 2017 17:10:44 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170612091044.GE18542@umbus>
References: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1497245555-32472-2-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <1497245555-32472-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] spapr: Add a "no HPT" encoding to
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


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 11:02:34AM +0530, Bharata B Rao wrote:
> Add a "no HPT" encoding (using value -1) to the HTAB migration
> stream (in the place of HPT size) when the guest doesn't allocate HPT.
> This will help the target side to match target HPT with the source HPT
> and thus enable successful migration.
>=20
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8b541d9..c425499 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1558,13 +1558,19 @@ static int htab_save_setup(QEMUFile *f, void *opa=
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
> @@ -1710,7 +1716,12 @@ static int htab_save_iterate(QEMUFile *f, void *op=
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
> @@ -1744,7 +1755,12 @@ static int htab_save_complete(QEMUFile *f, void *o=
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

Do you actually need the modifications for _iterate and _complete?  I
would have thought you just wouldn't need to send any more of the HPT
stream at all after sending the -1 header. =20

We should also adjust the downtime estimation logic so we don't allow
for transferring an HPT that isn't there.

>      if (!spapr->htab) {
>          int rc;
> @@ -1788,6 +1804,11 @@ static int htab_load(QEMUFile *f, void *opaque, in=
t version_id)
> =20
>      section_hdr =3D qemu_get_be32(f);
> =20
> +    if (section_hdr =3D=3D -1) {
> +        spapr_free_hpt(spapr);
> +        return 0;
> +    }

Strictly speaking we probably shouldn't just return here.  We should
wait and see if there is more data in the stream.  Any actual content
(i.e. section_hdr =3D=3D 0 sections) would be an error at this point.
However, a reset to an HPT guest would be represented by a new
non-zero section header, then more data.  This isn't urgent, but it
would be nice to fix at some point.

>      if (section_hdr) {
>          Error *local_err =3D NULL;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPlqSAAoJEGw4ysog2bOSQv4QAIoNH2qAn32iYsMkndn3RNHo
IaUnRDkHMY7mIoLbyAw6gOXtWhHv2hQHfMx801VhkHx+LeU80X0QIvtAXuxKf0m7
JK+pD5Uhsvaa3IrprNj5buxzoqQKZGqvwnqRhHqlQ6bqbzB+OoLnZ1GQS2T5mKYf
kdV7rknBj/c02noL9vfhuwPkeH67gWtikixzWkE9s31WBiOr9Up8Te7In5/8dWSj
89oBYJIUPx9jd18FjNRk2qOngJCS3uJiBnTn93TnTQZEgb5iOtc5ThJkRQkRwNiC
FFUWVuDgHOIf679yZP5EUDuR6INnWrlVivY/eynZHeCFHAVK2Va+zEfHVQ/B2s0A
5cBj2WTx9G7Du5lelz2W3njvxke6lr6ul9WKkx5/0zbEKSPb632hPWLuROufYmv8
scxZAG+OUVqU7IcPzJtmITVojt5kFuyoyBulgrZXHMJioIrijOuoKUbyf/os11gl
qalnUo64GpzX5eaoCj64JRQOVP0+11Xr8nk5+PUhQGryHgX82ASijmHLaJi6Uhwk
mFUAy/MeJeTEMHo3vAzY0gYnXkqnS0CzwF7kj+cqXr86m+lYvOtQqMg5rTw0Xikt
mm4LsFBpCVW7h/Jf98ddSt6G42KJEwQpFZ2BoacR81x7UcwooWE5nPTrA/cVa1to
PqO6BSnloEnczm8mgq4N
=oR0/
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
