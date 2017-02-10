Received: from eggs.gnu.org ([2001:4830:134:3::10]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccA9U-0007iY-Vs
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccA9R-0006FX-Qt
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:18:12 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ccA9R-0006EZ-IK
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:18:09 -0500
Received: by mail-wm0-x233.google.com with SMTP id v186so108499863wmd.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 04:18:09 -0800 (PST)
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<52c93dcc-2577-e81f-867c-6159c1f61e91@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <52c93dcc-2577-e81f-867c-6159c1f61e91@redhat.com>
Date: Fri, 10 Feb 2017 12:18:21 +0000
Message-ID: <87zihuw86q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/02/2017 02:45, Pranith Kumar wrote:
>> The current method of executing atomic code in a guest uses
>> cpu_exec_step_atomic() from the outermost loop. This causes an abort()
>> when single stepping over atomic code since debug exception longjmp
>> will point to the the setlongjmp in cpu_exec(). Another issue with
>> this mechanism is that the flags which were set in atomic execution
>> will be lost since we do not call cpu_exec_enter().
>>
>> The following patch moves atomic exception handling to the exception
>> handler where all these issues are taken care of. The change in
>> start_exclusive() is necessary since now the cpu in atomic execution
>> will have its running flag set, but we do not want to count it as
>> pending.
>>
>> Thanks to Alex for helping me debug the issue.
>>
>> CC: Alex Bennée <alex.bennee@linaro.org>
>> CC: Richard Henderson <rth@twiddle.net>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> ---
>>  cpu-exec.c    | 2 ++
>>  cpus-common.c | 2 +-
>>  cpus.c        | 4 ----
>>  3 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/cpu-exec.c b/cpu-exec.c
>> index b0ddada8c1..dceacfc5dd 100644
>> --- a/cpu-exec.c
>> +++ b/cpu-exec.c
>> @@ -427,6 +427,8 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>>              *ret = cpu->exception_index;
>>              if (*ret == EXCP_DEBUG) {
>>                  cpu_handle_debug_exception(cpu);
>> +            } else if (*ret == EXCP_ATOMIC) {
>> +                cpu_exec_step_atomic(cpu);
>
> I think you can unlock/lock the iothread here, and also call

The iothread is already unlocked by this point (see tcg_cpu_exec).

> cpu_exec_end/start to work around the limitation in start_exclusive.

While that seems right it also seems very messy as it inverts the calls
so far. I fear we may end up very confused in special casing. Is there a
cleaner way we can unwind this?

>
> Paolo
>
>>              }
>>              cpu->exception_index = -1;
>>              return true;
>> diff --git a/cpus-common.c b/cpus-common.c
>> index 59f751ecf9..7b859752ea 100644
>> --- a/cpus-common.c
>> +++ b/cpus-common.c
>> @@ -192,7 +192,7 @@ void start_exclusive(void)
>>      smp_mb();
>>      running_cpus = 0;
>>      CPU_FOREACH(other_cpu) {
>> -        if (atomic_read(&other_cpu->running)) {
>> +        if (atomic_read(&other_cpu->running) && !qemu_cpu_is_self(other_cpu)) {
>>              other_cpu->has_waiter = true;
>>              running_cpus++;
>>              qemu_cpu_kick(other_cpu);
>> diff --git a/cpus.c b/cpus.c
>> index e1b82bcd49..981f23d52b 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1461,10 +1461,6 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>>                   */
>>                  g_assert(cpu->halted);
>>                  break;
>> -            case EXCP_ATOMIC:
>> -                qemu_mutex_unlock_iothread();
>> -                cpu_exec_step_atomic(cpu);
>> -                qemu_mutex_lock_iothread();
>>              default:
>>                  /* Ignore everything else? */
>>                  break;
>>


--
Alex Bennée
