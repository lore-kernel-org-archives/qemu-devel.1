Received: from eggs.gnu.org ([2001:4830:134:3::10]:44036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZDYt-0000Y3-1F
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZDYs-0007gu-7p
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:24:47 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZDYr-0007gG-OY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:24:46 -0500
Received: by mail-ot0-x244.google.com with SMTP id 37so13841784otv.6
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 02:24:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001401d389e1$495ffa30$dc1fee90$@ru>
References: <20171116115926.16627-1-pbonzini@redhat.com>
	<20171116115926.16627-8-pbonzini@redhat.com>
	<CAFEAcA-06-VmH7Pvymo-o-HmiQ-uQ67Hs0KhWZfxswBxsfD2-g@mail.gmail.com>
	<bf4bedd9-0ef8-cff3-6153-531fba597237@redhat.com>
	<CAFEAcA9Rnd3gtrHb389e6fOEAae4aLhJnQWU-vKyzTM4o-riOQ@mail.gmail.com>
	<001b01d361e9$d46ace40$7d406ac0$@ru>
	<CAFEAcA8NGnmG_8SipvPN5_dPhokH2zZAXykN2KiW10XhB-9xXQ@mail.gmail.com>
	<CAFEAcA9PUOyK_vEnMKJkZV5s7o4zHDRedUY7z0ZH0i5ULEGzwg@mail.gmail.com>
	<004401d3894c$b3fc90f0$1bf5b2d0$@ru>
	<CAFEAcA8GiMDyFU4j3OvZ7F=fXk93B4447RQnpp+9cHWUGMp7Ag@mail.gmail.com>
	<001401d389e1$495ffa30$dc1fee90$@ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jan 2018 10:24:24 +0000
Message-ID: <CAFEAcA_RCunjurjJt3rrOp+0hHXCZgK2X9mM857fKtF8v=Kb+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/11] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 10 January 2018 at 07:04, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> The failure cause is in incorrect interrupt processing.
> When ARM processes hardware interrupt in arm_cpu_exec_interrupt(),
> it executes cs->exception_index = excp_idx;
>
> This assumes, that the exception will be processed later.
> But it is processed immediately by calling cc->do_interrupt(cs);
> instead of leaving this job to cpu_exec.

That seems fine to me. The code knows it needs to take
an interrupt, it has all the information it needs to do
it, it can just go ahead and call the code that takes
the interrupt. The comment in accel/tcg/cpu-exec.c says:

        /* The target hook has 3 exit conditions:
           False when the interrupt isn't processed,
           True when it is, and we should restart on a new TB,
           and via longjmp via cpu_loop_exit.  */

and here we have processed the interrupt and returned true.
We set exception_index because that's how you tell the
do_interrupt hook which interrupt to deal with.

That is, the pattern that the arm target code assumes for
cs->exception_index is "you don't set this unless you're
about to call do_interrupt; if you do set it then definitely
call do_interrupt and don't do anything much in between".
In that view of the world there's no need to reset it or
check it because nothing is permitted to happen between
"set value" and "call do_interrupt". This is in line with
the way we handle other arm-specific bits of information
associated with the exception, like env->exception.target_el.
Having a long gap between "set value" and "do_interrupt"
is worrying because it means that maybe we might end
up doing something else in that gap that corrupts the
various bits of information associated with the exception,
or something that's not architecturally permitted to
happen at that point.

thanks
-- PMM
