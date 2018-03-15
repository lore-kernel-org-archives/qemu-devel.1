Received: from eggs.gnu.org ([2001:4830:134:3::10]:39939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewGos-00071b-Vt
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 20:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewGop-0002TC-S9
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 20:32:34 -0400
Date: Thu, 15 Mar 2018 11:19:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180315001910.GA4525@umbus.fritz.box>
References: <20180314173336.20055-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180314173336.20055-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix tlbsync to check privilege
 level depending on GTSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 06:33:36PM +0100, C=E9dric Le Goater wrote:
> tlbsync also needs to check the Guest Translation Shootdown Enable
> (GTSE) bit in the Logical Partition Control Register (LPCR) to
> determine at which privilege level it is running.
>=20
> See commit c6fd28fd573d ("target/ppc: Update tlbie to check privilege
> level based on GTSE")
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  This will have its importance when we activate the HV bit on the
>  POWER9 CPU for the PowerNV machine.
>=20
>  target/ppc/translate.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied to ppc-for-2.12, thanks.

>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0a0c090c9978..218665b4080b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4526,7 +4526,7 @@ static void gen_tlbie(DisasContext *ctx)
>      TCGv_i32 t1;
> =20
>      if (ctx->gtse) {
> -        CHK_SV; /* If gtse is set then tblie is supervisor privileged */
> +        CHK_SV; /* If gtse is set then tlbie is supervisor privileged */
>      } else {
>          CHK_HV; /* Else hypervisor privileged */
>      }
> @@ -4553,7 +4553,12 @@ static void gen_tlbsync(DisasContext *ctx)
>  #if defined(CONFIG_USER_ONLY)
>      GEN_PRIV;
>  #else
> -    CHK_HV;
> +
> +    if (ctx->gtse) {
> +        CHK_SV; /* If gtse is set then tlbsync is supervisor privileged =
*/
> +    } else {
> +        CHK_HV; /* Else hypervisor privileged */
> +    }
> =20
>      /* BookS does both ptesync and tlbsync make tlbsync a nop for server=
 */
>      if (ctx->insns_flags & PPC_BOOKE) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqpu/sACgkQbDjKyiDZ
s5Lz1w/9F99wUiAunzftcV0LCPYH5u7OoHQjVNczUDeJiQPJ2xbnMGQUbHuxQOfa
AscU/MO2pXqiOeRyU+vXCIXyPEBVPeCCO0vQbu4J7IfVztNaq4K6g38y1+15f+9V
bmoindyzMesIkVAV8nhgA1gFLKlUiEIUwVWgqy+gMupWSNln9OYQDiWJCEqyRO3g
Bium0W5kLS5679NaYnEFxrp1afxxSYkWro1Nw9bvSjBjKzG1WbU2Hxa+FsGcoSKv
Ju2A2X9jWZ+TqD5CfnBuCUZ1CuNg0/i96nrz/N8KLWY+kVjHviBIfzQxDp77sZiu
kiXoPn/ymLk6ibyNS9b4ta7PXGqhGiTyCxpFDFn2LlTDtj839H5bMhk04p8nyIde
eDtClLdnsEpXT9Cq6qLCXn3yzKciGQAjXUH5ISjSdyLL00lwuvt8kIN3uUVN/6dW
Ody0c7LOKAq9WsnPm8zdMGXGdyNccolec0KevQwiG23dvWzDk1yaXU2RwayrmKWA
pjzfSlvCI7UNocyyGa1oHAk8bIfE3W4c3iLiTRA4JwidG+jHViwMQ6I1/o+ANjYN
wEIrurxNYaUOwx22TxaJW1fE44EjnT0vf4YrSr5nC27fJk012PmioK6jjqSfMYtk
UgLkMX4lwpEpFBvX3U1+vD2arEQBC0Jg6t6aaUCFcZO5JmFaUkk=
=jOzC
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
