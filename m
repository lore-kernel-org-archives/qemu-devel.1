Received: from eggs.gnu.org ([2001:4830:134:3::10]:33130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1drnnd-0001YU-4g
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1drnnb-0000kH-BB
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:12:33 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:38136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1drnnb-0000jw-4O
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:12:31 -0400
Received: by mail-it0-x243.google.com with SMTP id z81so6072809itb.5
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:12:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906160612.22769-29-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
	<20170906160612.22769-29-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 12 Sep 2017 18:12:28 +0200
Message-ID: <CABoDooN99XUyw6TFG+G2cu1yUfvgK057NKy1mEoKCtuyebwk0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 28/32] target/arm: [tcg] Port to generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>

Hello,

On Wed, Sep 6, 2017 at 6:06 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>
> Tested-by: Emilio G. Cota <cota@braap.org>
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> Message-Id: <150002631325.22386.10348327185029496649.stgit@frigg.lan>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate.h     |   8 +---
>  target/arm/translate-a64.c | 107 ++++++++-------------------------------=
-----
>  target/arm/translate.c     | 109 +++++++++------------------------------=
------
>  3 files changed, 41 insertions(+), 183 deletions(-)
>
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index e8dcec51ac..55d691db40 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -150,21 +150,15 @@ static void disas_set_insn_syndrome(DisasContext *s=
, uint32_t syn)
>
>  #ifdef TARGET_AARCH64
>  void a64_translate_init(void);
> -void gen_intermediate_code_a64(DisasContextBase *db, CPUState *cpu,
> -                               TranslationBlock *tb);
>  void gen_a64_set_pc_im(uint64_t val);
>  void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
>                              fprintf_function cpu_fprintf, int flags);
> +extern const TranslatorOps aarch64_translator_ops;
>  #else
>  static inline void a64_translate_init(void)
>  {
>  }
>
> -static inline void gen_intermediate_code_a64(DisasContextBase *db, CPUSt=
ate *cpu,
> -                                             TranslationBlock *tb)
> -{
> -}
> -
>  static inline void gen_a64_set_pc_im(uint64_t val)
>  {
>  }
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 1973a36462..25c6622825 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11262,6 +11262,11 @@ static int aarch64_tr_init_disas_context(DisasCo=
ntextBase *dcbase,
>      return max_insns;
>  }
>
> +static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> +{
> +    tcg_clear_temp_count();
> +}

Is it really needed to call tcg_clear_temp_count here when it's now
called in translator_loop?

> +
>  static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cp=
u)
>  {
>      DisasContext *dc =3D container_of(dcbase, DisasContext, base);
> @@ -11325,6 +11330,7 @@ static void aarch64_tr_translate_insn(DisasContex=
tBase *dcbase, CPUState *cpu)
>      }
>
>      dc->base.pc_next =3D dc->pc;
> +    translator_loop_temp_check(&dc->base);
>  }
>
>  static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
> @@ -11391,6 +11397,9 @@ static void aarch64_tr_tb_stop(DisasContextBase *=
dcbase, CPUState *cpu)
>              break;
>          }
>      }
> +
> +    /* Functions above can change dc->pc, so re-align db->pc_next */
> +    dc->base.pc_next =3D dc->pc;
>  }
>
>  static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
> @@ -11403,92 +11412,12 @@ static void aarch64_tr_disas_log(const DisasCon=
textBase *dcbase,
>                       4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
>  }
>
> -void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
> -                               TranslationBlock *tb)
> -{
> -    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
> -    int max_insns;
> -
> -    dc->base.tb =3D tb;
> -    dc->base.pc_first =3D dc->base.tb->pc;
> -    dc->base.pc_next =3D dc->base.pc_first;
> -    dc->base.is_jmp =3D DISAS_NEXT;
> -    dc->base.num_insns =3D 0;
> -    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
> -
> -    max_insns =3D dc->base.tb->cflags & CF_COUNT_MASK;
> -    if (max_insns =3D=3D 0) {
> -        max_insns =3D CF_COUNT_MASK;
> -    }
> -    if (max_insns > TCG_MAX_INSNS) {
> -        max_insns =3D TCG_MAX_INSNS;
> -    }
> -    max_insns =3D aarch64_tr_init_disas_context(&dc->base, cs, max_insns=
);
> -
> -    gen_tb_start(tb);
> -
> -    tcg_clear_temp_count();
> -
> -    do {
> -        dc->base.num_insns++;
> -        aarch64_tr_insn_start(&dc->base, cs);
> -
> -        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
> -            CPUBreakpoint *bp;
> -            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
> -                if (bp->pc =3D=3D dc->base.pc_next) {
> -                    if (aarch64_tr_breakpoint_check(&dc->base, cs, bp)) =
{
> -                        break;
> -                    }
> -                }
> -            }
> -            if (dc->base.is_jmp > DISAS_TOO_MANY) {
> -                break;
> -            }
> -        }
> -
> -        if (dc->base.num_insns =3D=3D max_insns && (dc->base.tb->cflags =
& CF_LAST_IO)) {
> -            gen_io_start();
> -        }
> -
> -        aarch64_tr_translate_insn(&dc->base, cs);
> -
> -        if (tcg_check_temp_count()) {
> -            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
> -                    dc->pc);
> -        }
> -
> -        if (!dc->base.is_jmp && (tcg_op_buf_full() || cs->singlestep_ena=
bled ||
> -                            singlestep || dc->base.num_insns >=3D max_in=
sns)) {
> -            dc->base.is_jmp =3D DISAS_TOO_MANY;
> -        }
> -
> -        /* Translation stops when a conditional branch is encountered.
> -         * Otherwise the subsequent code could get translated several ti=
mes.
> -         * Also stop translation when a page boundary is reached.  This
> -         * ensures prefetch aborts occur at the right place.
> -         */
> -    } while (!dc->base.is_jmp);
> -
> -    if (dc->base.tb->cflags & CF_LAST_IO) {
> -        gen_io_end();
> -    }
> -
> -    aarch64_tr_tb_stop(&dc->base, cs);
> -
> -    gen_tb_end(tb, dc->base.num_insns);
> -
> -    dc->base.tb->size =3D dc->pc - dc->base.pc_first;
> -    dc->base.tb->icount =3D dc->base.num_insns;
> -
> -#ifdef DEBUG_DISAS
> -    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
> -        qemu_log_in_addr_range(dc->base.pc_first)) {
> -        qemu_log_lock();
> -        qemu_log("----------------\n");
> -        aarch64_tr_disas_log(&dc->base, cs);
> -        qemu_log("\n");
> -        qemu_log_unlock();
> -    }
> -#endif
> -}
> +const TranslatorOps aarch64_translator_ops =3D {
> +    .init_disas_context =3D aarch64_tr_init_disas_context,
> +    .tb_start           =3D aarch64_tr_tb_start,
> +    .insn_start         =3D aarch64_tr_insn_start,
> +    .breakpoint_check   =3D aarch64_tr_breakpoint_check,
> +    .translate_insn     =3D aarch64_tr_translate_insn,
> +    .tb_stop            =3D aarch64_tr_tb_stop,
> +    .disas_log          =3D aarch64_tr_disas_log,
> +};
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 2dca196e17..dabd5eb89a 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11936,6 +11936,7 @@ static void arm_tr_tb_start(DisasContextBase *dcb=
ase, CPUState *cpu)
>          tcg_gen_movi_i32(tmp, 0);
>          store_cpu_field(tmp, condexec_bits);
>      }
> +    tcg_clear_temp_count();

Same here.

Thanks,

Laurent

>  }
>
>  static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
> @@ -12055,6 +12056,7 @@ static void arm_tr_translate_insn(DisasContextBas=
e *dcbase, CPUState *cpu)
>      }
>
>      dc->base.pc_next =3D dc->pc;
> +    translator_loop_temp_check(&dc->base);
>  }
>
>  static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
> @@ -12169,6 +12171,9 @@ static void arm_tr_tb_stop(DisasContextBase *dcba=
se, CPUState *cpu)
>              gen_goto_tb(dc, 1, dc->pc);
>          }
>      }
> +
> +    /* Functions above can change dc->pc, so re-align db->pc_next */
> +    dc->base.pc_next =3D dc->pc;
>  }
>
>  static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *c=
pu)
> @@ -12180,99 +12185,29 @@ static void arm_tr_disas_log(const DisasContext=
Base *dcbase, CPUState *cpu)
>                       dc->thumb | (dc->sctlr_b << 1));
>  }
>
> +static const TranslatorOps arm_translator_ops =3D {
> +    .init_disas_context =3D arm_tr_init_disas_context,
> +    .tb_start           =3D arm_tr_tb_start,
> +    .insn_start         =3D arm_tr_insn_start,
> +    .breakpoint_check   =3D arm_tr_breakpoint_check,
> +    .translate_insn     =3D arm_tr_translate_insn,
> +    .tb_stop            =3D arm_tr_tb_stop,
> +    .disas_log          =3D arm_tr_disas_log,
> +};
> +
>  /* generate intermediate code for basic block 'tb'.  */
> -void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
> +void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>  {
> -    DisasContext dc1, *dc =3D &dc1;
> -    int max_insns;
> -
> -    /* generate intermediate code */
> +    DisasContext dc;
> +    const TranslatorOps *ops =3D &arm_translator_ops;
>
> -    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
> -     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
> -     */
> +#ifdef TARGET_AARCH64
>      if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
> -        gen_intermediate_code_a64(&dc->base, cs, tb);
> -        return;
> -    }
> -
> -    dc->base.tb =3D tb;
> -    dc->base.pc_first =3D dc->base.tb->pc;
> -    dc->base.pc_next =3D dc->base.pc_first;
> -    dc->base.is_jmp =3D DISAS_NEXT;
> -    dc->base.num_insns =3D 0;
> -    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
> -
> -    max_insns =3D tb->cflags & CF_COUNT_MASK;
> -    if (max_insns =3D=3D 0) {
> -        max_insns =3D CF_COUNT_MASK;
> -    }
> -    if (max_insns > TCG_MAX_INSNS) {
> -        max_insns =3D TCG_MAX_INSNS;
> -    }
> -    max_insns =3D arm_tr_init_disas_context(&dc->base, cs, max_insns);
> -
> -    gen_tb_start(tb);
> -
> -    tcg_clear_temp_count();
> -    arm_tr_tb_start(&dc->base, cs);
> -
> -    do {
> -        dc->base.num_insns++;
> -        arm_tr_insn_start(&dc->base, cs);
> -
> -        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
> -            CPUBreakpoint *bp;
> -            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
> -                if (bp->pc =3D=3D dc->base.pc_next) {
> -                    if (arm_tr_breakpoint_check(&dc->base, cs, bp)) {
> -                        break;
> -                    }
> -                }
> -            }
> -            if (dc->base.is_jmp > DISAS_TOO_MANY) {
> -                break;
> -            }
> -        }
> -
> -        if (dc->base.num_insns =3D=3D max_insns && (tb->cflags & CF_LAST=
_IO)) {
> -            gen_io_start();
> -        }
> -
> -        arm_tr_translate_insn(&dc->base, cs);
> -
> -        if (tcg_check_temp_count()) {
> -            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
> -                    dc->pc);
> -        }
> -
> -        if (!dc->base.is_jmp && (tcg_op_buf_full() || singlestep ||
> -                            dc->base.num_insns >=3D max_insns)) {
> -            dc->base.is_jmp =3D DISAS_TOO_MANY;
> -        }
> -    } while (!dc->base.is_jmp);
> -
> -    if (dc->base.tb->cflags & CF_LAST_IO) {
> -        gen_io_end();
> -    }
> -
> -    arm_tr_tb_stop(&dc->base, cs);
> -
> -    gen_tb_end(tb, dc->base.num_insns);
> -
> -    tb->size =3D dc->pc - dc->base.pc_first;
> -    tb->icount =3D dc->base.num_insns;
> -
> -#ifdef DEBUG_DISAS
> -    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
> -        qemu_log_in_addr_range(dc->base.pc_first)) {
> -        qemu_log_lock();
> -        qemu_log("----------------\n");
> -        arm_tr_disas_log(&dc->base, cs);
> -        qemu_log("\n");
> -        qemu_log_unlock();
> +        ops =3D &aarch64_translator_ops;
>      }
>  #endif
> +
> +    translator_loop(ops, &dc.base, cpu, tb);
>  }
>
>  static const char *cpu_mode_names[16] =3D {
> --
> 2.13.5
>
>
