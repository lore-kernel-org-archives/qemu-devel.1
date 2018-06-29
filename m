Received: from eggs.gnu.org ([2001:4830:134:3::10]:48991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYl3e-0008HV-VA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYl3d-0003Xp-MZ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:30:54 -0400
Date: Fri, 29 Jun 2018 14:16:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629041632.GF3422@umbus.fritz.box>
References: <20180624231248.6827-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline
In-Reply-To: <20180624231248.6827-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fpu_helper.c: fix setting FPSCR[FI] bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 24, 2018 at 07:12:48PM -0400, John Arbuckle wrote:
> The FPSCR[FI] bit indicates if the last floating point instruction had a =
result that was rounded. Each consecutive floating point instruction is sup=
pose to set this bit to the correct value. What currently happens is this b=
it is not set as often as it should be. I have verified that this is the be=
havior of a real PowerPC 950. This patch fixes that problem by deciding to =
set this bit after each floating point instruction.
>=20
> https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-en=
vironments-for-32-e3087633.html
> Page 63 in table 2-4 is where the description of this bit can be found.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

I'm not sure it's the nicest way to fix it, but the existing code is
pretty horrible, so, whatever.

It looks correct, so, applied to ppc-for-3.0.

> ---
>  target/ppc/fpu_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index d31a933cbb..9c841864c8 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -274,6 +274,7 @@ static inline void float_inexact_excp(CPUPPCState *en=
v)
>  {
>      CPUState *cs =3D CPU(ppc_env_get_cpu(env));
> =20
> +    env->fpscr |=3D 1 << FPSCR_FI;
>      env->fpscr |=3D 1 << FPSCR_XX;
>      /* Update the floating-point exception summary */
>      env->fpscr |=3D FP_FX;
> @@ -505,6 +506,7 @@ static void do_float_check_status(CPUPPCState *env, u=
intptr_t raddr)
>  {
>      CPUState *cs =3D CPU(ppc_env_get_cpu(env));
>      int status =3D get_float_exception_flags(&env->fp_status);
> +    bool inexact_happened =3D false;
> =20
>      if (status & float_flag_divbyzero) {
>          float_zero_divide_excp(env, raddr);
> @@ -514,6 +516,12 @@ static void do_float_check_status(CPUPPCState *env, =
uintptr_t raddr)
>          float_underflow_excp(env);
>      } else if (status & float_flag_inexact) {
>          float_inexact_excp(env);
> +        inexact_happened =3D true;
> +    }
> +
> +    /* if the inexact flag was not set */
> +    if (inexact_happened =3D=3D false) {
> +        env->fpscr &=3D ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
>      }
> =20
>      if (cs->exception_index =3D=3D POWERPC_EXCP_PROGRAM &&

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1sqAACgkQbDjKyiDZ
s5Iiig//TDeLnVINVJrta0pDQeDiPBoEV7aoRty7BAMsA1Jyr7d9XIDjYiD1ebAk
tbLeZhvSIqzY/gLU9LWYPC8gPFKdD9+54AEZcNQid3zCQQ/vdcX8dJhz8ssoIf32
twrpBLHQ18n4bHRi2MqQG01NTIVUODFbPzM8kZ2TOzcbaXMnDytDzwA8dKOA7uyi
xi9Q8Ifm/GBM9FGNP2L9q9NycNPAxPcylAwZMgX9KyZBFO2Dcx26owl+Wwb4JJe/
yEPvNFBDO6u0x7cbA8pWpLk5Cg/sCgDKYiJwWvbgm/MNJ8/IWoF2P5ZennqJ3yxJ
I/bYDRWyfnY4C1AxJGEdF49ameeuDibm0fu3xfi0ggh9PJxLu1hS5oTrR2sNgrY3
zLaCyW938e05ajH+B/dElsyLSGOCZzqTbDA/AGNqZ8CFG/ffk4ZMwhv+8lyW7I6m
FRY7XWLJk1uLrXAwK10EAlZosVVuel3TnleG3B+hRl357o0LiKsuCc2hgaauoB4+
DhyUYk/DXQLap5TWGiCoiKPYoFmfvlKb58lKDEFix968ohjH9rCRZoC4EvhglGGu
kJEGPbA9CeKwybV9k5OA+4i6VEB5ntbXAWf0ucSypLHgqQpXsCkpz3zJnqaJwqrF
CilxmceR2CK/4wUzrVa4y38vI50nOWSlPgPqqOy3b55ByC/L91I=
=5R2I
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
