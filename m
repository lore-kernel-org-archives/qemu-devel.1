Received: from eggs.gnu.org ([209.51.188.92]:57885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grm3y-000521-T9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grm3x-0008FQ-WB
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:58:06 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grm3x-0008Ej-RR
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:58:05 -0500
Received: by mail-ot1-x342.google.com with SMTP id v23so534163otk.9
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 07:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-5-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 15:57:52 +0000
Message-ID: <CAFEAcA_EWtyqOnsropKbsmAnoZc60H339u5YtoLbx6H6m-K3sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/17] target/arm: Fill in helper_mte_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 14 Jan 2019 at 01:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implements the rules of "PE generation of Checked and
> Unchecked accesses" which aren't already covered by XXX.

What should the "XXX" be here ?

> Implements the rules of "PE handling of Tag Check Failure".
>
> Does not implement tag physical address space, so all
> operations reduce to unchecked so far.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/mte_helper.c | 80 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
> index a3226c44a4..6f4bc0aa04 100644
> --- a/target/arm/mte_helper.c
> +++ b/target/arm/mte_helper.c
> @@ -25,8 +25,86 @@
>  #include "exec/helper-proto.h"
>
>
> +static int get_allocation_tag(CPUARMState *env, uint64_t ptr)
> +{
> +    /* Tag storage not implemented.  */
> +    return -1;
> +}
> +
> +static int allocation_tag_from_addr(uint64_t ptr)
> +{
> +    return (extract64(ptr, 56, 4) + extract64(ptr, 55, 1)) & 15;
> +}
> +
>  uint64_t HELPER(mte_check)(CPUARMState *env, uint64_t ptr)
>  {
> -    /* Only unchecked implemented so far.  */
> +    ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
> +    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, true);
> +    int ptr_tag, mem_tag;
> +
> +    /*
> +     * If TBI is disabled, then the access is unchecked.
> +     * While we filtered out TBI0==0 && TBI1==0 in cpu_get_tb_cpu_state,
> +     * we did not save separate bits for TBI0 != TBI1.
> +     */
> +    if (!param.tbi) {
> +        /* Do not ignore the top byte.  */
> +        return ptr;
> +    }
> +
> +    /*
> +     * If TCMA is enabled, then physical tag 0 is unchecked.
> +     * Note the rules R0076 & R0077 are written with logical tags,
> +     * and we need the physical tag below anyway.
> +     */
> +    ptr_tag = allocation_tag_from_addr(ptr);
> +    if (param.tcma && ptr_tag == 0) {
> +        goto pass;
> +    }
> +
> +    /*
> +     * If an access is made to an address that does not provide tag storage,
> +     * the result is implementation defined (R0006).  We choose to treat the
> +     * access as unchecked.
> +     * This is similar to MemAttr != Tagged, which are also unchecked.
> +     */
> +    mem_tag = get_allocation_tag(env, ptr);
> +    if (mem_tag < 0) {
> +        goto pass;
> +    }
> +
> +    /* If the tags do not match, the tag check operation fails.  */
> +    if (ptr_tag != mem_tag) {
> +        int el = arm_current_el(env);
> +        int tcf;
> +
> +        /* Indicate the tag check fail, both async and sync reporting.  */
> +        env->cp15.tfsr_el[el] |= 1 << param.select;

We should only update the TFSR bits if we're not taking a fault
(ie if tcf == 2).

> +
> +        if (el == 0) {
> +            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> +            tcf = extract64(env->cp15.sctlr_el[1], 38, 2);
> +        } else {
> +            tcf = extract64(env->cp15.sctlr_el[el], 40, 2);
> +        }
> +        if (tcf == 1) {
> +            /* Tag check fail causes a synchronous exception.  */
> +            CPUState *cs = ENV_GET_CPU(env);
> +
> +            /*
> +             * In restore_state_to_opc, we set the exception syndrome
> +             * for the load or store operation.  Do that first so we
> +             * may overwrite that with the syndrome for the tag check.
> +             */
> +            cpu_restore_state(cs, GETPC(), true);
> +            env->exception.vaddress = ptr;
> +            raise_exception(env, EXCP_DATA_ABORT,
> +                            syn_data_abort_no_iss(el != 0, 0, 0, 0, 0, 0x11),
> +                            exception_target_el(env));
> +        }
> +    }
> +
> + pass:
> +    /* Unchecked, or tag check pass.  Ignore the top byte.  */
>      return sextract64(ptr, 0, 55);
>  }

Remarks from earlier patch still apply about the 'unchecked or check pass'
code path needing to do the usual TBI stuff.

thanks
-- PMM
