Received: from eggs.gnu.org ([2001:4830:134:3::10]:35854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqbnB-0007xs-0f
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqbnA-0002fz-4e
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:15:40 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqbn9-0002fZ-TD
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:15:40 -0400
Received: by mail-oi0-x244.google.com with SMTP id 8-v6so13159195oip.0
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 03:15:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-1-peter.maydell@linaro.org>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 11:15:18 +0100
Message-ID: <CAFEAcA99e2sO8dz3J42+BHO=AJDfx90z1GKGAOreNiWSo3KELw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 00/10] target/arm: Some pieces
 of support for 32-bit Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Edgar Iglesias <edgari@xilinx.com>, Luc Michel <luc.michel@greensocs.com>, "patches@linaro.org" <patches@linaro.org>

On 14 August 2018 at 13:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> Now we have virtualization support in the GICv2 emulation,
> I thought I'd have a look at how much we were still missing
> for being able to enable EL2 support for AArch32.
> This set of patches fixes some minor missing pieces:
>  * various small bugs in cp15 registers or places where
>    we were missing the 32-bit version of a 64-bit register
>  * a bugfix for MSR/MRS (banked), which were not allowing
>    Hyp mode to access ELR_Hyp
>  * implementation of the ERET instruction for A32/T32
>  * support for taking exceptions to Hyp mode (the largest
>    of these missing bits)
>
> This isn't complete, but I thought I'd push these patches
> out for review. My test setup is that I have another
> couple of patches, one which fixes up hw/arm/boot.c to
> boot AArch32 kernels in Hyp mode if it exists, and one
> which sets ARM_FEATURE_EL2 on our A15 model. With those I
> can get an outer kernel to boot with KVM support and try
> to run an inner guest kernel. The inner kernel boots OK
> but gets random segfaults in its userspace -- I haven't
> tracked down why this is yet...

I've put patches 1, 2, 4, 6, 7, 8, 9:

>   target/arm: Correct typo in HAMAIR1 regdef name
>   target/arm: Add missing .cp = 15 to HMAIR1 and HAMAIR1 regdefs
>   target/arm: Implement RAZ/WI HACTLR2
>   target/arm: Implement AArch32 HVBAR
>   target/arm: Implement AArch32 HCR and HCR2
>   target/arm: Implement AArch32 Hyp FARs
>   target/arm: Implement ESR_EL2/HSR for AArch32 and no-EL2
>   target/arm: Permit accesses to ELR_Hyp from Hyp mode via MSR/MRS
>     (banked)
>   target/arm: Implement AArch32 ERET instruction

into target-arm.next.

Patches 3, 5, 10 had issues in code review and I'll
rework those and send a v2 at some point:

>   target/arm: Implement RAZ/WI HACTLR2
>   target/arm: Implement AArch32 HCR and HCR2
>   target/arm: Implement support for taking exceptions to Hyp mode

thanks
-- PMM
