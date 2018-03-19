Received: from eggs.gnu.org ([2001:4830:134:3::10]:53263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1exoJw-0001Az-G3
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 02:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1exoJt-0001k8-82
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 02:31:00 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34570)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1exoJs-0001gd-Qi
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 02:30:57 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180319031545.29359-1-richard.henderson@linaro.org>
In-Reply-To: <20180319031545.29359-1-richard.henderson@linaro.org>
Date: Mon, 19 Mar 2018 09:30:53 +0300
Message-ID: <001e01d3bf4b$d4f4ecf0$7edec6d0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v2] tcg: Really fix cpu_io_recompile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Richard Henderson' <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, peter.maydell@linaro.org, pbonzini@redhat.com

> From: Richard Henderson [mailto:richard.henderson@linaro.org]
> We have confused the number of instructions that have been
> executed in the TB with the number of instructions needed
> to repeat the I/O instruction.
> 
> We have used cpu_restore_state_from_tb, which means that
> the guest pc is pointing to the I/O instruction.  The only
> time the answer to the later question is not 1 is when
> MIPS or SH4 need to re-execute the branch for the delay
> slot as well.
> 
> We must rely on cpu->cflags_next_tb to generate the next TB,
> as otherwise we have a race condition with other guest cpus
> within the TB cache.
> 
> Fixes: 0790f86861079b1932679d0f011e431aaf4ee9e2
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> My v1 raced with Paolo's pull request, so v2 now fixes Pavel's fix.
> 

Works for Ciro's ARM sample and doesn't break icount and replay for i386.
Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>


Pavel Dovgalyuk
> r~
> 
> ---
>  accel/tcg/translate-all.c | 37 ++++++++++---------------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5ad1b919bc..d4190602d1 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1728,8 +1728,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>      CPUArchState *env = cpu->env_ptr;
>  #endif
>      TranslationBlock *tb;
> -    uint32_t n, flags;
> -    target_ulong pc, cs_base;
> +    uint32_t n;
> 
>      tb_lock();
>      tb = tb_find_pc(retaddr);
> @@ -1737,44 +1736,33 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>          cpu_abort(cpu, "cpu_io_recompile: could not find TB for pc=%p",
>                    (void *)retaddr);
>      }
> -    n = cpu->icount_decr.u16.low + tb->icount;
>      cpu_restore_state_from_tb(cpu, tb, retaddr);
> -    /* Calculate how many instructions had been executed before the fault
> -       occurred.  */
> -    n = n - cpu->icount_decr.u16.low;
> -    /* Generate a new TB ending on the I/O insn.  */
> -    n++;
> +
>      /* On MIPS and SH, delay slot instructions can only be restarted if
>         they were already the first instruction in the TB.  If this is not
>         the first instruction in a TB then re-execute the preceding
>         branch.  */
> +    n = 1;
>  #if defined(TARGET_MIPS)
> -    if ((env->hflags & MIPS_HFLAG_BMASK) != 0 && n > 1) {
> +    if ((env->hflags & MIPS_HFLAG_BMASK) != 0
> +        && env->active_tc.PC != tb->pc) {
>          env->active_tc.PC -= (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
>          cpu->icount_decr.u16.low++;
>          env->hflags &= ~MIPS_HFLAG_BMASK;
> +        n = 2;
>      }
>  #elif defined(TARGET_SH4)
>      if ((env->flags & ((DELAY_SLOT | DELAY_SLOT_CONDITIONAL))) != 0
> -            && n > 1) {
> +        && env->pc != tb->pc) {
>          env->pc -= 2;
>          cpu->icount_decr.u16.low++;
>          env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
> +        n = 2;
>      }
>  #endif
> -    /* This should never happen.  */
> -    if (n > CF_COUNT_MASK) {
> -        cpu_abort(cpu, "TB too big during recompile");
> -    }
> 
> -    pc = tb->pc;
> -    cs_base = tb->cs_base;
> -    flags = tb->flags;
> -    tb_phys_invalidate(tb, -1);
> -
> -    /* Execute one IO instruction without caching
> -       instead of creating large TB. */
> -    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | CF_NOCACHE | 1;
> +    /* Generate a new TB executing the I/O insn.  */
> +    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | n;
> 
>      if (tb->cflags & CF_NOCACHE) {
>          if (tb->orig_tb) {
> @@ -1785,11 +1773,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>          tb_remove(tb);
>      }
> 
> -    /* Generate new TB instead of the current one. */
> -    /* FIXME: In theory this could raise an exception.  In practice
> -       we have already translated the block once so it's probably ok.  */
> -    tb_gen_code(cpu, pc, cs_base, flags, curr_cflags() | CF_LAST_IO | n);
> -
>      /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
>       * the first in the TB) then we end up generating a whole new TB and
>       *  repeating the fault, which is horribly inefficient.
> --
> 2.14.3
