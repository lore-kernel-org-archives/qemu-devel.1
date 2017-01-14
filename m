Received: from eggs.gnu.org ([2001:4830:134:3::10]:44811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cSJKO-00063s-Tl
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cSJKK-0003OY-8A
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:04:44 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cSJKK-0003OP-0V
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:04:40 -0500
Received: by mail-pf0-x244.google.com with SMTP id y143so10997376pfb.1
	for <qemu-devel@nongnu.org>; Sat, 14 Jan 2017 00:04:39 -0800 (PST)
Date: Sat, 14 Jan 2017 17:04:35 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170114080435.GF25986@lianli.shorne-pla.net>
References: <20170113215720.29598-1-shorne@gmail.com>
	<20170113220252.GE25986@lianli.shorne-pla.net>
	<CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org

Hello,

On Sat, Jan 14, 2017 at 12:29:32PM +0800, Jia Liu wrote:
> Hi all,
> 
> On Sat, Jan 14, 2017 at 6:02 AM, Stafford Horne <shorne@gmail.com> wrote:
> > Hello,
> >
> > Sorry for the duplicate. There was an issue with my copy to qemu-devel
> > group.  Resent to everyone with proper cc to qemu-devel.
> >
> > Please ignore this one.
> >
> > -Stafford
> >
> > On Sat, Jan 14, 2017 at 06:57:20AM +0900, Stafford Horne wrote:
> >> I am working on testing instruction emulation patches for the linux
> >> kernel. During testing I found these 2 issues:
> >>
> >>  - sets DSX (delay slot exception) but never clears it
> >>  - EEAR for illegal insns should point to the bad exception (as per
> >>    openrisc spec) but its not
> >>
> >> This patch fixes these two issues by clearing the DSX flag when not in a
> >> delay slot and by setting EEAR to exception PC when handling illegal
> >> instruction exceptions.
> >>
> >> After this patch the openrisc kernel with latest patches boots great on
> >> qemu and instruction emulation works.
> >>
> >> Cc: qemu-trivial@nongnu.org
> >> Cc: openrisc@lists.librecores.org
> >> Signed-off-by: Stafford Horne <shorne@gmail.com>
> >> ---
> >>  target/openrisc/interrupt.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> >> index 5fe3f11..e1b0142 100644
> >> --- a/target/openrisc/interrupt.c
> >> +++ b/target/openrisc/interrupt.c
> >> @@ -38,10 +38,17 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
> >>          env->flags &= ~D_FLAG;
> >>          env->sr |= SR_DSX;
> >>          env->epcr -= 4;
> >> +    } else {
> >> +        env->sr &= ~SR_DSX;
> >>      }
> >>      if (cs->exception_index == EXCP_SYSCALL) {
> >>          env->epcr += 4;
> >>      }
> >> +    /* When we have an illegal instruction the error effective address
> >> +       shall be set to the illegal instruction address.  */
> >> +    if (cs->exception_index == EXCP_ILLEGAL) {
> >> +        env->eear = env->pc;
> >> +    }
> >>
> >>      /* For machine-state changed between user-mode and supervisor mode,
> >>         we need flush TLB when we enter&exit EXCP.  */
> 
> Anyone wanna take the openrisc job in QEMU?
> Will you Stafford?
> I really don't have time working on it.

I don't mind watching the the mailing list and collecting patchs and
sending pull requests for openrisc.

But if anyone is more willing to take over the role I would not step in
their way.  I only have a few days experience with the qemu code base.
But I do think its very nice :)

I think I would need my key signed, do you know anyone in Japan?

> And, this is the lwa&swa support.
> It also make latest Linux boot.

Thanks, I know about these patches from Sebastian.  In my case I
explicity wanted to fix the illegal instruction handling logic as I am
testing the instruction emulation patch for lwa/swa which I am preparing
for the next kernel merge window.  (I am currently the Linux openrisc
maintainer)

I think the l.swa and l.lwa support should go in too. I have tested
those instructions on fpga and the or1ksim simulator.

-Stafford

> diff --git a/target-openrisc/cpu.c b/target-openrisc/cpu.c
> index 155913f..e6f6186 100644
> --- a/target-openrisc/cpu.c
> +++ b/target-openrisc/cpu.c
> @@ -55,6 +55,7 @@ static void openrisc_cpu_reset(CPUState *s)
>  
>      cpu->env.pc = 0x100;
>      cpu->env.sr = SR_FO | SR_SM;
> +    cpu->env.lock_addr = -1;
>      s->exception_index = -1;
>  
>      cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP;
> diff --git a/target-openrisc/cpu.h b/target-openrisc/cpu.h
> index aaf1535..d64c54f 100644
> --- a/target-openrisc/cpu.h
> +++ b/target-openrisc/cpu.h
> @@ -296,6 +296,9 @@ typedef struct CPUOpenRISCState {
>      uint32_t fpcsr;           /* Float register */
>      float_status fp_status;
>  
> +    target_ulong lock_addr;
> +    target_ulong lock_value;
> +
>      uint32_t flags;           /* cpu_flags, we only use it for exception
>                                   in solt so far.  */
>      uint32_t btaken;          /* the SR_F bit */
> diff --git a/target-openrisc/interrupt.c b/target-openrisc/interrupt.c
> index 5fe3f11..2c4f452 100644
> --- a/target-openrisc/interrupt.c
> +++ b/target-openrisc/interrupt.c
> @@ -55,6 +55,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>      env->sr &= ~SR_TEE;
>      env->tlb->cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
>      env->tlb->cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
> +    env->lock_addr = -1;
>  
>      if (cs->exception_index > 0 && cs->exception_index < EXCP_NR) {
>          env->pc = (cs->exception_index << 8);
> diff --git a/target-openrisc/interrupt_helper.c b/target-openrisc/interrupt_helper.c
> index 116f9109..a1d3a9b 100644
> --- a/target-openrisc/interrupt_helper.c
> +++ b/target-openrisc/interrupt_helper.c
> @@ -34,6 +34,7 @@ void HELPER(rfe)(CPUOpenRISCState *env)
>      cpu->env.pc = cpu->env.epcr;
>      cpu->env.npc = cpu->env.epcr;
>      cpu->env.sr = cpu->env.esr;
> +    cpu->env.lock_addr = -1;
>  
>  #ifndef CONFIG_USER_ONLY
>      if (cpu->env.sr & SR_DME) {
> diff --git a/target-openrisc/mmu.c b/target-openrisc/mmu.c
> index 505dcdc..56b11d3 100644
> --- a/target-openrisc/mmu.c
> +++ b/target-openrisc/mmu.c
> @@ -174,6 +174,7 @@ static void cpu_openrisc_raise_mmu_exception(OpenRISCCPU *cpu,
>  
>      cs->exception_index = exception;
>      cpu->env.eear = address;
> +    cpu->env.lock_addr = -1;
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target-openrisc/translate.c b/target-openrisc/translate.c
> index 28c9446..1185a00 100644
> --- a/target-openrisc/translate.c
> +++ b/target-openrisc/translate.c
> @@ -61,6 +61,8 @@ static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
>  static TCGv cpu_npc;
>  static TCGv cpu_ppc;
>  static TCGv_i32 env_btaken;    /* bf/bnf , F flag taken */
> +static TCGv cpu_lock_addr;
> +static TCGv cpu_lock_value;
>  static TCGv_i32 fpcsr;
>  static TCGv machi, maclo;
>  static TCGv fpmaddhi, fpmaddlo;
> @@ -95,6 +97,12 @@ void openrisc_translate_init(void)
>      env_btaken = tcg_global_mem_new_i32(cpu_env,
>                                          offsetof(CPUOpenRISCState, btaken),
>                                          "btaken");
> +    cpu_lock_addr = tcg_global_mem_new(cpu_env,
> +                                       offsetof(CPUOpenRISCState, lock_addr),
> +                                       "lock_addr");
> +    cpu_lock_value = tcg_global_mem_new(cpu_env,
> +                                        offsetof(CPUOpenRISCState, lock_value),
> +                                        "lock_value");
>      fpcsr = tcg_global_mem_new_i32(cpu_env,
>                                     offsetof(CPUOpenRISCState, fpcsr),
>                                     "fpcsr");
> @@ -264,6 +272,44 @@ static void gen_jump(DisasContext *dc, uint32_t imm, uint32_t reg, uint32_t op0)
>      gen_sync_flags(dc);
>  }
>  
> +static void gen_lwa(DisasContext *dc, TCGv rd, TCGv ra, int32_t ofs)
> +{
> +    TCGv ea = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(ea, ra, ofs);
> +    tcg_gen_qemu_ld_tl(rd, ea, dc->mem_idx, MO_TEUL);
> +    tcg_gen_mov_tl(cpu_lock_addr, ea);
> +    tcg_gen_mov_tl(cpu_lock_value, rd);
> +    tcg_temp_free(ea);
> +}
> +
> +static void gen_swa(DisasContext *dc, TCGv rb, TCGv ra, int32_t ofs)
> +{
> +    TCGv ea, val;
> +    TCGLabel *lab_fail, *lab_done;
> +
> +    ea = tcg_temp_new();
> +    tcg_gen_addi_tl(ea, ra, ofs);
> +
> +    lab_fail = gen_new_label();
> +    lab_done = gen_new_label();
> +    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
> +    tcg_temp_free(ea);
> +
> +    val = tcg_temp_new();
> +    tcg_gen_qemu_ld_tl(val, cpu_lock_addr, dc->mem_idx, MO_TEUL);
> +    tcg_gen_brcond_tl(TCG_COND_NE, val, cpu_lock_value, lab_fail);
> +
> +    tcg_gen_qemu_st_tl(rb, cpu_lock_addr, dc->mem_idx, MO_TEUL);
> +    tcg_gen_movi_i32(env_btaken, 0x1);
> +    tcg_gen_br(lab_done);
> +
> +    gen_set_label(lab_fail);
> +    tcg_gen_movi_i32(env_btaken, 0x0);
> +
> +    gen_set_label(lab_done);
> +    tcg_gen_movi_tl(cpu_lock_addr, -1);
> +}
>  
>  static void dec_calc(DisasContext *dc, uint32_t insn)
>  {
> @@ -858,6 +904,11 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
>          goto do_load;
>  #endif*/
>  
> +    case 0x1b: /* l.lwa */
> +        LOG_DIS("l.lwa r%d, r%d, %d\n", rd, ra, I16);
> +        gen_lwa(dc, cpu_R[rd], cpu_R[ra], I16);
> +        break;
> +
>      case 0x21:    /* l.lwz */
>          LOG_DIS("l.lwz r%d, r%d, %d\n", rd, ra, I16);
>          mop = MO_TEUL;
> @@ -1036,6 +1087,11 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
>          goto do_store;
>  #endif*/
>  
> +    case 0x33: /* l.swa */
> +        LOG_DIS("l.swa r%d, r%d, %d\n", ra, rb, I16);
> +        gen_swa(dc, cpu_R[rb], cpu_R[ra], sign_extend(tmp, 16));
> +        break;
> +
>      case 0x35:    /* l.sw */
>          LOG_DIS("l.sw %d, r%d, r%d, %d\n", I5, ra, rb, I11);
>          mop = MO_TEUL;
