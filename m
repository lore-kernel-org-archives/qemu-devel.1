Received: from eggs.gnu.org ([209.51.188.92]:59444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr2aX-00087g-V3
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr2aO-0002a7-1Y
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:24:36 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr2aN-0002So-NJ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:24:31 -0500
Received: by mail-ot1-x344.google.com with SMTP id e12so6283967otl.5
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 07:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20190131112240.8395-1-peter.maydell@linaro.org>
	<20190131112240.8395-3-peter.maydell@linaro.org>
	<20190205161609.1640f733@Igors-MacBook-Pro.local>
In-Reply-To: <20190205161609.1640f733@Igors-MacBook-Pro.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 15:24:06 +0000
Message-ID: <CAFEAcA-BP6Oucy8BVr2EfXKFbC-1B5+SkqYmr5+Vc1Em1k0f9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/arm/boot: Factor out "direct kernel
 boot" code into its own function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>

On Tue, 5 Feb 2019 at 15:16, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 31 Jan 2019 11:22:37 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > +void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
> > +{
> > +    CPUState *cs;
> > +    AddressSpace *as = arm_boot_address_space(cpu, info);
> > +
> > +    /*
> > +     * CPU objects (unlike devices) are not automatically reset on system
> > +     * reset, so we must always register a handler to do so. If we're
> > +     * actually loading a kernel, the handler is also responsible for
> > +     * arranging that we start it correctly.
> > +     */
> > +    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
> > +        qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
> > +    }
> Should we move this hunk to cpu code instead, like it's done for x86?

I don't know how x86 does it, but CPU reset is a mess, so if
we can clean it up that would be nice. Most of what do_cpu_reset()
is doing here is handling image load though, which doesn't seem
to me to fit very well in the CPU code: it's pretty much what
hw/arm/boot.c's job is.

I'd rather do that in a different patchset, though: this is just
a code movement refactoring.

thanks
-- PMM
