Received: from eggs.gnu.org ([2001:4830:134:3::10]:41853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffPjO-0002If-5e
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffPjN-00062z-6V
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:09:30 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffPjN-00061X-07
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:09:29 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so1893584ois.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 06:09:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180713103059.12539-1-jusual@mail.ru>
References: <20180713103059.12539-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 14:09:07 +0100
Message-ID: <CAFEAcA9zzSu86Ra3Cgs_V8NYnC+vYCujE5vBkqtnX6AWFk-+LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm: Add ARMv6-M programmer's model support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 13 July 2018 at 11:30, Julia Suvorova <jusual@mail.ru> wrote:
> Forbid stack alignment change. (CCR)
> Reserve FAULTMASK, BASEPRI registers.
> Report any fault as HardFault. Disable MemManage, BusFault and
> UsageFault, so they always escalated to HardFault. (SHCSR)
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> This is the last cortex-m0 patch.
>
>  hw/intc/armv7m_nvic.c | 10 ++++++++++
>  target/arm/cpu.c      | 10 ++++++++++
>  target/arm/helper.c   | 13 +++++++++++--
>  3 files changed, 31 insertions(+), 2 deletions(-)

Most of this looks good; I have some comments on the reset value of CCR.

> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a914ce4e8c..3788cb773d 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -220,6 +220,11 @@ static void arm_cpu_reset(CPUState *s)
>              env->v7m.aircr = R_V7M_AIRCR_BFHFNMINS_MASK;
>          }
>
> +        if (!arm_feature(env, ARM_FEATURE_V7)) {
> +            env->v7m.ccr[M_REG_NS] = 0x3f8;
> +            env->v7m.ccr[M_REG_S] = 0x3f8;

This code will have no effect, because just below we already have an
assignment to these fields:
        env->v7m.ccr[M_REG_NS] = R_V7M_CCR_STKALIGN_MASK;
        env->v7m.ccr[M_REG_S] = R_V7M_CCR_STKALIGN_MASK;

> +        }
> +
>          /* In v7M the reset value of this bit is IMPDEF, but ARM recommends
>           * that it resets to 1, so QEMU always does that rather than making
>           * it dependent on CPU model. In v8M it is RES1.
> @@ -230,6 +235,11 @@ static void arm_cpu_reset(CPUState *s)
>              /* in v8M the NONBASETHRDENA bit [0] is RES1 */
>              env->v7m.ccr[M_REG_NS] |= R_V7M_CCR_NONBASETHRDENA_MASK;
>              env->v7m.ccr[M_REG_S] |= R_V7M_CCR_NONBASETHRDENA_MASK;
> +
> +            if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +                env->v7m.ccr[M_REG_NS] |= R_V7M_CCR_UNALIGN_TRP_MASK;
> +                env->v7m.ccr[M_REG_S] |= R_V7M_CCR_UNALIGN_TRP_MASK;
> +            }

This should be outside the "if v8" if(), because you also want it for v6M
(giving you the v6M CCR value of STKALIGN and UNALIGN_TRP set and all
other bits clear).

thanks
-- PMM
