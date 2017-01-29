Received: from eggs.gnu.org ([2001:4830:134:3::10]:37111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cXo9N-0000hc-Rl
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 07:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cXo9N-00057c-0s
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 07:00:05 -0500
Date: Sun, 29 Jan 2017 12:59:55 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170129115955.kz2o3r6nuitg6o6i@hawk.localdomain>
References: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
	<1484558821-15512-5-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484558821-15512-5-git-send-email-zhaoshenglong@huawei.com>
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
Cc: qemu-arm@nongnu.org, wei@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, wu.wubin@huawei.com, kvmarm@lists.cs.columbia.edu, christoffer.dall@linaro.org

On Mon, Jan 16, 2017 at 05:26:59PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a generic type cpu, it's useful for migration when running on
> different hardwares.

How are the cpu parameters and features chosen for this generic
version? Shouldn't some of them, like id_aa64mmfr0, be configurable?
Or do we want to create multiple generic flavors?

Thanks,
drew

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
> +    cpu->dbgdidr = 0x3516d000;
> +    cpu->clidr = 0x0a200023;
> +    cpu->ccsidr[0] = 0x7003e01a; /* 8KB L1 dcache */
> +    cpu->ccsidr[1] = 0x2007e00a; /* 8KB L1 icache */
> +    cpu->ccsidr[2] = 0x700fe07a; /* 128KB L2 cache */
> +    cpu->dcz_blocksize = 4; /* 64 bytes */
> +    define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
> +}
> +
>  #ifdef CONFIG_USER_ONLY
>  static void aarch64_any_initfn(Object *obj)
>  {
> @@ -232,6 +285,7 @@ typedef struct ARMCPUInfo {
>  static const ARMCPUInfo aarch64_cpus[] = {
>      { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
>      { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
> +    { .name = "generic",            .initfn = aarch64_generic_initfn },
>  #ifdef CONFIG_USER_ONLY
>      { .name = "any",         .initfn = aarch64_any_initfn },
>  #endif
> -- 
> 2.0.4
> 
> 
> 
