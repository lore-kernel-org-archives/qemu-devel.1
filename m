Received: from eggs.gnu.org ([2001:4830:134:3::10]:38299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZ1vD-0000KO-2S
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZ1v9-000795-Qn
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:54:31 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cZ1v8-00077u-3l
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:54:27 -0500
Received: by mail-pg0-x244.google.com with SMTP id 75so35184021pgf.3
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 12:54:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170129210910.6333-1-pbonzini@redhat.com>
	<000601d27ba1$1f009a50$5d01cef0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf88e926-78b5-7d74-a1eb-4f13b3955496@redhat.com>
Date: Wed, 1 Feb 2017 12:54:20 -0800
MIME-Version: 1.0
In-Reply-To: <000601d27ba1$1f009a50$5d01cef0$@ru>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 0/7] cpu-exec: simplify cpu_exec
 and remove some icount special cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: serge.fdrv@gmail.com, pavel.dovgaluk@ispras.ru, peter.maydell@linaro.org



On 31/01/2017 01:05, Pavel Dovgalyuk wrote:
> Hi, Paolo!
> 
> Thanks for refactoring.
> I tested these patches with icount record/replay on i386 machine.
> It works, but the following changes should be applied.
> I also removed call to replay_has_interrupt, because now it is not needed here.
> It seems, that this call is an artifact of an older record/replay revision.
> 
> diff --git a/cpu-exec.c b/cpu-exec.c
> index 3838eb8..5cef8bc 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -519,7 +519,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      }
> 
>      /* Finally, check if we need to exit to the main loop.  */
> -    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
> +    if (unlikely(atomic_read(&cpu->exit_request)
> +        || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
>          atomic_set(&cpu->exit_request, 0);
>          cpu->exception_index = EXCP_INTERRUPT;
>          return true;

So is this needed to avoid exceptions in tb_find?  Please add a comment
about this and check if you can also replace:

	atomic_set(&cpu->exit_request, 1);

in cpu_loop_exec_tb with

	cpu->icount_decr.u16.low = 0;


?

Thanks,

Paolo

> Pavel Dovgalyuk
> 
>> -----Original Message-----
>> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
>> Sent: Monday, January 30, 2017 12:09 AM
>> To: qemu-devel@nongnu.org
>> Cc: serge.fdrv@gmail.com; peter.maydell@linaro.org; pavel.dovgaluk@ispras.ru
>> Subject: [RFC/RFT PATCH 0/7] cpu-exec: simplify cpu_exec and remove some icount special cases
>>
>> The series includes three parts:
>>
>> 1-2: fix two bugs, the first one pretty bad, the second seems
>> to be theoretical only.
>>
>> 3-5: simplify cpu_exec.  This builds on Sergey's conversion
>> of cpu_exec to a simple top-down logic, making the phases
>> clearer and saving on the cost of siglongjmp in the meanwhile.
>>
>> 6-7: these are intended to be a base for Pavel's record/replay
>> fixes.  The main thing I noticed while reviewing is that icount
>> is redoing (with u16.high) a lot of things that tcg_exit_req is
>> doing too.  This is because, at the time icount was introduced,
>> tcg_exit_req didn't exist and QEMU instead unwound chained TBs
>> through POSIX signals.  But now we have essentially two ways to
>> do the same thing with subtly different invariants or downright
>> bugs (such as the one fixed by patch 1).  Patch 6 therefore
>> unifies tcg_exit_req and the icount interrupt flag.  It saves a
>> handful of instructions per TB in icount mode and generally
>> makes icount mode "less special", which is a good thing since
>> no one seems to understand it well.  Patch 7 then removes another
>> EXCP_INTERRUPT/cpu_loop_exit pair; by exiting to main loop simply
>> through cpu->exit_request, hopefully it fixes one of the issues that
>> Pavel was seeing.
>>
>> For now I've tested this only on an aarch64 Linux image (with
>> and without -icount).  Thanks,
>>
>> Paolo
>>
>> Paolo Bonzini (7):
>>   cpu-exec: fix jmp_first out-of-bounds access with icount
>>   cpu-exec: tighten barrier on TCG_EXIT_REQUESTED
>>   cpu-exec: avoid cpu_loop_exit in cpu_handle_interrupt
>>   cpu-exec: avoid repeated sigsetjmp on interrupts
>>   cpu-exec: remove outermost infinite loop
>>   cpu-exec: unify icount_decr and tcg_exit_req
>>   cpu-exec: centralize exiting to the main loop
>>
>>  cpu-exec.c                | 153 +++++++++++++++++++++-------------------------
>>  include/exec/exec-all.h   |   1 +
>>  include/exec/gen-icount.h |  53 ++++++++--------
>>  include/qom/cpu.h         |  15 +++--
>>  qom/cpu.c                 |   2 +-
>>  tcg/tcg.h                 |   1 -
>>  translate-all.c           |   2 +-
>>  translate-common.c        |  13 ++--
>>  8 files changed, 109 insertions(+), 131 deletions(-)
>>
>> --
>> 2.9.3
> 
> 
> 
> 
