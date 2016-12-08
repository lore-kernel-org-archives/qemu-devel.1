Received: from eggs.gnu.org ([2001:4830:134:3::10]:60692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xn-0005HD-Jo
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xk-0002TF-HV
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:03 -0500
Date: Fri, 9 Dec 2016 09:26:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161208222618.GD13139@umbus.fritz.box>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481135102-20011-4-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <1481135102-20011-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/9] target-ppc: implement stxvl
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 11:54:56PM +0530, Nikunj A Dadhania wrote:
> stxvl: Store VSX Vector with Length
>=20
> Vector (8-bit elements) in BE:
> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
> |=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=
=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=
=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=
=9D|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|00|00|
> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
>=20
> Vector (8-bit elements) in LE:
> +--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
> |00|00|=E2=80=9CT=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CE=E2=80=9D|=E2=80=
=9CT=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=
=E2=80=9Cs=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Cs=E2=
=80=9D|=E2=80=9Ci=E2=80=9D|"h"|"T"|
> +--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
>=20
> Storing 14 bytes would result in following Little/Big-endian Storage:
> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
> |=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=
=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=
=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=
=9D|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|FF|FF|
> +---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

As with lxvl/lxvll I think you should be able to share the helper for
stxvl and stxvll.

> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/mem_helper.c             | 25 +++++++++++++++++++++++++
>  target-ppc/translate/vsx-impl.inc.c |  1 +
>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>  4 files changed, 28 insertions(+)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index 67c8b71..5ddc96d 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -319,6 +319,7 @@ DEF_HELPER_3(stvehx, void, env, avr, tl)
>  DEF_HELPER_3(stvewx, void, env, avr, tl)
>  DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
>  DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
> +DEF_HELPER_4(stxvl, void, env, tl, tl, tl)
>  DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
>  DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
>  DEF_HELPER_4(vsum4sbs, void, env, avr, avr, avr)
> diff --git a/target-ppc/mem_helper.c b/target-ppc/mem_helper.c
> index 08fd90d..771c660 100644
> --- a/target-ppc/mem_helper.c
> +++ b/target-ppc/mem_helper.c
> @@ -334,6 +334,31 @@ void helper_lxvll(CPUPPCState *env, target_ulong add=
r,
>      putVSR(xt_num, &xt, env);
>  }
> =20
> +void helper_stxvl(CPUPPCState *env, target_ulong addr,
> +                  target_ulong xt_num, target_ulong rb)
> +{
> +    int i;
> +    ppc_vsr_t xt;
> +    target_ulong nb =3D GET_NB(rb);
> +
> +    if (!nb) {
> +        return;
> +    }
> +    getVSR(xt_num, &xt, env);
> +    nb =3D (nb >=3D 16) ? 16 : nb;
> +    if (msr_le) {
> +        for (i =3D 16; i > 16 - nb; i--) {
> +            cpu_stb_data_ra(env, addr, xt.VsrB(i - 1), GETPC());
> +            addr =3D addr_add(env, addr, 1);
> +        }
> +    } else {
> +        for (i =3D 0; i < nb; i++) {
> +            cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());
> +            addr =3D addr_add(env, addr, 1);
> +        }
> +    }
> +}
> +
>  #undef HI_IDX
>  #undef LO_IDX
>  #undef GET_NB
> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
> index ee884cf..6d61285 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -267,6 +267,7 @@ static void gen_##name(DisasContext *ctx)            =
           \
> =20
>  VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
>  VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
> +VSX_VECTOR_LOAD_STORE_LENGTH(stxvl)
> =20
>  #define VSX_LOAD_SCALAR_DS(name, operation)                       \
>  static void gen_##name(DisasContext *ctx)                         \
> diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
> index 88f46d9..76eba3c 100644
> --- a/target-ppc/translate/vsx-ops.inc.c
> +++ b/target-ppc/translate/vsx-ops.inc.c
> @@ -23,6 +23,7 @@ GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PP=
C2_VSX),
>  GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
>  GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(stxvx, 0x1F, 0x0C, 0x0C, 0, PPC_NONE, PPC2_ISA300),
> +GEN_HANDLER_E(stxvl, 0x1F, 0x0D, 0x0C, 0, PPC_NONE, PPC2_ISA300),
> =20
>  GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX2=
07),
>  GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX2=
07),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSd4KAAoJEGw4ysog2bOSCpgQALtwuBQgLKFyx9BrNI3ih6yv
lU2LLwwsMYhCUYTlNTe00igmPjt5bGwomD7lW9M6e0hvZgZTdmx9oGdEfIDXWAcy
vP26QaY9bffCNwwkjpSKH9eqipk3dRnrZX78oWTVBVVs26TJIz77GjeyufN7z6+6
emSynrkQjzYYU+RPm36oAIsUhjyO5NwyaftkEzf2cwQixujNzk/PhoG3rPAhxqqH
J+QZKkr0YbDkLRlBjtgEbc62R+5FxavczWVNE0Nq79diFmfYo/JgKA3MKmf+DQIq
XZJv+s+7tD588ib2oYP5JS1Ass/CeElBrYuZoHClUDYYGLHE/gDBnh8cVM02t56f
7SxKXnlkftT8y8wJ0AcEtjzr9l5cCrBfSRu5TYHkCdZBj/6+r2IlrGHwXi7v1CiG
4813ya/Ks2uRdBX0uu6qrHfAyT1wuSJ3Zgmtymy3URq/ANy5zX0y1gXwux8gHlIO
ZDgFWH1my9f1qkArqF0AerFgClOgDvzXyGs5L8y+s73ZxPIaL1WHGsNNZ3EkKM+V
HH7itidaBz/kD8mY2ORvyeGGv9NuDJ2cvLOSGxZOAzknmrMMqzTANkz4NaY2nTsF
zNBy5075jtrNVzDU7Mal8iw2QUrBFf5w9bH5zOwSS+7B27ndYBMoqIkEGW8KZng1
KByXhdujIULjQkXscGOO
=WUkj
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
