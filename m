Received: from eggs.gnu.org ([2001:4830:134:3::10]:40978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVQif-00054C-LZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 19:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVQib-0007v7-Lr
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 19:06:57 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVQib-0007gp-Gz
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 19:06:53 -0400
Received: by mail-qk0-x244.google.com with SMTP id q66so6044103qki.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 16:06:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-10-git-send-email-cota@braap.org>
	<cb152594-248b-85fb-180a-fb83eecf4998@twiddle.net>
	<20170710235751.GA16131@flamenco>
	<57e5db60-7008-7c60-7139-7eb426078c0d@twiddle.net>
	<20170712204804.GA25618@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f7b8057b-a52a-788e-cddb-0b4ecf761fbd@twiddle.net>
Date: Wed, 12 Jul 2017 13:06:23 -1000
MIME-Version: 1.0
In-Reply-To: <20170712204804.GA25618@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/22] exec-all: shrink tb->invalid to
 uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/12/2017 10:48 AM, Emilio G. Cota wrote:
> Would it be OK for this series to just start with CF_PARALLEL? I'm not
> too familiar with how icount mode recompiles code, and I'm now on
> patch 27 of v2 and still have quite a few patches to go through.

Certainly.

> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 49c1ecf..2531b73 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -224,31 +224,27 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
>   static void cpu_exec_step(CPUState *cpu)
>   {
>       CPUClass *cc = CPU_GET_CLASS(cpu);
> -    CPUArchState *env = (CPUArchState *)cpu->env_ptr;
>       TranslationBlock *tb;
>       target_ulong cs_base, pc;
>       uint32_t flags;
>   
> -    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>       if (sigsetjmp(cpu->jmp_env, 0) == 0) {
> -        mmap_lock();
> -        tb_lock();
> -        tb = tb_gen_code(cpu, pc, cs_base, flags,
> -                         1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
> -        tb->orig_tb = NULL;
> -        tb_unlock();
> -        mmap_unlock();
> +        tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags);
> +        if (tb == NULL) {
> +            mmap_lock();
> +            tb_lock();
> +            tb = tb_gen_code(cpu, pc, cs_base, flags,
> +                             1 | CF_IGNORE_ICOUNT);

You've got a problem here in that you're not including CF_COUNT_MASK in the 
hash and you dropped the flush when changing to parallel_cpus = true.  That 
means you could find an old TB with CF_COUNT > 1.

Not required for this patch set, but what I'd like to see eventually is

   (1) cpu_exec_step merged into cpu_exec_step_atomic for clarity.
   (2) callers of tb_gen_code add in CF_PARALLEL as needed; do not
       pick it up from parallel_cpus within tb_gen_code.
   (3) target/*/translate.c uses CF_PARALLEL instead of parallel_cpus.
   (4) cpu_exec_step_atomic does the tb lookup and code gen outside
       of the start_exclusive/end_exclusive lock.

And to that end I think there are some slightly different choices you can make 
now in order to reduce churn for that later.

> @@ -320,11 +318,12 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
>       desc.env = (CPUArchState *)cpu->env_ptr;
>       desc.cs_base = cs_base;
>       desc.flags = flags;
> +    desc.cf_mask = curr_cf_mask();
>       desc.trace_vcpu_dstate = *cpu->trace_dstate;
>       desc.pc = pc;
>       phys_pc = get_page_addr_code(desc.env, pc);
>       desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
> -    h = tb_hash_func(phys_pc, pc, flags, *cpu->trace_dstate);
> +    h = tb_hash_func(phys_pc, pc, flags, curr_cf_mask(), *cpu->trace_dstate);
>       return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
>   }

E.g. this fundamental lookup function should have cf_mask passed in.

> @@ -1254,6 +1256,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       if (use_icount && !(cflags & CF_IGNORE_ICOUNT)) {
>           cflags |= CF_USE_ICOUNT;
>       }
> +    if (parallel_cpus) {
> +        cflags |= CF_PARALLEL;
> +    }

E.g. pass this in.  Callers using curr_cf_mask() should suffice where it's not 
obvious.

> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 925ae11..fa40f6c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6312,11 +6312,10 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>           sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
>   
>           /* If this is our first additional thread, we need to ensure we
> -         * generate code for parallel execution and flush old translations.
> +         * generate code for parallel execution.
>            */
>           if (!parallel_cpus) {
>               parallel_cpus = true;
> -            tb_flush(cpu);

As per above, I think you must retain this for now.

I strongly suspect that it will be worthwhile forever, since we're pretty much 
guaranteed that none of the existing TBs will ever be used again.



r~
