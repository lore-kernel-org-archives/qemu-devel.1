Received: from eggs.gnu.org ([2001:4830:134:3::10]:45594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0SVK-00076n-O2
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0SVG-0006Zd-LM
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:21:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g0SVG-0006Vw-82
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:21:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id w11-v6so5877023wrc.5
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 07:21:53 -0700 (PDT)
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180911202823.21657-2-cota@braap.org>
Date: Thu, 13 Sep 2018 15:21:50 +0100
Message-ID: <87efdxbhq9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/13] target/i386: move cpu_cc_srcT to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/translate.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 1f9d1d9b24..e9f512472e 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -73,7 +73,7 @@
>
>  /* global register indexes */
>  static TCGv cpu_A0;
> -static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2, cpu_cc_srcT;
> +static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2;
>  static TCGv_i32 cpu_cc_op;
>  static TCGv cpu_regs[CPU_NB_REGS];
>  static TCGv cpu_seg_base[6];
> @@ -135,6 +135,10 @@ typedef struct DisasContext {
>      int cpuid_ext3_features;
>      int cpuid_7_0_ebx_features;
>      int cpuid_xsave_features;
> +
> +    /* TCG local temps */
> +    TCGv cc_srcT;
> +
>      sigjmp_buf jmpbuf;
>  } DisasContext;
>
> @@ -244,7 +248,7 @@ static void set_cc_op(DisasContext *s, CCOp op)
>          tcg_gen_discard_tl(cpu_cc_src2);
>      }
>      if (dead & USES_CC_SRCT) {
> -        tcg_gen_discard_tl(cpu_cc_srcT);
> +        tcg_gen_discard_tl(s->cc_srcT);
>      }
>
>      if (op =3D=3D CC_OP_DYNAMIC) {
> @@ -667,11 +671,11 @@ static inline void gen_op_testl_T0_T1_cc(void)
>      tcg_gen_and_tl(cpu_cc_dst, cpu_T0, cpu_T1);
>  }
>
> -static void gen_op_update_neg_cc(void)
> +static void gen_op_update_neg_cc(DisasContext *s)
>  {
>      tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
>      tcg_gen_neg_tl(cpu_cc_src, cpu_T0);
> -    tcg_gen_movi_tl(cpu_cc_srcT, 0);
> +    tcg_gen_movi_tl(s->cc_srcT, 0);
>  }
>
>  /* compute all eflags to cc_src */
> @@ -742,7 +746,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s=
, TCGv reg)
>          t1 =3D gen_ext_tl(cpu_tmp0, cpu_cc_src, size, false);
>          /* If no temporary was used, be careful not to alias t1 and t0. =
 */
>          t0 =3D t1 =3D=3D cpu_cc_src ? cpu_tmp0 : reg;
> -        tcg_gen_mov_tl(t0, cpu_cc_srcT);
> +        tcg_gen_mov_tl(t0, s->cc_srcT);
>          gen_extu(size, t0);
>          goto add_sub;
>
> @@ -899,7 +903,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int =
b, TCGv reg)
>          size =3D s->cc_op - CC_OP_SUBB;
>          switch (jcc_op) {
>          case JCC_BE:
> -            tcg_gen_mov_tl(cpu_tmp4, cpu_cc_srcT);
> +            tcg_gen_mov_tl(cpu_tmp4, s->cc_srcT);
>              gen_extu(size, cpu_tmp4);
>              t0 =3D gen_ext_tl(cpu_tmp0, cpu_cc_src, size, false);
>              cc =3D (CCPrepare) { .cond =3D TCG_COND_LEU, .reg =3D cpu_tm=
p4,
> @@ -912,7 +916,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int =
b, TCGv reg)
>          case JCC_LE:
>              cond =3D TCG_COND_LE;
>          fast_jcc_l:
> -            tcg_gen_mov_tl(cpu_tmp4, cpu_cc_srcT);
> +            tcg_gen_mov_tl(cpu_tmp4, s->cc_srcT);
>              gen_exts(size, cpu_tmp4);
>              t0 =3D gen_ext_tl(cpu_tmp0, cpu_cc_src, size, true);
>              cc =3D (CCPrepare) { .cond =3D cond, .reg =3D cpu_tmp4,
> @@ -1309,11 +1313,11 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>      case OP_SUBL:
>          if (s1->prefix & PREFIX_LOCK) {
>              tcg_gen_neg_tl(cpu_T0, cpu_T1);
> -            tcg_gen_atomic_fetch_add_tl(cpu_cc_srcT, cpu_A0, cpu_T0,
> +            tcg_gen_atomic_fetch_add_tl(s1->cc_srcT, cpu_A0, cpu_T0,
>                                          s1->mem_index, ot | MO_LE);
> -            tcg_gen_sub_tl(cpu_T0, cpu_cc_srcT, cpu_T1);
> +            tcg_gen_sub_tl(cpu_T0, s1->cc_srcT, cpu_T1);
>          } else {
> -            tcg_gen_mov_tl(cpu_cc_srcT, cpu_T0);
> +            tcg_gen_mov_tl(s1->cc_srcT, cpu_T0);
>              tcg_gen_sub_tl(cpu_T0, cpu_T0, cpu_T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> @@ -1356,7 +1360,7 @@ static void gen_op(DisasContext *s1, int op, TCGMem=
Op ot, int d)
>          break;
>      case OP_CMPL:
>          tcg_gen_mov_tl(cpu_cc_src, cpu_T1);
> -        tcg_gen_mov_tl(cpu_cc_srcT, cpu_T0);
> +        tcg_gen_mov_tl(s1->cc_srcT, cpu_T0);
>          tcg_gen_sub_tl(cpu_cc_dst, cpu_T0, cpu_T1);
>          set_cc_op(s1, CC_OP_SUBB + ot);
>          break;
> @@ -4823,7 +4827,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                      gen_op_mov_reg_v(ot, rm, cpu_T0);
>                  }
>              }
> -            gen_op_update_neg_cc();
> +            gen_op_update_neg_cc(s);
>              set_cc_op(s, CC_OP_SUBB + ot);
>              break;
>          case 4: /* mul */
> @@ -5283,7 +5287,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  }
>              }
>              tcg_gen_mov_tl(cpu_cc_src, oldv);
> -            tcg_gen_mov_tl(cpu_cc_srcT, cmpv);
> +            tcg_gen_mov_tl(s->cc_srcT, cmpv);
>              tcg_gen_sub_tl(cpu_cc_dst, cmpv, oldv);
>              set_cc_op(s, CC_OP_SUBB + ot);
>              tcg_temp_free(oldv);
> @@ -8463,7 +8467,7 @@ static void i386_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cpu)
>      cpu_tmp4 =3D tcg_temp_new();
>      cpu_ptr0 =3D tcg_temp_new_ptr();
>      cpu_ptr1 =3D tcg_temp_new_ptr();
> -    cpu_cc_srcT =3D tcg_temp_local_new();
> +    dc->cc_srcT =3D tcg_temp_local_new();
>  }
>
>  static void i386_tr_tb_start(DisasContextBase *db, CPUState *cpu)


--
Alex Benn=C3=A9e
