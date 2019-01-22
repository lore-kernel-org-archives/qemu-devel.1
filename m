Received: from eggs.gnu.org ([209.51.188.92]:45236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1nK-0007mB-A2
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1jz-0002UM-CE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:29:44 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1jz-0002P0-3h
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:29:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id i6so18416321oia.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20190110124951.15473-1-richard.henderson@linaro.org>
	<20190110124951.15473-5-richard.henderson@linaro.org>
In-Reply-To: <20190110124951.15473-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 15:59:52 +0000
Message-ID: <CAFEAcA_XQODwYmJGAMte2CJ_Qa5==uoTogUv4U2sTAeE_81QtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Enable TBI for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 10 Jan 2019 at 12:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This has been enabled in the linux kernel since v3.11
> (commit d50240a5f6cea, 2013-09-03,
> "arm64: mm: permit use of tagged pointers at EL0").
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 14bc24a35a..5eff6995ee 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -174,6 +174,12 @@ static void arm_cpu_reset(CPUState *s)
>          env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
>          env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
>          env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
> +        /*
> +         * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
> +         * turning on both here will produce smaller code and otherwise
> +         * make no difference to the user-level emulation.
> +         */
> +        env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);
>  #else
>          /* Reset into the highest available EL */
>          if (arm_feature(env, ARM_FEATURE_EL3)) {
> --
> 2.17.2

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
