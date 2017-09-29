Received: from eggs.gnu.org ([2001:4830:134:3::10]:56901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy2TS-0003cZ-4X
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy2TP-0002Gt-0k
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:05:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-8-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1b0c978f-2cf1-da68-3ee9-4282a0cb93cc@amsat.org>
Date: Fri, 29 Sep 2017 18:05:25 -0300
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 07/20] target/arm: Warn about
 restoring to unaligned stack
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
> Attempting to do an exception return with an exception frame that
> is not 8-aligned is UNPREDICTABLE in v8M; warn about this.
> (It is not UNPREDICTABLE in v7M, and our implementation can
> handle the merely-4-aligned case fine, so we don't need to
> do anything except warn.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/arm/helper.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a2e46fb..979129e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6403,6 +6403,13 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>                                                 return_to_sp_process);
>           uint32_t frameptr = *frame_sp_p;
>   
> +        if (!QEMU_IS_ALIGNED(frameptr, 8) &&
> +            arm_feature(env, ARM_FEATURE_V8)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "M profile exception return with non-8-aligned SP "
> +                          "for destination state is UNPREDICTABLE\n");
> +        }
> +
>           /* Pop registers. TODO: make these accesses use the correct
>            * attributes and address space (S/NS, priv/unpriv) and handle
>            * memory transaction failures.
> 
