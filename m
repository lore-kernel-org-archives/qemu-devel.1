Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVsf-0004Bi-Cw
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVse-0005CU-3M
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:49 -0500
Date: Thu, 12 Jan 2017 13:47:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112024743.GD14026@umbus.fritz.box>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1484038243-30314-4-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <1484038243-30314-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] target-ppc: Add xsiexpdp instruction
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


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 02:20:35PM +0530, Nikunj A Dadhania wrote:
> xsiexpdp: VSX Scalar Insert Exponent Double Precision
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 20 ++++++++++++++++++++
>  target/ppc/translate/vsx-ops.inc.c  |  1 +
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 2d9fe50..2d09225 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1243,6 +1243,26 @@ static void gen_xsxexpqp(DisasContext *ctx)
>      tcg_gen_movi_i64(xtl, 0);
>  }
> =20
> +static void gen_xsiexpdp(DisasContext *ctx)
> +{
> +    TCGv_i64 xth =3D cpu_vsrh(xT(ctx->opcode));
> +    TCGv ra =3D cpu_gpr[rA(ctx->opcode)];
> +    TCGv rb =3D cpu_gpr[rB(ctx->opcode)];
> +    TCGv_i64 t0;
> +
> +    if (unlikely(!ctx->vsx_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);
> +        return;
> +    }
> +    t0 =3D tcg_temp_new_i64();
> +    tcg_gen_andi_i64(xth, ra, 0x800FFFFFFFFFFFFF);
> +    tcg_gen_andi_i64(t0, rb, 0x7FF);
> +    tcg_gen_shli_i64(t0, t0, 52);
> +    tcg_gen_or_i64(xth, xth, t0);
> +    /* dword[1] is undefined */

According to the ISA doc I have, dword[1] is set to 0 rather than
being undefined.

> +    tcg_temp_free_i64(t0);
> +}
> +
>  static void gen_xsxsigdp(DisasContext *ctx)
>  {
>      TCGv rt =3D cpu_gpr[rD(ctx->opcode)];
> diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vs=
x-ops.inc.c
> index aeeaff2..5980ac6 100644
> --- a/target/ppc/translate/vsx-ops.inc.c
> +++ b/target/ppc/translate/vsx-ops.inc.c
> @@ -120,6 +120,7 @@ GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA30=
0),
>  GEN_VSX_XFORM_300_EO(xsxexpqp, 0x04, 0x19, 0x02, 0x00000001),
>  GEN_XX2FORM_EO(xsxsigdp, 0x16, 0x15, 0x01, PPC2_ISA300),
>  GEN_VSX_XFORM_300_EO(xsxsigqp, 0x04, 0x19, 0x12, 0x00000001),
> +GEN_HANDLER_E(xsiexpdp, 0x3C, 0x16, 0x1C, 0, PPC_NONE, PPC2_ISA300),
>  #endif
> =20
>  GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdu5NAAoJEGw4ysog2bOSI54QALZa6VALxLVZ8nanAdgCHtEH
qv+Ew0wx0VxaP3CfvA1YX77uPBeM58v9LwqR6rH2Kyf3Y4rKT7gu0RzpOBd9gbNd
H++Jpg99PB/l7AqycmYS1iRb2oJ0GHiINiefb5fc/gH8HN2fscNTMNTYg6btUNOF
1+R6gCyK1jMtKUlb4hN2zklzlfAZnLT0TY7Mz1YdBPi59REXhiQqlwb/p/tQL89v
Psp6e1Bho9IUjOXblry25XC8NzKh8mjtAFb8grJE1o6aFy2qwIN9QJgSrlTU2ITa
gceAYQEod0io7NefHi67eHoHXidRknDRIbWyEAqjnbZzxKFCcUThi2gQXvzdPZ1U
R4m1rioAzc+O9Chdn5Elk/UdminEG20K5IfFduZhw320zXfHs1+r2sudLFdAktaq
gpMFXcsmsdSBjriYoLH1NFZgx7uLAB0O1raeGsYXoGEEfSDteDtWlwgys10CwE1v
PvR5Sa3Qn44bFFYL7NUV2C5Dfq4yE10fLxLHsa4+QUn2r1YMTic0fyWZI9cKRWVr
pUQHuQSzCP8UOcosXrc5VEqF6nIz5d+bhegNZ0cGUJ4ymdHeYXxucorecK41N3qk
licjxaYKSFsI2ve1nnl5gVrpgCd6fpRqnXDJ53YI4ni3EUaKlBZQx419kENATWb6
oaEhpq1bf2eT9tHuza4t
=hl/X
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
