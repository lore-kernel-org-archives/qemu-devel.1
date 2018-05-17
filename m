Received: from eggs.gnu.org ([2001:4830:134:3::10]:44803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fJOcP-0003sC-7c
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fJOcO-00066P-22
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:31:17 -0400
Date: Thu, 17 May 2018 15:31:04 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180517193104.GB4771@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-16-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA9bYdwByseqCMKSVtWV59mNruT3jJfWWLju1koCnwSb=Q@mail.gmail.com>
	<20180417142318.GO24561@codeaurora.org>
	<CAFEAcA8RwC7DSbo+mMqYUS6tL5UwfQGMa_r5AnAkJqm7v63HWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8RwC7DSbo+mMqYUS6tL5UwfQGMa_r5AnAkJqm7v63HWw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Apr 17 16:00, Peter Maydell wrote:
> On 17 April 2018 at 15:23, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > On Apr 12 18:17, Peter Maydell wrote:
> >> What's the difference between this and ARM_FEATURE_EL2 ?
> >
> > I use ARM_FEATURE_V7VE in a later patch to guard against implementing
> > PMOVSSET on v7 machines which don't implement the virtualization
> > extensions
> > (http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04917.html).
> > I could use ARM_FEATURE_EL2, but declaring that v7 machines supported
> > EL2 didn't feel right. I don't feel strongly one way or the other - how
> > do you prefer to handle this?
> 
> So, the underlying issue here is that there's a QEMU specific
> fudge going on. Architecturally, if the CPU implements the
> Virtualization Extensions, then:
>  * it has Hyp mode
>  * it must also implement the Security Extensions
>  * on reset it starts in the Secure world
>  * it has LPAE
>  * it has some stuff that is not inherently tied to having EL2,
>    like the SDIV and UDIV instructions, and the presence of
>    PMOVSSET
> 
> In an ideal world, we'd just have a feature flag that turned
> all that on. Unfortunately, a combination of backwards compatibility
> issues, the order in which various features were implemented
> in QEMU, and the fact that KVM can't emulate a guest CPU with
> the Security Extensions means that we want to be able to model
> variants of some CPUs that don't really exist in real hardware:
> Cortex-A15 and -A7 which only implement EL0/EL1 but still have
> all the v7VE features that you can see from those ELs. But we
> didn't really properly lay out guidelines for how the feature
> bits should work in this case, with the result that we have
> a bunch of local hacks (for instance get_S1prot() has a check
> on the LPAE feature bit, since in practice that bit is set in
> exactly the CPUs that have v7VE; and the UDIV/SDIV insns have
> their own feature bits.)
> 
> So we should probably sort out this mess first, either by:
> 
> (a) state that we use ARM_FEATURE_LPAE for all checks for
> features that are architecturally v7VE but which we want to
> exist even on our v7VE-no-Hyp-no-Secure oddballs
> (b) define an ARM_FEATURE_V7VE for them
> (c) define separate feature bits for them individually

>From what I can tell, using ARM_FEATURE_LPAE to represent all the
almost-v7ve misfits won't work well because ARM_FEATURE_ARM_DIV may be
supported on some platforms for which ARM_FEATURE_LPAE is not (Cortex
R5), and ARM_FEATURE_ARM_DIV is read from ID_ISAR0 in
kvm_arm_get_host_cpu_features() (and may be set/not set independently of
ARM_FEATURE_LPAE). It appears there is a need to independently
distinguish between them. The same reasoning also seems to rule out
option (b) "one ARM_FEATURE_V7VE to rule them all", leaving me with
option (c).

It almost seems silly to create ARM_FEATURE_PMOVSSET, but I'm not sure
what else makes sense to do here. Am I missing something (I'm almost
hoping I am)?

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
