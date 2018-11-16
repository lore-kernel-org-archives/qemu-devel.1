Received: from eggs.gnu.org ([2001:4830:134:3::10]:47896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNeU0-0000OI-N1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNeTy-0004Jj-P9
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:48:28 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNeTw-0004Hx-RL
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:48:26 -0500
Received: by mail-oi1-x243.google.com with SMTP id g188-v6so19655090oif.8
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 05:48:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181029155339.15280-4-richard.henderson@linaro.org>
References: <20181029155339.15280-1-richard.henderson@linaro.org>
	<20181029155339.15280-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 13:47:59 +0000
Message-ID: <CAFEAcA8Lyhu2wqNyCkCEtAs0C6ZA46ghhD-EkNT_D3xKvjrK2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/4] target/arm: Install ASIDs for
 short-form from EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 October 2018 at 15:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This is less complex than the LPAE case, but still we now avoid the
> flush in case it is only the PROCID field that is changing.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 26d6f28793..f767467dcf 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -541,17 +541,31 @@ static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>  static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> -
> -    if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
> -        && !extended_addresses_enabled(env)) {
> -        /* For VMSA (when not using the LPAE long descriptor page table
> -         * format) this register includes the ASID, so do a TLB flush.
> -         * For PMSA it is purely a process ID and no action is needed.
> -         */
> -        tlb_flush(CPU(cpu));
> -    }
>      raw_write(env, ri, value);
> +
> +    /*
> +     * For VMSA (when not using the LPAE long descriptor page table format)
> +     * this register includes the ASID.  For PMSA it is purely a process ID
> +     * and no action is needed.
> +     */

I've now thought about this a bit and read through some of
the relevant bits of the Arm ARM. My updated opinion is below:

General principles first:
 * the set of MMU indexes we need to do a set-asid or flush for
depends on the register being written (and not the context
from which it is being written), ie your remarks to this effect
in the cover letter are correct
 * for some registers the register is used by translations in
exactly one translation regime, and therefore the situation is
simple (eg TTBR(S) is only used by S1E3|S1SE0)
 * for some registers the same register may be used by more than
one translation regime, eg AArch64 CONTEXTIDR_EL1 written from
EL3 may be because we're setting up the translation regime
for Secure EL1&0 (ie S1SE1|S1SE0) or for NS EL1&0 (S12NSE1|S12NSE0),
and we can't tell which at this point.

> +    if (!arm_feature(env, ARM_FEATURE_PMSA) &&
> +        !extended_addresses_enabled(env)) {

The current definition of extended_addresses_enabled(), which
is used only here, is:

static inline bool extended_addresses_enabled(CPUARMState *env)
{
    TCR *tcr = &env->cp15.tcr_el[arm_is_secure(env) ? 3 : 1];
    return arm_el_is_aa64(env, 1) ||
           (arm_feature(env, ARM_FEATURE_LPAE) && (tcr->raw_tcr & TTBCR_EAE));
}

This is bogus both because of that hardcoded '1' argument to
arm_el_is_aa64() and also because it's asking a question about
the current state of the CPU, whereas what we'd like to know
is whether the translation regime affected by the register
which we are changing is using extended addressing.
We also need to make sure that any state we depend upon here
when determining which indexes to flush is either:
 * in the list of things the architecture says can be
   cached in a tlb and so the guest is going to have
   to do tlb maintenance ops if they change it
 * something that causes QEMU to do a tlb flush or asid update
   if it changes

We should fix the condition we're checking, and I think also
just do it inline here and get rid of extended_addresses_enabled(),
which looks like a general-purpose utility function but isn't.
(We've previously managed to get rid of all the other uses
of it, which were generally bugs.)

> +        CPUState *cs = CPU(arm_env_get_cpu(env));
> +        int asid = extract32(value, 0, 8);
> +        int idxmask;
> +
> +        switch (ri->secure) {
> +        case ARM_CP_SECSTATE_S:
> +            idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;

This must be TTBR(S), which means EL3 must be AArch32 and we're
in Secure EL3 (aka Secure PL1), and the ASID here affects only
S1E3|SESE0.

> +            break;
> +        case ARM_CP_SECSTATE_NS:
> +            idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;

There are two possibilities here:
 * EL3 is AArch32: this must be TTBR(NS), in which case it affects
   S12NSE1|S12NSE0
 * EL3 is AArch64, in which case this is the one and only
   CONTEXTIDR_EL1 (whether we're accessing it from AArch32 or
   AArch64), and it affects either S1SE1|S1SE0 or S12NSE1|S12NSE0.
   If we're executing at EL2 or below then we can know which
   of those two is affected (it will be the current CPU state),
   but we can't set-asid just the one that is affected unless we're
   also willing to arrange to do a set-asid for the other security
   state when we transition into EL3. (Otherwise "be in NS EL1;
   set CONTEXTIDR_EL1; go to EL3; set S bit; go to S EL1" will
   take you to S EL1 with a new CONTEXTIDR value without having
   updated the ASID for its MMU indexes.)
   (If we have no EL3 at all then obviously we need not flush
   the non-existent Secure regime TLBs.)

> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
> +    }
>  }
>
>  /* IS variants of TLB operations must affect all cores */
> --
> 2.17.2

I haven't reviewed patch 2 but I expect that the above
applies there too, give or take.

thanks
-- PMM
