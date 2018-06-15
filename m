Received: from eggs.gnu.org ([2001:4830:134:3::10]:53150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTpHL-0006hu-Bx
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTpHH-0007QQ-SQ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:00:39 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:51701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTpHH-0007N6-F7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:00:35 -0400
Received: from player771.ha.ovh.net (unknown [10.109.108.86])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id D8BA4B3BCF
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 16:00:31 +0200 (CEST)
Date: Fri, 15 Jun 2018 16:00:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180615160024.079e7daf@bahia.lan>
In-Reply-To: <20180615122928.9356-1-david@gibson.dropbear.id.au>
References: <20180615122928.9356-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2] target/ppc,
 spapr: Move VPA information to machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru

On Fri, 15 Jun 2018 22:29:28 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> CPUPPCState currently contains a number of fields containing the state of
> the VPA.  The VPA is a PAPR specific concept covering several guest/host
> shared memory areas used to communicate some information with the
> hypervisor.
> 
> As a PAPR concept this is really machine specific information, although it
> is per-cpu, so it doesn't really belong in the core CPU state structure.
> 
> There's also other information that's per-cpu, but platform/machine
> specific.  So create a (void *)machine_data in PowerPCCPU which can be
> used by the machine to locate per-cpu data.  Intialization, lifetime and
> cleanup of machine_data is entirely up to the machine type.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

and

Tested-by: Greg Kurz <groug@kaod.org>

(threads=4 with hotplug, both success and error paths)

And now I'll look into migrating this *new* state.

>  hw/ppc/spapr_cpu_core.c         | 13 ++++++
>  hw/ppc/spapr_hcall.c            | 77 ++++++++++++++++++---------------
>  include/hw/ppc/spapr_cpu_core.h | 11 +++++
>  target/ppc/cpu.h                |  7 +--
>  target/ppc/kvm.c                | 39 +++++++++--------
>  target/ppc/translate_init.inc.c |  8 ----
>  6 files changed, 88 insertions(+), 67 deletions(-)
> 
> Changes in v2:
>  * Move alloc/free of machine_data to spapr_{create,delete}_vcpu()
>    instead of spapr_{,un}realize_vcpu() (fixing a possible leak in the
>    process)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 4f0c168784..f416212ae0 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -28,6 +28,7 @@ static void spapr_cpu_reset(void *opaque)
>      CPUState *cs = CPU(cpu);
>      CPUPPCState *env = &cpu->env;
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
>      target_ulong lpcr;
>  
>      cpu_reset(cs);
> @@ -69,6 +70,12 @@ static void spapr_cpu_reset(void *opaque)
>  
>      /* Set a full AMOR so guest can use the AMR as it sees fit */
>      env->spr[SPR_AMOR] = 0xffffffffffffffffull;
> +
> +    spapr_cpu->vpa_addr = 0;
> +    spapr_cpu->slb_shadow_addr = 0;
> +    spapr_cpu->slb_shadow_size = 0;
> +    spapr_cpu->dtl_addr = 0;
> +    spapr_cpu->dtl_size = 0;
>  }
>  
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
> @@ -186,6 +193,8 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
>          goto err;
>      }
>  
> +    cpu->machine_data = g_new0(sPAPRCPUState, 1);
> +
>      object_unref(obj);
>      return cpu;
>  
> @@ -197,6 +206,10 @@ err:
>  
>  static void spapr_delete_vcpu(PowerPCCPU *cpu)
>  {
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    cpu->machine_data = NULL;
> +    g_free(spapr_cpu);
>      object_unparent(OBJECT(cpu));
>  }
>  
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8b9a4b577f..ae913d070f 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -8,6 +8,7 @@
>  #include "exec/exec-all.h"
>  #include "helper_regs.h"
>  #include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_cpu_core.h"
>  #include "mmu-hash64.h"
>  #include "cpu-models.h"
>  #include "trace.h"
> @@ -908,9 +909,11 @@ unmap_out:
>  #define VPA_SHARED_PROC_OFFSET 0x9
>  #define VPA_SHARED_PROC_VAL    0x2
>  
> -static target_ulong register_vpa(CPUPPCState *env, target_ulong vpa)
> +static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = CPU(cpu);
> +    CPUPPCState *env = &cpu->env;
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
>      uint16_t size;
>      uint8_t tmp;
>  
> @@ -935,32 +938,34 @@ static target_ulong register_vpa(CPUPPCState *env, target_ulong vpa)
>          return H_PARAMETER;
>      }
>  
> -    env->vpa_addr = vpa;
> +    spapr_cpu->vpa_addr = vpa;
>  
> -    tmp = ldub_phys(cs->as, env->vpa_addr + VPA_SHARED_PROC_OFFSET);
> +    tmp = ldub_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET);
>      tmp |= VPA_SHARED_PROC_VAL;
> -    stb_phys(cs->as, env->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
> +    stb_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
>  
>      return H_SUCCESS;
>  }
>  
> -static target_ulong deregister_vpa(CPUPPCState *env, target_ulong vpa)
> +static target_ulong deregister_vpa(PowerPCCPU *cpu, target_ulong vpa)
>  {
> -    if (env->slb_shadow_addr) {
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    if (spapr_cpu->slb_shadow_addr) {
>          return H_RESOURCE;
>      }
>  
> -    if (env->dtl_addr) {
> +    if (spapr_cpu->dtl_addr) {
>          return H_RESOURCE;
>      }
>  
> -    env->vpa_addr = 0;
> +    spapr_cpu->vpa_addr = 0;
>      return H_SUCCESS;
>  }
>  
> -static target_ulong register_slb_shadow(CPUPPCState *env, target_ulong addr)
> +static target_ulong register_slb_shadow(PowerPCCPU *cpu, target_ulong addr)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
>      uint32_t size;
>  
>      if (addr == 0) {
> @@ -968,7 +973,7 @@ static target_ulong register_slb_shadow(CPUPPCState *env, target_ulong addr)
>          return H_HARDWARE;
>      }
>  
> -    size = ldl_be_phys(cs->as, addr + 0x4);
> +    size = ldl_be_phys(CPU(cpu)->as, addr + 0x4);
>      if (size < 0x8) {
>          return H_PARAMETER;
>      }
> @@ -977,26 +982,28 @@ static target_ulong register_slb_shadow(CPUPPCState *env, target_ulong addr)
>          return H_PARAMETER;
>      }
>  
> -    if (!env->vpa_addr) {
> +    if (!spapr_cpu->vpa_addr) {
>          return H_RESOURCE;
>      }
>  
> -    env->slb_shadow_addr = addr;
> -    env->slb_shadow_size = size;
> +    spapr_cpu->slb_shadow_addr = addr;
> +    spapr_cpu->slb_shadow_size = size;
>  
>      return H_SUCCESS;
>  }
>  
> -static target_ulong deregister_slb_shadow(CPUPPCState *env, target_ulong addr)
> +static target_ulong deregister_slb_shadow(PowerPCCPU *cpu, target_ulong addr)
>  {
> -    env->slb_shadow_addr = 0;
> -    env->slb_shadow_size = 0;
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    spapr_cpu->slb_shadow_addr = 0;
> +    spapr_cpu->slb_shadow_size = 0;
>      return H_SUCCESS;
>  }
>  
> -static target_ulong register_dtl(CPUPPCState *env, target_ulong addr)
> +static target_ulong register_dtl(PowerPCCPU *cpu, target_ulong addr)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
>      uint32_t size;
>  
>      if (addr == 0) {
> @@ -1004,26 +1011,28 @@ static target_ulong register_dtl(CPUPPCState *env, target_ulong addr)
>          return H_HARDWARE;
>      }
>  
> -    size = ldl_be_phys(cs->as, addr + 0x4);
> +    size = ldl_be_phys(CPU(cpu)->as, addr + 0x4);
>  
>      if (size < 48) {
>          return H_PARAMETER;
>      }
>  
> -    if (!env->vpa_addr) {
> +    if (!spapr_cpu->vpa_addr) {
>          return H_RESOURCE;
>      }
>  
> -    env->dtl_addr = addr;
> -    env->dtl_size = size;
> +    spapr_cpu->dtl_addr = addr;
> +    spapr_cpu->dtl_size = size;
>  
>      return H_SUCCESS;
>  }
>  
> -static target_ulong deregister_dtl(CPUPPCState *env, target_ulong addr)
> +static target_ulong deregister_dtl(PowerPCCPU *cpu, target_ulong addr)
>  {
> -    env->dtl_addr = 0;
> -    env->dtl_size = 0;
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    spapr_cpu->dtl_addr = 0;
> +    spapr_cpu->dtl_size = 0;
>  
>      return H_SUCCESS;
>  }
> @@ -1035,38 +1044,36 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>      target_ulong procno = args[1];
>      target_ulong vpa = args[2];
>      target_ulong ret = H_PARAMETER;
> -    CPUPPCState *tenv;
>      PowerPCCPU *tcpu;
>  
>      tcpu = spapr_find_cpu(procno);
>      if (!tcpu) {
>          return H_PARAMETER;
>      }
> -    tenv = &tcpu->env;
>  
>      switch (flags) {
>      case FLAGS_REGISTER_VPA:
> -        ret = register_vpa(tenv, vpa);
> +        ret = register_vpa(tcpu, vpa);
>          break;
>  
>      case FLAGS_DEREGISTER_VPA:
> -        ret = deregister_vpa(tenv, vpa);
> +        ret = deregister_vpa(tcpu, vpa);
>          break;
>  
>      case FLAGS_REGISTER_SLBSHADOW:
> -        ret = register_slb_shadow(tenv, vpa);
> +        ret = register_slb_shadow(tcpu, vpa);
>          break;
>  
>      case FLAGS_DEREGISTER_SLBSHADOW:
> -        ret = deregister_slb_shadow(tenv, vpa);
> +        ret = deregister_slb_shadow(tcpu, vpa);
>          break;
>  
>      case FLAGS_REGISTER_DTL:
> -        ret = register_dtl(tenv, vpa);
> +        ret = register_dtl(tcpu, vpa);
>          break;
>  
>      case FLAGS_DEREGISTER_DTL:
> -        ret = deregister_dtl(tenv, vpa);
> +        ret = deregister_dtl(tcpu, vpa);
>          break;
>      }
>  
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 47dcfda12b..8ceea2973a 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -41,4 +41,15 @@ typedef struct sPAPRCPUCoreClass {
>  const char *spapr_get_cpu_core_type(const char *cpu_type);
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3);
>  
> +typedef struct sPAPRCPUState {
> +    uint64_t vpa_addr;
> +    uint64_t slb_shadow_addr, slb_shadow_size;
> +    uint64_t dtl_addr, dtl_size;
> +} sPAPRCPUState;
> +
> +static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
> +{
> +    return (sPAPRCPUState *)cpu->machine_data;
> +}
> +
>  #endif
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a91f1a8777..874da6efbc 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1091,12 +1091,6 @@ struct CPUPPCState {
>      target_ulong rmls;
>  #endif
>  
> -#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> -    uint64_t vpa_addr;
> -    uint64_t slb_shadow_addr, slb_shadow_size;
> -    uint64_t dtl_addr, dtl_size;
> -#endif /* TARGET_PPC64 */
> -
>      int error_code;
>      uint32_t pending_interrupts;
>  #if !defined(CONFIG_USER_ONLY)
> @@ -1205,6 +1199,7 @@ struct PowerPCCPU {
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
>      Object *intc;
> +    void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
>  
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7fe9d0126b..5c0e313ca6 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -829,22 +829,22 @@ static int kvm_get_fp(CPUState *cs)
>  static int kvm_get_vpa(CPUState *cs)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
> -    CPUPPCState *env = &cpu->env;
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
>      struct kvm_one_reg reg;
>      int ret;
>  
>      reg.id = KVM_REG_PPC_VPA_ADDR;
> -    reg.addr = (uintptr_t)&env->vpa_addr;
> +    reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
>          DPRINTF("Unable to get VPA address from KVM: %s\n", strerror(errno));
>          return ret;
>      }
>  
> -    assert((uintptr_t)&env->slb_shadow_size
> -           == ((uintptr_t)&env->slb_shadow_addr + 8));
> +    assert((uintptr_t)&spapr_cpu->slb_shadow_size
> +           == ((uintptr_t)&spapr_cpu->slb_shadow_addr + 8));
>      reg.id = KVM_REG_PPC_VPA_SLB;
> -    reg.addr = (uintptr_t)&env->slb_shadow_addr;
> +    reg.addr = (uintptr_t)&spapr_cpu->slb_shadow_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
>          DPRINTF("Unable to get SLB shadow state from KVM: %s\n",
> @@ -852,9 +852,10 @@ static int kvm_get_vpa(CPUState *cs)
>          return ret;
>      }
>  
> -    assert((uintptr_t)&env->dtl_size == ((uintptr_t)&env->dtl_addr + 8));
> +    assert((uintptr_t)&spapr_cpu->dtl_size
> +           == ((uintptr_t)&spapr_cpu->dtl_addr + 8));
>      reg.id = KVM_REG_PPC_VPA_DTL;
> -    reg.addr = (uintptr_t)&env->dtl_addr;
> +    reg.addr = (uintptr_t)&spapr_cpu->dtl_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>      if (ret < 0) {
>          DPRINTF("Unable to get dispatch trace log state from KVM: %s\n",
> @@ -868,7 +869,7 @@ static int kvm_get_vpa(CPUState *cs)
>  static int kvm_put_vpa(CPUState *cs)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
> -    CPUPPCState *env = &cpu->env;
> +    sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
>      struct kvm_one_reg reg;
>      int ret;
>  
> @@ -876,11 +877,12 @@ static int kvm_put_vpa(CPUState *cs)
>       * registered.  That means when restoring state, if a VPA *is*
>       * registered, we need to set that up first.  If not, we need to
>       * deregister the others before deregistering the master VPA */
> -    assert(env->vpa_addr || !(env->slb_shadow_addr || env->dtl_addr));
> +    assert(spapr_cpu->vpa_addr
> +           || !(spapr_cpu->slb_shadow_addr || spapr_cpu->dtl_addr));
>  
> -    if (env->vpa_addr) {
> +    if (spapr_cpu->vpa_addr) {
>          reg.id = KVM_REG_PPC_VPA_ADDR;
> -        reg.addr = (uintptr_t)&env->vpa_addr;
> +        reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
>              DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(errno));
> @@ -888,19 +890,20 @@ static int kvm_put_vpa(CPUState *cs)
>          }
>      }
>  
> -    assert((uintptr_t)&env->slb_shadow_size
> -           == ((uintptr_t)&env->slb_shadow_addr + 8));
> +    assert((uintptr_t)&spapr_cpu->slb_shadow_size
> +           == ((uintptr_t)&spapr_cpu->slb_shadow_addr + 8));
>      reg.id = KVM_REG_PPC_VPA_SLB;
> -    reg.addr = (uintptr_t)&env->slb_shadow_addr;
> +    reg.addr = (uintptr_t)&spapr_cpu->slb_shadow_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>      if (ret < 0) {
>          DPRINTF("Unable to set SLB shadow state to KVM: %s\n", strerror(errno));
>          return ret;
>      }
>  
> -    assert((uintptr_t)&env->dtl_size == ((uintptr_t)&env->dtl_addr + 8));
> +    assert((uintptr_t)&spapr_cpu->dtl_size
> +           == ((uintptr_t)&spapr_cpu->dtl_addr + 8));
>      reg.id = KVM_REG_PPC_VPA_DTL;
> -    reg.addr = (uintptr_t)&env->dtl_addr;
> +    reg.addr = (uintptr_t)&spapr_cpu->dtl_addr;
>      ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>      if (ret < 0) {
>          DPRINTF("Unable to set dispatch trace log state to KVM: %s\n",
> @@ -908,9 +911,9 @@ static int kvm_put_vpa(CPUState *cs)
>          return ret;
>      }
>  
> -    if (!env->vpa_addr) {
> +    if (!spapr_cpu->vpa_addr) {
>          reg.id = KVM_REG_PPC_VPA_ADDR;
> -        reg.addr = (uintptr_t)&env->vpa_addr;
> +        reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret < 0) {
>              DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(errno));
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index bb9296f5a3..76d6f3fd5e 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10316,14 +10316,6 @@ static void ppc_cpu_reset(CPUState *s)
>      s->exception_index = POWERPC_EXCP_NONE;
>      env->error_code = 0;
>  
> -#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> -    env->vpa_addr = 0;
> -    env->slb_shadow_addr = 0;
> -    env->slb_shadow_size = 0;
> -    env->dtl_addr = 0;
> -    env->dtl_size = 0;
> -#endif /* TARGET_PPC64 */
> -
>      for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
>          ppc_spr_t *spr = &env->spr_cb[i];
>  
