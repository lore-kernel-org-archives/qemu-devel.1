Received: from eggs.gnu.org ([2001:4830:134:3::10]:45165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgBz6-00051C-Tk
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgBz2-0001VY-WE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:04:08 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgBz2-0001V8-Ps
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:04:04 -0500
Received: by mail-wm0-x234.google.com with SMTP id c85so113452631wmi.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:04:03 -0800 (PST)
References: <20170220145335.591-1-bobby.prani@gmail.com>
	<87fuj8x2gi.fsf@linaro.org> <87k28ko1qw.fsf@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87k28ko1qw.fsf@gmail.com>
Date: Tue, 21 Feb 2017 15:04:06 +0000
Message-ID: <878tozwpp5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mttcg: Set jmp_env to handle exit from
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net


Pranith Kumar <bobby.prani@gmail.com> writes:

> Alex Bennée writes:
>
>> Pranith Kumar <bobby.prani@gmail.com> writes:
>>
>>> tb_gen_code() can exit execution using cpu_exit_loop() when it cannot
>>> allocate new tb's. To handle this, we need to properly set the jmp_env
>>> pointer ahead of calling tb_gen_code().
>>>
>>> CC:Alex Bennée <alex.bennee@linaro.org>
>>> CC: Richard Henderson <rth@twiddle.net>
>>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>>> ---
>>>  cpu-exec.c | 23 +++++++++++------------
>>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/cpu-exec.c b/cpu-exec.c
>>> index 97d79612d9..4b70988b24 100644
>>> --- a/cpu-exec.c
>>> +++ b/cpu-exec.c
>>> @@ -236,23 +236,22 @@ static void cpu_exec_step(CPUState *cpu)
>>>
>>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>>      tb_lock();
>>> -    tb = tb_gen_code(cpu, pc, cs_base, flags,
>>> -                     1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
>>> -    tb->orig_tb = NULL;
>>> -    tb_unlock();
>>> -
>>> -    cc->cpu_exec_enter(cpu);
>>> -
>>
>> It occurs to me we are also diverging in our locking pattern from
>> tb_find which takes mmap_lock first. This is a NOP for system emulation
>> but needed for user-emulation (for which we can do cpu_exec_step but not
>> cpu_exec_nocache).
>
> Right. So we have to take the mmap_lock() before calling
> tb_gen_code(). However, this lock is released in the error path before calling
> cpu_loop_exit() if allocation of a new tb fails. The following is what I have
> after merging with the previous EXCP_ATOMIC handling patch.
>
> diff --git a/cpu-exec.c b/cpu-exec.c
> index a8e04bffbf..2bb3ba3672 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -228,6 +228,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
>
>  static void cpu_exec_step(CPUState *cpu)
>  {
> +    CPUClass *cc = CPU_GET_CLASS(cpu);
>      CPUArchState *env = (CPUArchState *)cpu->env_ptr;
>      TranslationBlock *tb;
>      target_ulong cs_base, pc;
> @@ -235,16 +236,24 @@ static void cpu_exec_step(CPUState *cpu)
>
>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>      tb_lock();
> -    tb = tb_gen_code(cpu, pc, cs_base, flags,
> -                     1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
> -    tb->orig_tb = NULL;
> -    tb_unlock();
> -    /* execute the generated code */
> -    trace_exec_tb_nocache(tb, pc);
> -    cpu_tb_exec(cpu, tb);
> -    tb_lock();
> -    tb_phys_invalidate(tb, -1);
> -    tb_free(tb);
> +    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
> +        mmap_lock();

That gets the locking order the wrong way around - I'm wary of that.

> +        tb = tb_gen_code(cpu, pc, cs_base, flags,
> +                         1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
> +        tb->orig_tb = NULL;
> +        mmap_unlock();
> +        tb_unlock();
> +
> +        cc->cpu_exec_enter(cpu);
> +        /* execute the generated code */
> +        trace_exec_tb_nocache(tb, pc);
> +        cpu_tb_exec(cpu, tb);
> +        cc->cpu_exec_exit(cpu);
> +
> +        tb_lock();
> +        tb_phys_invalidate(tb, -1);
> +        tb_free(tb);
> +    }
>      tb_unlock();
>  }
>
> diff --git a/cpus.c b/cpus.c
> index 77bba08f9a..b39408b4b1 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1347,6 +1347,11 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>                  if (r == EXCP_DEBUG) {
>                      cpu_handle_guest_debug(cpu);
>                      break;
> +                } else if (r == EXCP_ATOMIC) {
> +                    qemu_mutex_unlock_iothread();
> +                    cpu_exec_step_atomic(cpu);
> +                    qemu_mutex_lock_iothread();
> +                    break;
>                  }
>              } else if (cpu->stop) {
>                  if (cpu->unplug) {
> @@ -1457,6 +1462,10 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>                   */
>                  g_assert(cpu->halted);
>                  break;
> +            case EXCP_ATOMIC:
> +                qemu_mutex_unlock_iothread();
> +                cpu_exec_step_atomic(cpu);
> +                qemu_mutex_lock_iothread();
>              default:
>                  /* Ignore everything else? */
>                  break;


--
Alex Bennée
