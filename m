Received: from eggs.gnu.org ([2001:4830:134:3::10]:55436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4SUL-0006LS-Is
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4SUF-0004Jx-UJ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:04:57 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:55910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4SUF-0004HV-MX
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:04:51 -0400
Received: by mail-wm0-x229.google.com with SMTP id u138so4231739wmu.4
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 07:04:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506737310-21880-9-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-9-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 15:04:30 +0100
Message-ID: <CAFEAcA8OTNA9J4x0qthH8zK2Ezpd4JrdSQMFirzanzkp3SfxWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/13] target/arm: Split arm_ccnt_enabled
 into generic pmu_counter_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3932ac0..c0ef367 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -975,17 +975,22 @@ static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
>      return pmreg_access(env, ri, isread);
>  }
>
> -static inline bool arm_ccnt_enabled(CPUARMState *env)
> +static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
>  {
>      /* Does not check PMCCFILTR_EL0, which is handled by pmu_counter_filtered */
> -
> -    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
> +    if (!(env->cp15.c9_pmcr & PMCRE) ||
> +            !(env->cp15.c9_pmcnten & (1 << counter))) {
>          return false;
>      }
>
>      return true;
>  }
>
> +static inline bool arm_ccnt_enabled(CPUARMState *env)
> +{
> +    return pmu_counter_enabled(env, 31);
> +}
> +

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
