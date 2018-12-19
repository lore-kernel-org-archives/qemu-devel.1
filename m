Received: from eggs.gnu.org ([2001:4830:134:3::10]:41300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZUrq-0002HG-Bh
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZUro-0007Lv-RV
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:58:02 -0500
Date: Wed, 19 Dec 2018 16:39:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219053909.GF30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-4-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 03/34] tcg: Add gvec expanders for nand, nor,
 eqv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:40PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  accel/tcg/tcg-runtime.h      |  3 +++
>  tcg/tcg-op-gvec.h            |  6 +++++
>  tcg/tcg-op.h                 |  3 +++
>  accel/tcg/tcg-runtime-gvec.c | 33 +++++++++++++++++++++++
>  tcg/tcg-op-gvec.c            | 51 ++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-vec.c             | 21 +++++++++++++++
>  6 files changed, 117 insertions(+)
>=20
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 1bd39d136d..835ddfebb2 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -211,6 +211,9 @@ DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, pt=
r, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_nand, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_nor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_eqv, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> =20
>  DEF_HELPER_FLAGS_4(gvec_ands, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>  DEF_HELPER_FLAGS_4(gvec_xors, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index ff43a29a0b..d65b9d9d4c 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -242,6 +242,12 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
>  void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> =20
>  void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t c, uint32_t oprsz, uint32_t maxsz);
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index db4e9188f4..1974bf1cae 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -961,6 +961,9 @@ void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_v=
ec a, TCGv_vec b);
>  void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>  void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
> =20
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index 90340e56e0..d1802467d5 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -512,6 +512,39 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uin=
t32_t desc)
>      clear_high(d, oprsz, desc);
>  }
> =20
> +void HELPER(gvec_nand)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D ~(*(vec64 *)(a + i) & *(vec64 *)(b + i));
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_nor)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D ~(*(vec64 *)(a + i) | *(vec64 *)(b + i));
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_eqv)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D ~(*(vec64 *)(a + i) ^ *(vec64 *)(b + i));
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
>  void HELPER(gvec_ands)(void *d, void *a, uint64_t b, uint32_t desc)
>  {
>      intptr_t oprsz =3D simd_oprsz(desc);
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index ec231b78fb..81689d02f7 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1920,6 +1920,57 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>      }
>  }
> =20
> +void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g =3D {
> +        .fni8 =3D tcg_gen_nand_i64,
> +        .fniv =3D tcg_gen_nand_vec,
> +        .fno =3D gen_helper_gvec_nand,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +
> +    if (aofs =3D=3D bofs) {
> +        tcg_gen_gvec_not(vece, dofs, aofs, oprsz, maxsz);
> +    } else {
> +        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +    }
> +}
> +
> +void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g =3D {
> +        .fni8 =3D tcg_gen_nor_i64,
> +        .fniv =3D tcg_gen_nor_vec,
> +        .fno =3D gen_helper_gvec_nor,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +
> +    if (aofs =3D=3D bofs) {
> +        tcg_gen_gvec_not(vece, dofs, aofs, oprsz, maxsz);
> +    } else {
> +        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +    }
> +}
> +
> +void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g =3D {
> +        .fni8 =3D tcg_gen_eqv_i64,
> +        .fniv =3D tcg_gen_eqv_vec,
> +        .fno =3D gen_helper_gvec_eqv,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +
> +    if (aofs =3D=3D bofs) {
> +        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
> +    } else {
> +        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +    }
> +}
> +
>  static const GVecGen2s gop_ands =3D {
>      .fni8 =3D tcg_gen_and_i64,
>      .fniv =3D tcg_gen_and_vec,
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index cefba3d185..d77fdf7c1d 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -275,6 +275,27 @@ void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv=
_vec a, TCGv_vec b)
>      }
>  }
> =20
> +void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    /* TODO: Add TCG_TARGET_HAS_nand_vec when adding a backend supports =
it. */
> +    tcg_gen_and_vec(0, r, a, b);
> +    tcg_gen_not_vec(0, r, r);
> +}
> +
> +void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    /* TODO: Add TCG_TARGET_HAS_nor_vec when adding a backend supports i=
t. */
> +    tcg_gen_or_vec(0, r, a, b);
> +    tcg_gen_not_vec(0, r, r);
> +}
> +
> +void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    /* TODO: Add TCG_TARGET_HAS_eqv_vec when adding a backend supports i=
t. */
> +    tcg_gen_xor_vec(0, r, a, b);
> +    tcg_gen_not_vec(0, r, r);
> +}
> +
>  void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
>  {
>      if (TCG_TARGET_HAS_not_vec) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ2XwACgkQbDjKyiDZ
s5I12A/+PWgxRk6rmnilapLioHt3tX9O9bdnKZim6mBpTFVdVw7yLRIRPPPLCErd
Gy0cRUOVVh9XCaX/O0r28S4FWhiWuaruDuEhNxIMFQbgeBJGIsGDwtVbb1zh39WY
QL4KKBBbnjo79QShf/GWAi5BOY39ZBXMPlZFN/wyxy6IrhAkvPHm+xMDYeF8Xitg
u1NCF/NbK1czSjPGzpYcbW8f79FjlOGvTNq3zplSSHqJd/dzuSYgNWfUKA7d9XcP
TfxzYb+lNPyIsTGSUglKYC7iOj14/XUPaUVz4dR9GDmRWUsn1sMeb+Qij2hghJ+M
v7bnrZhV+e5V/8TDSPcRBCyTPguKV+fgd0ilKx4LiWSf/bY7ZMv5Vh7Y2sQvvN6E
uqzYoH7CBgwuKSM7l4Awxj87axyc2dGikYYQKHfj/2g308O4AVgizTlZNkCCVwrR
A+1ZmYhuRCqemkHIax/JKcdSKl836Lsuf03Rxoy1q+kUt/KVW6gqRMNfqr04oPBj
15xNkknUBrTuKLgU9bmthrab01OBhhtHWSx9soIXmtSkylsHwbUAwTUNUAKNW8e5
JHvieg+vmg2w2WeR9dxOW8ER1pSCViUNkNUxo15QJwyPd+1ULllWjnIdGIkoXh8D
KsDuUyVdGvKEkDaIKduUVMMY9Bvl30IxOI4DBPiYXZYdhXik53A=
=GayB
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
