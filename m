Received: from eggs.gnu.org ([208.118.235.92]:35390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1fucEz-000835-M4
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 07:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1fuc5U-0006ML-CS
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 07:23:10 -0400
References: <1535402777-46620-1-git-send-email-gengdongjiu@huawei.com>
	<1535402777-46620-3-git-send-email-gengdongjiu@huawei.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <c2e71ef7-5e5e-873c-0ec3-b36a257256c3@gmail.com>
Date: Tue, 28 Aug 2018 19:22:43 +0800
MIME-Version: 1.0
In-Reply-To: <1535402777-46620-3-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v7 2/2] target: arm: Add support
 for VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi,

On 8/28/2018 4:46 AM, Dongjiu Geng wrote:
> This patch extends the qemu-kvm state sync logic with support for
> KVM_GET/SET_VCPU_EVENTS, giving access to yet missing SError exception.
> And also it can support the exception state migration.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> change since v6:
> 1. Add cover letter
> 2. Change name "cpu/ras" to "cpu/serror"
> 3. Add some comments and check the ioctl return value for kvm_put_vcpu_events()
> 
> Change since v5:
> address Peter's comments:
> 1. Move the "struct serror" before the "end_reset_fields" in CPUARMState
> 2. Remove ARM_FEATURE_RAS_EXT and add a variable have_inject_serror_esr
> 3. Use the variable have_inject_serror_esr to track whether the kernel has state we need to migrate
> 4. Remove printf() in kvm_arch_put_registers()
> 5. ras_needed/vmstate_ras to serror_needed/vmstate_serror
> 6. Check to use "return env.serror.pending != 0" instead of "arm_feature(env, ARM_FEATURE_RAS_EXT)" in the ras_needed()
> 
> Change since v4:
> 1. Rebase the code to latest
> 
> Change since v3:
> 1. Add a new new subsection with a suitable 'ras_needed' function
>     controlling whether it is present
> 2. Add a ARM_FEATURE_RAS feature bit for CPUARMState
> ---
>   target/arm/cpu.h     |  7 ++++++
>   target/arm/kvm64.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   target/arm/machine.c | 22 +++++++++++++++++
>   3 files changed, 97 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 62c36b4..7030680 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -530,6 +530,13 @@ typedef struct CPUARMState {
>            */
>       } exception;
>   
> +    /* Information associated with an SError */
> +    struct {
> +        uint32_t pending;
> +        uint32_t has_esr;
why use uint32_t for a bool parameter here while it's u8 in the kernel 
header?

> +        uint64_t esr;
> +    } serror;
> +
>       /* Thumb-2 EE state.  */
>       uint32_t teecr;
>       uint32_t teehbr;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index e0b8246..6e0252c 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -29,6 +29,7 @@
>   #include "hw/arm/arm.h"
>   
>   static bool have_guest_debug;
> +static bool have_inject_serror_esr;
>   
>   /*
>    * Although the ARM implementation of hardware assisted debugging
> @@ -546,6 +547,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>   
>       kvm_arm_init_debug(cs);
>   
> +    /* Check whether userspace can specify guest syndrome value */
> +    have_inject_serror_esr = kvm_check_extension(cs->kvm_state,
> +                                                 KVM_CAP_ARM_INJECT_SERROR_ESR);
> +
>       return kvm_arm_init_cpreg_list(cpu);
>   }
>   
> @@ -600,6 +605,59 @@ int kvm_arm_cpreg_level(uint64_t regidx)
>   #define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
>                    KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>   
> +static int kvm_put_vcpu_events(ARMCPU *cpu)
> +{
> +    CPUARMState *env = &cpu->env;
> +    struct kvm_vcpu_events events = {};
> +    int ret;
> +
> +    if (!kvm_has_vcpu_events()) {
> +        return 0;
> +    }
> +
> +    memset(&events, 0, sizeof(events));
> +    events.exception.serror_pending = env->serror.pending;
> +
> +    /* Inject SError to guest with specified syndrome if host kernel
> +     * supports it, otherwise inject SError without syndrome.
> +     */
> +    if (have_inject_serror_esr) {
> +        events.exception.serror_has_esr = env->serror.has_esr;
> +        events.exception.serror_esr = env->serror.esr;
> +    }
> +
> +    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
> +    if (ret) {
> +        error_report("failed to put vcpu events");
> +    }
> +
> +    return ret;
> +}
> +
> +static int kvm_get_vcpu_events(ARMCPU *cpu)
> +{
> +    CPUARMState *env = &cpu->env;
> +    struct kvm_vcpu_events events;
> +    int ret;
> +
> +    if (!kvm_has_vcpu_events()) {
> +        return 0;
> +    }
> +
> +    memset(&events, 0, sizeof(events));
> +    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_VCPU_EVENTS, &events);
> +
> +    if (ret < 0) {
like the put function, it's better to add a error_report here.

Thanks,
Shannon
> +        return ret;
> +    }
> +
> +    env->serror.pending = events.exception.serror_pending;
> +    env->serror.has_esr = events.exception.serror_has_esr;
> +    env->serror.esr = events.exception.serror_esr;
> +
> +    return 0;
> +}
> +
>   int kvm_arch_put_registers(CPUState *cs, int level)
>   {
>       struct kvm_one_reg reg;
> @@ -727,6 +785,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>           return ret;
>       }
>   
> +    ret = kvm_put_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +
>       if (!write_list_to_kvmstate(cpu, level)) {
>           return EINVAL;
>       }
> @@ -863,6 +926,11 @@ int kvm_arch_get_registers(CPUState *cs)
>       }
>       vfp_set_fpcr(env, fpr);
>   
> +    ret = kvm_get_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +
>       if (!write_kvmstate_to_list(cpu)) {
>           return EINVAL;
>       }
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index ff4ec22..d6dadf1 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -172,6 +172,27 @@ static const VMStateDescription vmstate_sve = {
>   };
>   #endif /* AARCH64 */
>   
> +static bool serror_needed(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    CPUARMState *env = &cpu->env;
> +
> +    return env->serror.pending != 0;
> +}
> +
> +static const VMStateDescription vmstate_serror = {
> +    .name = "cpu/serror",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = serror_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(env.serror.pending, ARMCPU),
> +        VMSTATE_UINT32(env.serror.has_esr, ARMCPU),
> +        VMSTATE_UINT64(env.serror.esr, ARMCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static bool m_needed(void *opaque)
>   {
>       ARMCPU *cpu = opaque;
> @@ -726,6 +747,7 @@ const VMStateDescription vmstate_arm_cpu = {
>   #ifdef TARGET_AARCH64
>           &vmstate_sve,
>   #endif
> +        &vmstate_serror,
>           NULL
>       }
>   };
> 
