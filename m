Received: from eggs.gnu.org ([2001:4830:134:3::10]:39596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb7rb-0003YP-06
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb7rZ-000582-Mg
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:39:27 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb7rZ-00057i-FI
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:39:25 -0500
Received: by mail-wm0-x234.google.com with SMTP id c85so166093796wmi.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 07:39:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484558821-15512-5-git-send-email-zhaoshenglong@huawei.com>
References: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
	<1484558821-15512-5-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 15:39:03 +0000
Message-ID: <CAFEAcA90zm3gqvNO6QTGcpg2=rYMbC=G0E+p-6ERXf=UXSXe9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] target: arm: Add a generic type cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, wu.wubin@huawei.com

On 16 January 2017 at 09:26, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
>
> Add a generic type cpu, it's useful for migration when running on
> different hardwares.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  target/arm/cpu64.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 549cb1e..223f31e 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -204,6 +204,59 @@ static void aarch64_a53_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
>  }
>
> +static void aarch64_generic_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    cpu->dtb_compatible = "arm,armv8";
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
> +    set_feature(&cpu->env, ARM_FEATURE_EL3);
> +    cpu->kvm_target = QEMU_KVM_ARM_TARGET_GENERIC_V8;
> +    cpu->midr = 0x410fd000; /* FIXME: this needs to adjust */
> +    cpu->revidr = 0x00000000;
> +    cpu->reset_fpsid = 0x41034070;
> +    cpu->mvfr0 = 0x10110222;
> +    cpu->mvfr1 = 0x12111111;
> +    cpu->mvfr2 = 0x00000043;
> +    cpu->ctr = 0x84448004; /* L1Ip = VIPT */
> +    cpu->reset_sctlr = 0x00c50838;
> +    cpu->id_pfr0 = 0x00000131;
> +    cpu->id_pfr1 = 0x00011011;
> +    cpu->id_dfr0 = 0x03010066;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->id_mmfr0 = 0x10101105;
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
> +    cpu->id_aa64isar0 = 0x00011120;
> +    cpu->id_aa64mmfr0 = 0x0f001101; /* only support 4k page, 36 bit physical addr */

Not 64K as well? That seems rather limiting.

> +    cpu->dbgdidr = 0x3516d000;
> +    cpu->clidr = 0x0a200023;
> +    cpu->ccsidr[0] = 0x7003e01a; /* 8KB L1 dcache */
> +    cpu->ccsidr[1] = 0x2007e00a; /* 8KB L1 icache */
> +    cpu->ccsidr[2] = 0x700fe07a; /* 128KB L2 cache */
> +    cpu->dcz_blocksize = 4; /* 64 bytes */
> +    define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
> +}

What's the general principle behind the values we're using
here for the various ID and feature registers?

thanks
-- PMM
