Received: from eggs.gnu.org ([2001:4830:134:3::10]:48141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSs8P-0004cT-Ry
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSs8N-000275-8p
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:46:57 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSs8M-00026v-V4
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:46:55 -0400
Received: by mail-wr0-x236.google.com with SMTP id 77so2713799wrb.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 14:46:54 -0700 (PDT)
References: <8737aaeuu5.fsf@linaro.org>
	<CAFEAcA8ZHz4vyBrHV6Vi7227h+_NafgV1oBY0g9sV7zU_8my0w@mail.gmail.com>
	<87van6adhi.fsf@linaro.org>
	<CAFEAcA_DcOMzo=X1Y9O+5VrfeA32i012vpQmqB++aEXH6J1qeg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_DcOMzo=X1Y9O+5VrfeA32i012vpQmqB++aEXH6J1qeg@mail.gmail.com>
Date: Wed, 05 Jul 2017 22:46:52 +0100
Message-ID: <87r2xua75f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qemu_system_reset_request() broken w.r.t BQL
 locking regime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>, maciej.borzecki@rndity.com


Peter Maydell <peter.maydell@linaro.org> writes:

> On 5 July 2017 at 20:30, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 5 July 2017 at 17:01, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>> An interesting bug was reported on #qemu today. It was bisected to
>>>> 8d04fb55 (drop global lock for TCG) and only occurred when QEMU was run
>>>> with taskset -c 0. Originally the fingers where pointed at mttcg but it
>>>> occurs in both single and multi-threaded modes.
>>>>
>>>> I think the problem is qemu_system_reset_request() is certainly racy
>>>> when resetting a running CPU. AFAICT:
>>>>
>>>>   - Guest resets board, writing to some hw address (e.g.
>>>>     arm_sysctl_write)
>>>>   - This triggers qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET)
>>>>   - We exit iowrite and drop the BQL
>>>>   - vl.c schedules qemu_system_reset->qemu_devices_reset...arm_cpu_reset
>>>>   - we start writing new values to CPU env while still in TCG code
>>>>   - CHAOS!
>>>>
>>>> The general solution for this is to ensure these sort of tasks are done
>>>> with safe work in the CPUs context when we know nothing else is running.
>>>> It seems this is probably best done by modifying
>>>> qemu_system_reset_request to queue work up on current_cpu and execute it
>>>> as safe work - I don't think the vl.c thread should ever be messing
>>>> about with calling cpu_reset directly.
>>>
>>> My first thought is that qemu_system_reset() should absolutely
>>> stop every CPU (or other runnable thing like a DMA agent) in the
>>> system.
>>
>> Are all these reset calls system wide though?
>
> It's called 'system_reset' because it resets the entire system...
>
>> After all with PCSI you
>> can bring individual cores up and down. I appreciate the vexpress stuff
>> pre-dates those well defined semantics though.
>
> It's individual core reset that's a more ad-hoc afterthought,
> really.
>
>> vm_stop certainly tries to deal with things gracefully as well as send
>> qapi events, drain IO queues and the rest of it. My only concern is it
>> handles two cases - external vm_stops and those from the current CPU.
>>
>> I think it may be cleaner for CPU originated halts to use the
>> async_safe_run_on_cpu() mechanism.
>
> System reset already has an async component to it -- you call
> qemu_system_reset_request(), which just says "schedule a system
> reset as soon as convenient". qemu_system_reset() is the thing
> that runs later and actually does the job (from the io thread,
> not the CPU thread).
>
> Looking more closely at the vl.c code, it looks like it
> calls pause_all_vcpus() before calling qemu_system_reset():
> shouldn't that be pausing all the TCG CPUs?

Looking deeper it seems cpu_stop_current() is doing the wrong thing.
Because it sets cpu->stopped the pause_all_vcpus() in the vl.c thread
doesn't wait.

I suspect it should really be doing a cpu_loop_exit. I'll see if I can
work up a patch.

>
> thanks
> -- PMM


--
Alex Bennée
