Received: from eggs.gnu.org ([2001:4830:134:3::10]:48840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpHcy-000085-JG
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpHct-0002ht-OU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:27:08 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpHct-0002ha-Gm
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:27:03 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f199so1899277wme.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:27:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503066227-18251-5-git-send-email-gengdongjiu@huawei.com>
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-5-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 18:26:41 +0100
Message-ID: <CAFEAcA9oecuzXXrdo3zZHxF3AgrDUh_NHxz-znto4GU+OoxVFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 4/6] target-arm: kvm64: detect guest
 RAS EXTENSION feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ingo Molnar <mingo@kernel.org>, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, arm-mail-list <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com, Huangshaoyu <huangshaoyu@huawei.com>, wuquanming <wuquanming@huawei.com>, Linuxarm <linuxarm@huawei.com>, zhengqiang10@huawei.com

On 18 August 2017 at 15:23, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> check if kvm supports guest RAS EXTENSION. if so, set
> corresponding feature bit for vcpu.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  linux-headers/linux/kvm.h | 1 +
>  target/arm/cpu.h          | 3 +++
>  target/arm/kvm64.c        | 8 ++++++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 7971a4f..2aa176e 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -929,6 +929,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PPC_SMT_POSSIBLE 147
>  #define KVM_CAP_HYPERV_SYNIC2 148
>  #define KVM_CAP_HYPERV_VP_INDEX 149
> +#define KVM_CAP_ARM_RAS_EXTENSION 150
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>

Hi. Changes to linux-headers need to be done as a patch of their
own created using scripts/update-linux-headers.sh run against a
mainline kernel tree (and with a commit message that quotes the
kernel commit hash used). This ensures that we have a consistent
set of headers that don't diverge from the kernel copy.

> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index b39d64a..6b0961b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -611,6 +611,8 @@ struct ARMCPU {
>
>      /* CPU has memory protection unit */
>      bool has_mpu;
> +    /* CPU has ras extension unit */
> +    bool has_ras_extension;
>      /* PMSAv7 MPU number of supported regions */
>      uint32_t pmsav7_dregion;
>
> @@ -1229,6 +1231,7 @@ enum arm_features {
>      ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
>      ARM_FEATURE_PMU, /* has PMU support */
>      ARM_FEATURE_VBAR, /* has cp15 VBAR */
> +    ARM_FEATURE_RAS_EXTENSION, /*has RAS extension support */

Missing space after '/*' ?

>  };
>
>  static inline int arm_feature(CPUARMState *env, int feature)
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index a16abc8..0781367 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -518,6 +518,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          unset_feature(&env->features, ARM_FEATURE_PMU);
>      }
>
> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_RAS_EXTENSION)) {
> +        cpu->has_ras_extension = true;
> +        set_feature(&env->features, ARM_FEATURE_RAS_EXTENSION);
> +    } else {
> +        cpu->has_ras_extension = false;
> +        unset_feature(&env->features, ARM_FEATURE_RAS_EXTENSION);
> +    }
> +

Shouldn't we need to also tell the kernel that we actually want
it to expose RAS to the guest? Compare the PMU code in this
function, where we set a kvm_init_features bit to do this.
(This suggests that your ABI for the kernel part of this feature
may not be correct?)

You should also not be calling set_feature() here -- if the
CPU features bit doesn't say "this CPU should have the RAS
extensions" we shouldn't create a CPU with them. Instead
you should set it in kvm_arm_get_host_cpu_features() (again,
compare the PMU code).

thanks
-- PMM
