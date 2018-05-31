Received: from eggs.gnu.org ([2001:4830:134:3::10]:40504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOOQ9-0007je-Gq
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOOQ8-0002pn-Cr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:19:17 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOOQ8-0002pM-6z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:19:16 -0400
Received: by mail-oi0-x243.google.com with SMTP id i205-v6so5081763oib.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 07:19:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180517193104.GB4771@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-16-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA9bYdwByseqCMKSVtWV59mNruT3jJfWWLju1koCnwSb=Q@mail.gmail.com>
	<20180417142318.GO24561@codeaurora.org>
	<CAFEAcA8RwC7DSbo+mMqYUS6tL5UwfQGMa_r5AnAkJqm7v63HWw@mail.gmail.com>
	<20180517193104.GB4771@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:18:54 +0100
Message-ID: <CAFEAcA-+sO3oUqfQXHcHRBu2i-WFzvFKObcBz26qeLS_0+3s2Q@mail.gmail.com>
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

On 17 May 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> On Apr 17 16:00, Peter Maydell wrote:
>> So, the underlying issue here is that there's a QEMU specific
>> fudge going on. Architecturally, if the CPU implements the
>> Virtualization Extensions, then:
>>  * it has Hyp mode
>>  * it must also implement the Security Extensions
>>  * on reset it starts in the Secure world
>>  * it has LPAE
>>  * it has some stuff that is not inherently tied to having EL2,
>>    like the SDIV and UDIV instructions, and the presence of
>>    PMOVSSET
>>
>> In an ideal world, we'd just have a feature flag that turned
>> all that on. Unfortunately, a combination of backwards compatibility
>> issues, the order in which various features were implemented
>> in QEMU, and the fact that KVM can't emulate a guest CPU with
>> the Security Extensions means that we want to be able to model
>> variants of some CPUs that don't really exist in real hardware:
>> Cortex-A15 and -A7 which only implement EL0/EL1 but still have
>> all the v7VE features that you can see from those ELs. But we
>> didn't really properly lay out guidelines for how the feature
>> bits should work in this case, with the result that we have
>> a bunch of local hacks (for instance get_S1prot() has a check
>> on the LPAE feature bit, since in practice that bit is set in
>> exactly the CPUs that have v7VE; and the UDIV/SDIV insns have
>> their own feature bits.)
>>
>> So we should probably sort out this mess first, either by:
>>
>> (a) state that we use ARM_FEATURE_LPAE for all checks for
>> features that are architecturally v7VE but which we want to
>> exist even on our v7VE-no-Hyp-no-Secure oddballs
>> (b) define an ARM_FEATURE_V7VE for them
>> (c) define separate feature bits for them individually
>
> From what I can tell, using ARM_FEATURE_LPAE to represent all the
> almost-v7ve misfits won't work well because ARM_FEATURE_ARM_DIV may be
> supported on some platforms for which ARM_FEATURE_LPAE is not (Cortex
> R5), and ARM_FEATURE_ARM_DIV is read from ID_ISAR0 in
> kvm_arm_get_host_cpu_features() (and may be set/not set independently of
> ARM_FEATURE_LPAE). It appears there is a need to independently
> distinguish between them.

We need (and already have) a separate feature bit for ARM_DIV
exactly because it's present on some CPUs which don't have V7VE;
so we don't want to roll that back into a V7VE feature bit.

> The same reasoning also seems to rule out
> option (b) "one ARM_FEATURE_V7VE to rule them all", leaving me with
> option (c).
>
> It almost seems silly to create ARM_FEATURE_PMOVSSET, but I'm not sure
> what else makes sense to do here. Am I missing something (I'm almost
> hoping I am)?

Sorry, I forgot I hadn't replied to this email yet. Let's do this:

 * define a new ARM_FEATURE_V7VE:

  ARM_FEATURE_V7VE, /* v7 Virtualization Extensions (non-EL2 parts) */

In arm_cpu_realizefn:

 * change the existing "FEATURE_V8 implies V7/ARM_DIV/LPAE" to
   "FEATURE_V8 implies V7VE"
 * below that put

   if (arm_feature(env, ARM_FEATURE_V7VE) {
       /* v7 Virtualization Extensions. In real hardware this implies
        * EL2 and also the presence of the Security Extensions.
        * For QEMU, for backwards-compatibility we implement some
        * CPUs or CPU configs which have no actual EL2 or EL3 but do
        * include the various other features that V7VE implies.
        * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
        * Security Extensions is ARM_FEATURE_EL3.
        */
       set_feature(env, ARM_FEATURE_ARM_DIV);
       set_feature(env, ARM_FEATURE_LPAE);
       set_feature(env, ARM_FEATURE_V7);
   }

 * in kvm_arm_get_host_cpu_features() in kvm32.c add
   set_feature(&features, ARM_FEATURE_V7VE);
   where we currently set V7, LPAE, etc.
   (by definition a host CPU which supports KVM has v7VE.)

 * perhaps some followon patches that correct checks that were
   testing something else and can now use the new V7VE feature bit.

thanks
-- PMM
