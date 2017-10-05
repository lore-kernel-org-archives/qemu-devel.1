Received: from eggs.gnu.org ([2001:4830:134:3::10]:38658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08dn-0002ol-KH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08dj-0001ef-Jh
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:04:51 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:49917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e08dj-0001e3-Fb
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:04:47 -0400
Received: by mail-qt0-x233.google.com with SMTP id o3so26313388qte.6
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:04:47 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0b514b4-6474-87ed-6fa0-c109761d243c@linaro.org>
Date: Thu, 5 Oct 2017 12:04:43 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/20] target/arm: Don't switch to target
 stack early in v7M exception return
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

On 09/22/2017 10:59 AM, Peter Maydell wrote:
> Currently our M profile exception return code switches to the
> target stack pointer relatively early in the process, before
> it tries to pop the exception frame off the stack. This is
> awkward for v8M for two reasons:
>  * in v8M the process vs main stack pointer is not selected
>    purely by the value of CONTROL.SPSEL, so updating SPSEL
>    and relying on that to switch to the right stack pointer
>    won't work
>  * the stack we should be reading the stack frame from and
>    the stack we will eventually switch to might not be the
>    same if the guest is doing strange things
> 
> Change our exception return code to use a 'frame pointer'
> to read the exception frame rather than assuming that we
> can switch the live stack pointer this early.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 127 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 95 insertions(+), 32 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8be78ea..f13b99d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6040,16 +6040,6 @@ static void v7m_push(CPUARMState *env, uint32_t val)
>      stl_phys(cs->as, env->regs[13], val);
>  }
>  
> -static uint32_t v7m_pop(CPUARMState *env)
> -{
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> -    uint32_t val;
> -
> -    val = ldl_phys(cs->as, env->regs[13]);
> -    env->regs[13] += 4;
> -    return val;
> -}
> -
>  /* Return true if we're using the process stack pointer (not the MSP) */
>  static bool v7m_using_psp(CPUARMState *env)
>  {
> @@ -6141,6 +6131,40 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
>      env->regs[15] = dest & ~1;
>  }
>  
> +static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
> +                                bool spsel)
> +{
> +    /* Return a pointer to the location where we currently store the
> +     * stack pointer for the requested security state and thread mode.
> +     * This pointer will become invalid if the CPU state is updated
> +     * such that the stack pointers are switched around (eg changing
> +     * the SPSEL control bit).
> +     * Compare the v8M ARM ARM pseudocode LookUpSP_with_security_mode().
> +     * Unlike that pseudocode, we require the caller to pass us in the
> +     * SPSEL control bit value; this is because we also use this
> +     * function in handling of pushing of the callee-saves registers
> +     * part of the v8M stack frame, and in that case the SPSEL bit
> +     * comes from the exception return magic LR value.

Exception return magic lr value does not appear to match "pushing".  Did you
mean "poping" here?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
