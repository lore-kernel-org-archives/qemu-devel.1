Received: from eggs.gnu.org ([2001:4830:134:3::10]:37265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dT2Hj-0007T0-MQ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dT2He-0007mV-PV
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:37:15 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dT2He-0007mH-Fe
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:37:10 -0400
Received: by mail-wr0-x231.google.com with SMTP id 77so18840219wrb.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 01:37:10 -0700 (PDT)
References: <8737aaeuu5.fsf@linaro.org>
	<CAFEAcA8ZHz4vyBrHV6Vi7227h+_NafgV1oBY0g9sV7zU_8my0w@mail.gmail.com>
	<672d2102-5a27-47b3-ef5b-f49d1e21d9f2@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <672d2102-5a27-47b3-ef5b-f49d1e21d9f2@redhat.com>
Date: Thu, 06 Jul 2017 09:37:07 +0100
Message-ID: <87pode9d1o.fsf@linaro.org>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>, maciej.borzecki@rndity.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/07/2017 18:14, Peter Maydell wrote:
>>>   - Guest resets board, writing to some hw address (e.g.
>>>     arm_sysctl_write)
>>>   - This triggers qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET)
>>>   - We exit iowrite and drop the BQL
>>>   - vl.c schedules qemu_system_reset->qemu_devices_reset...arm_cpu_reset
>>>   - we start writing new values to CPU env while still in TCG code
>>>   - CHAOS!
>>>
>>> The general solution for this is to ensure these sort of tasks are done
>>> with safe work in the CPUs context when we know nothing else is running.
>>> It seems this is probably best done by modifying
>>> qemu_system_reset_request to queue work up on current_cpu and execute it
>>> as safe work - I don't think the vl.c thread should ever be messing
>>> about with calling cpu_reset directly.
>> My first thought is that qemu_system_reset() should absolutely
>> stop every CPU (or other runnable thing like a DMA agent) in the
>> system. The semantics are basically "like a power cycle", so
>> that should include a complete stop of the world. (Is this
>> what vm_stop() does? Dunno...)
>
> I agree, it should do vm_stop() as the first thing and, if applicable,
> vm_start() as the last thing, similar to e.g. savevm.

OK I did some more digging and basically the problem is cpu_stop_current
does the wrong thing. It can set cpu->stopped while still in the vCPU
thread which means when the vl.c thread does pause_all_vcpus() it thinks
the thread is paused when in fact it isn't leading to the chaos. I think
the fix is to tighten up our usage of these two functions. So my current
plan is:

* pause_all_vcpus() should never be called from vCPU/HW emulation

One case in kvm_apic has been fixed by Pranith. The other case in s390
should be converted to use async_safe_work. Once this is done we can
assert that pause_all_vcpus() is not in a vCPU thread and keep it for
qmp,hmp and gdb type operations.

* vm_stop() is probably being misused by vCPU threads

There are more uses than pause_all_vcpus here but they all seem to be
for error handling bail-out type things.

* cpu_stop_current() is probably superfluous now

It certainly shouldn't be called directly from the vCPU code
(rtas_power_off) and once we know pause_all_vcpus() can't be called
directly at least one call is gone. I think the current_cpu handling is
a relic of the days of single-threaded handling when it was a global.

Does that sound reasonable?

--
Alex Bennée
