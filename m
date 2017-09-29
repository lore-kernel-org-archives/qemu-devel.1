Received: from eggs.gnu.org ([2001:4830:134:3::10]:57574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy2Vu-0004W1-7G
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy2Vr-00059X-0h
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:08:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-9-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b455f17e-e8e0-fbdc-0f81-2731d5427bbd@amsat.org>
Date: Fri, 29 Sep 2017 18:07:52 -0300
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/20] target/arm: Don't warn about
 exception return with PC low bit set for v8M
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org
List-ID: <qemu-devel.nongnu.org>

On 09/22/2017 11:59 AM, Peter Maydell wrote:
> In the v8M architecture, return from an exception to a PC which
> has bit 0 set is not UNPREDICTABLE; it is defined that bit 0
> is discarded [R_HRJH]. Restrict our complaint about this to v7M.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/arm/helper.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 979129e..59a07d2 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6421,16 +6421,22 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>           env->regs[12] = ldl_phys(cs->as, frameptr + 0x10);
>           env->regs[14] = ldl_phys(cs->as, frameptr + 0x14);
>           env->regs[15] = ldl_phys(cs->as, frameptr + 0x18);
> -        if (env->regs[15] & 1) {
> +
> +        /* Returning from an exception with a PC with bit 0 set is defined
> +         * behaviour on v8M (bit 0 is ignored), but for v7M it was specified
> +         * to be UNPREDICTABLE. In practice actual v7M hardware seems to ignore
> +         * the lsbit, and there are several RTOSes out there which incorrectly
> +         * assume the r15 in the stack frame should be a Thumb-style "lsbit
> +         * indicates ARM/Thumb" value, so ignore the bit on v7M as well, but
> +         * complain about the badly behaved guest.
> +         */
> +        if ((env->regs[15] & 1) && !arm_feature(env, ARM_FEATURE_V8)) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "M profile return from interrupt with misaligned "
> -                          "PC is UNPREDICTABLE\n");
> -            /* Actual hardware seems to ignore the lsbit, and there are several
> -             * RTOSes out there which incorrectly assume the r15 in the stack
> -             * frame should be a Thumb-style "lsbit indicates ARM/Thumb" value.
> -             */
> -            env->regs[15] &= ~1U;
> +                          "PC is UNPREDICTABLE on v7M\n");
>           }
> +        env->regs[15] &= ~1U;
> +
>           xpsr = ldl_phys(cs->as, frameptr + 0x1c);
>   
>           if (arm_feature(env, ARM_FEATURE_V8)) {
> 
