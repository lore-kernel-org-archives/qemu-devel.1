Received: from eggs.gnu.org ([2001:4830:134:3::10]:41631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbf-0001w9-LB
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbd-0005n8-QE
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:27 -0500
Date: Wed, 19 Dec 2018 17:15:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219061555.GH30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-13-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-13-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 12/34] target/ppc: introduce get_avr64()
 and set_avr64() helpers for VMX register access
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


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:49PM -0800, Richard Henderson wrote:
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> These helpers allow us to move AVR register values to/from the specified =
TCGv_i64
> argument.
>=20
> To prevent VMX helpers accessing the cpu_avr{l,h} arrays directly, add ex=
tra TCG
> temporaries as required.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> Message-Id: <20181217122405.18732-3-mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/translate.c              |  10 +++
>  target/ppc/translate/vmx-impl.inc.c | 128 ++++++++++++++++++++++------
>  2 files changed, 110 insertions(+), 28 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 1d4bf624a3..fa3e8dc114 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6704,6 +6704,16 @@ static inline void set_fpr(int regno, TCGv_i64 src)
>      tcg_gen_mov_i64(cpu_fpr[regno], src);
>  }
> =20
> +static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
> +{
> +    tcg_gen_mov_i64(dst, (high ? cpu_avrh : cpu_avrl)[regno]);
> +}
> +
> +static inline void set_avr64(int regno, TCGv_i64 src, bool high)
> +{
> +    tcg_gen_mov_i64((high ? cpu_avrh : cpu_avrl)[regno], src);
> +}
> +
>  #include "translate/fp-impl.inc.c"
> =20
>  #include "translate/vmx-impl.inc.c"
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 3cb6fc2926..30046c6e31 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -18,52 +18,66 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
>  static void glue(gen_, name)(DisasContext *ctx)                         =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 avr;                                                       =
      \
>      if (unlikely(!ctx->altivec_enabled)) {                              =
      \
>          gen_exception(ctx, POWERPC_EXCP_VPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_INT);                               =
      \
> +    avr =3D tcg_temp_new_i64();                                         =
        \
>      EA =3D tcg_temp_new();                                              =
        \
>      gen_addr_reg_index(ctx, EA);                                        =
      \
>      tcg_gen_andi_tl(EA, EA, ~0xf);                                      =
      \
>      /* We only need to swap high and low halves. gen_qemu_ld64_i64 does =
      \
>         necessary 64-bit byteswap already. */                            =
      \
>      if (ctx->le_mode) {                                                 =
      \
> -        gen_qemu_ld64_i64(ctx, cpu_avrl[rD(ctx->opcode)], EA);          =
      \
> +        gen_qemu_ld64_i64(ctx, avr, EA);                                =
      \
> +        set_avr64(rD(ctx->opcode), avr, false);                         =
      \
>          tcg_gen_addi_tl(EA, EA, 8);                                     =
      \
> -        gen_qemu_ld64_i64(ctx, cpu_avrh[rD(ctx->opcode)], EA);          =
      \
> +        gen_qemu_ld64_i64(ctx, avr, EA);                                =
      \
> +        set_avr64(rD(ctx->opcode), avr, true);                          =
      \
>      } else {                                                            =
      \
> -        gen_qemu_ld64_i64(ctx, cpu_avrh[rD(ctx->opcode)], EA);          =
      \
> +        gen_qemu_ld64_i64(ctx, avr, EA);                                =
      \
> +        set_avr64(rD(ctx->opcode), avr, true);                          =
      \
>          tcg_gen_addi_tl(EA, EA, 8);                                     =
      \
> -        gen_qemu_ld64_i64(ctx, cpu_avrl[rD(ctx->opcode)], EA);          =
      \
> +        gen_qemu_ld64_i64(ctx, avr, EA);                                =
      \
> +        set_avr64(rD(ctx->opcode), avr, false);                         =
      \
>      }                                                                   =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(avr);                                             =
      \
>  }
> =20
>  #define GEN_VR_STX(name, opc2, opc3)                                    =
      \
>  static void gen_st##name(DisasContext *ctx)                             =
      \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 avr;                                                       =
      \
>      if (unlikely(!ctx->altivec_enabled)) {                              =
      \
>          gen_exception(ctx, POWERPC_EXCP_VPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_INT);                               =
      \
> +    avr =3D tcg_temp_new_i64();                                         =
        \
>      EA =3D tcg_temp_new();                                              =
        \
>      gen_addr_reg_index(ctx, EA);                                        =
      \
>      tcg_gen_andi_tl(EA, EA, ~0xf);                                      =
      \
>      /* We only need to swap high and low halves. gen_qemu_st64_i64 does =
      \
>         necessary 64-bit byteswap already. */                            =
      \
>      if (ctx->le_mode) {                                                 =
      \
> -        gen_qemu_st64_i64(ctx, cpu_avrl[rD(ctx->opcode)], EA);          =
      \
> +        get_avr64(avr, rD(ctx->opcode), false);                         =
      \
> +        gen_qemu_st64_i64(ctx, avr, EA);                                =
      \
>          tcg_gen_addi_tl(EA, EA, 8);                                     =
      \
> -        gen_qemu_st64_i64(ctx, cpu_avrh[rD(ctx->opcode)], EA);          =
      \
> +        get_avr64(avr, rD(ctx->opcode), true);                          =
      \
> +        gen_qemu_st64_i64(ctx, avr, EA);                                =
      \
>      } else {                                                            =
      \
> -        gen_qemu_st64_i64(ctx, cpu_avrh[rD(ctx->opcode)], EA);          =
      \
> +        get_avr64(avr, rD(ctx->opcode), true);                          =
      \
> +        gen_qemu_st64_i64(ctx, avr, EA);                                =
      \
>          tcg_gen_addi_tl(EA, EA, 8);                                     =
      \
> -        gen_qemu_st64_i64(ctx, cpu_avrl[rD(ctx->opcode)], EA);          =
      \
> +        get_avr64(avr, rD(ctx->opcode), false);                         =
      \
> +        gen_qemu_st64_i64(ctx, avr, EA);                                =
      \
>      }                                                                   =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(avr);                                             =
      \
>  }
> =20
>  #define GEN_VR_LVE(name, opc2, opc3, size)                              \
> @@ -159,15 +173,20 @@ static void gen_lvsr(DisasContext *ctx)
>  static void gen_mfvscr(DisasContext *ctx)
>  {
>      TCGv_i32 t;
> +    TCGv_i64 avr;
>      if (unlikely(!ctx->altivec_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_VPU);
>          return;
>      }
> -    tcg_gen_movi_i64(cpu_avrh[rD(ctx->opcode)], 0);
> +    avr =3D tcg_temp_new_i64();
> +    tcg_gen_movi_i64(avr, 0);
> +    set_avr64(rD(ctx->opcode), avr, true);
>      t =3D tcg_temp_new_i32();
>      tcg_gen_ld_i32(t, cpu_env, offsetof(CPUPPCState, vscr));
> -    tcg_gen_extu_i32_i64(cpu_avrl[rD(ctx->opcode)], t);
> +    tcg_gen_extu_i32_i64(avr, t);
> +    set_avr64(rD(ctx->opcode), avr, false);
>      tcg_temp_free_i32(t);
> +    tcg_temp_free_i64(avr);
>  }
> =20
>  static void gen_mtvscr(DisasContext *ctx)
> @@ -188,6 +207,7 @@ static void glue(gen_, name)(DisasContext *ctx)      =
                   \
>      TCGv_i64 t0 =3D tcg_temp_new_i64();                                 =
  \
>      TCGv_i64 t1 =3D tcg_temp_new_i64();                                 =
  \
>      TCGv_i64 t2 =3D tcg_temp_new_i64();                                 =
  \
> +    TCGv_i64 avr =3D tcg_temp_new_i64();                                =
  \
>      TCGv_i64 ten, z;                                                    \
>                                                                          \
>      if (unlikely(!ctx->altivec_enabled)) {                              \
> @@ -199,26 +219,35 @@ static void glue(gen_, name)(DisasContext *ctx)    =
                     \
>      z =3D tcg_const_i64(0);                                             =
  \
>                                                                          \
>      if (add_cin) {                                                      \
> -        tcg_gen_mulu2_i64(t0, t1, cpu_avrl[rA(ctx->opcode)], ten);      \
> -        tcg_gen_andi_i64(t2, cpu_avrl[rB(ctx->opcode)], 0xF);           \
> -        tcg_gen_add2_i64(cpu_avrl[rD(ctx->opcode)], t2, t0, t1, t2, z); \
> +        get_avr64(avr, rA(ctx->opcode), false);                         \
> +        tcg_gen_mulu2_i64(t0, t1, avr, ten);                            \
> +        get_avr64(avr, rB(ctx->opcode), false);                         \
> +        tcg_gen_andi_i64(t2, avr, 0xF);                                 \
> +        tcg_gen_add2_i64(avr, t2, t0, t1, t2, z);                       \
> +        set_avr64(rD(ctx->opcode), avr, false);                         \
>      } else {                                                            \
> -        tcg_gen_mulu2_i64(cpu_avrl[rD(ctx->opcode)], t2,                \
> -                          cpu_avrl[rA(ctx->opcode)], ten);              \
> +        get_avr64(avr, rA(ctx->opcode), false);                         \
> +        tcg_gen_mulu2_i64(avr, t2, avr, ten);                           \
> +        set_avr64(rD(ctx->opcode), avr, false);                         \
>      }                                                                   \
>                                                                          \
>      if (ret_carry) {                                                    \
> -        tcg_gen_mulu2_i64(t0, t1, cpu_avrh[rA(ctx->opcode)], ten);      \
> -        tcg_gen_add2_i64(t0, cpu_avrl[rD(ctx->opcode)], t0, t1, t2, z); \
> -        tcg_gen_movi_i64(cpu_avrh[rD(ctx->opcode)], 0);                 \
> +        get_avr64(avr, rA(ctx->opcode), true);                          \
> +        tcg_gen_mulu2_i64(t0, t1, avr, ten);                            \
> +        tcg_gen_add2_i64(t0, avr, t0, t1, t2, z);                       \
> +        set_avr64(rD(ctx->opcode), avr, false);                         \
> +        set_avr64(rD(ctx->opcode), z, true);                            \
>      } else {                                                            \
> -        tcg_gen_mul_i64(t0, cpu_avrh[rA(ctx->opcode)], ten);            \
> -        tcg_gen_add_i64(cpu_avrh[rD(ctx->opcode)], t0, t2);             \
> +        get_avr64(avr, rA(ctx->opcode), true);                          \
> +        tcg_gen_mul_i64(t0, avr, ten);                                  \
> +        tcg_gen_add_i64(avr, t0, t2);                                   \
> +        set_avr64(rD(ctx->opcode), avr, true);                          \
>      }                                                                   \
>                                                                          \
>      tcg_temp_free_i64(t0);                                              \
>      tcg_temp_free_i64(t1);                                              \
>      tcg_temp_free_i64(t2);                                              \
> +    tcg_temp_free_i64(avr);                                             \
>      tcg_temp_free_i64(ten);                                             \
>      tcg_temp_free_i64(z);                                               \
>  }                                                                       \
> @@ -232,12 +261,27 @@ GEN_VX_VMUL10(vmul10ecuq, 1, 1);
>  #define GEN_VX_LOGICAL(name, tcg_op, opc2, opc3)                        \
>  static void glue(gen_, name)(DisasContext *ctx)                         =
        \
>  {                                                                       \
> +    TCGv_i64 t0 =3D tcg_temp_new_i64();                                 =
  \
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();                                 =
  \
> +    TCGv_i64 avr =3D tcg_temp_new_i64();                                =
  \
> +                                                                        \
>      if (unlikely(!ctx->altivec_enabled)) {                              \
>          gen_exception(ctx, POWERPC_EXCP_VPU);                           \
>          return;                                                         \
>      }                                                                   \
> -    tcg_op(cpu_avrh[rD(ctx->opcode)], cpu_avrh[rA(ctx->opcode)], cpu_avr=
h[rB(ctx->opcode)]); \
> -    tcg_op(cpu_avrl[rD(ctx->opcode)], cpu_avrl[rA(ctx->opcode)], cpu_avr=
l[rB(ctx->opcode)]); \
> +    get_avr64(t0, rA(ctx->opcode), true);                               \
> +    get_avr64(t1, rB(ctx->opcode), true);                               \
> +    tcg_op(avr, t0, t1);                                                \
> +    set_avr64(rD(ctx->opcode), avr, true);                              \
> +                                                                        \
> +    get_avr64(t0, rA(ctx->opcode), false);                              \
> +    get_avr64(t1, rB(ctx->opcode), false);                              \
> +    tcg_op(avr, t0, t1);                                                \
> +    set_avr64(rD(ctx->opcode), avr, false);                             \
> +                                                                        \
> +    tcg_temp_free_i64(t0);                                              \
> +    tcg_temp_free_i64(t1);                                              \
> +    tcg_temp_free_i64(avr);                                             \
>  }
> =20
>  GEN_VX_LOGICAL(vand, tcg_gen_and_i64, 2, 16);
> @@ -406,6 +450,7 @@ GEN_VXFORM(vmrglw, 6, 6);
>  static void gen_vmrgew(DisasContext *ctx)
>  {
>      TCGv_i64 tmp;
> +    TCGv_i64 avr;
>      int VT, VA, VB;
>      if (unlikely(!ctx->altivec_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_VPU);
> @@ -415,15 +460,28 @@ static void gen_vmrgew(DisasContext *ctx)
>      VA =3D rA(ctx->opcode);
>      VB =3D rB(ctx->opcode);
>      tmp =3D tcg_temp_new_i64();
> -    tcg_gen_shri_i64(tmp, cpu_avrh[VB], 32);
> -    tcg_gen_deposit_i64(cpu_avrh[VT], cpu_avrh[VA], tmp, 0, 32);
> -    tcg_gen_shri_i64(tmp, cpu_avrl[VB], 32);
> -    tcg_gen_deposit_i64(cpu_avrl[VT], cpu_avrl[VA], tmp, 0, 32);
> +    avr =3D tcg_temp_new_i64();
> +
> +    get_avr64(avr, VB, true);
> +    tcg_gen_shri_i64(tmp, avr, 32);
> +    get_avr64(avr, VA, true);
> +    tcg_gen_deposit_i64(avr, avr, tmp, 0, 32);
> +    set_avr64(VT, avr, true);
> +
> +    get_avr64(avr, VB, false);
> +    tcg_gen_shri_i64(tmp, avr, 32);
> +    get_avr64(avr, VA, false);
> +    tcg_gen_deposit_i64(avr, avr, tmp, 0, 32);
> +    set_avr64(VT, avr, false);
> +
>      tcg_temp_free_i64(tmp);
> +    tcg_temp_free_i64(avr);
>  }
> =20
>  static void gen_vmrgow(DisasContext *ctx)
>  {
> +    TCGv_i64 t0, t1;
> +    TCGv_i64 avr;
>      int VT, VA, VB;
>      if (unlikely(!ctx->altivec_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_VPU);
> @@ -432,9 +490,23 @@ static void gen_vmrgow(DisasContext *ctx)
>      VT =3D rD(ctx->opcode);
>      VA =3D rA(ctx->opcode);
>      VB =3D rB(ctx->opcode);
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    avr =3D tcg_temp_new_i64();
> =20
> -    tcg_gen_deposit_i64(cpu_avrh[VT], cpu_avrh[VB], cpu_avrh[VA], 32, 32=
);
> -    tcg_gen_deposit_i64(cpu_avrl[VT], cpu_avrl[VB], cpu_avrl[VA], 32, 32=
);
> +    get_avr64(t0, VB, true);
> +    get_avr64(t1, VA, true);
> +    tcg_gen_deposit_i64(avr, t0, t1, 32, 32);
> +    set_avr64(VT, avr, true);
> +
> +    get_avr64(t0, VB, false);
> +    get_avr64(t1, VA, false);
> +    tcg_gen_deposit_i64(avr, t0, t1, 32, 32);
> +    set_avr64(VT, avr, false);
> +
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(avr);
>  }
> =20
>  GEN_VXFORM(vmuloub, 4, 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ4hsACgkQbDjKyiDZ
s5K7fxAAuFBm2rHza6BeQtsr6fCJwx2nAucUnK0gqf5gRYo0TQuGBtRUYjEDartV
KjmF1CopsCHPwqoTST/rsKLM/m9WNhHoSLP4vl7QgpTG/c6T9lQZXa0Nz+zye57Z
+QgYwZ2Oe3af3QDkSmt2MT+M4ZcP1yBur3eIOBWDQRie1OwLnL8kY9szZ1PZl5uh
51NKTieMBRlXsWoGZ7IavKEzExG1XogxFO0zyzVs2sM2zndA8eb+1mrNJQnyrqwm
v8+zt8GXVYCOw+vfgjZT0r+TIw5FvN+as9nhsu9m0AZvQfT8PGfauj7Z5FYLdFSp
Ye3tfR/7OJhzrqiwA4HKqEF5Orvs6oVhMe+O2id3QF5C9ShPILm8nBP3e1EDGpBM
yO8+DRNYiKoQCH+uI3N+U2Qtr9uCZXEeNye/BfwJPSVqAFuXKBLhI39UdcCDkNKT
g8Ri2YddL2mOhTWqgD7DGZCealEzt1q7PWrInlvAMSA68+nfoV4U2AmDSpD0PUTH
c9+byytDdgj7CZfir9k97dNsaruCmzaP2iYlAQCSnnlv/2FWzyPGGhgsyjN5JSOr
g6C+ECLNC/78TI8T5EM7CdUDg67QIExnBtCZ0dpb0Ud/CqnxcP2GKAJPQPyKV+Mj
ts5acBOPpFgt8m8mSPxRigvmykRqmWWM7ZlxFv3rFclOE0t4Irg=
=Cu6i
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
