Received: from eggs.gnu.org ([2001:4830:134:3::10]:44930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvVj-0002eW-RD
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvVh-0002ow-0I
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:23:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180320134114.30418-1-peter.maydell@linaro.org>
	<20180320134114.30418-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a1381141-9f62-7305-aa8c-424d190c446f@amsat.org>
Date: Thu, 22 Mar 2018 05:23:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180320134114.30418-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12 3/4] target/arm: Set
 FSR for BKPT, BRK when raising exception
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

On 03/20/2018 10:41 AM, Peter Maydell wrote:
> Now that we have a helper function specifically for the BRK and
> BKPT instructions, we can set the exception.fsr there rather
> than in arm_cpu_do_interrupt_aarch32(). This allows us to
> use our new arm_debug_exception_fsr() helper.
> 
> In particular this fixes a bug where we were hardcoding the
> short-form IFSR value, which is wrong if the target exception
> level has LPAE enabled.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1756927
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c    | 1 -
>  target/arm/op_helper.c | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 09893e3f72..dcb8476d9e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7910,7 +7910,6 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
>          offset = 0;
>          break;
>      case EXCP_BKPT:
> -        env->exception.fsr = 2;
>          /* Fall through to prefetch abort.  */
>      case EXCP_PREFETCH_ABORT:
>          A32_BANKED_CURRENT_REG_SET(env, ifsr, env->exception.fsr);
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 75efff9edf..8e1e521193 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -488,6 +488,8 @@ void HELPER(exception_with_syndrome)(CPUARMState *env, uint32_t excp,
>   */
>  void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
>  {
> +    /* FSR will only be used if the debug target EL is AArch32. */
> +    env->exception.fsr = arm_debug_exception_fsr(env);
>      raise_exception(env, EXCP_BKPT, syndrome, arm_debug_target_el(env));
>  }
>  
> 
