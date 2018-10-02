Received: from eggs.gnu.org ([2001:4830:134:3::10]:38723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HyO-00065o-Ti
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HyN-000635-Vj
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:32:12 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:45105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HyN-00062z-Qn
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:32:11 -0400
Received: by mail-ot1-x330.google.com with SMTP id u22so1337988ota.12
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:32:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87in2kllc2.fsf@linaro.org>
References: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
	<87lg7hlend.fsf@linaro.org>
	<CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
	<87in2kllc2.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:31:50 +0100
Message-ID: <CAFEAcA-ZXfO15KPNRRHAntSMqQU2e8MQdJ_8Fa+DB7hnCG0RMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] racing between pause_all_vcpus() and
 qemu_cpu_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>

On 2 October 2018 at 11:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 1 October 2018 at 19:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>> I would have thought the reset code should be scheduled via safe async
>>> work to run in the vCPU context. Why should the main loop get involved
>>> at all here?
>>
>> The reset code is much older than the safe-async support for
>> running things in the vCPU context... Also, does the safe
>> async support work with KVM/HAX/Hypervisor.Framework? The
>> reset code has to handle all those, not just TCG.
>
> the *_run_on_cpu functions should be safe for all users although KVM
> stuff seems to use the direct run_on_cpu stuff more. The events are
> consumed in the wait_io logic that all accelerators share - in the outer
> loop in cpus-common.c
>
>> Plus, which vCPU thread would you use?
>
> Each vCPU should reset it's own data. For one thing it avoids issue
> with barriers across threads.

That seems a very long way from where we are at the moment,
where the semantics are that a CPU is just another kind of
device, and we should ensure that nothing in the system is
executing before we try to reset any of it. (Otherwise
you get into all kinds of nasty conditions where a vCPU
is still running and executes writes to devices that have
already reset, or causes calls into a different vCPU
that again is in the process of resetting).

>> We're resetting
>> the entire system, so privileging an arbitrary vCPU
>> thread to do that doesn't seem any less odd than using
>> the main loop thread.
>
> Sure - but they do give predictable semantics. If in this case the cpu
> sourcing the request scheduled async tasks to stop the cpu to everything
> else and a safe task to it's own thread it can be assured everyone has
> done their "work" (stopping in this case) and is in a known state.
>
> Does qemu_system_reset_request() make any particular promises of what
> order things should happen in?

AIUI the promise is that when the reset occurs the entire
system should end up in the state as if QEMU had just
been started. There is no guarantee about ordering between
different reset methods/functions (which is a bit of a
can of worms of its own), but any device can assume that
nobody else is going to call into it during the reset
process (either before its reset function runs, or after).

Basically it should be like:
 * whole VM pauses
 * we do all the reset work
 * start the VM

thanks
-- PMM
