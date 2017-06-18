Received: from eggs.gnu.org ([2001:4830:134:3::10]:55676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNf-0006O6-Sy
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNa-0004RJ-TU
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:47 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:57379 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNa-0004Q2-1t
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:42 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615220501.GA26408@flamenco>
Date: Sun, 18 Jun 2017 17:37:39 +0300
In-Reply-To: <20170615220501.GA26408@flamenco> (Emilio G. Cota's message of
	"Thu, 15 Jun 2017 18:05:02 -0400")
Message-ID: <87y3spcqfg.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] translator mega-patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Emilio G Cota writes:

> On Mon, Jun 12, 2017 at 17:54:09 +0300, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> include/exec/gen-icount.h             |    2=20
>> include/exec/translate-all_template.h |   73 ++++++++++++
>> include/qom/cpu.h                     |   22 ++++
>> translate-all_template.h              |  204 +++++++++++++++++++++++++++=
++++++

> I think this concept of "template" is quite painful.

> Find appended something that I find more palatable: it embeds
> DisasContextBase in DisasContext, so that we can have a standalone
> object with all generic code;

I don't get it. Isn't that what my series is already doing? Or do you mean
explicitly passing DisasContextBase to all the generic translator functions
below? I kind of dislike it every time I see container_of, and it makes type
checking from the compiler a bit more fragile.


> target-specific code is called via
> an "ops" struct with function pointers that targets fill in.
> The target-specific DisasContext struct can then be retrieved from
> the base struct with container_of().

I seem to remember we discussed this at some point before I sent the first
version, to allow multiple targets on the same binary, but decided against =
it.

Still, I can leave the ops struct in place without even trying to support
multiple targets. It should be a little bit slower (using function pointers
instead of a "template"), but I don't think performance will suffer that mu=
ch
since we're at the translation path.

Any other opinions on this and the point above?



> I'll send as a separate, proper patch the gen-icount changes; really
> having cpu_env there as a global seems wrong to me.

That's an orthogonal issue that can he handled in a separate series.


Thanks!
  Lluis



> What do you think?

> 		Emilio

> PS. Apply with `git am --scissors'.

> --- 8< ---

> Warning: INCOMPLETE, do not even think of merging!

> This is just to show an alternative approach to including C
> code from the target translators (ugh!). Only arm and aarch64
> have been converted.

> This applies on top of this series:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02833.html

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  Makefile.target            |   2 +-
>  include/exec/exec-all.h    |   2 +-
>  include/exec/gen-icount.h  |   6 +-
>  include/exec/translator.h  |  74 +++++++++++++++++++
>  target/arm/translate-a64.c | 130 ++++++++++++++++++----------------
>  target/arm/translate.c     | 173 +++++++++++++++++++++++----------------=
------
>  target/arm/translate.h     |  11 +--
>  translator.c               | 170 +++++++++++++++++++++++++++++++++++++++=
+++++
>  8 files changed, 411 insertions(+), 157 deletions(-)
>  create mode 100644 include/exec/translator.h
>  create mode 100644 translator.c

> diff --git a/Makefile.target b/Makefile.target
> index ce8dfe4..ef2d538 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -88,7 +88,7 @@ all: $(PROGS) stap
=20
>  #########################################################
>  # cpu emulator library
> -obj-y =3D exec.o translate-all.o cpu-exec.o
> +obj-y =3D exec.o translate-all.o cpu-exec.o translator.o
>  obj-y +=3D translate-common.o
>  obj-y +=3D cpu-exec-common.o
>  obj-y +=3D tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 6ad31a8..d376546 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -22,6 +22,7 @@
=20
>  #include "qemu-common.h"
>  #include "exec/tb-context.h"
> +#include "exec/translator.h"
=20
>  /* allow to see translation results - the slowdown should be negligible,=
 so we leave it */
>  #define DEBUG_DISAS
> @@ -37,7 +38,6 @@ typedef ram_addr_t tb_page_addr_t;
=20
>  /* is_jmp field values */
>  /* TODO: delete after all targets are transitioned to generic translatio=
n */
> -#include "exec/translate-all_template.h"
>  #define DISAS_NEXT    DJ_NEXT           /* next instruction can be analy=
zed */
>  #define DISAS_JUMP    (DJ_TARGET + 0)   /* only pc was modified dynamica=
lly */
>  #define DISAS_UPDATE  (DJ_TARGET + 1)   /* cpu state was modified dynami=
cally */
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index 547c979..f4ad610 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -8,7 +8,7 @@
>  static int icount_start_insn_idx;
>  static TCGLabel *exitreq_label;
=20
> -static inline void gen_tb_start(TranslationBlock *tb)
> +static inline void gen_tb_start(TranslationBlock *tb, TCGv_env cpu_env)
>  {
>      TCGv_i32 count, imm;
=20
> @@ -59,14 +59,14 @@ static inline void gen_tb_end(TranslationBlock *tb, i=
nt num_insns)
>      tcg_ctx.gen_op_buf[tcg_ctx.gen_op_buf[0].prev].next =3D 0;
>  }
=20
> -static inline void gen_io_start(void)
> +static inline void gen_io_start(TCGv_env cpu_env)
>  {
>      TCGv_i32 tmp =3D tcg_const_i32(1);
>      tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do=
_io));
>      tcg_temp_free_i32(tmp);
>  }
=20
> -static inline void gen_io_end(void)
> +static inline void gen_io_end(TCGv_env cpu_env)
>  {
>      TCGv_i32 tmp =3D tcg_const_i32(0);
>      tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do=
_io));
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> new file mode 100644
> index 0000000..f2da424
> --- /dev/null
> +++ b/include/exec/translator.h
> @@ -0,0 +1,74 @@
> +#ifndef EXEC_TRANSLATOR_H
> +#define EXEC_TRANSLATOR_H
> +
> +#include "exec/exec-all.h"
> +#include "tcg.h"
> +
> +/**
> + * BreakpointHitType:
> + * @BH_MISS: No hit
> + * @BH_HIT_INSN: Hit, but continue translating instruction
> + * @BH_HIT_TB: Hit, stop translating TB
> + *
> + * How to react to a breakpoint hit.
> + */
> +typedef enum BreakpointHitType {
> +    BH_MISS,
> +    BH_HIT_INSN,
> +    BH_HIT_TB,
> +} BreakpointHitType;
> +
> +/**
> + * DisasJumpType:
> + * @DJ_NEXT: Next instruction in program order
> + * @DJ_TOO_MANY: Too many instructions executed
> + * @DJ_TARGET: Start of target-specific conditions
> + *
> + * What instruction to disassemble next.
> + */
> +typedef enum DisasJumpType {
> +    DJ_NEXT,
> +    DJ_TOO_MANY,
> +    DJ_TARGET,
> +} DisasJumpType;
> +
> +/**
> + * DisasContextBase:
> + * @tb: Translation block for this disassembly.
> + * @pc_first: Address of first guest instruction in this TB.
> + * @pc_next: Address of next guest instruction in this TB (current during
> + *           disassembly).
> + * @num_insns: Number of translated instructions (including current).
> + * @singlestep_enabled: "Hardware" single stepping enabled.
> + *
> + * Architecture-agnostic disassembly context.
> + */
> +typedef struct DisasContextBase {
> +    TranslationBlock *tb;
> +    target_ulong pc_first;
> +    target_ulong pc_next;
> +    DisasJumpType jmp_type;
> +    unsigned int num_insns;
> +    bool singlestep_enabled;
> +} DisasContextBase;
> +
> +/* all void-returning ops are optional, i.e. can be NULL */
> +struct translator_ops {
> +    void (*init_context)(DisasContextBase *, CPUArchState *);
> +    void (*init_globals)(DisasContextBase *, CPUArchState *);
> +    void (*tb_start)(DisasContextBase *, CPUArchState *);
> +    void (*insn_start)(DisasContextBase *, CPUArchState *);
> +    BreakpointHitType (*breakpoint_hit)(DisasContextBase *, CPUArchState=
 *,
> +                                        const CPUBreakpoint *);
> +    target_ulong (*disas_insn)(DisasContextBase *, CPUArchState *);
> +    DisasJumpType (*stop_check)(DisasContextBase *, CPUArchState *);
> +    void (*stop)(DisasContextBase *, CPUArchState *);
> +    int (*disas_flags)(const DisasContextBase *);
> +};
> +
> +typedef struct translator_ops TranslatorOps;
> +
> +void translator_gen(const TranslatorOps *tr, DisasContextBase *base,
> +                    CPUState *cpu, TranslationBlock *tb, TCGv_env cpu_en=
v);
> +
> +#endif /* EXEC_TRANSLATOR_H */
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 508a016..c486d04 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1561,7 +1561,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
sn, bool isread,
>      }
=20
>      if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
> -        gen_io_start();
> +        gen_io_start(cpu_env);
>      }
=20
>      tcg_rt =3D cpu_reg(s, rt);
> @@ -1593,7 +1593,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
sn, bool isread,
=20
>      if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
>          /* I/O operations must end the TB here (whether read or write) */
> -        gen_io_end();
> +        gen_io_end(cpu_env);
s-> base.jmp_type =3D DJ_UPDATE;
>      } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>          /* We default to ending the TB on a coprocessor register write,
> @@ -11191,16 +11191,10 @@ static void disas_a64_insn(CPUARMState *env, Di=
sasContext *s)
>      free_tmp_a64(s);
>  }
=20
> -
> -
> -/* Use separate top-level templates for each architecture */
> -#define gen_intermediate_code gen_intermediate_code_aarch64
> -#include "translate-all_template.h"
> -#undef gen_intermediate_code
> -
> -static void gen_intermediate_code_target_init_disas_context(
> -    DisasContext *dc, CPUArchState *env)
> +static void a64_tr_init_dc(DisasContextBase *base, CPUArchState *env)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
dc-> condjmp =3D 0;
=20
dc-> aarch64 =3D 1;
> @@ -11211,17 +11205,17 @@ static void gen_intermediate_code_target_init_d=
isas_context(
>                                 !arm_el_is_aa64(env, 3);
dc-> thumb =3D 0;
dc-> sctlr_b =3D 0;
> -    dc->be_data =3D ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_=
LE;
> +    dc->be_data =3D ARM_TBFLAG_BE_DATA(base->tb->flags) ? MO_BE : MO_LE;
dc-> condexec_mask =3D 0;
dc-> condexec_cond =3D 0;
> -    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.=
tb->flags));
> -    dc->tbi0 =3D ARM_TBFLAG_TBI0(dc->base.tb->flags);
> -    dc->tbi1 =3D ARM_TBFLAG_TBI1(dc->base.tb->flags);
> +    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(base->tb-=
>flags));
> +    dc->tbi0 =3D ARM_TBFLAG_TBI0(base->tb->flags);
> +    dc->tbi1 =3D ARM_TBFLAG_TBI1(base->tb->flags);
dc-> current_el =3D arm_mmu_idx_to_el(dc->mmu_idx);
>  #if !defined(CONFIG_USER_ONLY)
dc-> user =3D (dc->current_el =3D=3D 0);
>  #endif
> -    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
> +    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(base->tb->flags);
dc-> vec_len =3D 0;
dc-> vec_stride =3D 0;
dc-> cp_regs =3D arm_env_get_cpu(env)->cp_regs;
> @@ -11242,43 +11236,35 @@ static void gen_intermediate_code_target_init_d=
isas_context(
>       *   emit code to generate a software step exception
>       *   end the TB
>       */
> -    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
> -    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
> +    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(base->tb->flags);
> +    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(base->tb->flags);
dc-> is_ldex =3D false;
dc-> ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
=20
>      init_tmp_a64_array(dc);
=20
dc-> next_page_start =3D
> -        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> -}
> -
> -static void gen_intermediate_code_target_init_globals(
> -    DisasContext *dc, CPUArchState *env)
> -{
> +        (base->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
>  }
=20
> -static void gen_intermediate_code_target_tb_start(
> -    DisasContext *dc, CPUArchState *env)
> +static void a64_tr_insn_start(DisasContextBase *base, CPUArchState *env)
>  {
> -}
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
=20
> -static void gen_intermediate_code_target_insn_start(
> -    DisasContext *dc, CPUArchState *env)
> -{
dc-> insn_start_idx =3D tcg_op_buf_count();
> -    tcg_gen_insn_start(dc->base.pc_next, 0, 0);
> +    tcg_gen_insn_start(base->pc_next, 0, 0);
>  }
=20
> -static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
> -    DisasContext *dc, CPUArchState *env,
> -    const CPUBreakpoint *bp)
> +static BreakpointHitType
> +a64_tr_bp_hit(DisasContextBase *b, CPUArchState *env, const CPUBreakpoin=
t *bp)
>  {
> +    DisasContext *dc =3D container_of(b, DisasContext, base);
> +
>      if (bp->flags & BP_CPU) {
> -        gen_a64_set_pc_im(dc->base.pc_next);
> +        gen_a64_set_pc_im(b->pc_next);
>          gen_helper_check_breakpoints(cpu_env);
>          /* End the TB early; it likely won't be executed */
> -        dc->base.jmp_type =3D DJ_UPDATE;
> +        b->jmp_type =3D DJ_UPDATE;
>          return BH_HIT_INSN;
>      } else {
>          gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
> @@ -11287,14 +11273,15 @@ static BreakpointHitType gen_intermediate_code_=
target_breakpoint_hit(
>             to for it to be properly cleared -- thus we
>             increment the PC here so that the logic setting
tb-> size below does the right thing.  */
> -        dc->base.pc_next +=3D 4;
> +        b->pc_next +=3D 4;
>          return BH_HIT_TB;
>      }
>  }
=20
> -static target_ulong gen_intermediate_code_target_disas_insn(
> -    DisasContext *dc, CPUArchState *env)
> +static target_ulong a64_tr_disas_insn(DisasContextBase *base, CPUArchSta=
te *env)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
>      if (dc->ss_active && !dc->pstate_ss) {
>          /* Singlestep state is Active-pending.
>           * If we're in this state at the start of a TB then either
> @@ -11306,19 +11293,21 @@ static target_ulong gen_intermediate_code_targe=
t_disas_insn(
>           * "did not step an insn" case, and so the syndrome ISV and EX
>           * bits should be zero.
>           */
> -        assert(dc->base.num_insns =3D=3D 1);
> +        assert(base->num_insns =3D=3D 1);
>          gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
>                        default_exception_el(dc));
> -        dc->base.jmp_type =3D DJ_EXC;
> +        base->jmp_type =3D DJ_EXC;
>      } else {
>          disas_a64_insn(env, dc);
>      }
> -    return dc->base.pc_next;
> +    return base->pc_next;
>  }
=20
> -static DisasJumpType gen_intermediate_code_target_stop_check(
> -    DisasContext *dc, CPUArchState *env)
> +static DisasJumpType
> +a64_tr_stop_check(DisasContextBase *base, CPUArchState *env)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
>      /* Translation stops when a conditional branch is encountered.
>       * Otherwise the subsequent code could get translated several times.
>       * Also stop translation when a page boundary is reached.  This
> @@ -11327,41 +11316,42 @@ static DisasJumpType gen_intermediate_code_targ=
et_stop_check(
>      if (dc->ss_active) {
>          return DJ_SS;
>      } else {
> -        return dc->base.jmp_type;
> +        return base->jmp_type;
>      }
>  }
=20
> -static void gen_intermediate_code_target_stop(
> -    DisasContext *dc, CPUArchState *env)
> +static void a64_tr_stop(DisasContextBase *base, CPUArchState *env)
>  {
> -    if (unlikely(dc->base.singlestep_enabled || dc->ss_active)
> -        && dc->base.jmp_type !=3D DJ_EXC) {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
> +    if (unlikely(base->singlestep_enabled || dc->ss_active)
> +        && base->jmp_type !=3D DJ_EXC) {
>          /* Note that this means single stepping WFI doesn't halt the CPU.
>           * For conditional branch insns this is harmless unreachable cod=
e as
>           * gen_goto_tb() has already handled emitting the debug exception
>           * (and thus a tb-jump is not possible when singlestepping).
>           */
> -        assert(dc->base.jmp_type !=3D DJ_TB_JUMP);
> -        if (dc->base.jmp_type !=3D DJ_JUMP) {
> -            gen_a64_set_pc_im(dc->base.pc_next);
> +        assert(base->jmp_type !=3D DJ_TB_JUMP);
> +        if (base->jmp_type !=3D DJ_JUMP) {
> +            gen_a64_set_pc_im(base->pc_next);
>          }
> -        if (dc->base.singlestep_enabled) {
> +        if (base->singlestep_enabled) {
>              gen_exception_internal(EXCP_DEBUG);
>          } else {
>              gen_step_complete_exception(dc);
>          }
>      } else {
>          /* Cast because target-specific values are not in generic enum */
> -        unsigned int jt =3D (unsigned int)dc->base.jmp_type;
> +        unsigned int jt =3D (unsigned int)base->jmp_type;
=20
>          switch (jt) {
>          case DJ_NEXT:
>          case DJ_TOO_MANY:               /* target set DJ_NEXT */
> -            gen_goto_tb(dc, 1, dc->base.pc_next);
> +            gen_goto_tb(dc, 1, base->pc_next);
>              break;
>          default:
>          case DJ_UPDATE:
> -            gen_a64_set_pc_im(dc->base.pc_next);
> +            gen_a64_set_pc_im(base->pc_next);
>              /* fall through */
>          case DJ_JUMP:
>              tcg_gen_lookup_and_goto_ptr(cpu_pc);
> @@ -11375,18 +11365,18 @@ static void gen_intermediate_code_target_stop(
>              /* nothing to generate */
>              break;
>          case DJ_WFE:
> -            gen_a64_set_pc_im(dc->base.pc_next);
> +            gen_a64_set_pc_im(base->pc_next);
>              gen_helper_wfe(cpu_env);
>              break;
>          case DJ_YIELD:
> -            gen_a64_set_pc_im(dc->base.pc_next);
> +            gen_a64_set_pc_im(base->pc_next);
>              gen_helper_yield(cpu_env);
>              break;
>          case DJ_WFI:
>              /* This is a special case because we don't want to just halt=
 the CPU
>               * if trying to debug across a WFI.
>               */
> -            gen_a64_set_pc_im(dc->base.pc_next);
> +            gen_a64_set_pc_im(base->pc_next);
>              gen_helper_wfi(cpu_env);
>              /* The helper doesn't necessarily throw an exception, but we
>               * must go back to the main loop to check for interrupts any=
way.
> @@ -11397,8 +11387,26 @@ static void gen_intermediate_code_target_stop(
>      }
>  }
=20
> -static int gen_intermediate_code_target_get_disas_flags(
> -    const DisasContext *dc)
> +static int a64_tr_disas_flags(const DisasContextBase *base)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
>      return 4 | (bswap_code(dc->sctlr_b) ? 2 : 0);
>  }
> +
> +static const TranslatorOps a64_tr =3D {
> +    .init_context	=3D a64_tr_init_dc,
> +    .insn_start		=3D a64_tr_insn_start,
> +    .breakpoint_hit	=3D a64_tr_bp_hit,
> +    .disas_insn		=3D a64_tr_disas_insn,
> +    .stop_check		=3D a64_tr_stop_check,
> +    .stop		=3D a64_tr_stop,
> +    .disas_flags	=3D a64_tr_disas_flags,
> +};
> +
> +void gen_intermediate_code_a64(CPUState *cpu, struct TranslationBlock *t=
b)
> +{
> +    DisasContext dc;
> +
> +    translator_gen(&a64_tr, &dc.base, cpu, tb, cpu_env);
> +}
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 06f207a..5ea9952 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7655,7 +7655,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
>          }
=20
>          if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_I=
O)) {
> -            gen_io_start();
> +            gen_io_start(cpu_env);
>          }
=20
>          if (isread) {
> @@ -7747,7 +7747,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
=20
>          if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_I=
O)) {
>              /* I/O operations must end the TB here (whether read or writ=
e) */
> -            gen_io_end();
> +            gen_io_end(cpu_env);
>              gen_lookup_tb(s);
>          } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>              /* We default to ending the TB on a coprocessor register wri=
te,
> @@ -11864,31 +11864,10 @@ void restore_state_to_opc(CPUARMState *env, Tra=
nslationBlock *tb,
>      }
>  }
=20
> -
> -
> -/* Use separate top-level templates for each architecture */
> -#define gen_intermediate_code gen_intermediate_code_arm
> -#include "translate-all_template.h"
> -#undef gen_intermediate_code
> -
> -#if !defined(TARGET_AARCH64)
> -void gen_intermediate_code_aarch64(CPUState *cpu, struct TranslationBloc=
k *tb)
> -{
> -}
> -#endif
> -
> -void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
> +static void arm_tr_init_dc(DisasContextBase *base, CPUARMState *env)
>  {
> -    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
> -        gen_intermediate_code_aarch64(cpu, tb);
> -    } else {
> -        gen_intermediate_code_arm(cpu, tb);
> -    }
> -}
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
=20
> -static void gen_intermediate_code_target_init_disas_context(
> -    DisasContext *dc, CPUARMState *env)
> -{
dc-> condjmp =3D 0;
=20
dc-> aarch64 =3D 0;
> @@ -11897,23 +11876,23 @@ static void gen_intermediate_code_target_init_d=
isas_context(
>       */
dc-> secure_routed_to_el3 =3D arm_feature(env, ARM_FEATURE_EL3) &&
>          !arm_el_is_aa64(env, 3);
> -    dc->thumb =3D ARM_TBFLAG_THUMB(dc->base.tb->flags);
> -    dc->sctlr_b =3D ARM_TBFLAG_SCTLR_B(dc->base.tb->flags);
> -    dc->be_data =3D ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_=
LE;
> -    dc->condexec_mask =3D (ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) & 0xf=
) << 1;
> -    dc->condexec_cond =3D ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) >> 4;
> -    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.=
tb->flags));
> +    dc->thumb =3D ARM_TBFLAG_THUMB(base->tb->flags);
> +    dc->sctlr_b =3D ARM_TBFLAG_SCTLR_B(base->tb->flags);
> +    dc->be_data =3D ARM_TBFLAG_BE_DATA(base->tb->flags) ? MO_BE : MO_LE;
> +    dc->condexec_mask =3D (ARM_TBFLAG_CONDEXEC(base->tb->flags) & 0xf) <=
< 1;
> +    dc->condexec_cond =3D ARM_TBFLAG_CONDEXEC(base->tb->flags) >> 4;
> +    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(base->tb-=
>flags));
dc-> current_el =3D arm_mmu_idx_to_el(dc->mmu_idx);
>  #if !defined(CONFIG_USER_ONLY)
dc-> user =3D (dc->current_el =3D=3D 0);
>  #endif
> -    dc->ns =3D ARM_TBFLAG_NS(dc->base.tb->flags);
> -    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
> -    dc->vfp_enabled =3D ARM_TBFLAG_VFPEN(dc->base.tb->flags);
> -    dc->vec_len =3D ARM_TBFLAG_VECLEN(dc->base.tb->flags);
> -    dc->vec_stride =3D ARM_TBFLAG_VECSTRIDE(dc->base.tb->flags);
> -    dc->c15_cpar =3D ARM_TBFLAG_XSCALE_CPAR(dc->base.tb->flags);
> -    dc->v7m_handler_mode =3D ARM_TBFLAG_HANDLER(dc->base.tb->flags);
> +    dc->ns =3D ARM_TBFLAG_NS(base->tb->flags);
> +    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(base->tb->flags);
> +    dc->vfp_enabled =3D ARM_TBFLAG_VFPEN(base->tb->flags);
> +    dc->vec_len =3D ARM_TBFLAG_VECLEN(base->tb->flags);
> +    dc->vec_stride =3D ARM_TBFLAG_VECSTRIDE(base->tb->flags);
> +    dc->c15_cpar =3D ARM_TBFLAG_XSCALE_CPAR(base->tb->flags);
> +    dc->v7m_handler_mode =3D ARM_TBFLAG_HANDLER(base->tb->flags);
dc-> cp_regs =3D arm_env_get_cpu(env)->cp_regs;
dc-> features =3D env->features;
=20
> @@ -11932,17 +11911,16 @@ static void gen_intermediate_code_target_init_d=
isas_context(
>       *   emit code to generate a software step exception
>       *   end the TB
>       */
> -    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
> -    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
> +    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(base->tb->flags);
> +    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(base->tb->flags);
dc-> is_ldex =3D false;
dc-> ss_same_el =3D false; /* Can't be true since EL_d must be AArch64 */
=20
dc-> next_page_start =3D
> -        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> +        (base->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
>  }
=20
> -static void gen_intermediate_code_target_init_globals(
> -    DisasContext *dc, CPUARMState *env)
> +static void arm_tr_init_globals(DisasContextBase *base, CPUARMState *env)
>  {
>      cpu_F0s =3D tcg_temp_new_i32();
>      cpu_F1s =3D tcg_temp_new_i32();
> @@ -11954,8 +11932,7 @@ static void gen_intermediate_code_target_init_glo=
bals(
>      cpu_M0 =3D tcg_temp_new_i64();
>  }
=20
> -static void gen_intermediate_code_target_tb_start(
> -    DisasContext *dc, CPUARMState *env)
> +static void arm_tr_tb_start(DisasContextBase *base, CPUARMState *env)
>  {
>      /* A note on handling of the condexec (IT) bits:
>       *
> @@ -11986,6 +11963,7 @@ static void gen_intermediate_code_target_tb_start(
>       * we don't need to care about whether CPUARMState is correct in the
>       * middle of a TB.
>       */
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
=20
>      /*
>       * Reset the conditional execution bits immediately. This avoids
> @@ -11998,43 +11976,45 @@ static void gen_intermediate_code_target_tb_sta=
rt(
>      }
>  }
=20
> -static void gen_intermediate_code_target_insn_start(
> -    DisasContext *dc, CPUARMState *env)
> +static void arm_tr_insn_start(DisasContextBase *base, CPUARMState *env)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
dc-> insn_start_idx =3D tcg_op_buf_count();
> -    tcg_gen_insn_start(dc->base.pc_next,
> +    tcg_gen_insn_start(base->pc_next,
>                         (dc->condexec_cond << 4) | (dc->condexec_mask >> =
1),
>                         0);
=20
=20
>  #ifdef CONFIG_USER_ONLY
>      /* Intercept jump to the magic kernel page.  */
> -    if (dc->base.pc_next >=3D 0xffff0000) {
> +    if (base->pc_next >=3D 0xffff0000) {
>          /* We always get here via a jump, so know we are not in a
>             conditional execution block.  */
>          gen_exception_internal(EXCP_KERNEL_TRAP);
> -        dc->base.jmp_type =3D DJ_EXC;
> +        base->jmp_type =3D DJ_EXC;
>      }
>  #else
> -    if (dc->base.pc_next >=3D 0xfffffff0 && arm_dc_feature(dc, ARM_FEATU=
RE_M)) {
> +    if (base->pc_next >=3D 0xfffffff0 && arm_dc_feature(dc, ARM_FEATURE_=
M)) {
>          /* We always get here via a jump, so know we are not in a
>             conditional execution block.  */
>          gen_exception_internal(EXCP_EXCEPTION_EXIT);
> -        dc->base.jmp_type =3D DJ_EXC;
> +        base->jmp_type =3D DJ_EXC;
>      }
>  #endif
>  }
=20
> -static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
> -    DisasContext *dc, CPUARMState *env,
> -    const CPUBreakpoint *bp)
> +static BreakpointHitType
> +arm_tr_bp_hit(DisasContextBase *base, CPUARMState *env, const CPUBreakpo=
int *bp)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
>      if (bp->flags & BP_CPU) {
>          gen_set_condexec(dc);
> -        gen_set_pc_im(dc, dc->base.pc_next);
> +        gen_set_pc_im(dc, base->pc_next);
>          gen_helper_check_breakpoints(cpu_env);
>          /* End the TB early; it's likely not going to be executed */
> -        dc->base.jmp_type =3D DJ_UPDATE;
> +        base->jmp_type =3D DJ_UPDATE;
>          return BH_HIT_INSN;
>      } else {
>          gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
> @@ -12045,14 +12025,15 @@ static BreakpointHitType gen_intermediate_code_=
target_breakpoint_hit(
tb-> size below does the right thing.  */
>          /* TODO: Advance PC by correct instruction length to avoid
>           * disassembler error messages */
> -        dc->base.pc_next +=3D 2;
> +        base->pc_next +=3D 2;
>          return BH_HIT_TB;
>      }
>  }
=20
> -static target_ulong gen_intermediate_code_target_disas_insn(
> -    DisasContext *dc, CPUArchState *env)
> +static target_ulong arm_tr_disas_insn(DisasContextBase *base, CPUArchSta=
te *env)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
>      if (dc->ss_active && !dc->pstate_ss) {
>          /* Singlestep state is Active-pending.
>           * If we're in this state at the start of a TB then either
> @@ -12064,11 +12045,11 @@ static target_ulong gen_intermediate_code_targe=
t_disas_insn(
>           * "did not step an insn" case, and so the syndrome ISV and EX
>           * bits should be zero.
>           */
> -        assert(dc->base.num_insns =3D=3D 1);
> +        assert(base->num_insns =3D=3D 1);
>          gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
>                        default_exception_el(dc));
> -        dc->base.jmp_type =3D DJ_SKIP;
> -        return dc->base.pc_next;
> +        base->jmp_type =3D DJ_SKIP;
> +        return base->pc_next;
>      }
=20
>      if (dc->thumb) {
> @@ -12082,30 +12063,32 @@ static target_ulong gen_intermediate_code_targe=
t_disas_insn(
>              }
>          }
>      } else {
> -        unsigned int insn =3D arm_ldl_code(env, dc->base.pc_next, dc->sc=
tlr_b);
> -        dc->base.pc_next +=3D 4;
> +        unsigned int insn =3D arm_ldl_code(env, base->pc_next, dc->sctlr=
_b);
> +        base->pc_next +=3D 4;
>          disas_arm_insn(dc, insn);
>      }
=20
> -    if (dc->condjmp && !dc->base.jmp_type) {
> +    if (dc->condjmp && !base->jmp_type) {
>          gen_set_label(dc->condlabel);
dc-> condjmp =3D 0;
>      }
=20
> -    return dc->base.pc_next;
> +    return base->pc_next;
>  }
=20
> -static DisasJumpType gen_intermediate_code_target_stop_check(
> -    DisasContext *dc, CPUARMState *env)
> +static DisasJumpType arm_tr_stop_check(DisasContextBase *base, CPUARMSta=
te *env)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
>      /* Translation stops when a conditional branch is encountered.
>       * Otherwise the subsequent code could get translated several times.
>       * Also stop translation when a page boundary is reached.  This
>       * ensures prefetch aborts occur at the right place.  */
=20
> +    dc =3D container_of(base, DisasContext, base);
>      if (is_singlestepping(dc)) {
>          return DJ_SS;
> -    } else if ((dc->base.pc_next >=3D dc->next_page_start - 3)
> +    } else if ((base->pc_next >=3D dc->next_page_start - 3)
>                 && insn_crosses_page(env, dc)) {
>          /*
>           * Generic code already checked if the next insn starts in a new
> @@ -12122,21 +12105,21 @@ static DisasJumpType gen_intermediate_code_targ=
et_stop_check(
>           */
>          return DJ_PAGE_CROSS;
>      } else {
> -        return dc->base.jmp_type;
> +        return base->jmp_type;
>      }
>  }
=20
> -static void gen_intermediate_code_target_stop(
> -    DisasContext *dc, CPUARMState *env)
> +static void arm_tr_stop(DisasContextBase *base, CPUARMState *env)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
>      /* Cast because target-specific values are not in generic enum */
> -    unsigned int jt =3D (unsigned int)dc->base.jmp_type;
> +    unsigned int jt =3D (unsigned int)base->jmp_type;
=20
>      if (jt =3D=3D DJ_SKIP) {
>          return;
>      }
=20
> -    if ((dc->base.tb->cflags & CF_LAST_IO) && dc->condjmp) {
> +    if ((base->tb->cflags & CF_LAST_IO) && dc->condjmp) {
>          /* FIXME: This can theoretically happen with self-modifying code=
. */
>          cpu_abort(ENV_GET_CPU(env), "IO on conditional branch instructio=
n");
>      }
> @@ -12145,7 +12128,7 @@ static void gen_intermediate_code_target_stop(
>         instruction was a conditional branch or trap, and the PC has
>         already been written.  */
>      gen_set_condexec(dc);
> -    if (dc->base.jmp_type =3D=3D DJ_BX_EXCRET) {
> +    if (base->jmp_type =3D=3D DJ_BX_EXCRET) {
>          /* Exception return branches need some special case code at the
>           * end of the TB, which is complex enough that it has to
>           * handle the single-step vs not and the condition-failed
> @@ -12171,7 +12154,7 @@ static void gen_intermediate_code_target_stop(
>          case DJ_NEXT:
>          case DJ_TOO_MANY:               /* target set DJ_NEXT */
>          case DJ_UPDATE:
> -            gen_set_pc_im(dc, dc->base.pc_next);
> +            gen_set_pc_im(dc, base->pc_next);
>              /* fall through */
>          default:
>              /* FIXME: Single stepping a WFI insn will not halt the CPU. =
*/
> @@ -12191,10 +12174,10 @@ static void gen_intermediate_code_target_stop(
>          switch (jt) {
>          case DJ_NEXT:
>          case DJ_TOO_MANY:               /* target set DJ_NEXT */
> -            gen_goto_tb(dc, 1, dc->base.pc_next);
> +            gen_goto_tb(dc, 1, base->pc_next);
>              break;
>          case DJ_UPDATE:
> -            gen_set_pc_im(dc, dc->base.pc_next);
> +            gen_set_pc_im(dc, base->pc_next);
>              /* fall through */
>          case DJ_JUMP:
>              gen_goto_ptr();
> @@ -12238,16 +12221,40 @@ static void gen_intermediate_code_target_stop(
>          gen_set_label(dc->condlabel);
>          gen_set_condexec(dc);
>          if (unlikely(is_singlestepping(dc))) {
> -            gen_set_pc_im(dc, dc->base.pc_next);
> +            gen_set_pc_im(dc, base->pc_next);
>              gen_singlestep_exception(dc);
>          } else {
> -            gen_goto_tb(dc, 1, dc->base.pc_next);
> +            gen_goto_tb(dc, 1, base->pc_next);
>          }
>      }
>  }
=20
> -static int gen_intermediate_code_target_get_disas_flags(
> -    const DisasContext *dc)
> +static int arm_tr_disas_flags(const DisasContextBase *base)
>  {
> +    DisasContext *dc =3D container_of(base, DisasContext, base);
> +
>      return dc->thumb | (dc->sctlr_b << 1);
>  }
> +
> +static const TranslatorOps arm_tr =3D {
> +    .init_context	=3D arm_tr_init_dc,
> +    .init_globals	=3D arm_tr_init_globals,
> +    .tb_start		=3D arm_tr_tb_start,
> +    .insn_start		=3D arm_tr_insn_start,
> +    .breakpoint_hit	=3D arm_tr_bp_hit,
> +    .disas_insn		=3D arm_tr_disas_insn,
> +    .stop_check		=3D arm_tr_stop_check,
> +    .stop		=3D arm_tr_stop,
> +    .disas_flags	=3D arm_tr_disas_flags,
> +};
> +
> +void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
> +{
> +    DisasContext dc;
> +
> +    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
> +        gen_intermediate_code_a64(cpu, tb);
> +    } else {
> +        translator_gen(&arm_tr, &dc.base, cpu, tb, cpu_env);
> +    }
> +}
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index 5473994..1aa5d49 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -1,8 +1,7 @@
>  #ifndef TARGET_ARM_TRANSLATE_H
>  #define TARGET_ARM_TRANSLATE_H
=20
> -#include "exec/translate-all_template.h"
> -
> +#include "exec/translator.h"
=20
>  /* internal defines */
>  typedef struct DisasContext {
> @@ -122,7 +121,6 @@ static void disas_set_insn_syndrome(DisasContext *s, =
uint32_t syn)
>  }
=20
>  /* Target-specific values for DisasContextBase::jmp_type */
> -#include "exec/translate-all_template.h"
>  #define DJ_JUMP    (DJ_TARGET + 0)
>  #define DJ_UPDATE  (DJ_TARGET + 1)
>  #define DJ_TB_JUMP (DJ_TARGET + 2)
> @@ -153,13 +151,10 @@ static void disas_set_insn_syndrome(DisasContext *s=
, uint32_t syn)
>  #define DJ_PAGE_CROSS (DJ_TARGET + 13)
>  #define DJ_SKIP    (DJ_TARGET + 14)
=20
> -void gen_intermediate_code_arm(CPUState *cpu, struct TranslationBlock *t=
b);
> -void gen_intermediate_code_aarch64(CPUState *cpu, struct TranslationBloc=
k *tb);
> -
>  #ifdef TARGET_AARCH64
>  void init_tmp_a64_array(DisasContext *s);
>  void a64_translate_init(void);
> -void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb);
> +void gen_intermediate_code_a64(CPUState *cpu, TranslationBlock *tb);
>  void gen_a64_set_pc_im(uint64_t val);
>  void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
>                              fprintf_function cpu_fprintf, int flags);
> @@ -172,7 +167,7 @@ static inline void a64_translate_init(void)
>  {
>  }
=20
> -static inline void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlo=
ck *tb)
> +static inline void gen_intermediate_code_a64(CPUState *cpu, TranslationB=
lock *tb)
>  {
>  }
=20
> diff --git a/translator.c b/translator.c
> new file mode 100644
> index 0000000..2248b52
> --- /dev/null
> +++ b/translator.c
> @@ -0,0 +1,170 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "disas/disas.h"
> +#include "cpu.h"
> +#include "tcg.h"
> +#include "tcg-op.h"
> +#include "exec/exec-all.h"
> +#include "exec/translator.h"
> +#include "exec/gen-icount.h"
> +#include "exec/log.h"
> +
> +static inline void check_tcg(const DisasContextBase *base)
> +{
> +    if (tcg_check_temp_count()) {
> +        error_report("warning: TCG temporary leaks before "TARGET_FMT_lx,
> +                     base->pc_next);
> +    }
> +}
> +
> +void translator_gen(const TranslatorOps *tr, DisasContextBase *base,
> +                    CPUState *cpu, TranslationBlock *tb, TCGv_env cpu_en=
v)
> +{
> +    CPUArchState *env =3D cpu->env_ptr;
> +    int max_insns;
> +
> +    /* Initialize DisasContextBase */
> +    base->tb =3D tb;
> +    base->singlestep_enabled =3D cpu->singlestep_enabled;
> +    base->pc_first =3D tb->pc;
> +    base->pc_next =3D base->pc_first;
> +    base->jmp_type =3D DJ_NEXT;
> +    base->num_insns =3D 0;
> +    if (tr->init_context) {
> +        tr->init_context(base, env);
> +    }
> +
> +    /* Initialize globals */
> +    if (tr->init_globals) {
> +        tr->init_globals(base, env);
> +    }
> +    tcg_clear_temp_count();
> +
> +    /* Instruction counting */
> +    max_insns =3D base->tb->cflags & CF_COUNT_MASK;
> +    if (max_insns =3D=3D 0) {
> +        max_insns =3D CF_COUNT_MASK;
> +    }
> +    if (max_insns > TCG_MAX_INSNS) {
> +        max_insns =3D TCG_MAX_INSNS;
> +    }
> +    if (base->singlestep_enabled || singlestep) {
> +        max_insns =3D 1;
> +    }
> +
> +    /* Start translating */
> +    gen_tb_start(base->tb, cpu_env);
> +    if (tr->tb_start) {
> +        tr->tb_start(base, env);
> +    }
> +
> +    while (true) {
> +        CPUBreakpoint *bp;
> +
> +        base->num_insns++;
> +        if (tr->insn_start) {
> +            tr->insn_start(base, env);
> +        }
> +
> +        /* Early exit before breakpoint checks */
> +        if (unlikely(base->jmp_type !=3D DJ_NEXT)) {
> +            break;
> +        }
> +
> +        /* Pass breakpoint hits to target for further processing */
> +        bp =3D NULL;
> +        do {
> +            bp =3D cpu_breakpoint_get(cpu, base->pc_next, bp);
> +            if (unlikely(bp)) {
> +                BreakpointHitType bh =3D tr->breakpoint_hit(base, env, b=
p);
> +                if (bh =3D=3D BH_HIT_INSN) {
> +                    /* Hit, keep translating */
> +                    /*
> +                     * TODO: if we're never going to have more than one =
BP in a
> +                     *       single address, we can simply use a bool he=
re.
> +                     */
> +                    break;
> +                } else if (bh =3D=3D BH_HIT_TB) {
> +                    goto done_generating;
> +                }
> +            }
> +        } while (bp !=3D NULL);
> +
> +        /* Accept I/O on last instruction */
> +        if (base->num_insns =3D=3D max_insns &&
> +            (base->tb->cflags & CF_LAST_IO)) {
> +            gen_io_start(cpu_env);
> +        }
> +
> +        /* Disassemble one instruction */
> +        base->pc_next =3D tr->disas_insn(base, env);
> +
> +        /**************************************************/
> +        /* Conditions to stop translation                 */
> +        /**************************************************/
> +
> +        /* Disassembly already set a stop condition */
> +        if (base->jmp_type >=3D DJ_TARGET) {
> +            break;
> +        }
> +
> +        /* Target-specific conditions */
> +        base->jmp_type =3D tr->stop_check(base, env);
> +        if (base->jmp_type >=3D DJ_TARGET) {
> +            break;
> +        }
> +
> +        /* Too many instructions */
> +        if (tcg_op_buf_full() || base->num_insns >=3D max_insns) {
> +            base->jmp_type =3D DJ_TOO_MANY;
> +            break;
> +        }
> +
> +        /*
> +         * Check if next instruction is on next page, which can cause an
> +         * exception.
> +         *
> +         * NOTE: Target-specific code must check a single instruction do=
es not
> +         *       cross page boundaries; the first in the TB is always al=
lowed to
> +         *       cross pages (never goes through this check).
> +         */
> +        if ((base->pc_first & TARGET_PAGE_MASK)
> +            !=3D (base->pc_next & TARGET_PAGE_MASK)) {
> +            base->jmp_type =3D DJ_TOO_MANY;
> +            break;
> +        }
> +
> +        check_tcg(base);
> +    }
> +
> +    if (tr->stop) {
> +        tr->stop(base, env);
> +    }
> +
> +    if (base->tb->cflags & CF_LAST_IO) {
> +        gen_io_end(cpu_env);
> +    }
> +
> + done_generating:
> +    gen_tb_end(base->tb, base->num_insns);
> +
> +    check_tcg(base);
> +
> +#ifdef DEBUG_DISAS
> +    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
> +        qemu_log_in_addr_range(base->pc_first)) {
> +        qemu_log_lock();
> +        qemu_log("----------------\n");
> +        qemu_log("IN: %s\n", lookup_symbol(base->pc_first));
> +        log_target_disas(cpu, base->pc_first,
> +                         base->pc_next - base->pc_first,
> +                         tr->disas_flags(base));
> +        qemu_log("\n");
> +        qemu_log_unlock();
> +    }
> +#endif
> +
> +    base->tb->size =3D base->pc_next - base->pc_first;
> +    base->tb->icount =3D base->num_insns;
> +}
> --=20
> 2.7.4
