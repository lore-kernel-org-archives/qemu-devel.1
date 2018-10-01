Received: from eggs.gnu.org ([2001:4830:134:3::10]:41993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g72gY-0002CF-Lr
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g72gT-0004In-N2
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:12:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:37075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g72gT-0004Hg-8x
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:12:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id 185-v6so4243124wmt.2
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 11:12:41 -0700 (PDT)
References: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
Date: Mon, 01 Oct 2018 19:12:38 +0100
Message-ID: <87lg7hlend.fsf@linaro.org>
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

> I've been investigating a race condition where sometimes when my
> guest writes to a device register which triggers a
> qemu_system_reset_request(), it doesn't actually cause a clean reset,
> but instead the guest CPU continues to execute instructions.
> I managed to repro it under 'rr', which let me walk through enough
> of what was going on to determine the following:
>
> When a guest CPU thread calls qemu_system_reset_request(), this
> results in a call to qemu_cpu_stop(current_cpu, true), to
> make the CPU come back out to the main loop. We also set the
> reset_requested flag, to get the IO thread to actually do the
> reset.
>
> The main loop thread runs main_loop_should_exit(). If there is a
> pending reset, it calls pause_all_vcpus(), with the intention
> that this quiesces all the guest CPUs before it starts messing
> with reset actions.
>
> pause_all_vcpus() just waits for every cpu to have cpu->stopped set.
> However, if the running cpu has just called qemu_cpu_stop() on
> itself then it will have set cpu->stopped true but not actually
> made it out to the main loop yet. (In the case I'm looking at,
> what happens is that as soon as the CPU thread unlocks the
> iothread mutex in io_writex() after the device write, the
> main thread runs and does all the reset operations.)
>
> The reset code in the iothread then proceeds to start calling
> various reset functions while the CPU thread is still inside
> the exec loop, running generated code and so on. This doesn't
> seem like what ought to happen. In particular it includes
> calling cpu_common_reset(), which clears all kinds of flags
> relevant to the still-executing CPU...

I would have thought the reset code should be scheduled via safe async
work to run in the vCPU context. Why should the main loop get involved
at all here?

>
> Any suggestions for how we should fix this?
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
