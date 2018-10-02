Received: from eggs.gnu.org ([2001:4830:134:3::10]:56426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g7HTt-0000Mx-0J
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g7HTn-0002SF-DH
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:00:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g7HTk-0002IM-59
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:00:33 -0400
Received: by mail-wr1-x42d.google.com with SMTP id y8-v6so1465191wrh.7
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:00:31 -0700 (PDT)
References: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
	<87lg7hlend.fsf@linaro.org>
	<CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
Date: Tue, 02 Oct 2018 11:00:29 +0100
Message-ID: <87in2kllc2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 1 October 2018 at 19:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>> I would have thought the reset code should be scheduled via safe async
>> work to run in the vCPU context. Why should the main loop get involved
>> at all here?
>
> The reset code is much older than the safe-async support for
> running things in the vCPU context... Also, does the safe
> async support work with KVM/HAX/Hypervisor.Framework? The
> reset code has to handle all those, not just TCG.

the *_run_on_cpu functions should be safe for all users although KVM
stuff seems to use the direct run_on_cpu stuff more. The events are
consumed in the wait_io logic that all accelerators share - in the outer
loop in cpus-common.c

> Plus, which vCPU thread would you use?

Each vCPU should reset it's own data. For one thing it avoids issue
with barriers across threads.

> We're resetting
> the entire system, so privileging an arbitrary vCPU
> thread to do that doesn't seem any less odd than using
> the main loop thread.

Sure - but they do give predictable semantics. If in this case the cpu
sourcing the request scheduled async tasks to stop the cpu to everything
else and a safe task to it's own thread it can be assured everyone has
done their "work" (stopping in this case) and is in a known state.

Does qemu_system_reset_request() make any particular promises of what
order things should happen in?

--
Alex Benn=C3=A9e
