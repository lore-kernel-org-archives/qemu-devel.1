Received: from eggs.gnu.org ([2001:4830:134:3::10]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSxXU-0000HK-LI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 23:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSxXP-0007Zw-OR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 23:33:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1498820791-8130-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dcf0bab4-8bf1-a21f-c4b6-05ac081d37f7@amsat.org>
Date: Thu, 6 Jul 2017 00:33:03 -0300
MIME-Version: 1.0
In-Reply-To: <1498820791-8130-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target-arm: v7M: ignore writes
 to CONTROL.SPSEL from Thread mode
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

Hi Peter,

On 06/30/2017 08:06 AM, Peter Maydell wrote:
> For v7M, writes to the CONTROL register are only permitted for
> privileged code. However even if the code is privileged, the
> write must not affect the SPSEL bit in the CONTROL register
> if the CPU is in Thread mode (as documented in the pseudocode
> for the MSR instruction). Implement this, instead of permitting
> SPSEL to be written in all cases.
> 
> This was causing mbed applications not to run, because the
> RTX RTOS they use relies on this behaviour.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org> > ---
>   target/arm/helper.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2594faa..4ed32c5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8768,9 +8768,16 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>           }
>           break;
>       case 20: /* CONTROL */
> -        switch_v7m_sp(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
> -        env->v7m.control = val & (R_V7M_CONTROL_SPSEL_MASK |
> -                                  R_V7M_CONTROL_NPRIV_MASK);
> +        /* Writing to the SPSEL bit only has an effect if we are in
> +         * thread mode; other bits can be updated by any privileged code.
> +         * switch_v7m_sp() deals with updating the SPSEL bit in
> +         * env->v7m.control, so we only need update the others.
> +         */

I'v been thinking about adding some function like v7m_is_privileged() 
v7m_is_thread_mode() !v7m_exception_pending() to ease code readability, 
like armv7m_nvic_can_take_pending_exception() or is_singlestepping().
Not much inspired yet :(

> +        if (env->v7m.exception == 0) {
> +            switch_v7m_sp(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
> +        }
> +        env->v7m.control &= ~R_V7M_CONTROL_NPRIV_MASK;
> +        env->v7m.control |= val & R_V7M_CONTROL_NPRIV_MASK;
>           break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown special"
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
