Received: from eggs.gnu.org ([209.51.188.92]:36447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyhjH-0002Vc-OY
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyhjB-00026Z-8H
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:45:21 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyhj4-0001jV-Rz
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:45:11 -0500
Received: by mail-oi1-x241.google.com with SMTP id t82so11172639oie.12
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20190220235017.1060-1-richard.henderson@linaro.org>
	<20190220235017.1060-3-richard.henderson@linaro.org>
In-Reply-To: <20190220235017.1060-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 18:44:43 +0000
Message-ID: <CAFEAcA_e4aGCi=uYe-Jy5GG7-VuxbRMagiTqT_mfFBS3c4SCpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Implement ARMv8.0-PredRes
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

On Wed, 20 Feb 2019 at 23:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is named "Execution and Data prediction restriction instructions"
> within the ARMv8.5 manual, and given the name "PredRes" by binutils.

The official name is v8.0-PredInv.
(You can see this used in the xml descriptions for the new insns, eg:
https://developer.arm.com/docs/ddi0595/b/aarch64-system-instructions/cfp-rctx )


>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 11 ++++++++++
>  target/arm/cpu.c    |  1 +
>  target/arm/cpu64.c  |  2 ++
>  target/arm/helper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 76d6a73c0e..202ff1f1ea 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1074,6 +1074,7 @@ void pmu_init(ARMCPU *cpu);
>  #define SCTLR_UMA     (1U << 9) /* v8 onward, AArch64 only */
>  #define SCTLR_F       (1U << 10) /* up to v6 */
>  #define SCTLR_SW      (1U << 10) /* v7, RES0 in v8 */
> +#define SCTLR_EnRCTX  (1U << 10) /* in v8.0-specres */

You should delete the "RES0 in v8" from the preceding comment
(and update the feature name to v8.0-PredInv).

>  #define SCTLR_Z       (1U << 11) /* in v7, RES1 in v8 */
>  #define SCTLR_EOS     (1U << 11) /* v8.5-ExS */
>  #define SCTLR_I       (1U << 12)

> +
> +    /* All v8.0-a cpus support aarch64.  */

True, but why is it relevant here ?

> +    if (cpu_isar_feature(aa64_specres, cpu)) {
> +        define_arm_cp_regs(cpu, specres_reginfo);
> +    }
>  }
>
>  void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
> --
> 2.17.2

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
