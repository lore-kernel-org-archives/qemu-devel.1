Received: from eggs.gnu.org ([2001:4830:134:3::10]:49325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cxUuA-00017y-4H
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cxUu9-0002uX-41
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:42:34 -0400
Date: Mon, 10 Apr 2017 10:42:22 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170410084222.GA19103@toto>
References: <1491486152-24304-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491486152-24304-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] target/arm: Add assertion about FSC format
 for syndrome registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, patches@linaro.org

On Thu, Apr 06, 2017 at 02:42:32PM +0100, Peter Maydell wrote:
> In tlb_fill() we construct a syndrome register value from a
> fault status register value which is filled in by arm_tlb_fill().
> arm_tlb_fill() returns FSR values which might be in the format
> used with short-format page descriptors, or the format used
> with long-format (LPAE) descriptors. The syndrome register
> always uses LPAE-format FSR status codes.
> 
> It isn't actually possible to end up delivering a syndrome
> register value to the guest for a fault which is reported
> with a short-format FSR (that kind of stage 1 fault will only
> happen for an AArch32 translation regime which doesn't have
> a syndrome register, and can never be redirected to an AArch64
> or Hyp exception level). Add an assertion which checks this,
> and adjust the code so that we construct a syndrome with
> an invalid status code, rather than allowing set bits in
> the FSR input to randomly corrupt other fields in the syndrome.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Tricky but it looks correct as far as I can follow the specs...

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>




> ---
> It took me a little while to convince myself that you'd
> never take a short-format FSR to a using-syndrome EL :-)
> ---
>  target/arm/op_helper.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index d64c867..156b825 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -130,7 +130,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>      if (unlikely(ret)) {
>          ARMCPU *cpu = ARM_CPU(cs);
>          CPUARMState *env = &cpu->env;
> -        uint32_t syn, exc;
> +        uint32_t syn, exc, fsc;
>          unsigned int target_el;
>          bool same_el;
>  
> @@ -145,19 +145,32 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>              env->cp15.hpfar_el2 = extract64(fi.s2addr, 12, 47) << 4;
>          }
>          same_el = arm_current_el(env) == target_el;
> -        /* AArch64 syndrome does not have an LPAE bit */
> -        syn = fsr & ~(1 << 9);
> +
> +        if (fsr & (1 << 9)) {
> +            /* LPAE format fault status register : bottom 6 bits are
> +             * status code in the same form as needed for syndrome
> +             */
> +            fsc = extract32(fsr, 0, 6);
> +        } else {
> +            /* Short format FSR : this fault will never actually be reported
> +             * to an EL that uses a syndrome register. Check that here,
> +             * and use a (currently) reserved FSR code in case the constructed
> +             * syndrome does leak into the guest somehow.
> +             */
> +            assert(target_el != 2 && !arm_el_is_aa64(env, target_el));
> +            fsc = 0x3f;
> +        }
>  
>          /* For insn and data aborts we assume there is no instruction syndrome
>           * information; this is always true for exceptions reported to EL1.
>           */
>          if (access_type == MMU_INST_FETCH) {
> -            syn = syn_insn_abort(same_el, 0, fi.s1ptw, syn);
> +            syn = syn_insn_abort(same_el, 0, fi.s1ptw, fsc);
>              exc = EXCP_PREFETCH_ABORT;
>          } else {
>              syn = merge_syn_data_abort(env->exception.syndrome, target_el,
>                                         same_el, fi.s1ptw,
> -                                       access_type == MMU_DATA_STORE, syn);
> +                                       access_type == MMU_DATA_STORE, fsc);
>              if (access_type == MMU_DATA_STORE
>                  && arm_feature(env, ARM_FEATURE_V6)) {
>                  fsr |= (1 << 11);
> -- 
> 2.7.4
> 
> 
