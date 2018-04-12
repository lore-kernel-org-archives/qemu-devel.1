Received: from eggs.gnu.org ([2001:4830:134:3::10]:41051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6g2v-0005vD-3u
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6g2u-00007N-6N
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:30:05 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6g2u-00006m-1j
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:30:04 -0400
Received: by mail-oi0-x244.google.com with SMTP id c3-v6so5926480oib.5
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 10:30:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-18-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-18-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 18:29:43 +0100
Message-ID: <CAFEAcA_ouvraVWU+JvfrWhYcoU_sdGMDmBnH8hFThOhDvBr3BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 17/22] target/arm: Split
 arm_ccnt_enabled into generic pmu_counter_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f5e800e..2073d56 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1009,17 +1009,22 @@ static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
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

We only use arm_ccnt_enabled() in a couple of places, so
I would just make those callsites use pmu_counter_enabled(env, 31)
directly.

thanks
-- PMM
