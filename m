Received: from eggs.gnu.org ([2001:4830:134:3::10]:48449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNMlP-0002H6-LJ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNMlO-0000UP-94
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:53:15 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNMlN-0000Rj-PI
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:53:13 -0500
Received: by mail-oi1-x241.google.com with SMTP id b141so8613666oii.12
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 10:53:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181029155339.15280-4-richard.henderson@linaro.org>
References: <20181029155339.15280-1-richard.henderson@linaro.org>
	<20181029155339.15280-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 18:52:44 +0000
Message-ID: <CAFEAcA-nS6V2dB6GUq6vwtDK0EHdZzPENWYtCXGFDFxPxxv4xA@mail.gmail.com>
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
> +    if (!arm_feature(env, ARM_FEATURE_PMSA) &&
> +        !extended_addresses_enabled(env)) {
> +        CPUState *cs = CPU(arm_env_get_cpu(env));
> +        int asid = extract32(value, 0, 8);
> +        int idxmask;
> +
> +        switch (ri->secure) {
> +        case ARM_CP_SECSTATE_S:
> +            idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
> +            break;
> +        case ARM_CP_SECSTATE_NS:
> +            idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }

If EL3 is AArch32 then changes to CONTEXTIDR(S) need to
invalidate the S1E3 MMU index.

If EL3 is not AArch32 then there is no CONTEXTIDR(S), but
if we are at EL3 then whether CONTEXTIDR applies to
ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0 or to
ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 is tricky,
because it's up to EL3 to swap registers around depending
on whether it wants to enter EL1 in secure or nonsecure state.
I need to check more deeply about how this works.

NB also that I'm a bit suspicious of the definition of
extended_addresses_enabled(); need to check it.

> +        tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
> +    }
>  }
>
>  /* IS variants of TLB operations must affect all cores */
> --
> 2.17.2

thanks
-- PMM
