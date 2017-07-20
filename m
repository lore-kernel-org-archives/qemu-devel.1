Received: from eggs.gnu.org ([2001:4830:134:3::10]:40014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY762-0007rX-Kj
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY75x-0005Wr-Pu
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:46:10 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:38611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY75x-0005W0-KB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:46:05 -0400
Received: by mail-qk0-x234.google.com with SMTP id g6so11072285qkf.5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 01:46:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-12-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f2f06875-057e-9c57-718f-134246177b6b@twiddle.net>
Date: Wed, 19 Jul 2017 22:45:57 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-12-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/43] tcg: define CF_PARALLEL and use
 it for TB hashing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:08 PM, Emilio G. Cota wrote:
> @@ -225,31 +226,27 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
>   static void cpu_exec_step(CPUState *cpu)
>   {
>       CPUClass *cc = CPU_GET_CLASS(cpu);
> -    CPUArchState *env = (CPUArchState *)cpu->env_ptr;
>       TranslationBlock *tb;
>       target_ulong cs_base, pc;
>       uint32_t flags;
> +    uint32_t cflags = 1 | CF_IGNORE_ICOUNT;
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
> +        tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags,
> +                                  cflags & CF_HASH_MASK);
> +        if (tb == NULL) {
> +            mmap_lock();
> +            tb_lock();
> +            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
> +            tb_unlock();
> +            mmap_unlock();
> +        }
>   

The only thing I'm worried about here is that the correctness of this *relies* 
on the tb_flush that happens when enabling parallel_cpus.  Consider:

Prior to multiple threads, we create a TB with pc=X, cflags=0, which happens to 
begin with an atomic operation.  Later, after cloning the first thread, we 
raise EXCP_ATOMIC at pc=X.  We'll ask for an existing tb with 
cflags=1|CF_IGNORE_ICOUNT, but since we don't compare any of those bits, we 
return the original TB.

Worse, that original TB may have populated links to other TBs and control may 
"escape" from the one TB, vastly extending the amount of code we execute under 
the exclusive lock.

The only reason this escape does not happen now is that (1) we generate new TBs 
and (2) cpu_exec_step does not fill in links, so that (3) any goto_tb 
degenerate to jump-to-next-host-insn, and (4) front-ends are unlikely to 
generate goto_ptr when ending a TB containing a single instruction.

Some of the above seems extremely fragile.

This suggests to me the usefulness of a CF_NOCHAIN flag, which would cause 
tcg-op.c to suppress emitting any code that chains between blocks.  No need for 
you to add that in this patch set, however, your tcg_ctx.cf_parallel should 
simply be tcg_ctx.tb_cflags, and s/cf_parallel/tb_cflags & CF_PARALLEL/.  Then 
it is trivial for me to come along and test tb_cflags & CF_NOCHAIN.

Anyway, back to the current patch.  Leaving CF_IGNORE_ICOUNT alone for the 
moment, that implies adding CF_COUNT_MASK to CF_HASH_MASK.

If we were to clean up CF_IGNORE_ICOUNT, then I think we could compare all bits 
of cflags.  You need not do that in this patch set.



r~
