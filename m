Received: from eggs.gnu.org ([209.51.188.92]:51181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hAvwU-0007Rv-Rz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hAvwT-0007se-Iu
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:21:34 -0400
References: <20190401102911.8685-1-richard.henderson@linaro.org>
	<20190401102911.8685-3-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3bc9c186-709b-ab28-f218-ebeaab8e6494@redhat.com>
Date: Mon, 1 Apr 2019 14:21:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190401102911.8685-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/6] target/s390x: Add ilen to
 unwind data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 01.04.19 12:29, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> Use ILEN_UNWIND to signal that we have in fact that
> cpu_restore_state will have been called by the time
> we arrive in do_program_interrupt.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu.h       |  4 +++-
>  target/s390x/internal.h  |  2 +-
>  target/s390x/interrupt.c |  7 +++++--
>  target/s390x/translate.c | 10 +++++++++-
>  4 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 6ccf41fc45..1498f3b7f4 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -44,7 +44,7 @@
>  #include "exec/cpu-all.h"
>  
>  #define NB_MMU_MODES 4
> -#define TARGET_INSN_START_EXTRA_WORDS 1
> +#define TARGET_INSN_START_EXTRA_WORDS 2
>  
>  #define MMU_MODE0_SUFFIX _primary
>  #define MMU_MODE1_SUFFIX _secondary
> @@ -787,6 +787,8 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo, void *puc);
>  void s390_crw_mchk(void);
>  void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
>                         uint32_t io_int_parm, uint32_t io_int_word);
> +/* instruction length set by unwind info */
> +#define ILEN_UNWIND                 0
>  /* automatically detect the instruction length */
>  #define ILEN_AUTO                   0xff
>  #define RA_IGNORED                  0
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index 3b4855c175..5f7901da5e 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -312,7 +312,7 @@ void cpu_unmap_lowcore(LowCore *lowcore);
>  
>  
>  /* interrupt.c */
> -void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
> +void trigger_pgm_exception(CPUS390XState *env, uint32_t code, int ilen);
>  void cpu_inject_clock_comparator(S390CPU *cpu);
>  void cpu_inject_cpu_timer(S390CPU *cpu);
>  void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
> diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
> index a17eff5ebc..901cd713de 100644
> --- a/target/s390x/interrupt.c
> +++ b/target/s390x/interrupt.c
> @@ -21,13 +21,16 @@
>  #endif
>  
>  /* Ensure to exit the TB after this call! */
> -void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
> +void trigger_pgm_exception(CPUS390XState *env, uint32_t code, int ilen)
>  {
>      CPUState *cs = CPU(s390_env_get_cpu(env));
>  
>      cs->exception_index = EXCP_PGM;
>      env->int_pgm_code = code;
> -    env->int_pgm_ilen = ilen;
> +    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
> +    if (ilen != ILEN_UNWIND) {
> +        env->int_pgm_ilen = ilen;
> +    }
>  }
>  
>  void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index d22d0f7643..6f9cd19126 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -57,6 +57,7 @@ struct DisasContext {
>      DisasContextBase base;
>      const DisasInsn *insn;
>      DisasFields *fields;
> +    TCGOp *insn_start;
>      uint64_t ex_value;
>      /*
>       * During translate_one(), pc_tmp is used to determine the instruction
> @@ -6220,6 +6221,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
>      }
>      s->pc_tmp = s->base.pc_next + ilen;
>      s->ilen = ilen;
> +    tcg_set_insn_param(s->insn_start, 2, ilen);
>  
>      /* We can't actually determine the insn format until we've looked up
>         the full insn opcode.  Which we can't do without locating the
> @@ -6455,7 +6457,12 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *dc = container_of(dcbase, DisasContext, base);
>  
> -    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
> +    /*
> +     * ??? Alternately, delay emitting insn_start until after we
> +     * have computed the insn length in extract_insn.
> +     */

Or maybe change that comment to indicate where the actual ilen will be
set (extract_insn) and that this is just a dummy value.

> +    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
> +    dc->insn_start = tcg_last_op();
>  }
>  
>  static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
> @@ -6561,4 +6568,5 @@ void restore_state_to_opc(CPUS390XState *env, TranslationBlock *tb,
>      if ((cc_op != CC_OP_DYNAMIC) && (cc_op != CC_OP_STATIC)) {
>          env->cc_op = cc_op;
>      }
> +    env->int_pgm_ilen = data[2];
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
