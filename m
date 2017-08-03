Received: from eggs.gnu.org ([2001:4830:134:3::10]:38294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddMzQ-0006ck-0v
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddMzP-0001E9-0X
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:45:04 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:32780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddMzO-00018l-Mu
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:45:02 -0400
Received: by mail-wr0-x234.google.com with SMTP id v105so9908371wrb.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 13:45:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3f6ee028-b7f9-fbe0-1aea-eb1e6faab5a3@twiddle.net>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-3-git-send-email-peter.maydell@linaro.org>
	<3f6ee028-b7f9-fbe0-1aea-eb1e6faab5a3@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2017 21:44:39 +0100
Message-ID: <CAFEAcA-n=72QB_mpJjOvk88o1brC_udhdBKZwgTtSDa+ZB2dhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/15] target/arm: Don't trap WFI/WFE for M
 profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 3 August 2017 at 21:28, Richard Henderson <rth@twiddle.net> wrote:
> While looking at this, I think there's an error in helper_wfi.  The early exit
> for cpu_has_work should happen after the exception check.

No, that's deliberate; as Edgar says, the trap only
happens "if the instruction would otherwise have caused the
PE to enter a low-power state".
The rationale AIUI is that the traps to EL2 are there so
that when an EL guest does a WFI in its idle loop the EL2
hypervisor can gain control and give the CPU to
something else. This obviously imposes overhead, so if
the WFI wouldn't actually halt (because there's already
a condition that will cause it to wake up) it's more
efficient just to let the guest continue to execute.
(It also means that NOP is a valid WFI implementation,
though I think that's just a coincidental bonus.)

In fact the architecture gives even more flexibility
in that it only requires the trap to be taken "if the
instruction does not complete in finite time in the
absence of a Wakeup event", so you can do more complicated
things like "just pause for a short period of time to
see if an interrupt might come in and wake us up,
before giving up and taking the trap to EL2".

thanks
-- PMM
