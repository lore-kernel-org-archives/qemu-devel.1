Received: from eggs.gnu.org ([2001:4830:134:3::10]:53948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1enFPs-00010f-LK
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 22:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1enFPp-0000U1-Be
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 22:13:28 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1enFPp-0000TV-0f
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 22:13:25 -0500
Received: by mail-pg0-x241.google.com with SMTP id m1so514796pgp.13
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 19:13:24 -0800 (PST)
Date: Sun, 18 Feb 2018 12:13:21 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180218031321.GB2836@lianli.shorne-pla.net>
References: <1518917557-12063-1-git-send-email-cota@braap.org>
	<1518917557-12063-3-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518917557-12063-3-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] target/openrisc: convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Sat, Feb 17, 2018 at 08:32:37PM -0500, Emilio G. Cota wrote:
> Notes:
> 
> - Changed the num_insns test in tb_start to check for
>   dc->base.num_insns > 1, since when tb_start is first
>   called in a TB, base.num_insns is already set to 1.
> 
> - Removed DISAS_NEXT from the switch on tb_stop; use DISAS_TOO_MANY
>   instead.
> 
> - Added an assert_not_reached on tb_stop for DISAS_NEXT and the default
>   case.
> 
> - Merged the two separate log_target_disas calls into the disas_log op.

Hello, thanks for this again.  But just wondering if you can add some background
to the commit message?  Whats the benefit?  Probably something like "Updating
translate core to use new DisasContext and other apis which are being adopted in
other targets... "

-Stafford

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/openrisc/translate.c | 168 ++++++++++++++++++++++----------------------
>  1 file changed, 85 insertions(+), 83 deletions(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 0450144..4af4569 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -49,6 +49,7 @@ typedef struct DisasContext {
>      uint32_t mem_idx;
>      uint32_t tb_flags;
>      uint32_t delayed_branch;
> +    uint32_t next_page_start;
>  } DisasContext;
>  
>  static TCGv cpu_sr;
> @@ -1519,46 +1520,23 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
>      }
>  }
>  
> -void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
> +static int openrisc_tr_init_disas_context(DisasContextBase *dcbase,
> +                                          CPUState *cs, int max_insns)
>  {
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
>      CPUOpenRISCState *env = cs->env_ptr;
> -    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> -    struct DisasContext ctx, *dc = &ctx;
> -    uint32_t pc_start;
> -    uint32_t next_page_start;
> -    int num_insns;
> -    int max_insns;
>  
> -    pc_start = tb->pc;
> -
> -    dc->base.tb = tb;
> -    dc->base.singlestep_enabled = cs->singlestep_enabled;
> -    dc->base.pc_next = pc_start;
> -    dc->base.is_jmp = DISAS_NEXT;
> -
> -    dc->mem_idx = cpu_mmu_index(&cpu->env, false);
> +    dc->mem_idx = cpu_mmu_index(env, false);
>      dc->tb_flags = dc->base.tb->flags;
>      dc->delayed_branch = (dc->tb_flags & TB_FLAGS_DFLAG) != 0;
> +    dc->next_page_start = (dc->base.pc_first & TARGET_PAGE_MASK) +
> +        TARGET_PAGE_SIZE;
> +    return max_insns;
> +}
>  
> -    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> -    num_insns = 0;
> -    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
> -
> -    if (max_insns == 0) {
> -        max_insns = CF_COUNT_MASK;
> -    }
> -    if (max_insns > TCG_MAX_INSNS) {
> -        max_insns = TCG_MAX_INSNS;
> -    }
> -
> -    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
> -        && qemu_log_in_addr_range(pc_start)) {
> -        qemu_log_lock();
> -        qemu_log("----------------\n");
> -        qemu_log("IN: %s\n", lookup_symbol(pc_start));
> -    }
> -
> -    gen_tb_start(tb);
> +static void openrisc_tr_tb_start(DisasContextBase *db, CPUState *cs)
> +{
> +    DisasContext *dc = container_of(db, DisasContext, base);
>  
>      /* Allow the TCG optimizer to see that R0 == 0,
>         when it's true, which is the common case.  */
> @@ -1567,50 +1545,60 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>      } else {
>          cpu_R[0] = cpu_R0;
>      }
> +}
> +
> +static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
>  
> -    do {
> -        tcg_gen_insn_start(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
> -			   | (num_insns ? 2 : 0));
> -        num_insns++;
> +    tcg_gen_insn_start(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
> +                       | (dc->base.num_insns > 1 ? 2 : 0));
> +}
>  
> -        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next, BP_ANY))) {
> -            tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
> -            gen_exception(dc, EXCP_DEBUG);
> +static bool openrisc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
> +                                         const CPUBreakpoint *bp)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +
> +    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
> +    gen_exception(dc, EXCP_DEBUG);
> +    dc->base.is_jmp = DISAS_UPDATE;
> +    /* The address covered by the breakpoint must be included in
> +       [tb->pc, tb->pc + tb->size) in order to for it to be
> +       properly cleared -- thus we increment the PC here so that
> +       the logic setting tb->size below does the right thing.  */
> +    dc->base.pc_next += 4;
> +    return true;
> +}
> +
> +static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
> +
> +    disas_openrisc_insn(dc, cpu);
> +    dc->base.pc_next += 4;
> +
> +    /* delay slot */
> +    if (dc->delayed_branch) {
> +        dc->delayed_branch--;
> +        if (!dc->delayed_branch) {
> +            tcg_gen_mov_tl(cpu_pc, jmp_pc);
> +            tcg_gen_discard_tl(jmp_pc);
>              dc->base.is_jmp = DISAS_UPDATE;
> -            /* The address covered by the breakpoint must be included in
> -               [tb->pc, tb->pc + tb->size) in order to for it to be
> -               properly cleared -- thus we increment the PC here so that
> -               the logic setting tb->size below does the right thing.  */
> -            dc->base.pc_next += 4;
> -            break;
> +            return;
>          }
> +    }
>  
> -        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
> -            gen_io_start();
> -        }
> -        disas_openrisc_insn(dc, cpu);
> -        dc->base.pc_next += 4;
> -
> -        /* delay slot */
> -        if (dc->delayed_branch) {
> -            dc->delayed_branch--;
> -            if (!dc->delayed_branch) {
> -                tcg_gen_mov_tl(cpu_pc, jmp_pc);
> -                tcg_gen_discard_tl(jmp_pc);
> -                dc->base.is_jmp = DISAS_UPDATE;
> -                break;
> -            }
> -        }
> -    } while (!dc->base.is_jmp
> -             && !tcg_op_buf_full()
> -             && !dc->base.singlestep_enabled
> -             && !singlestep
> -             && (dc->base.pc_next < next_page_start)
> -             && num_insns < max_insns);
> -
> -    if (tb_cflags(tb) & CF_LAST_IO) {
> -        gen_io_end();
> +    if (dc->base.is_jmp == DISAS_NEXT &&
> +        dc->base.pc_next >= dc->next_page_start) {
> +        dc->base.is_jmp = DISAS_TOO_MANY;
>      }
> +}
> +
> +static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
>  
>      if ((dc->tb_flags & TB_FLAGS_DFLAG ? 1 : 0) != (dc->delayed_branch != 0)) {
>          tcg_gen_movi_i32(cpu_dflag, dc->delayed_branch != 0);
> @@ -1625,10 +1613,9 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>          gen_exception(dc, EXCP_DEBUG);
>      } else {
>          switch (dc->base.is_jmp) {
> -        case DISAS_NEXT:
> +        case DISAS_TOO_MANY:
>              gen_goto_tb(dc, 0, dc->base.pc_next);
>              break;
> -        default:
>          case DISAS_JUMP:
>              break;
>          case DISAS_UPDATE:
> @@ -1639,20 +1626,35 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>          case DISAS_TB_JUMP:
>              /* nothing more to generate */
>              break;
> +        default:
> +            g_assert_not_reached();
>          }
>      }
> +}
> +
> +static void openrisc_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
> +{
> +    DisasContext *s = container_of(dcbase, DisasContext, base);
>  
> -    gen_tb_end(tb, num_insns);
> +    qemu_log("IN: %s\n", lookup_symbol(s->base.pc_first));
> +    log_target_disas(cs, s->base.pc_first, s->base.tb->size);
> +}
>  
> -    tb->size = dc->base.pc_next - pc_start;
> -    tb->icount = num_insns;
> +static const TranslatorOps openrisc_tr_ops = {
> +    .init_disas_context = openrisc_tr_init_disas_context,
> +    .tb_start           = openrisc_tr_tb_start,
> +    .insn_start         = openrisc_tr_insn_start,
> +    .breakpoint_check   = openrisc_tr_breakpoint_check,
> +    .translate_insn     = openrisc_tr_translate_insn,
> +    .tb_stop            = openrisc_tr_tb_stop,
> +    .disas_log          = openrisc_tr_disas_log,
> +};
>  
> -    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
> -        && qemu_log_in_addr_range(pc_start)) {
> -        log_target_disas(cs, pc_start, tb->size);
> -        qemu_log("\n");
> -        qemu_log_unlock();
> -    }
> +void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
> +{
> +    DisasContext ctx;
> +
> +    translator_loop(&openrisc_tr_ops, &ctx.base, cs, tb);
>  }
>  
>  void openrisc_cpu_dump_state(CPUState *cs, FILE *f,
> -- 
> 2.7.4
> 
