Received: from eggs.gnu.org ([2001:4830:134:3::10]:49115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUaLp-0004eE-2d
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUaLn-0003u6-Oj
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:11:53 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUaLn-0003ra-H5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:11:51 -0400
Received: by mail-wr0-x235.google.com with SMTP id c11so142768294wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:11:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
	<1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 16:11:29 +0100
Message-ID: <CAFEAcA-dssYnbZjuWTjBta1aK3iL3pyRKh5Qs4hFh=bPONgnTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target-arm: Extend PAR format
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 30 June 2017 at 14:45, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Extend PAR format determination to handle more cases.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/arm/helper.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index fd1027e..6a1fffe 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2345,12 +2345,40 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
>      uint32_t fsr;
>      bool ret;
>      uint64_t par64;
> +    bool format64 = false;
>      MemTxAttrs attrs = {};
>      ARMMMUFaultInfo fi = {};
>
>      ret = get_phys_addr(env, value, access_type, mmu_idx,
>                          &phys_addr, &attrs, &prot, &page_size, &fsr, &fi);
> -    if (extended_addresses_enabled(env)) {
> +
> +    if (is_a64(env)) {
> +        format64 = true;
> +    } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
> +        /*
> +         * ATS1Cxx:
> +         * * TTBCR.EAE determines whether the result is returned using the
> +         *   32-bit or the 64-bit PAR format
> +         * * Instructions executed in Hyp mode always use the 64bit format
> +         *
> +         * ATS1S2NSOxx uses the 64bit format if any of the following is true:
> +         * * The Non-secure TTBCR.EAE bit is set to 1
> +         * * The implementation includes EL2, and the value of HCR.VM is 1
> +         *
> +         * ATS1Hx always uses the 64bit format (not supported yet).
> +         */
> +        format64 = regime_using_lpae_format(env, mmu_idx);
> +
> +        if (arm_feature(env, ARM_FEATURE_EL2)) {
> +            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> +                format64 |= env->cp15.hcr_el2 & HCR_VM;
> +            } else {
> +                format64 |= arm_current_el(env) == 2;
> +            }
> +        }
> +    }

So this kind of worries me, because what it's coded as is "determine
whether architecturally we should be returning a 64-bit or 32-bit
PAR format", but what the code below it uses the format64 flag for is
"manipulate whatever PAR we got handed back by get_phys_addr()".
So we have two separate bits of code that are both choosing
32 vs 64 bit PAR (the code in this patch, and the logic inside
get_phys_addr()), and they have to come to the same conclusion
or we'll silently mangle the PAR. It seems like it would be
better to either have get_phys_addr() explicitly tell us what kind
of format it is returning to us, or to have the caller tell it
what kind of PAR it needs.

PS: on the subject of virtualization, I notice there's a comment
a bit later on in do_ats_write() that says
    /* Note that S2WLK and FSTAGE are always zero, because we don't
     * implement virtualization and therefore there can't be a stage 2
     * fault.
     */
so we'll need to address that too at some point...

thanks
-- PMM
