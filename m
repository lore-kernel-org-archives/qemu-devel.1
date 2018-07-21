Received: from eggs.gnu.org ([2001:4830:134:3::10]:34096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fgxs2-0006zr-Nl
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 15:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fgxry-0005Dm-3W
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 15:48:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180720145647.8810-1-peter.maydell@linaro.org>
	<20180720145647.8810-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e72f48c0-2335-42f1-87d7-d7635e5f109f@amsat.org>
Date: Sat, 21 Jul 2018 16:48:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180720145647.8810-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/4] target/arm: Initialize
 exc_secure correctly in do_v7m_exception_exit()
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

On 07/20/2018 11:56 AM, Peter Maydell wrote:
> In do_v7m_exception_exit(), we use the exc_secure variable to track
> whether the exception we're returning from is secure or non-secure.
> Unfortunately the statement initializing this was accidentally
> inside an "if (env->v7m.exception != ARMV7M_EXCP_NMI)" conditional,
> which meant that we were using the wrong value for NMI handlers.
> Move the initialization out to the right place.

Oops

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3ec6114599b..efcadfc7fa9 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7052,6 +7052,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>              /* For all other purposes, treat ES as 0 (R_HXSR) */
>              excret &= ~R_V7M_EXCRET_ES_MASK;
>          }
> +        exc_secure = excret & R_V7M_EXCRET_ES_MASK;
>      }
>  
>      if (env->v7m.exception != ARMV7M_EXCP_NMI) {
> @@ -7062,7 +7063,6 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>           * which security state's faultmask to clear. (v8M ARM ARM R_KBNF.)
>           */
>          if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
> -            exc_secure = excret & R_V7M_EXCRET_ES_MASK;
>              if (armv7m_nvic_raw_execution_priority(env->nvic) >= 0) {
>                  env->v7m.faultmask[exc_secure] = 0;
>              }
> 
