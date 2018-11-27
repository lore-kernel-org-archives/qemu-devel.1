Received: from eggs.gnu.org ([2001:4830:134:3::10]:55700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRfZT-0000b0-Uv
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRfZT-0003Ea-49
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:46:43 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRfZS-0003C0-Vf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:46:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id x23so19679532oix.3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 07:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-5-sameo@linux.intel.com>
	<CAFEAcA9wvrnshOTYz-jZ0n6m7SfusYY+bnB-iPnQuVNqqdg5Ww@mail.gmail.com>
	<20181127153551.GC4393@caravaggio>
In-Reply-To: <20181127153551.GC4393@caravaggio>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 15:46:30 +0000
Message-ID: <CAFEAcA9B5DPeot26-oGtR-h+xdfg+tmUPrYpKhaneaT1tr1yqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/13] target: arm: Move all interrupt and
 exception handlers into their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Tue, 27 Nov 2018 at 15:36, Samuel Ortiz <sameo@linux.intel.com> wrote:
>
> On Tue, Nov 20, 2018 at 01:45:03PM +0000, Peter Maydell wrote:
> > What is your plan for dealing with the way that the KVM code
> > for injecting a breakpoint exception into the guest works
> > by calling the do_interrupt code ?
> > (see target/arm/kvm64.c:kvm_arm_handle_debug(),
> > which calls cc->do_interrupt(cs).) This patch moves those
> > functions to a file which won't be compiled and a later one
> > in the series seems to stop cc->do_interrupt being set at all
> > if CONFIG_TCG is not defined. That will result in QEMU crashing
> > when it tries to inject an exception, won't it?
> Yes, indeed.
> So it seems we need to inject an exception back into the guest when
> doing hardware assisted debugging and when we have not set any
> breakpoint from QEMU. So it's essentially handling the debugging from
> the guest case.
> Would returning an error when that happens be an acceptable solution? So
> when building qemu for arm64 with TCG disabled, one would basically no
> longer be able to debug from the guest.

I don't think that's a good idea. --disable-tcg shouldn't imply
"and you lose some features of KVM". This code is used in both TCG
and KVM, so needs to still be in the binary for KVM.

NB that it will also be used by the codepath for injecting SErrors
when the host detects a RAS memory error in RAM used by the guest
and wants to inform the guest of that. There are patches on-list
for that, currently undergoing code review.

thanks
-- PMM
