Received: from eggs.gnu.org ([209.51.188.92]:33063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqd1N-0005nj-6a
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqd1G-00047n-FZ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:06:38 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqd1A-00040r-FQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:06:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id l9so14040101wrt.13
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 04:06:25 -0800 (PST)
References: <20190128223118.5255-1-richard.henderson@linaro.org>
	<20190128223118.5255-12-richard.henderson@linaro.org>
	<CAFEAcA_isfxbkFcjdx8bcDs4_D66Vpi3czJq-TXRoesy8LVXGg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <84bf3e00-2294-99ed-4cae-9e117a38bdf9@linaro.org>
Date: Mon, 4 Feb 2019 12:06:21 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_isfxbkFcjdx8bcDs4_D66Vpi3czJq-TXRoesy8LVXGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/12] linux-user/aarch64: Reset btype
 for syscalls and signals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2/4/19 12:02 PM, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 22:31, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The value of btype for syscalls is CONSTRAINED UNPREDICTABLE,
>> so we need to make sure that the value is 0 before clone,
>> fork, or syscall return.
>>
>> The value of btype for signals is defined, but it does not make
>> sense for a SIGILL handler to enter with the btype set as for
>> the indirect branch that caused the SIGILL.
>>
>> Clearing the value early means that btype is zero within the pstate
>> saved into the signal frame, and so is also zero on (normal) signal
>> return, but also allows the signal handler to adjust the value as
>> seen after the sigcontext restore.
>>
>> This last is a guess at a future kernel's user-space ABI.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/aarch64/cpu_loop.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
>> index 65d815f030..51ea9961ba 100644
>> --- a/linux-user/aarch64/cpu_loop.c
>> +++ b/linux-user/aarch64/cpu_loop.c
>> @@ -83,8 +83,19 @@ void cpu_loop(CPUARMState *env)
>>          cpu_exec_end(cs);
>>          process_queued_cpu_work(cs);
>>
>> +        /*
>> +         * The state of BTYPE on syscall and interrupt entry is CONSTRAINED
>> +         * UNPREDICTABLE.  The real kernel will need to tidy this up as well.
>> +         * Do this before syscalls and signals, so that the value is correct
>> +         * both within signal handlers, and on return from syscall (especially
>> +         * clone & fork) and from signal handlers.
>> +         *
>> +         * The SIGILL signal handler, for BTITrap, can see the failing BTYPE
>> +         * within the ESR value in the signal frame.
>> +         */
>>          switch (trapnr) {
>>          case EXCP_SWI:
>> +            env->btype = 0;
>>              ret = do_syscall(env,
>>                               env->xregs[8],
>>                               env->xregs[0],
> 
> If the idea is to give a particular value on return from
> the syscall and on entry to a signal handler, shouldn't we be
> setting it after the do_syscall() call returns, and in the
> signal handler entry path ?
> 
>> @@ -104,6 +115,7 @@ void cpu_loop(CPUARMState *env)
>>              /* just indicate that signals should be handled asap */
>>              break;
>>          case EXCP_UDEF:
>> +            env->btype = 0;
>>              info.si_signo = TARGET_SIGILL;
>>              info.si_errno = 0;
>>              info.si_code = TARGET_ILL_ILLOPN;
>> @@ -112,6 +124,7 @@ void cpu_loop(CPUARMState *env)
>>              break;
>>          case EXCP_PREFETCH_ABORT:
>>          case EXCP_DATA_ABORT:
>> +            env->btype = 0;
>>              info.si_signo = TARGET_SIGSEGV;
>>              info.si_errno = 0;
>>              /* XXX: check env->error_code */
> 
>> @@ -121,12 +134,14 @@ void cpu_loop(CPUARMState *env)
>>              break;
>>          case EXCP_DEBUG:
>>          case EXCP_BKPT:
>> +            env->btype = 0;
>>              info.si_signo = TARGET_SIGTRAP;
>>              info.si_errno = 0;
>>              info.si_code = TARGET_TRAP_BRKPT;
>>              queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>>              break;
>>          case EXCP_SEMIHOST:
>> +            env->btype = 0;
> 
> Leaving btype alone rather than clearing it here would be
> consistent with how we handle semihosting in system emulation,
> right ?

Er.. yes.  I sort of forgot we had semi-hosting for aa64.


r~
