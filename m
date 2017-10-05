Received: from eggs.gnu.org ([2001:4830:134:3::10]:49103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BDy-0001Zp-0U
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BDw-0006Go-SQ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:50:22 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:47974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0BDw-0006Fj-Ne
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:50:20 -0400
Received: by mail-qt0-x233.google.com with SMTP id z50so22221351qtj.4
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:50:20 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-18-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd16f792-28a0-95b8-6a68-73f1427e6d38@linaro.org>
Date: Thu, 5 Oct 2017 14:50:17 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-18-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/20] target/arm: Implement SG instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/22/2017 11:00 AM, Peter Maydell wrote:
> Implement the SG instruction, which we emulate 'by hand' in the
> exception handling code path.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 124 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b1ecb66..8df819d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -41,6 +41,10 @@ typedef struct V8M_SAttributes {
>      bool irvalid;
>  } V8M_SAttributes;
>  
> +static void v8m_security_lookup(CPUARMState *env, uint32_t address,
> +                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
> +                                V8M_SAttributes *sattrs);
> +
>  /* Definitions for the PMCCNTR and PMCR registers */
>  #define PMCRD   0x8
>  #define PMCRC   0x4
> @@ -6724,6 +6728,123 @@ static void arm_log_exception(int idx)
>      }
>  }
>  
> +static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx, uint16_t *insn)
> +{

This function doesn't take an address ...

> +    if (get_phys_addr(env, env->regs[15], MMU_INST_FETCH, mmu_idx,
> +                      &physaddr, &attrs, &prot, &page_size, &fsr, &fi)) {

... reading it directly from r15 ...

> +    if (insn != 0xe97f) {
> +        /* Not an SG instruction first half (we choose the IMPDEF
> +         * early-SG-check option).
> +         */
> +        goto gen_invep;
> +    }
> +
> +    if (!v7m_read_half_insn(cpu, mmu_idx, &insn)) {
> +        return false;
> +    }
> +
> +    if (insn != 0xe97f) {
> +        /* Not an SG instruction second half */
> +        goto gen_invep;
> +    }

... but somehow expects to get two different values read from the same address?

Certainly you'd get the wrong exception frame if you incremented r15 in between.

> +    env->regs[15] += 4;

... that make this right and the implicit address to the readers wrong.

I don't see anything else amiss in the patch.


r~
