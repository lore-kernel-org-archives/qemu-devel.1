Received: from eggs.gnu.org ([2001:4830:134:3::10]:41843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbo-0001yv-Mg
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbg-0005pc-Qx
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:36 -0500
Date: Wed, 19 Dec 2018 17:15:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219061529.GG30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-12-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-12-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 11/34] target/ppc: introduce get_fpr() and
 set_fpr() helpers for FP register access
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


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:48PM -0800, Richard Henderson wrote:
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> These helpers allow us to move FP register values to/from the specified T=
CGv_i64
> argument in the VSR helpers to be introduced shortly.
>=20
> To prevent FP helpers accessing the cpu_fpr array directly, add extra TCG
> temporaries as required.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Message-Id: <20181217122405.18732-2-mark.cave-ayland@ilande.co.uk>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Do you want me to take these, or will you take them via your tree?

> ---
>  target/ppc/translate.c             |  10 +
>  target/ppc/translate/fp-impl.inc.c | 490 ++++++++++++++++++++++-------
>  2 files changed, 390 insertions(+), 110 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2b37910248..1d4bf624a3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6694,6 +6694,16 @@ static inline void gen_##name(DisasContext *ctx)  =
             \
>  GEN_TM_PRIV_NOOP(treclaim);
>  GEN_TM_PRIV_NOOP(trechkpt);
> =20
> +static inline void get_fpr(TCGv_i64 dst, int regno)
> +{
> +    tcg_gen_mov_i64(dst, cpu_fpr[regno]);
> +}
> +
> +static inline void set_fpr(int regno, TCGv_i64 src)
> +{
> +    tcg_gen_mov_i64(cpu_fpr[regno], src);
> +}
> +
>  #include "translate/fp-impl.inc.c"
> =20
>  #include "translate/vmx-impl.inc.c"
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
> index 08770ba9f5..04b8733055 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -34,24 +34,38 @@ static void gen_set_cr1_from_fpscr(DisasContext *ctx)
>  #define _GEN_FLOAT_ACB(name, op, op1, op2, isfloat, set_fprf, type)     =
      \
>  static void gen_f##name(DisasContext *ctx)                              =
      \
>  {                                                                       =
      \
> +    TCGv_i64 t0;                                                        =
      \
> +    TCGv_i64 t1;                                                        =
      \
> +    TCGv_i64 t2;                                                        =
      \
> +    TCGv_i64 t3;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
> +    t1 =3D tcg_temp_new_i64();                                          =
        \
> +    t2 =3D tcg_temp_new_i64();                                          =
        \
> +    t3 =3D tcg_temp_new_i64();                                          =
        \
>      gen_reset_fpstatus();                                               =
      \
> -    gen_helper_f##op(cpu_fpr[rD(ctx->opcode)], cpu_env,                 =
      \
> -                     cpu_fpr[rA(ctx->opcode)],                          =
      \
> -                     cpu_fpr[rC(ctx->opcode)], cpu_fpr[rB(ctx->opcode)])=
;     \
> +    get_fpr(t0, rA(ctx->opcode));                                       =
      \
> +    get_fpr(t1, rC(ctx->opcode));                                       =
      \
> +    get_fpr(t2, rB(ctx->opcode));                                       =
      \
> +    gen_helper_f##op(t3, cpu_env, t0, t1, t2);                          =
      \
>      if (isfloat) {                                                      =
      \
> -        gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,              =
      \
> -                        cpu_fpr[rD(ctx->opcode)]);                      =
      \
> +        get_fpr(t0, rD(ctx->opcode));                                   =
      \
> +        gen_helper_frsp(t3, cpu_env, t0);                               =
      \
>      }                                                                   =
      \
> +    set_fpr(rD(ctx->opcode), t3);                                       =
      \
>      if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);             =
      \
> +        gen_compute_fprf_float64(t3);                                   =
      \
>      }                                                                   =
      \
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
>          gen_set_cr1_from_fpscr(ctx);                                    =
      \
>      }                                                                   =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
> +    tcg_temp_free_i64(t1);                                              =
      \
> +    tcg_temp_free_i64(t2);                                              =
      \
> +    tcg_temp_free_i64(t3);                                              =
      \
>  }
> =20
>  #define GEN_FLOAT_ACB(name, op2, set_fprf, type)                        =
      \
> @@ -61,24 +75,34 @@ _GEN_FLOAT_ACB(name##s, name, 0x3B, op2, 1, set_fprf,=
 type);
>  #define _GEN_FLOAT_AB(name, op, op1, op2, inval, isfloat, set_fprf, type=
)     \
>  static void gen_f##name(DisasContext *ctx)                              =
      \
>  {                                                                       =
      \
> +    TCGv_i64 t0;                                                        =
      \
> +    TCGv_i64 t1;                                                        =
      \
> +    TCGv_i64 t2;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
> +    t1 =3D tcg_temp_new_i64();                                          =
        \
> +    t2 =3D tcg_temp_new_i64();                                          =
        \
>      gen_reset_fpstatus();                                               =
      \
> -    gen_helper_f##op(cpu_fpr[rD(ctx->opcode)], cpu_env,                 =
      \
> -                     cpu_fpr[rA(ctx->opcode)],                          =
      \
> -                     cpu_fpr[rB(ctx->opcode)]);                         =
      \
> +    get_fpr(t0, rA(ctx->opcode));                                       =
      \
> +    get_fpr(t1, rB(ctx->opcode));                                       =
      \
> +    gen_helper_f##op(t2, cpu_env, t0, t1);                              =
      \
>      if (isfloat) {                                                      =
      \
> -        gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,              =
      \
> -                        cpu_fpr[rD(ctx->opcode)]);                      =
      \
> +        get_fpr(t0, rD(ctx->opcode));                                   =
      \
> +        gen_helper_frsp(t2, cpu_env, t0);                               =
      \
>      }                                                                   =
      \
> +    set_fpr(rD(ctx->opcode), t2);                                       =
      \
>      if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);             =
      \
> +        gen_compute_fprf_float64(t2);                                   =
      \
>      }                                                                   =
      \
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
>          gen_set_cr1_from_fpscr(ctx);                                    =
      \
>      }                                                                   =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
> +    tcg_temp_free_i64(t1);                                              =
      \
> +    tcg_temp_free_i64(t2);                                              =
      \
>  }
>  #define GEN_FLOAT_AB(name, op2, inval, set_fprf, type)                  =
      \
>  _GEN_FLOAT_AB(name, name, 0x3F, op2, inval, 0, set_fprf, type);         =
      \
> @@ -87,24 +111,35 @@ _GEN_FLOAT_AB(name##s, name, 0x3B, op2, inval, 1, se=
t_fprf, type);
>  #define _GEN_FLOAT_AC(name, op, op1, op2, inval, isfloat, set_fprf, type=
)     \
>  static void gen_f##name(DisasContext *ctx)                              =
      \
>  {                                                                       =
      \
> +    TCGv_i64 t0;                                                        =
      \
> +    TCGv_i64 t1;                                                        =
      \
> +    TCGv_i64 t2;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
> +    t1 =3D tcg_temp_new_i64();                                          =
        \
> +    t2 =3D tcg_temp_new_i64();                                          =
        \
>      gen_reset_fpstatus();                                               =
      \
> -    gen_helper_f##op(cpu_fpr[rD(ctx->opcode)], cpu_env,                 =
      \
> -                     cpu_fpr[rA(ctx->opcode)],                          =
      \
> -                     cpu_fpr[rC(ctx->opcode)]);                         =
      \
> +    get_fpr(t0, rA(ctx->opcode));                                       =
      \
> +    get_fpr(t1, rC(ctx->opcode));                                       =
      \
> +    gen_helper_f##op(t2, cpu_env, t0, t1);                              =
      \
> +    set_fpr(rD(ctx->opcode), t2);                                       =
      \
>      if (isfloat) {                                                      =
      \
> -        gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,              =
      \
> -                        cpu_fpr[rD(ctx->opcode)]);                      =
      \
> +        get_fpr(t0, rD(ctx->opcode));                                   =
      \
> +        gen_helper_frsp(t2, cpu_env, t0);                               =
      \
> +        set_fpr(rD(ctx->opcode), t2);                                   =
      \
>      }                                                                   =
      \
>      if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);             =
      \
> +        gen_compute_fprf_float64(t2);                                   =
      \
>      }                                                                   =
      \
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
>          gen_set_cr1_from_fpscr(ctx);                                    =
      \
>      }                                                                   =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
> +    tcg_temp_free_i64(t1);                                              =
      \
> +    tcg_temp_free_i64(t2);                                              =
      \
>  }
>  #define GEN_FLOAT_AC(name, op2, inval, set_fprf, type)                  =
      \
>  _GEN_FLOAT_AC(name, name, 0x3F, op2, inval, 0, set_fprf, type);         =
      \
> @@ -113,37 +148,51 @@ _GEN_FLOAT_AC(name##s, name, 0x3B, op2, inval, 1, s=
et_fprf, type);
>  #define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                     =
      \
>  static void gen_f##name(DisasContext *ctx)                              =
      \
>  {                                                                       =
      \
> +    TCGv_i64 t0;                                                        =
      \
> +    TCGv_i64 t1;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
> +    t1 =3D tcg_temp_new_i64();                                          =
        \
>      gen_reset_fpstatus();                                               =
      \
> -    gen_helper_f##name(cpu_fpr[rD(ctx->opcode)], cpu_env,               =
      \
> -                       cpu_fpr[rB(ctx->opcode)]);                       =
      \
> +    get_fpr(t0, rB(ctx->opcode));                                       =
      \
> +    gen_helper_f##name(t1, cpu_env, t0);                                =
      \
> +    set_fpr(rD(ctx->opcode), t1);                                       =
      \
>      if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);             =
      \
> +        gen_compute_fprf_float64(t1);                                   =
      \
>      }                                                                   =
      \
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
>          gen_set_cr1_from_fpscr(ctx);                                    =
      \
>      }                                                                   =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
> +    tcg_temp_free_i64(t1);                                              =
      \
>  }
> =20
>  #define GEN_FLOAT_BS(name, op1, op2, set_fprf, type)                    =
      \
>  static void gen_f##name(DisasContext *ctx)                              =
      \
>  {                                                                       =
      \
> +    TCGv_i64 t0;                                                        =
      \
> +    TCGv_i64 t1;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
> +    t1 =3D tcg_temp_new_i64();                                          =
        \
>      gen_reset_fpstatus();                                               =
      \
> -    gen_helper_f##name(cpu_fpr[rD(ctx->opcode)], cpu_env,               =
      \
> -                       cpu_fpr[rB(ctx->opcode)]);                       =
      \
> +    get_fpr(t0, rB(ctx->opcode));                                       =
      \
> +    gen_helper_f##name(t1, cpu_env, t0);                                =
      \
> +    set_fpr(rD(ctx->opcode), t1);                                       =
      \
>      if (set_fprf) {                                                     =
      \
> -        gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);             =
      \
> +        gen_compute_fprf_float64(t1);                                   =
      \
>      }                                                                   =
      \
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
>          gen_set_cr1_from_fpscr(ctx);                                    =
      \
>      }                                                                   =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
> +    tcg_temp_free_i64(t1);                                              =
      \
>  }
> =20
>  /* fadd - fadds */
> @@ -165,19 +214,25 @@ GEN_FLOAT_BS(rsqrte, 0x3F, 0x1A, 1, PPC_FLOAT_FRSQR=
TE);
>  /* frsqrtes */
>  static void gen_frsqrtes(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
>      gen_reset_fpstatus();
> -    gen_helper_frsqrte(cpu_fpr[rD(ctx->opcode)], cpu_env,
> -                       cpu_fpr[rB(ctx->opcode)]);
> -    gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,
> -                    cpu_fpr[rD(ctx->opcode)]);
> -    gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);
> +    get_fpr(t0, rB(ctx->opcode));
> +    gen_helper_frsqrte(t1, cpu_env, t0);
> +    gen_helper_frsp(t1, cpu_env, t1);
> +    set_fpr(rD(ctx->opcode), t1);
> +    gen_compute_fprf_float64(t1);
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* fsel */
> @@ -189,34 +244,47 @@ GEN_FLOAT_AB(sub, 0x14, 0x000007C0, 1, PPC_FLOAT);
>  /* fsqrt */
>  static void gen_fsqrt(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
>      gen_reset_fpstatus();
> -    gen_helper_fsqrt(cpu_fpr[rD(ctx->opcode)], cpu_env,
> -                     cpu_fpr[rB(ctx->opcode)]);
> -    gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);
> +    get_fpr(t0, rB(ctx->opcode));
> +    gen_helper_fsqrt(t1, cpu_env, t0);
> +    set_fpr(rD(ctx->opcode), t1);
> +    gen_compute_fprf_float64(t1);
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  static void gen_fsqrts(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
>      gen_reset_fpstatus();
> -    gen_helper_fsqrt(cpu_fpr[rD(ctx->opcode)], cpu_env,
> -                     cpu_fpr[rB(ctx->opcode)]);
> -    gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,
> -                    cpu_fpr[rD(ctx->opcode)]);
> -    gen_compute_fprf_float64(cpu_fpr[rD(ctx->opcode)]);
> +    get_fpr(t0, rB(ctx->opcode));
> +    gen_helper_fsqrt(t1, cpu_env, t0);
> +    gen_helper_frsp(t1, cpu_env, t1);
> +    set_fpr(rD(ctx->opcode), t1);
> +    gen_compute_fprf_float64(t1);
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /***                     Floating-Point multiply-and-add                =
   ***/
> @@ -268,21 +336,32 @@ GEN_FLOAT_B(rim, 0x08, 0x0F, 1, PPC_FLOAT_EXT);
> =20
>  static void gen_ftdiv(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> -    gen_helper_ftdiv(cpu_crf[crfD(ctx->opcode)], cpu_fpr[rA(ctx->opcode)=
],
> -                     cpu_fpr[rB(ctx->opcode)]);
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rA(ctx->opcode));
> +    get_fpr(t1, rB(ctx->opcode));
> +    gen_helper_ftdiv(cpu_crf[crfD(ctx->opcode)], t0, t1);
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  static void gen_ftsqrt(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> -    gen_helper_ftsqrt(cpu_crf[crfD(ctx->opcode)], cpu_fpr[rB(ctx->opcode=
)]);
> +    t0 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rB(ctx->opcode));
> +    gen_helper_ftsqrt(cpu_crf[crfD(ctx->opcode)], t0);
> +    tcg_temp_free_i64(t0);
>  }
> =20
> =20
> @@ -293,32 +372,46 @@ static void gen_ftsqrt(DisasContext *ctx)
>  static void gen_fcmpo(DisasContext *ctx)
>  {
>      TCGv_i32 crf;
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
>      gen_reset_fpstatus();
>      crf =3D tcg_const_i32(crfD(ctx->opcode));
> -    gen_helper_fcmpo(cpu_env, cpu_fpr[rA(ctx->opcode)],
> -                     cpu_fpr[rB(ctx->opcode)], crf);
> +    get_fpr(t0, rA(ctx->opcode));
> +    get_fpr(t1, rB(ctx->opcode));
> +    gen_helper_fcmpo(cpu_env, t0, t1, crf);
>      tcg_temp_free_i32(crf);
>      gen_helper_float_check_status(cpu_env);
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* fcmpu */
>  static void gen_fcmpu(DisasContext *ctx)
>  {
>      TCGv_i32 crf;
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
>      gen_reset_fpstatus();
>      crf =3D tcg_const_i32(crfD(ctx->opcode));
> -    gen_helper_fcmpu(cpu_env, cpu_fpr[rA(ctx->opcode)],
> -                     cpu_fpr[rB(ctx->opcode)], crf);
> +    get_fpr(t0, rA(ctx->opcode));
> +    get_fpr(t1, rB(ctx->opcode));
> +    gen_helper_fcmpu(cpu_env, t0, t1, crf);
>      tcg_temp_free_i32(crf);
>      gen_helper_float_check_status(cpu_env);
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /***                         Floating-point move                        =
   ***/
> @@ -326,100 +419,153 @@ static void gen_fcmpu(DisasContext *ctx)
>  /* XXX: beware that fabs never checks for NaNs nor update FPSCR */
>  static void gen_fabs(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> -    tcg_gen_andi_i64(cpu_fpr[rD(ctx->opcode)], cpu_fpr[rB(ctx->opcode)],
> -                     ~(1ULL << 63));
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rB(ctx->opcode));
> +    tcg_gen_andi_i64(t1, t0, ~(1ULL << 63));
> +    set_fpr(rD(ctx->opcode), t1);
>      if (unlikely(Rc(ctx->opcode))) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* fmr  - fmr. */
>  /* XXX: beware that fmr never checks for NaNs nor update FPSCR */
>  static void gen_fmr(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> -    tcg_gen_mov_i64(cpu_fpr[rD(ctx->opcode)], cpu_fpr[rB(ctx->opcode)]);
> +    t0 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rB(ctx->opcode));
> +    set_fpr(rD(ctx->opcode), t0);
>      if (unlikely(Rc(ctx->opcode))) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
>  }
> =20
>  /* fnabs */
>  /* XXX: beware that fnabs never checks for NaNs nor update FPSCR */
>  static void gen_fnabs(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> -    tcg_gen_ori_i64(cpu_fpr[rD(ctx->opcode)], cpu_fpr[rB(ctx->opcode)],
> -                    1ULL << 63);
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rB(ctx->opcode));
> +    tcg_gen_ori_i64(t1, t0, 1ULL << 63);
> +    set_fpr(rD(ctx->opcode), t1);
>      if (unlikely(Rc(ctx->opcode))) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* fneg */
>  /* XXX: beware that fneg never checks for NaNs nor update FPSCR */
>  static void gen_fneg(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> -    tcg_gen_xori_i64(cpu_fpr[rD(ctx->opcode)], cpu_fpr[rB(ctx->opcode)],
> -                     1ULL << 63);
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rB(ctx->opcode));
> +    tcg_gen_xori_i64(t1, t0, 1ULL << 63);
> +    set_fpr(rD(ctx->opcode), t1);
>      if (unlikely(Rc(ctx->opcode))) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* fcpsgn: PowerPC 2.05 specification */
>  /* XXX: beware that fcpsgn never checks for NaNs nor update FPSCR */
>  static void gen_fcpsgn(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
> +    TCGv_i64 t2;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> -    tcg_gen_deposit_i64(cpu_fpr[rD(ctx->opcode)], cpu_fpr[rA(ctx->opcode=
)],
> -                        cpu_fpr[rB(ctx->opcode)], 0, 63);
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    t2 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rA(ctx->opcode));
> +    get_fpr(t1, rB(ctx->opcode));
> +    tcg_gen_deposit_i64(t2, t0, t1, 0, 63);
> +    set_fpr(rD(ctx->opcode), t2);
>      if (unlikely(Rc(ctx->opcode))) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
>  }
> =20
>  static void gen_fmrgew(DisasContext *ctx)
>  {
>      TCGv_i64 b0;
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
>      b0 =3D tcg_temp_new_i64();
> -    tcg_gen_shri_i64(b0, cpu_fpr[rB(ctx->opcode)], 32);
> -    tcg_gen_deposit_i64(cpu_fpr[rD(ctx->opcode)], cpu_fpr[rA(ctx->opcode=
)],
> -                        b0, 0, 32);
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rB(ctx->opcode));
> +    tcg_gen_shri_i64(b0, t0, 32);
> +    get_fpr(t0, rA(ctx->opcode));
> +    tcg_gen_deposit_i64(t1, t0, b0, 0, 32);
> +    set_fpr(rD(ctx->opcode), t1);
>      tcg_temp_free_i64(b0);
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  static void gen_fmrgow(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
> +    TCGv_i64 t1;
> +    TCGv_i64 t2;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> -    tcg_gen_deposit_i64(cpu_fpr[rD(ctx->opcode)],
> -                        cpu_fpr[rB(ctx->opcode)],
> -                        cpu_fpr[rA(ctx->opcode)],
> -                        32, 32);
> +    t0 =3D tcg_temp_new_i64();
> +    t1 =3D tcg_temp_new_i64();
> +    t2 =3D tcg_temp_new_i64();
> +    get_fpr(t0, rB(ctx->opcode));
> +    get_fpr(t1, rA(ctx->opcode));
> +    tcg_gen_deposit_i64(t2, t0, t1, 32, 32);
> +    set_fpr(rD(ctx->opcode), t2);
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
>  }
> =20
>  /***                  Floating-Point status & ctrl register             =
   ***/
> @@ -458,15 +604,19 @@ static void gen_mcrfs(DisasContext *ctx)
>  /* mffs */
>  static void gen_mffs(DisasContext *ctx)
>  {
> +    TCGv_i64 t0;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
> +    t0 =3D tcg_temp_new_i64();
>      gen_reset_fpstatus();
> -    tcg_gen_extu_tl_i64(cpu_fpr[rD(ctx->opcode)], cpu_fpscr);
> +    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> +    set_fpr(rD(ctx->opcode), t0);
>      if (unlikely(Rc(ctx->opcode))) {
>          gen_set_cr1_from_fpscr(ctx);
>      }
> +    tcg_temp_free_i64(t0);
>  }
> =20
>  /* mtfsb0 */
> @@ -522,6 +672,7 @@ static void gen_mtfsb1(DisasContext *ctx)
>  static void gen_mtfsf(DisasContext *ctx)
>  {
>      TCGv_i32 t0;
> +    TCGv_i64 t1;
>      int flm, l, w;
> =20
>      if (unlikely(!ctx->fpu_enabled)) {
> @@ -541,7 +692,9 @@ static void gen_mtfsf(DisasContext *ctx)
>      } else {
>          t0 =3D tcg_const_i32(flm << (w * 8));
>      }
> -    gen_helper_store_fpscr(cpu_env, cpu_fpr[rB(ctx->opcode)], t0);
> +    t1 =3D tcg_temp_new_i64();
> +    get_fpr(t1, rB(ctx->opcode));
> +    gen_helper_store_fpscr(cpu_env, t1, t0);
>      tcg_temp_free_i32(t0);
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {
>          tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
> @@ -549,6 +702,7 @@ static void gen_mtfsf(DisasContext *ctx)
>      }
>      /* We can raise a differed exception */
>      gen_helper_float_check_status(cpu_env);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* mtfsfi */
> @@ -588,21 +742,26 @@ static void gen_mtfsfi(DisasContext *ctx)
>  static void glue(gen_, name)(DisasContext *ctx)                         =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 t0;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_FLOAT);                             =
      \
>      EA =3D tcg_temp_new();                                              =
        \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      gen_addr_imm_index(ctx, EA, 0);                                     =
      \
> -    gen_qemu_##ldop(ctx, cpu_fpr[rD(ctx->opcode)], EA);                 =
      \
> +    gen_qemu_##ldop(ctx, t0, EA);                                       =
      \
> +    set_fpr(rD(ctx->opcode), t0);                                       =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
>  }
> =20
>  #define GEN_LDUF(name, ldop, opc, type)                                 =
      \
>  static void glue(gen_, name##u)(DisasContext *ctx)                      =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 t0;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
> @@ -613,20 +772,25 @@ static void glue(gen_, name##u)(DisasContext *ctx)
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_FLOAT);                             =
      \
>      EA =3D tcg_temp_new();                                              =
        \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      gen_addr_imm_index(ctx, EA, 0);                                     =
      \
> -    gen_qemu_##ldop(ctx, cpu_fpr[rD(ctx->opcode)], EA);                 =
      \
> +    gen_qemu_##ldop(ctx, t0, EA);                                       =
      \
> +    set_fpr(rD(ctx->opcode), t0);                                       =
      \
>      tcg_gen_mov_tl(cpu_gpr[rA(ctx->opcode)], EA);                       =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
>  }
> =20
>  #define GEN_LDUXF(name, ldop, opc, type)                                =
      \
>  static void glue(gen_, name##ux)(DisasContext *ctx)                     =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 t0;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      if (unlikely(rA(ctx->opcode) =3D=3D 0)) {                           =
          \
>          gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);             =
      \
>          return;                                                         =
      \
> @@ -634,24 +798,30 @@ static void glue(gen_, name##ux)(DisasContext *ctx)
>      gen_set_access_type(ctx, ACCESS_FLOAT);                             =
      \
>      EA =3D tcg_temp_new();                                              =
        \
>      gen_addr_reg_index(ctx, EA);                                        =
      \
> -    gen_qemu_##ldop(ctx, cpu_fpr[rD(ctx->opcode)], EA);                 =
      \
> +    gen_qemu_##ldop(ctx, t0, EA);                                       =
      \
> +    set_fpr(rD(ctx->opcode), t0);                                       =
      \
>      tcg_gen_mov_tl(cpu_gpr[rA(ctx->opcode)], EA);                       =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
>  }
> =20
>  #define GEN_LDXF(name, ldop, opc2, opc3, type)                          =
      \
>  static void glue(gen_, name##x)(DisasContext *ctx)                      =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 t0;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_FLOAT);                             =
      \
>      EA =3D tcg_temp_new();                                              =
        \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      gen_addr_reg_index(ctx, EA);                                        =
      \
> -    gen_qemu_##ldop(ctx, cpu_fpr[rD(ctx->opcode)], EA);                 =
      \
> +    gen_qemu_##ldop(ctx, t0, EA);                                       =
      \
> +    set_fpr(rD(ctx->opcode), t0);                                       =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
>  }
> =20
>  #define GEN_LDFS(name, ldop, op, type)                                  =
      \
> @@ -677,6 +847,7 @@ GEN_LDFS(lfs, ld32fs, 0x10, PPC_FLOAT);
>  static void gen_lfdepx(DisasContext *ctx)
>  {
>      TCGv EA;
> +    TCGv_i64 t0;
>      CHK_SV;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
> @@ -684,16 +855,19 @@ static void gen_lfdepx(DisasContext *ctx)
>      }
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      EA =3D tcg_temp_new();
> +    t0 =3D tcg_temp_new_i64();
>      gen_addr_reg_index(ctx, EA);
> -    tcg_gen_qemu_ld_i64(cpu_fpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_LOAD,
> -        DEF_MEMOP(MO_Q));
> +    tcg_gen_qemu_ld_i64(t0, EA, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_Q));
> +    set_fpr(rD(ctx->opcode), t0);
>      tcg_temp_free(EA);
> +    tcg_temp_free_i64(t0);
>  }
> =20
>  /* lfdp */
>  static void gen_lfdp(DisasContext *ctx)
>  {
>      TCGv EA;
> +    TCGv_i64 t0;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
> @@ -701,24 +875,31 @@ static void gen_lfdp(DisasContext *ctx)
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      EA =3D tcg_temp_new();
>      gen_addr_imm_index(ctx, EA, 0);
> +    t0 =3D tcg_temp_new_i64();
>      /* We only need to swap high and low halves. gen_qemu_ld64_i64 does
>         necessary 64-bit byteswap already. */
>      if (unlikely(ctx->le_mode)) {
> -        gen_qemu_ld64_i64(ctx, cpu_fpr[rD(ctx->opcode) + 1], EA);
> +        gen_qemu_ld64_i64(ctx, t0, EA);
> +        set_fpr(rD(ctx->opcode) + 1, t0);
>          tcg_gen_addi_tl(EA, EA, 8);
> -        gen_qemu_ld64_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +        gen_qemu_ld64_i64(ctx, t0, EA);
> +        set_fpr(rD(ctx->opcode), t0);
>      } else {
> -        gen_qemu_ld64_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +        gen_qemu_ld64_i64(ctx, t0, EA);
> +        set_fpr(rD(ctx->opcode), t0);
>          tcg_gen_addi_tl(EA, EA, 8);
> -        gen_qemu_ld64_i64(ctx, cpu_fpr[rD(ctx->opcode) + 1], EA);
> +        gen_qemu_ld64_i64(ctx, t0, EA);
> +        set_fpr(rD(ctx->opcode) + 1, t0);
>      }
>      tcg_temp_free(EA);
> +    tcg_temp_free_i64(t0);
>  }
> =20
>  /* lfdpx */
>  static void gen_lfdpx(DisasContext *ctx)
>  {
>      TCGv EA;
> +    TCGv_i64 t0;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
> @@ -726,18 +907,24 @@ static void gen_lfdpx(DisasContext *ctx)
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      EA =3D tcg_temp_new();
>      gen_addr_reg_index(ctx, EA);
> +    t0 =3D tcg_temp_new_i64();
>      /* We only need to swap high and low halves. gen_qemu_ld64_i64 does
>         necessary 64-bit byteswap already. */
>      if (unlikely(ctx->le_mode)) {
> -        gen_qemu_ld64_i64(ctx, cpu_fpr[rD(ctx->opcode) + 1], EA);
> +        gen_qemu_ld64_i64(ctx, t0, EA);
> +        set_fpr(rD(ctx->opcode) + 1, t0);
>          tcg_gen_addi_tl(EA, EA, 8);
> -        gen_qemu_ld64_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +        gen_qemu_ld64_i64(ctx, t0, EA);
> +        set_fpr(rD(ctx->opcode), t0);
>      } else {
> -        gen_qemu_ld64_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +        gen_qemu_ld64_i64(ctx, t0, EA);
> +        set_fpr(rD(ctx->opcode), t0);
>          tcg_gen_addi_tl(EA, EA, 8);
> -        gen_qemu_ld64_i64(ctx, cpu_fpr[rD(ctx->opcode) + 1], EA);
> +        gen_qemu_ld64_i64(ctx, t0, EA);
> +        set_fpr(rD(ctx->opcode) + 1, t0);
>      }
>      tcg_temp_free(EA);
> +    tcg_temp_free_i64(t0);
>  }
> =20
>  /* lfiwax */
> @@ -745,6 +932,7 @@ static void gen_lfiwax(DisasContext *ctx)
>  {
>      TCGv EA;
>      TCGv t0;
> +    TCGv_i64 t1;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
> @@ -752,47 +940,59 @@ static void gen_lfiwax(DisasContext *ctx)
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      EA =3D tcg_temp_new();
>      t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new_i64();
>      gen_addr_reg_index(ctx, EA);
>      gen_qemu_ld32s(ctx, t0, EA);
> -    tcg_gen_ext_tl_i64(cpu_fpr[rD(ctx->opcode)], t0);
> +    tcg_gen_ext_tl_i64(t1, t0);
> +    set_fpr(rD(ctx->opcode), t1);
>      tcg_temp_free(EA);
>      tcg_temp_free(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* lfiwzx */
>  static void gen_lfiwzx(DisasContext *ctx)
>  {
>      TCGv EA;
> +    TCGv_i64 t0;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      EA =3D tcg_temp_new();
> +    t0 =3D tcg_temp_new_i64();
>      gen_addr_reg_index(ctx, EA);
> -    gen_qemu_ld32u_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +    gen_qemu_ld32u_i64(ctx, t0, EA);
> +    set_fpr(rD(ctx->opcode), t0);
>      tcg_temp_free(EA);
> +    tcg_temp_free_i64(t0);
>  }
>  /***                         Floating-point store                       =
   ***/
>  #define GEN_STF(name, stop, opc, type)                                  =
      \
>  static void glue(gen_, name)(DisasContext *ctx)                         =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 t0;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_FLOAT);                             =
      \
>      EA =3D tcg_temp_new();                                              =
        \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      gen_addr_imm_index(ctx, EA, 0);                                     =
      \
> -    gen_qemu_##stop(ctx, cpu_fpr[rS(ctx->opcode)], EA);                 =
      \
> +    get_fpr(t0, rS(ctx->opcode));                                       =
      \
> +    gen_qemu_##stop(ctx, t0, EA);                                       =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
>  }
> =20
>  #define GEN_STUF(name, stop, opc, type)                                 =
      \
>  static void glue(gen_, name##u)(DisasContext *ctx)                      =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 t0;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
> @@ -803,16 +1003,20 @@ static void glue(gen_, name##u)(DisasContext *ctx)
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_FLOAT);                             =
      \
>      EA =3D tcg_temp_new();                                              =
        \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      gen_addr_imm_index(ctx, EA, 0);                                     =
      \
> -    gen_qemu_##stop(ctx, cpu_fpr[rS(ctx->opcode)], EA);                 =
      \
> +    get_fpr(t0, rS(ctx->opcode));                                       =
      \
> +    gen_qemu_##stop(ctx, t0, EA);                                       =
      \
>      tcg_gen_mov_tl(cpu_gpr[rA(ctx->opcode)], EA);                       =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
>  }
> =20
>  #define GEN_STUXF(name, stop, opc, type)                                =
      \
>  static void glue(gen_, name##ux)(DisasContext *ctx)                     =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 t0;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
> @@ -823,25 +1027,32 @@ static void glue(gen_, name##ux)(DisasContext *ctx)
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_FLOAT);                             =
      \
>      EA =3D tcg_temp_new();                                              =
        \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      gen_addr_reg_index(ctx, EA);                                        =
      \
> -    gen_qemu_##stop(ctx, cpu_fpr[rS(ctx->opcode)], EA);                 =
      \
> +    get_fpr(t0, rS(ctx->opcode));                                       =
      \
> +    gen_qemu_##stop(ctx, t0, EA);                                       =
      \
>      tcg_gen_mov_tl(cpu_gpr[rA(ctx->opcode)], EA);                       =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
>  }
> =20
>  #define GEN_STXF(name, stop, opc2, opc3, type)                          =
      \
>  static void glue(gen_, name##x)(DisasContext *ctx)                      =
              \
>  {                                                                       =
      \
>      TCGv EA;                                                            =
      \
> +    TCGv_i64 t0;                                                        =
      \
>      if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
>          gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
>          return;                                                         =
      \
>      }                                                                   =
      \
>      gen_set_access_type(ctx, ACCESS_FLOAT);                             =
      \
>      EA =3D tcg_temp_new();                                              =
        \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      gen_addr_reg_index(ctx, EA);                                        =
      \
> -    gen_qemu_##stop(ctx, cpu_fpr[rS(ctx->opcode)], EA);                 =
      \
> +    get_fpr(t0, rS(ctx->opcode));                                       =
      \
> +    gen_qemu_##stop(ctx, t0, EA);                                       =
      \
>      tcg_temp_free(EA);                                                  =
      \
> +    tcg_temp_free_i64(t0);                                              =
      \
>  }
> =20
>  #define GEN_STFS(name, stop, op, type)                                  =
      \
> @@ -867,6 +1078,7 @@ GEN_STFS(stfs, st32fs, 0x14, PPC_FLOAT);
>  static void gen_stfdepx(DisasContext *ctx)
>  {
>      TCGv EA;
> +    TCGv_i64 t0;
>      CHK_SV;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
> @@ -874,60 +1086,76 @@ static void gen_stfdepx(DisasContext *ctx)
>      }
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      EA =3D tcg_temp_new();
> +    t0 =3D tcg_temp_new_i64();
>      gen_addr_reg_index(ctx, EA);
> -    tcg_gen_qemu_st_i64(cpu_fpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_STORE,
> -                       DEF_MEMOP(MO_Q));
> +    get_fpr(t0, rD(ctx->opcode));
> +    tcg_gen_qemu_st_i64(t0, EA, PPC_TLB_EPID_STORE, DEF_MEMOP(MO_Q));
>      tcg_temp_free(EA);
> +    tcg_temp_free_i64(t0);
>  }
> =20
>  /* stfdp */
>  static void gen_stfdp(DisasContext *ctx)
>  {
>      TCGv EA;
> +    TCGv_i64 t0;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      EA =3D tcg_temp_new();
> +    t0 =3D tcg_temp_new_i64();
>      gen_addr_imm_index(ctx, EA, 0);
>      /* We only need to swap high and low halves. gen_qemu_st64_i64 does
>         necessary 64-bit byteswap already. */
>      if (unlikely(ctx->le_mode)) {
> -        gen_qemu_st64_i64(ctx, cpu_fpr[rD(ctx->opcode) + 1], EA);
> +        get_fpr(t0, rD(ctx->opcode) + 1);
> +        gen_qemu_st64_i64(ctx, t0, EA);
>          tcg_gen_addi_tl(EA, EA, 8);
> -        gen_qemu_st64_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +        get_fpr(t0, rD(ctx->opcode));
> +        gen_qemu_st64_i64(ctx, t0, EA);
>      } else {
> -        gen_qemu_st64_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +        get_fpr(t0, rD(ctx->opcode));
> +        gen_qemu_st64_i64(ctx, t0, EA);
>          tcg_gen_addi_tl(EA, EA, 8);
> -        gen_qemu_st64_i64(ctx, cpu_fpr[rD(ctx->opcode) + 1], EA);
> +        get_fpr(t0, rD(ctx->opcode) + 1);
> +        gen_qemu_st64_i64(ctx, t0, EA);
>      }
>      tcg_temp_free(EA);
> +    tcg_temp_free_i64(t0);
>  }
> =20
>  /* stfdpx */
>  static void gen_stfdpx(DisasContext *ctx)
>  {
>      TCGv EA;
> +    TCGv_i64 t0;
>      if (unlikely(!ctx->fpu_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_FPU);
>          return;
>      }
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      EA =3D tcg_temp_new();
> +    t0 =3D tcg_temp_new_i64();
>      gen_addr_reg_index(ctx, EA);
>      /* We only need to swap high and low halves. gen_qemu_st64_i64 does
>         necessary 64-bit byteswap already. */
>      if (unlikely(ctx->le_mode)) {
> -        gen_qemu_st64_i64(ctx, cpu_fpr[rD(ctx->opcode) + 1], EA);
> +        get_fpr(t0, rD(ctx->opcode) + 1);
> +        gen_qemu_st64_i64(ctx, t0, EA);
>          tcg_gen_addi_tl(EA, EA, 8);
> -        gen_qemu_st64_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +        get_fpr(t0, rD(ctx->opcode));
> +        gen_qemu_st64_i64(ctx, t0, EA);
>      } else {
> -        gen_qemu_st64_i64(ctx, cpu_fpr[rD(ctx->opcode)], EA);
> +        get_fpr(t0, rD(ctx->opcode));
> +        gen_qemu_st64_i64(ctx, t0, EA);
>          tcg_gen_addi_tl(EA, EA, 8);
> -        gen_qemu_st64_i64(ctx, cpu_fpr[rD(ctx->opcode) + 1], EA);
> +        get_fpr(t0, rD(ctx->opcode) + 1);
> +        gen_qemu_st64_i64(ctx, t0, EA);
>      }
>      tcg_temp_free(EA);
> +    tcg_temp_free_i64(t0);
>  }
> =20
>  /* Optional: */
> @@ -949,13 +1177,18 @@ static void gen_lfq(DisasContext *ctx)
>  {
>      int rd =3D rD(ctx->opcode);
>      TCGv t0;
> +    TCGv_i64 t1;
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new_i64();
>      gen_addr_imm_index(ctx, t0, 0);
> -    gen_qemu_ld64_i64(ctx, cpu_fpr[rd], t0);
> +    gen_qemu_ld64_i64(ctx, t1, t0);
> +    set_fpr(rd, t1);
>      gen_addr_add(ctx, t0, t0, 8);
> -    gen_qemu_ld64_i64(ctx, cpu_fpr[(rd + 1) % 32], t0);
> +    gen_qemu_ld64_i64(ctx, t1, t0);
> +    set_fpr((rd + 1) % 32, t1);
>      tcg_temp_free(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* lfqu */
> @@ -964,17 +1197,22 @@ static void gen_lfqu(DisasContext *ctx)
>      int ra =3D rA(ctx->opcode);
>      int rd =3D rD(ctx->opcode);
>      TCGv t0, t1;
> +    TCGv_i64 t2;
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      t0 =3D tcg_temp_new();
>      t1 =3D tcg_temp_new();
> +    t2 =3D tcg_temp_new_i64();
>      gen_addr_imm_index(ctx, t0, 0);
> -    gen_qemu_ld64_i64(ctx, cpu_fpr[rd], t0);
> +    gen_qemu_ld64_i64(ctx, t2, t0);
> +    set_fpr(rd, t2);
>      gen_addr_add(ctx, t1, t0, 8);
> -    gen_qemu_ld64_i64(ctx, cpu_fpr[(rd + 1) % 32], t1);
> +    gen_qemu_ld64_i64(ctx, t2, t1);
> +    set_fpr((rd + 1) % 32, t2);
>      if (ra !=3D 0)
>          tcg_gen_mov_tl(cpu_gpr[ra], t0);
>      tcg_temp_free(t0);
>      tcg_temp_free(t1);
> +    tcg_temp_free_i64(t2);
>  }
> =20
>  /* lfqux */
> @@ -984,16 +1222,21 @@ static void gen_lfqux(DisasContext *ctx)
>      int rd =3D rD(ctx->opcode);
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      TCGv t0, t1;
> +    TCGv_i64 t2;
> +    t2 =3D tcg_temp_new_i64();
>      t0 =3D tcg_temp_new();
>      gen_addr_reg_index(ctx, t0);
> -    gen_qemu_ld64_i64(ctx, cpu_fpr[rd], t0);
> +    gen_qemu_ld64_i64(ctx, t2, t0);
> +    set_fpr(rd, t2);
>      t1 =3D tcg_temp_new();
>      gen_addr_add(ctx, t1, t0, 8);
> -    gen_qemu_ld64_i64(ctx, cpu_fpr[(rd + 1) % 32], t1);
> +    gen_qemu_ld64_i64(ctx, t2, t1);
> +    set_fpr((rd + 1) % 32, t2);
>      tcg_temp_free(t1);
>      if (ra !=3D 0)
>          tcg_gen_mov_tl(cpu_gpr[ra], t0);
>      tcg_temp_free(t0);
> +    tcg_temp_free_i64(t2);
>  }
> =20
>  /* lfqx */
> @@ -1001,13 +1244,18 @@ static void gen_lfqx(DisasContext *ctx)
>  {
>      int rd =3D rD(ctx->opcode);
>      TCGv t0;
> +    TCGv_i64 t1;
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new_i64();
>      gen_addr_reg_index(ctx, t0);
> -    gen_qemu_ld64_i64(ctx, cpu_fpr[rd], t0);
> +    gen_qemu_ld64_i64(ctx, t1, t0);
> +    set_fpr(rd, t1);
>      gen_addr_add(ctx, t0, t0, 8);
> -    gen_qemu_ld64_i64(ctx, cpu_fpr[(rd + 1) % 32], t0);
> +    gen_qemu_ld64_i64(ctx, t1, t0);
> +    set_fpr((rd + 1) % 32, t1);
>      tcg_temp_free(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* stfq */
> @@ -1015,13 +1263,18 @@ static void gen_stfq(DisasContext *ctx)
>  {
>      int rd =3D rD(ctx->opcode);
>      TCGv t0;
> +    TCGv_i64 t1;
>      gen_set_access_type(ctx, ACCESS_FLOAT);
>      t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new_i64();
>      gen_addr_imm_index(ctx, t0, 0);
> -    gen_qemu_st64_i64(ctx, cpu_fpr[rd], t0);
> +    get_fpr(t1, rd);
> +    gen_qemu_st64_i64(ctx, t1, t0);
>      gen_addr_add(ctx, t0, t0, 8);
> -    gen_qemu_st64_i64(ctx, cpu_fpr[(rd + 1) % 32], t0);
> +    get_fpr(t1, (rd + 1) % 32);
> +    gen_qemu_st64_i64(ctx, t1, t0);
>      tcg_temp_free(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  /* stfqu */
> @@ -1030,17 +1283,23 @@ static void gen_stfqu(DisasContext *ctx)
>      int ra =3D rA(ctx->opcode);
>      int rd =3D rD(ctx->opcode);
>      TCGv t0, t1;
> +    TCGv_i64 t2;
>      gen_set_access_type(ctx, ACCESS_FLOAT);
> +    t2 =3D tcg_temp_new_i64();
>      t0 =3D tcg_temp_new();
>      gen_addr_imm_index(ctx, t0, 0);
> -    gen_qemu_st64_i64(ctx, cpu_fpr[rd], t0);
> +    get_fpr(t2, rd);
> +    gen_qemu_st64_i64(ctx, t2, t0);
>      t1 =3D tcg_temp_new();
>      gen_addr_add(ctx, t1, t0, 8);
> -    gen_qemu_st64_i64(ctx, cpu_fpr[(rd + 1) % 32], t1);
> +    get_fpr(t2, (rd + 1) % 32);
> +    gen_qemu_st64_i64(ctx, t2, t1);
>      tcg_temp_free(t1);
> -    if (ra !=3D 0)
> +    if (ra !=3D 0) {
>          tcg_gen_mov_tl(cpu_gpr[ra], t0);
> +    }
>      tcg_temp_free(t0);
> +    tcg_temp_free_i64(t2);
>  }
> =20
>  /* stfqux */
> @@ -1049,17 +1308,23 @@ static void gen_stfqux(DisasContext *ctx)
>      int ra =3D rA(ctx->opcode);
>      int rd =3D rD(ctx->opcode);
>      TCGv t0, t1;
> +    TCGv_i64 t2;
>      gen_set_access_type(ctx, ACCESS_FLOAT);
> +    t2 =3D tcg_temp_new_i64();
>      t0 =3D tcg_temp_new();
>      gen_addr_reg_index(ctx, t0);
> -    gen_qemu_st64_i64(ctx, cpu_fpr[rd], t0);
> +    get_fpr(t2, rd);
> +    gen_qemu_st64_i64(ctx, t2, t0);
>      t1 =3D tcg_temp_new();
>      gen_addr_add(ctx, t1, t0, 8);
> -    gen_qemu_st64_i64(ctx, cpu_fpr[(rd + 1) % 32], t1);
> +    get_fpr(t2, (rd + 1) % 32);
> +    gen_qemu_st64_i64(ctx, t2, t1);
>      tcg_temp_free(t1);
> -    if (ra !=3D 0)
> +    if (ra !=3D 0) {
>          tcg_gen_mov_tl(cpu_gpr[ra], t0);
> +    }
>      tcg_temp_free(t0);
> +    tcg_temp_free_i64(t2);
>  }
> =20
>  /* stfqx */
> @@ -1067,13 +1332,18 @@ static void gen_stfqx(DisasContext *ctx)
>  {
>      int rd =3D rD(ctx->opcode);
>      TCGv t0;
> +    TCGv_i64 t1;
>      gen_set_access_type(ctx, ACCESS_FLOAT);
> +    t1 =3D tcg_temp_new_i64();
>      t0 =3D tcg_temp_new();
>      gen_addr_reg_index(ctx, t0);
> -    gen_qemu_st64_i64(ctx, cpu_fpr[rd], t0);
> +    get_fpr(t1, rd);
> +    gen_qemu_st64_i64(ctx, t1, t0);
>      gen_addr_add(ctx, t0, t0, 8);
> -    gen_qemu_st64_i64(ctx, cpu_fpr[(rd + 1) % 32], t0);
> +    get_fpr(t1, (rd + 1) % 32);
> +    gen_qemu_st64_i64(ctx, t1, t0);
>      tcg_temp_free(t0);
> +    tcg_temp_free_i64(t1);
>  }
> =20
>  #undef _GEN_FLOAT_ACB

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ4f4ACgkQbDjKyiDZ
s5KTqxAAns5fzEXSrcassDAEPxUaTdmS04BAZZSspC2ozjda87/YezvXh5RoPweE
z92PJDPVSqCvNGzmtDjZnXbunmpTPnEdiBy5hbV1D0sdKITrbih6dNJUkhEXRZsA
HCrPNlOaR05YS2V+2tP0NHGx7vkpOjE6Prqt1ZcjmTvpgKy6Aw66pQLdDSUQJQnO
onkSyMPnJgH3GiWBs+hsso2pZlrImffxa4igDkfzn9vK8p5C2n353hV+K6nh+Sp8
4zHWQ3dfl2WYVwt7NqLBv6THvz9W7DSHdp6JSCxk7dtYeeN0354uqEGB9dnrWjvo
ARK8ZAYZb9Bb8V6XHdUXAlKeluOUxB6HqDdfjjxaOjAPSx2YZTHGvm4TzsaLlrPT
f36ml9+7VAXCFZUQeg83e70Z50v3j/Owe684AyWcD+dzjnYOOY9xoT7VZp6AwRDt
iYfha/9dO/XPXGul2+DuYmWT/yRS9rn/TTLecxHoEbVqXEz7Rzy/+H5oqK1ucR+M
c90IJXQUzGvqvVGlYpU7uxNxwnjOm4f4c22rPcEIHpHYp2tCxYLPCGOtiwP1XI5J
cMni5HKGksnVCKTeFgl/z0xJYcD1dmsZSTxBT6m3zRvwfSHzJ4IU3eglUadrfCzs
XIEoycd0mb6vyKdjmH5RFXIugH8hFkGu4XtvLefE1YcOy3hXx2Y=
=WH6e
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
