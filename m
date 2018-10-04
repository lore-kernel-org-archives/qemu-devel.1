Received: from eggs.gnu.org ([2001:4830:134:3::10]:46548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1g83sM-0000nT-Vy
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1g83sJ-0004CZ-Nv
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:41:10 -0400
Date: Thu, 4 Oct 2018 08:40:49 -0500
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181004134049.3sl6unwr42d2pnoi@kamzik.brq.redhat.com>
References: <1538067351-23931-1-git-send-email-gengdongjiu@huawei.com>
	<1538067351-23931-3-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538067351-23931-3-git-send-email-gengdongjiu@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC v11 2/2] target/arm: Add support for
 VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhengxiang9@huawei.com

On Thu, Sep 27, 2018 at 12:55:51PM -0400, Dongjiu Geng wrote:
> This patch extends the qemu-kvm state sync logic with support for
> KVM_GET/SET_VCPU_EVENTS, giving access to yet missing SError exception.
> And also it can support the exception state migration.
> 
> The SError exception states include SError pending state and ESR value,
> the kvm_put/get_vcpu_events() will be called when set or get system
> registers. When do migration, if source machine has SError pending,
> QEMU will do this migration regardless whether the target machine supports
> to specify guest ESR value, because if target machine does not support that,
> it can also inject the SError with zero ESR value.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> Because I do not have arm32 platform, only have arm64 platform,
> so I only test this patch in arm64, if somebody else can test this
> patch, I will very appreciate that.
> 
> How to test this patch:
> 1. Apply this patch to enable 32 bit KVM vcpu events support:
>    https://patchwork.kernel.org/patch/10612479/
> 2. Source machine is pending a SError, that is 'events.exception.serror_pending = 1',
>    then do migration, to see whether target machine will be also pending this SError.
> 
> Change since V10:
> Address Andrew's comments:
> 1. Put kvm_get/put_vcpu_events() into target/arm/kvm.c
> 
> Change since V9:
> address Andrew's comments:
> 1. Remove the '= {}' in kvm_put_vcpu_events()
> 2. Remove a blank line in kvm_get_vcpu_events()
> 3. Add 32 bit KVM supports
> 
> Change since v8:
> 1. Update the commit message
> 
> Change since v7:
> address shannon's comments:
> 1. Change "pending" and "has_esr" from uint32_t to uint8_t for CPUARMState
> 2. Add error_report() in kvm_get_vcpu_events()
> 
> Change since v6:
> address Peter's comments:
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
> ---
>  target/arm/cpu.h     |  7 ++++++
>  target/arm/kvm.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm32.c   | 13 ++++++++++++
>  target/arm/kvm64.c   | 13 ++++++++++++
>  target/arm/kvm_arm.h | 24 +++++++++++++++++++++
>  target/arm/machine.c | 22 +++++++++++++++++++
>  6 files changed, 139 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 65c0fa0..a8454f5 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -530,6 +530,13 @@ typedef struct CPUARMState {
>           */
>      } exception;
>  
> +    /* Information associated with an SError */
> +    struct {
> +        uint8_t pending;
> +        uint8_t has_esr;
> +        uint64_t esr;
> +    } serror;
> +
>      /* Thumb-2 EE state.  */
>      uint32_t teecr;
>      uint32_t teehbr;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 65f867d..c45eb91 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -34,6 +34,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>  };
>  
>  static bool cap_has_mp_state;
> +static bool cap_has_inject_serror_esr;
>  
>  static ARMHostCPUFeatures arm_host_cpu_features;
>  
> @@ -48,6 +49,12 @@ int kvm_arm_vcpu_init(CPUState *cs)
>      return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
>  }
>  
> +void kvm_arm_init_serror_injection(CPUState *cs)
> +{
> +    cap_has_inject_serror_esr = kvm_check_extension(cs->kvm_state,
> +                                    KVM_CAP_ARM_INJECT_SERROR_ESR);
> +}
> +
>  bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>                                        int *fdarray,
>                                        struct kvm_vcpu_init *init)
> @@ -522,6 +529,59 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
>      return 0;
>  }
>  
> +int kvm_put_vcpu_events(ARMCPU *cpu)
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
> +    events.exception.serror_pending = env->serror.pending;
> +
> +    /* Inject SError to guest with specified syndrome if host kernel
> +     * supports it, otherwise inject SError without syndrome.
> +     */
> +    if (cap_has_inject_serror_esr) {
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
> +int kvm_get_vcpu_events(ARMCPU *cpu)
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
> +    if (ret) {
> +        error_report("failed to get vcpu events");
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
>  void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
>  {
>  }
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 4e91c11..0f1e94c 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -217,6 +217,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>      cpu->mp_affinity = mpidr & ARM32_AFFINITY_MASK;
>  
> +    /* Check whether userspace can specify guest syndrome value */
> +    kvm_arm_init_serror_injection(cs);
> +
>      return kvm_arm_init_cpreg_list(cpu);
>  }
>  
> @@ -358,6 +361,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
>  
> +    ret = kvm_put_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      /* Note that we do not call write_cpustate_to_list()
>       * here, so we are only writing the tuple list back to
>       * KVM. This is safe because nothing can change the
> @@ -445,6 +453,11 @@ int kvm_arch_get_registers(CPUState *cs)
>      }
>      vfp_set_fpscr(env, fpscr);
>  
> +    ret = kvm_get_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      if (!write_kvmstate_to_list(cpu)) {
>          return EINVAL;
>      }
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index e0b8246..5411486 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -546,6 +546,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>      kvm_arm_init_debug(cs);
>  
> +    /* Check whether user space can specify guest syndrome value */
> +    kvm_arm_init_serror_injection(cs);
> +
>      return kvm_arm_init_cpreg_list(cpu);
>  }
>  
> @@ -727,6 +730,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
>  
> +    ret = kvm_put_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      if (!write_list_to_kvmstate(cpu, level)) {
>          return EINVAL;
>      }
> @@ -863,6 +871,11 @@ int kvm_arch_get_registers(CPUState *cs)
>      }
>      vfp_set_fpcr(env, fpr);
>  
> +    ret = kvm_get_vcpu_events(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      if (!write_kvmstate_to_list(cpu)) {
>          return EINVAL;
>      }
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 863f205..b9335fa 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -121,6 +121,30 @@ bool write_kvmstate_to_list(ARMCPU *cpu);
>   */
>  void kvm_arm_reset_vcpu(ARMCPU *cpu);
>  
> +/**
> + * kvm_arm_init_serror_injection:
> + * @cs: CPUState
> + *
> + * Check whether KVM can set guest SError syndrome.
> + */
> +void kvm_arm_init_serror_injection(CPUState *cs);
> +
> +/**
> + * kvm_get_vcpu_events:
> + * @cpu: ARMCPU
> + *
> + * Get VCPU related state from kvm.
> + */
> +int kvm_get_vcpu_events(ARMCPU *cpu);
> +
> +/**
> + * kvm_put_vcpu_events:
> + * @cpu: ARMCPU
> + *
> + * Put VCPU related state to kvm.
> + */
> +int kvm_put_vcpu_events(ARMCPU *cpu);
> +
>  #ifdef CONFIG_KVM
>  /**
>   * kvm_arm_create_scratch_host_vcpu:
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index ff4ec22..32bcde0 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -172,6 +172,27 @@ static const VMStateDescription vmstate_sve = {
>  };
>  #endif /* AARCH64 */
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
> +        VMSTATE_UINT8(env.serror.pending, ARMCPU),
> +        VMSTATE_UINT8(env.serror.has_esr, ARMCPU),
> +        VMSTATE_UINT64(env.serror.esr, ARMCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static bool m_needed(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
> @@ -726,6 +747,7 @@ const VMStateDescription vmstate_arm_cpu = {
>  #ifdef TARGET_AARCH64
>          &vmstate_sve,
>  #endif
> +        &vmstate_serror,
>          NULL
>      }
>  };
> -- 
> 2.7.4
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
