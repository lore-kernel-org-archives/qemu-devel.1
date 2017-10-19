Received: from eggs.gnu.org ([2001:4830:134:3::10]:43147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5CvC-0008TV-ES
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5CvB-0000yg-Gn
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:39:46 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:45571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5CvB-0000yN-8b
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:39:45 -0400
Received: by mail-wm0-x241.google.com with SMTP id q124so16859490wmb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:39:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710181539580.27209@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710181539580.27209@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 16:39:23 +0100
Message-ID: <CAFEAcA9t7i4JLbn2X5r2KqdA00fSEZPLEW4PpCsp_uyg8Gsm0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] don't hardcode EL1 in
 extended_addresses_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Julien Grall <julien.grall@linaro.org>

On 18 October 2017 at 23:41, Stefano Stabellini <sstabellini@kernel.org> wrote:
> extended_addresses_enabled calls arm_el_is_aa64, hardcoding exception
> level 1. Instead, retrieve the current el calling arm_current_el.
>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1f6efef..63507d9 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -187,7 +187,7 @@ static inline unsigned int arm_pamax(ARMCPU *cpu)
>  static inline bool extended_addresses_enabled(CPUARMState *env)
>  {
>      TCR *tcr = &env->cp15.tcr_el[arm_is_secure(env) ? 3 : 1];
> -    return arm_el_is_aa64(env, 1) ||
> +    return arm_el_is_aa64(env, arm_current_el(env)) ||
>             (arm_feature(env, ARM_FEATURE_LPAE) && (tcr->raw_tcr & TTBCR_EAE));
>  }

Hmm. The current code was definitely written under a "aarch64
only supports EL0 and EL1" assumption, but I'm not sure
this change is entirely correct.

We use this function in 3 places:

 * identifying whether to flush TLBs on CONTEXTIDR writes
    -- using current EL seems like the right thing (but I'm not
       sure -- perhaps we should pass in the S/NS from which
       version of the 32-bit banked register is being updated
       rather than using arm_is_secure(env) ???)
 * choosing a PAR format for ATS operations
    -- using the current EL is closer to correct that what we
       have now. There are cases for a 32-bit CPU in Hyp mode that
       this code mishandles, but we don't support that yet.
 * choosing an FSR value when taking a breakpoint or watchpoint trap
    -- here what we want the function to mean is "what is the
       FSR format for the EL we're about to take this debug
       exception to", which isn't necessarily the answer for the
       current EL (consider 32 bit EL0 under a 64-bit EL1)

So this change will fix the PAR format for ATS operations
made at AArch64 EL2 when EL1 is AArch32, but it will break
the FSR format for breakpoints/watchpoints hit at AArch32 EL0
and taken to AArch64 EL1, I think.

We probably need to separate out these uses to not all try
to use the same function, and clarify what they're checking.

thanks
-- PMM
