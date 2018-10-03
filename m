Received: from eggs.gnu.org ([2001:4830:134:3::10]:45156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7czp-0002r5-78
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7czl-00045v-VM
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:59:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7czl-00045X-Nb
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:59:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so5161408wrw.12
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 01:59:01 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5e8f2bd-1bed-d628-38d7-732d6d48caf4@redhat.com>
Date: Wed, 3 Oct 2018 10:58:59 +0200
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/13] target/arm: Add v8M stack checks on
 exception entry
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

On 02/10/2018 18:35, Peter Maydell wrote:
> Add checks for breaches of the v8M stack limit when the
> stack pointer is decremented to push the exception frame
> for exception entry.
> 
> Note that the exception-entry case is unique in that the
> stack pointer is updated to be the limit value if the limit
> is hit (per rule R_ZLZG).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/helper.c | 54 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ef8c244fb84..a10dff01a90 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6839,6 +6839,8 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
>      uint32_t frameptr;
>      ARMMMUIdx mmu_idx;
>      bool stacked_ok;
> +    uint32_t limit;
> +    bool want_psp;
>  
>      if (dotailchain) {
>          bool mode = lr & R_V7M_EXCRET_MODE_MASK;
> @@ -6848,12 +6850,34 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
>          mmu_idx = arm_v7m_mmu_idx_for_secstate_and_priv(env, M_REG_S, priv);
>          frame_sp_p = get_v7m_sp_ptr(env, M_REG_S, mode,
>                                      lr & R_V7M_EXCRET_SPSEL_MASK);
> +        want_psp = mode && (lr & R_V7M_EXCRET_SPSEL_MASK);
> +        if (want_psp) {
> +            limit = env->v7m.psplim[M_REG_S];
> +        } else {
> +            limit = env->v7m.msplim[M_REG_S];
> +        }
>      } else {
>          mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
>          frame_sp_p = &env->regs[13];
> +        limit = v7m_sp_limit(env);
>      }
>  
>      frameptr = *frame_sp_p - 0x28;
> +    if (frameptr < limit) {
> +        /*
> +         * Stack limit failure: set SP to the limit value, and generate
> +         * STKOF UsageFault. Stack pushes below the limit must not be
> +         * performed. It is IMPDEF whether pushes above the limit are
> +         * performed; we choose not to.
> +         */
> +        qemu_log_mask(CPU_LOG_INT,
> +                      "...STKOF during callee-saves register stacking\n");
> +        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_STKOF_MASK;
> +        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
> +                                env->v7m.secure);
> +        *frame_sp_p = limit;
> +        return true;
> +    }
>  
>      /* Write as much of the stack frame as we can. A write failure may
>       * cause us to pend a derived exception.
> @@ -6877,10 +6901,7 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
>          v7m_stack_write(cpu, frameptr + 0x24, env->regs[11], mmu_idx,
>                          ignore_faults);
>  
> -    /* Update SP regardless of whether any of the stack accesses failed.
> -     * When we implement v8M stack limit checking then this attempt to
> -     * update SP might also fail and result in a derived exception.
> -     */
> +    /* Update SP regardless of whether any of the stack accesses failed. */
>      *frame_sp_p = frameptr;
>  
>      return !stacked_ok;
> @@ -7028,6 +7049,26 @@ static bool v7m_push_stack(ARMCPU *cpu)
>  
>      frameptr -= 0x20;
>  
> +    if (arm_feature(env, ARM_FEATURE_V8)) {
> +        uint32_t limit = v7m_sp_limit(env);
> +
> +        if (frameptr < limit) {
> +            /*
> +             * Stack limit failure: set SP to the limit value, and generate
> +             * STKOF UsageFault. Stack pushes below the limit must not be
> +             * performed. It is IMPDEF whether pushes above the limit are
> +             * performed; we choose not to.
> +             */
> +            qemu_log_mask(CPU_LOG_INT,
> +                          "...STKOF during stacking\n");
> +            env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_STKOF_MASK;
> +            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
> +                                    env->v7m.secure);
> +            env->regs[13] = limit;
> +            return true;
> +        }
> +    }
> +
>      /* Write as much of the stack frame as we can. If we fail a stack
>       * write this will result in a derived exception being pended
>       * (which may be taken in preference to the one we started with
> @@ -7043,10 +7084,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
>          v7m_stack_write(cpu, frameptr + 24, env->regs[15], mmu_idx, false) &&
>          v7m_stack_write(cpu, frameptr + 28, xpsr, mmu_idx, false);
>  
> -    /* Update SP regardless of whether any of the stack accesses failed.
> -     * When we implement v8M stack limit checking then this attempt to
> -     * update SP might also fail and result in a derived exception.
> -     */
> +    /* Update SP regardless of whether any of the stack accesses failed. */
>      env->regs[13] = frameptr;
>  
>      return !stacked_ok;
> 
