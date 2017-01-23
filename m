Received: from eggs.gnu.org ([2001:4830:134:3::10]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cVb5H-0002xh-VJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cVb5E-0001bE-SV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:38:43 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cVb5E-0001aI-LB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:38:40 -0500
Received: by mail-wm0-x233.google.com with SMTP id r144so144680183wme.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 01:38:38 -0800 (PST)
References: <000301d259dc$f9d097c0$ed71c740$@ru>
	<000601d25a95$12b1b9f0$38152dd0$@ru>
	<20161220102126.GE5602@stefanha-x1.localdomain>
	<002501d25ab1$af024b00$0d06e100$@ru>
	<CAJSP0QXm9ssLC5C+gV_agkEW_fdUY=NWBMvHqMh55UhYTR276g@mail.gmail.com>
	<000301d25b4f$20018440$60048cc0$@ru>
	<CAJSP0QW1pOcthcEt16Pp5xQu3miUh2Leq3kn3yvQqWqhi1P=QQ@mail.gmail.com>
	<000801d26bd9$dca56db0$95f04910$@ru> <87o9zd3jta.fsf@linaro.org>
	<000e01d26caa$dfdb3150$9f9193f0$@ru> <87mveleiw8.fsf@linaro.org>
	<000c01d2754d$59a4cd70$0cee6850$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000c01d2754d$59a4cd70$0cee6850$@ru>
Date: Mon, 23 Jan 2017 09:38:35 +0000
Message-ID: <874m0qazfo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Stefan Hajnoczi' <stefanha@gmail.com>, 'qemu-devel' <qemu-devel@nongnu.org>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, 'Peter Maydell' <peter.maydell@linaro.org>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>
>> >> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> >
>> > Sorry, this is another problem which occurs only in icount replay mode:
>> > 1. cpu_handle_exception tries to force exception when is cannot occur due to
>> >    running out all the planned instructions:
>> >     } else if (replay_has_exception()
>> >                && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
>> >         /* try to cause an exception pending in the log */
>> >         cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
>> >         *ret = -1;
>> >         return true;
>> >
>> > 2. tb_find calls tb_gen_code, which cannot allocate new translation block
>> >    and calls tb_flush (which only queues the flushing) and cpu_loop_exit
>> > 3. cpu_loop_exit returns to infinite loop of cpu_exec and the condition
>> >             if (cpu_handle_exception(cpu, &ret)) {
>> >                 break;
>> >             }
>> >    is checked again causing an infinite loop.
>> >
>> > TB cache is not flushed because we never execute that break and real work of tb_flush
>> > is made outside this loop.
>>
>> I think what we need is a:
>>
>>
>>   if (cpu->exit_request)
>>     break;
>
> Where this exit_request is supposed to be set?

Ahh my mistake. Currently it is a global exit_request (becoming a
per-cpu exit_request when MTTCG is merged). It's set by qemu_cpu_kick()
when work is queued up, in this case the tb_flush async work.


>> before the cpu_handle_exception() call to ensure any queued work gets
>> processed first. Can you give me you current command line so I can
>> reproduce this and check the fix works?
>
> I solved the problem using following patch:
>
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -451,6 +451,10 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>  #ifndef CONFIG_USER_ONLY
>      } else if (replay_has_exception()
>                 && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
> +        /* Break the execution loop in case of running out of TB cache.
> +           This is needed to make flushing of the TB cache, because
> +           real flush is queued to be executed outside the cpu loop. */
> +        cpu->exception_index = EXCP_INTERRUPT;
>          /* try to cause an exception pending in the log */
>          cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
>          *ret = -1;

I wonder if it worth renaming EXCP_INTERRUPT? I always get it confused
with a guest interrupt. But the effect is the same as we set it on an
exit_request.

--
Alex Bennée
