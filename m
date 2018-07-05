Received: from eggs.gnu.org ([2001:4830:134:3::10]:60272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb1Zw-0004PV-5j
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb1Zv-0000h6-AV
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:33:36 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb1Zv-0000gD-5K
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:33:35 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so15868608oib.9
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 03:33:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180704203639.29553-1-jusual@mail.ru>
References: <20180704203639.29553-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 11:33:14 +0100
Message-ID: <CAFEAcA_6213s2e+_sDfCRemnVViPQ8ACSS8nRNAYs05a8xhbQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Forbid unprivileged mode for M
 Baseline
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

On 4 July 2018 at 21:36, Julia Suvorova <jusual@mail.ru> wrote:
> MSR handling is the only place where CONTROL.nPRIV is modified.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  target/arm/helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5ee229eb35..83cca554ad 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10781,8 +10781,10 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>              !arm_v7m_is_handler_mode(env)) {
>              write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
>          }
> -        env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
> -        env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
> +        if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +            env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
> +            env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
> +        }
>          break;
>      default:
>      bad_reg:
> --

Could you also guard the similar code in the CONTROL_NS case a
little earlier, in the function, please?

            env->v7m.control[M_REG_NS] &= ~R_V7M_CONTROL_NPRIV_MASK;
            env->v7m.control[M_REG_NS] |= val & R_V7M_CONTROL_NPRIV_MASK;

That won't be executed for v6M but for v8M it matters.

Otherwise I agree this is all we need to do to avoid the guest
incorrectly getting into nonpriviliged mode.

thanks
-- PMM
