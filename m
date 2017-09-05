Received: from eggs.gnu.org ([2001:4830:134:3::10]:56625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpI07-0008AP-Ap
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpI02-0007hn-8G
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:51:03 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:38160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpI01-0007hK-VJ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:50:58 -0400
Received: by mail-wr0-x236.google.com with SMTP id 108so10095298wra.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:50:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503066227-18251-7-git-send-email-gengdongjiu@huawei.com>
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-7-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 18:50:36 +0100
Message-ID: <CAFEAcA9TsQg4EXr4MAM2VbrzB9v5UA1F4o9tOCka=3e4wjbBGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 6/6] target-arm: kvm64: Handle SError
 interrupt for the guest OS
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
> When guest OS happens SError interrupt(SEI), it will trap to host.
> Host firstly calls memory failure to deal with this error and decide
> whether it needs to deliver SIGBUS signal to userspace. The advantage
> that using signal to notify is that it can make the notification method
> is general, non-KVM user can also use it. when userspace gets this
> signal and knows this is SError interrupt, it will translate the
> delivered host VA to PA and record this PA to GHES.
>
> Because ARMv8.2 adds an extension to RAS to allow system software insert
> implicit Error Synchronization Barrier operations to isolate the error and
> allow passes specified syndrome to guest OS, so after record the CPER, user
> space calls IOCTL to pass a specified syndrome to KVM, then switch to guest
> OS, guest OS can use the recorded CPER record and syndrome information to
> do the recovery.
>
> The steps are shown below:
> 1. translate the host VA to guest OS PA and record this error PA to HEST table.
> 2. set specified virtual SError syndrome and pass the value to KVM.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Quanming Wu <wuquanming@huawei.com>
> ---
>  linux-headers/linux/kvm.h |  1 +
>  target/arm/internals.h    |  1 +
>  target/arm/kvm64.c        | 28 ++++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 2aa176e..10dfcab 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1356,6 +1356,7 @@ struct kvm_s390_ucas_mapping {
>  /* Available with KVM_CAP_S390_CMMA_MIGRATION */
>  #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
>  #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
> +#define KVM_ARM_SEI                 _IO(KVMIO,   0xb10)
>
>  #define KVM_DEV_ASSIGN_ENABLE_IOMMU    (1 << 0)
>  #define KVM_DEV_ASSIGN_PCI_2_3         (1 << 1)
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index fc0ad6d..18b1cbc 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -237,6 +237,7 @@ enum arm_exception_class {
>  #define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
>  #define ARM_EL_EC_MASK  ((0x3F) << ARM_EL_EC_SHIFT)
>  #define ARM_EL_FSC_TYPE (0x3C)
> +#define ARM_EL_ISS_MASK ((1 << ARM_EL_IL_SHIFT) - 1)
>
>  #define FSC_SEA         (0x10)
>  #define FSC_SEA_TTW0    (0x14)
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index d3bdab2..b84cb49 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -616,6 +616,22 @@ static int kvm_arm_cpreg_value(ARMCPU *cpu, ptrdiff_t fieldoffset)
>      return -EINVAL;
>  }
>
> +static int kvm_inject_arm_sei(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    unsigned long syndrome = env->exception.vaddress;
> +    /* set virtual SError syndrome */
> +    if (arm_feature(env, ARM_FEATURE_RAS_EXTENSION)) {
> +        syndrome = syndrome & ARM_EL_ISS_MASK;
> +    } else {
> +        syndrome = 0;
> +    }
> +
> +    return  kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_SEI, &syndrome);

This looks odd. If we don't have the RAS extension why do
we need to do anything at all here ?

> +}
> +
>  /* Inject synchronous external abort */
>  static int kvm_inject_arm_sea(CPUState *c)
>  {
> @@ -1007,6 +1023,15 @@ static bool is_abort_sea(unsigned long syndrome)
>      }
>  }
>
> +static bool is_abort_sei(unsigned long syndrome)
> +{
> +    uint8_t ec = ((syndrome & ARM_EL_EC_MASK) >> ARM_EL_EC_SHIFT);

You don't need to bother masking here -- in other places in
QEMU we assume that the EC field is at the top of the word,
so just "syndrome >> ARM_EL_EC_SHIFT" is sufficient.

> +    if ((ec != EC_SERROR))
> +        return false;
> +    else
> +        return true;

scripts/checkpatch.pl should tell you that this if needs braces
(it's good to get in the habit of running it on all patches; it
is not always correct, so judgement is required, but it will flag
up some common mistakes).

In this particular case, you should just
   return ec == EC_SERROR;
though.

> +}
> +
>  void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  {
>      ram_addr_t ram_addr;
> @@ -1024,6 +1049,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>              if (is_abort_sea(env->exception.syndrome)) {
>                  ghes_update_guest(ACPI_HEST_NOTIFY_SEA, paddr);
>                  kvm_inject_arm_sea(c);
> +            } else if (is_abort_sei(env->exception.syndrome)) {
> +                ghes_update_guest(ACPI_HEST_NOTIFY_SEI, paddr);
> +                kvm_inject_arm_sei(c);
>              }
>              return;
>          }
> --
> 1.8.3.1

thanks
-- PMM
