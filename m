Received: from eggs.gnu.org ([2001:4830:134:3::10]:49965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Tp-0007kM-1e
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Tl-0008FT-4L
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:47:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-13-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c3b0faa1-f05d-7240-c5e7-02e143758a9e@amsat.org>
Date: Wed, 2 Aug 2017 18:46:53 -0300
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-13-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 12/15] target/arm: Don't
 calculate lr in arm_v7m_cpu_do_interrupt() until needed
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

On 08/02/2017 01:43 PM, Peter Maydell wrote:
> Move the code in arm_v7m_cpu_do_interrupt() that calculates the
> magic LR value down to when we're actually going to use it.
> Having the calculation and use so far apart makes the code
> a little harder to understand than it needs to be.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/arm/helper.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b64ddb1..0ecc8f1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6311,13 +6311,6 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>   
>       arm_log_exception(cs->exception_index);
>   
> -    lr = 0xfffffff1;
> -    if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
> -        lr |= 4;
> -    }
> -    if (env->v7m.exception == 0)
> -        lr |= 8;
> -
>       /* For exceptions we just mark as pending on the NVIC, and let that
>          handle it.  */
>       switch (cs->exception_index) {
> @@ -6408,6 +6401,14 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>           return; /* Never happens.  Keep compiler happy.  */
>       }
>   
> +    lr = 0xfffffff1;
> +    if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
> +        lr |= 4;
> +    }
> +    if (env->v7m.exception == 0) {
> +        lr |= 8;
> +    }
> +
>       v7m_push_stack(cpu);
>       v7m_exception_taken(cpu, lr);
>       qemu_log_mask(CPU_LOG_INT, "... as %d\n", env->v7m.exception);
> 
