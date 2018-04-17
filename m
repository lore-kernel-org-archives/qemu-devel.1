Received: from eggs.gnu.org ([2001:4830:134:3::10]:34239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8S6Z-0002dn-Sc
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8S6T-0002Nd-UM
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:01:11 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8S6T-0002Mx-NA
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:01:05 -0400
Received: by mail-ot0-x242.google.com with SMTP id g23-v6so6555174oti.0
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 08:01:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417142318.GO24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-16-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA9bYdwByseqCMKSVtWV59mNruT3jJfWWLju1koCnwSb=Q@mail.gmail.com>
	<20180417142318.GO24561@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 16:00:43 +0100
Message-ID: <CAFEAcA8RwC7DSbo+mMqYUS6tL5UwfQGMa_r5AnAkJqm7v63HWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 15/22] target/arm: Add ARM_FEATURE_V7VE
 for v7 Virtualization Extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 17 April 2018 at 15:23, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> On Apr 12 18:17, Peter Maydell wrote:
>> What's the difference between this and ARM_FEATURE_EL2 ?
>
> I use ARM_FEATURE_V7VE in a later patch to guard against implementing
> PMOVSSET on v7 machines which don't implement the virtualization
> extensions
> (http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04917.html).
> I could use ARM_FEATURE_EL2, but declaring that v7 machines supported
> EL2 didn't feel right. I don't feel strongly one way or the other - how
> do you prefer to handle this?

So, the underlying issue here is that there's a QEMU specific
fudge going on. Architecturally, if the CPU implements the
Virtualization Extensions, then:
 * it has Hyp mode
 * it must also implement the Security Extensions
 * on reset it starts in the Secure world
 * it has LPAE
 * it has some stuff that is not inherently tied to having EL2,
   like the SDIV and UDIV instructions, and the presence of
   PMOVSSET

In an ideal world, we'd just have a feature flag that turned
all that on. Unfortunately, a combination of backwards compatibility
issues, the order in which various features were implemented
in QEMU, and the fact that KVM can't emulate a guest CPU with
the Security Extensions means that we want to be able to model
variants of some CPUs that don't really exist in real hardware:
Cortex-A15 and -A7 which only implement EL0/EL1 but still have
all the v7VE features that you can see from those ELs. But we
didn't really properly lay out guidelines for how the feature
bits should work in this case, with the result that we have
a bunch of local hacks (for instance get_S1prot() has a check
on the LPAE feature bit, since in practice that bit is set in
exactly the CPUs that have v7VE; and the UDIV/SDIV insns have
their own feature bits.)

So we should probably sort out this mess first, either by:

(a) state that we use ARM_FEATURE_LPAE for all checks for
features that are architecturally v7VE but which we want to
exist even on our v7VE-no-Hyp-no-Secure oddballs
(b) define an ARM_FEATURE_V7VE for them
(c) define separate feature bits for them individually

In any case we'd retain ARM_FEATURE_EL2 for "and really
has EL2/Hyp mode", and we'd want to do an audit of current
uses of various feature bits to see whether they followed
the new rules.

(For AArch64 things are a bit less awkward because the
architecture allows the idea of an implementation that
has EL2 but not EL3.)

thanks
-- PMM
