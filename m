Received: from eggs.gnu.org ([2001:4830:134:3::10]:56471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9VJE-0005gU-DM
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9VJD-0001ku-Eh
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:10:52 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9VJD-0001iv-4Z
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:10:51 -0400
Received: by mail-ot1-x341.google.com with SMTP id l1so6214452otj.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 06:10:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-11-git-send-email-edgar.iglesias@gmail.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-11-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 14:10:29 +0100
Message-ID: <CAFEAcA9b4O4HrMwNTgbZ7JYdO=S3dnzC8ayabBEpKY5=DyBMog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 10/12] target/arm: Add the Cortex-A72
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add the ARM Cortex-A72.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/arm/cpu64.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 800bff7..02e500b 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -218,6 +218,64 @@ static void aarch64_a53_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
>  }
>
> +static void aarch64_a72_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    cpu->dtb_compatible = "arm,cortex-a72";
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> +    set_feature(&cpu->env, ARM_FEATURE_NEON);
> +    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> +    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> +    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_AES);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
> +    set_feature(&cpu->env, ARM_FEATURE_CRC);
> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
> +    set_feature(&cpu->env, ARM_FEATURE_EL3);

No ARM_FEATURE_PMU ?

> +    cpu->midr = 0x410fd083;
> +    cpu->revidr = 0x00000000;
> +    cpu->reset_fpsid = 0x41034080;
> +    cpu->mvfr0 = 0x10110222;
> +    cpu->mvfr1 = 0x12111111;
> +    cpu->mvfr2 = 0x00000043;
> +    cpu->ctr = 0x8444c004;
> +    cpu->reset_sctlr = 0x00c50838;

Do you happen to have the hardware to hand to check what the
top 4 bits of the reset value of SCTLR_ELx are? I think they
should be 0x3 -- the Arm ARM says that [29:28] are RES1 (as
does the A72 TRM, though its top level summary table lists
0x00c50838 as the reset value for some of the SCTLR_ELx.)

QEMU may have the wrong value for A53/A57 here too, I suspect.

> +    cpu->id_pfr0 = 0x00000131;
> +    cpu->id_pfr1 = 0x00011011;
> +    cpu->id_dfr0 = 0x03010066;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->id_mmfr0 = 0x10201105;
> +    cpu->id_mmfr1 = 0x40000000;
> +    cpu->id_mmfr2 = 0x01260000;
> +    cpu->id_mmfr3 = 0x02102211;
> +    cpu->id_isar0 = 0x02101110;
> +    cpu->id_isar1 = 0x13112111;
> +    cpu->id_isar2 = 0x21232042;
> +    cpu->id_isar3 = 0x01112131;
> +    cpu->id_isar4 = 0x00011142;
> +    cpu->id_isar5 = 0x00011121;
> +    cpu->id_aa64pfr0 = 0x00002222;
> +    cpu->id_aa64dfr0 = 0x10305106;
> +    cpu->pmceid0 = 0x00000000;
> +    cpu->pmceid1 = 0x00000000;
> +    cpu->id_aa64isar0 = 0x00011120;
> +    cpu->id_aa64mmfr0 = 0x00001124;
> +    cpu->dbgdidr = 0x3516d000;
> +    cpu->clidr = 0x0a200023;
> +    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
> +    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
> +    cpu->ccsidr[2] = 0x707fe07a; /* 1MB L2 cache */
> +    cpu->dcz_blocksize = 4; /* 64 bytes */
> +    cpu->gic_num_lrs = 4;
> +    cpu->gic_vpribits = 5;
> +    cpu->gic_vprebits = 5;
> +    define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);

The impdef registers do seem to be basically the same as
the A53/A57. The function name is now a bit inaccurate,
though, but I don't have a good idea for a better name.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
