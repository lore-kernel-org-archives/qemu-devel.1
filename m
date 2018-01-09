Received: from eggs.gnu.org ([2001:4830:134:3::10]:45621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eYscV-000114-W5
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eYscQ-0006Qg-Mt
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:03:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eYscQ-0006ME-D7
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:03:02 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w09C1CVG041457
	for <qemu-devel@nongnu.org>; Tue, 9 Jan 2018 07:02:58 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fctthffdt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 07:02:57 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 9 Jan 2018 07:02:56 -0500
Date: Tue, 9 Jan 2018 10:02:50 -0200
From: joserz@linux.vnet.ibm.com
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109092103.18458-3-sjitindarsingh@gmail.com>
Message-Id: <20180109120249.5cjli5545vlnj6uq@pacoca>
Subject: Re: [Qemu-devel] [QEMU-PPC] [RFC 2/3] hw/spapr/spapr_caps: Add new
 caps safe_[cache/bounds_check/indirect_branch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Tue, Jan 09, 2018 at 08:21:02PM +1100, Suraj Jitindar Singh wrote:
> This patch adds three new capabilities:
> cap-cfpc -> safe_cache
> cap-sbbc -> safe_bounds_check
> cap-ibs  -> safe_indirect_branch
> 
> Each capability is tristate with the possible values "broken",
> "workaround" or "fixed". Add generic getter and setter functions for
> this new capability type. Add these new capabilities to the capabilities
> list. The maximum value for the capabilities is queried from kvm through
> new kvm capabilities. The requested values are considered to be
> compatible if kvm can support an equal or higher value for each
> capability.
> 
> Discussion:
> Currently these new capabilities default to broken to allow for
> backwards compatibility, is this the best option?
> ---
>  hw/ppc/spapr.c            |   6 ++
>  hw/ppc/spapr_caps.c       | 224 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h    |  15 +++-
>  linux-headers/linux/kvm.h |   3 +
>  target/ppc/kvm.c          |  28 ++++++
>  target/ppc/kvm_ppc.h      |  18 ++++
>  6 files changed, 293 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7fa45729ba..d9700b0254 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1765,6 +1765,9 @@ static const VMStateDescription vmstate_spapr = {
>          &vmstate_spapr_cap_htm,
>          &vmstate_spapr_cap_vsx,
>          &vmstate_spapr_cap_dfp,
> +        &vmstate_spapr_cap_cfpc,
> +        &vmstate_spapr_cap_sbbc,
> +        &vmstate_spapr_cap_ibs,
>          NULL
>      }
>  };
> @@ -3837,6 +3840,9 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>      spapr_caps_add_properties(smc, &error_abort);
>  }
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index af40f2e469..e6910aa191 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -75,6 +75,64 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
>                                               SPAPR_CAP_CMD_LINE;
>  }
> 
> +static void spapr_cap_get_tristate(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap = opaque;
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> +    char *val = NULL;
> +    uint8_t value = spapr_get_cap(spapr, cap->index);
> +
> +    switch (value) {
> +    case SPAPR_CAP_BROKEN:
> +        val = g_strdup("broken");
> +        break;
> +    case SPAPR_CAP_WORKAROUND:
> +        val = g_strdup("workaround");
> +        break;
> +    case SPAPR_CAP_FIXED:
> +        val = g_strdup("fixed");
> +        break;
> +    default:
> +        break;

Hello Suraj

Is default a possible case? If so, will val be handled correctly by
visit_type_str and g_free?

if not, maybe a throwing an error like you did in
spapr_cap_set_tristate could be better.

> +    }
> +
> +    visit_type_str(v, name, &val, errp);
> +    g_free(val);
> +}
> +
> +static void spapr_cap_set_tristate(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap = opaque;
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> +    char *val;
> +    Error *local_err = NULL;
> +    uint8_t value;
> +
> +    visit_type_str(v, name, &val, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (!strcasecmp(val, "broken")) {
> +        value = SPAPR_CAP_BROKEN;
> +    } else if (!strcasecmp(val, "workaround")) {
> +        value = SPAPR_CAP_WORKAROUND;
> +    } else if (!strcasecmp(val, "fixed")) {
> +        value = SPAPR_CAP_FIXED;
> +    } else {
> +        error_setg(errp, "Invalid capability mode \"%s\" for cap-%s", val,
> +                   cap->name);
> +        goto out;
> +    }
> +
> +    spapr->cmd_line_caps.caps[cap->index] = value | SPAPR_CAP_CMD_LINE;
> +out:
> +    g_free(val);
> +}
> +
>  static void cap_htm_allow(sPAPRMachineState *spapr, uint8_t val, Error **errp)
>  {
>      if (!val) {
> @@ -122,6 +180,31 @@ static void cap_dfp_allow(sPAPRMachineState *spapr, uint8_t val, Error **errp)
>      }
>  }
> 
> +static void cap_safe_cache_allow(sPAPRMachineState *spapr, uint8_t val,
> +                                 Error **errp)
> +{
> +    if (kvm_enabled() && (val > kvmppc_get_cap_safe_cache())) {
> +        error_setg(errp, "Requested safe cache capability level not supported by kvm, try a different value for cap-cfpc");
> +    }
> +}
> +
> +static void cap_safe_bounds_check_allow(sPAPRMachineState *spapr, uint8_t val,
> +                                        Error **errp)
> +{
> +    if (kvm_enabled() && (val > kvmppc_get_cap_safe_bounds_check())) {
> +        error_setg(errp, "Requested safe bounds check capability level not supported by kvm, try a different value for cap-sbbc");
> +    }
> +}
> +
> +static void cap_safe_indirect_branch_allow(sPAPRMachineState *spapr,
> +                                           uint8_t val, Error **errp)
> +{
> +    if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_branch())) {
> +        error_setg(errp, "Requested safe indirect branch capability level not supported by kvm, try a different value for cap-ibs");
> +    }
> +}
> +
> +#define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
> 
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>      [SPAPR_CAP_HTM] = {
> @@ -154,6 +237,36 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .type = "bool",
>          .allow = cap_dfp_allow,
>      },
> +    [SPAPR_CAP_CFPC] = {
> +        .name = "cfpc",
> +        .description = "Cache Flush on Privilege Change",
> +        .options = VALUE_DESC_TRISTATE,
> +        .index = SPAPR_CAP_CFPC,
> +        .get = spapr_cap_get_tristate,
> +        .set = spapr_cap_set_tristate,
> +        .type = "string",
> +        .allow = cap_safe_cache_allow,
> +    },
> +    [SPAPR_CAP_SBBC] = {
> +        .name = "sbbc",
> +        .description = "Speculation Barrier Bounds Checking",
> +        .options = VALUE_DESC_TRISTATE,
> +        .index = SPAPR_CAP_SBBC,
> +        .get = spapr_cap_get_tristate,
> +        .set = spapr_cap_set_tristate,
> +        .type = "string",
> +        .allow = cap_safe_bounds_check_allow,
> +    },
> +    [SPAPR_CAP_IBS] = {
> +        .name = "ibs",
> +        .description = "Indirect Branch Serialisation",
> +        .options = VALUE_DESC_TRISTATE,
> +        .index = SPAPR_CAP_IBS,
> +        .get = spapr_cap_get_tristate,
> +        .set = spapr_cap_set_tristate,
> +        .type = "string",
> +        .allow = cap_safe_indirect_branch_allow,
> +    },
>  };
> 
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -326,6 +439,117 @@ const VMStateDescription vmstate_spapr_cap_dfp = {
>      },
>  };
> 
> +static bool spapr_cap_safe_cache_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_CFPC] & SPAPR_CAP_CMD_LINE);
> +}
> +
> +static int spapr_cap_safe_cache_pre_save(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_CFPC] =
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_CFPC];
> +    return 0;
> +}
> +
> +static int spapr_cap_safe_cache_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_CFPC] = 0;
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_cfpc = {
> +    .name = "spapr/cap_cfpc",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = spapr_cap_safe_cache_needed,
> +    .pre_save = spapr_cap_safe_cache_pre_save,
> +    .pre_load = spapr_cap_safe_cache_pre_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_CFPC], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool spapr_cap_safe_bounds_check_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_SBBC] & SPAPR_CAP_CMD_LINE);
> +}
> +
> +static int spapr_cap_safe_bounds_check_pre_save(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_SBBC] =
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_SBBC];
> +    return 0;
> +}
> +
> +static int spapr_cap_safe_bounds_check_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_SBBC] = 0;
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_sbbc = {
> +    .name = "spapr/cap_sbbc",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = spapr_cap_safe_bounds_check_needed,
> +    .pre_save = spapr_cap_safe_bounds_check_pre_save,
> +    .pre_load = spapr_cap_safe_bounds_check_pre_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_SBBC], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool spapr_cap_safe_indirect_branch_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_IBS] & SPAPR_CAP_CMD_LINE);
> +}
> +
> +static int spapr_cap_safe_indirect_branch_pre_save(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_IBS] =
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_IBS];
> +    return 0;
> +}
> +
> +static int spapr_cap_safe_indirect_branch_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_IBS] = 0;
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_ibs = {
> +    .name = "spapr/cap_ibs",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = spapr_cap_safe_indirect_branch_needed,
> +    .pre_save = spapr_cap_safe_indirect_branch_pre_save,
> +    .pre_load = spapr_cap_safe_indirect_branch_pre_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_IBS], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {
>      sPAPRCapabilities caps;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2804fbbf12..2db2f3e2e2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -62,8 +62,14 @@ typedef enum {
>  #define SPAPR_CAP_VSX                   0x01
>  /* Decimal Floating Point */
>  #define SPAPR_CAP_DFP                   0x02
> +/* Cache Flush on Privilege Change */
> +#define SPAPR_CAP_CFPC                  0x03
> +/* Speculation Barrier Bounds Checking */
> +#define SPAPR_CAP_SBBC                  0x04
> +/* Indirect Branch Serialisation */
> +#define SPAPR_CAP_IBS                   0x05
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_DFP + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
> 
>  /*
>   * Capability Values
> @@ -73,6 +79,10 @@ typedef enum {
>  /* Bool Caps */
>  #define SPAPR_CAP_OFF                   0x00
>  #define SPAPR_CAP_ON                    0x01
> +/* Broken | Workaround | Fixed Caps */
> +#define SPAPR_CAP_BROKEN                0x00
> +#define SPAPR_CAP_WORKAROUND            0x01
> +#define SPAPR_CAP_FIXED                 0x02
> 
>  typedef struct sPAPRCapabilities sPAPRCapabilities;
>  struct sPAPRCapabilities {
> @@ -763,6 +773,9 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>  extern const VMStateDescription vmstate_spapr_cap_htm;
>  extern const VMStateDescription vmstate_spapr_cap_vsx;
>  extern const VMStateDescription vmstate_spapr_cap_dfp;
> +extern const VMStateDescription vmstate_spapr_cap_cfpc;
> +extern const VMStateDescription vmstate_spapr_cap_sbbc;
> +extern const VMStateDescription vmstate_spapr_cap_ibs;
> 
>  static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index ce6c2f11f4..0abe0a0abb 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -932,6 +932,9 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_SYNIC2 148
>  #define KVM_CAP_HYPERV_VP_INDEX 149
>  #define KVM_CAP_S390_AIS_MIGRATION 150
> +#define KVM_CAP_PPC_SAFE_CACHE 151
> +#define KVM_CAP_PPC_SAFE_BOUNDS_CHECK 152
> +#define KVM_CAP_PPC_SAFE_INDIRECT_BRANCH 153
> 
>  #ifdef KVM_CAP_IRQ_ROUTING
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 518dd06e98..818499237c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -89,6 +89,9 @@ static int cap_mmu_radix;
>  static int cap_mmu_hash_v3;
>  static int cap_resize_hpt;
>  static int cap_ppc_pvr_compat;
> +static int cap_ppc_safe_cache;
> +static int cap_ppc_safe_bounds_check;
> +static int cap_ppc_safe_indirect_branch;
> 
>  static uint32_t debug_inst_opcode;
> 
> @@ -147,6 +150,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
>      cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
>      cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
> +    cap_ppc_safe_cache = kvm_vm_check_extension(s, KVM_CAP_PPC_SAFE_CACHE);
> +    cap_ppc_safe_cache = cap_ppc_safe_cache > 0 ? cap_ppc_safe_cache : 0;
> +    cap_ppc_safe_bounds_check = kvm_vm_check_extension(s,
> +                                KVM_CAP_PPC_SAFE_BOUNDS_CHECK);
> +    cap_ppc_safe_bounds_check = cap_ppc_safe_bounds_check > 0 ?
> +                                cap_ppc_safe_bounds_check : 0;
> +    cap_ppc_safe_indirect_branch = kvm_vm_check_extension(s,
> +                                   KVM_CAP_PPC_SAFE_INDIRECT_BRANCH);
> +    cap_ppc_safe_indirect_branch = cap_ppc_safe_indirect_branch > 0 ?
> +                                   cap_ppc_safe_indirect_branch : 0;
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2456,6 +2469,21 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> 
> +int kvmppc_get_cap_safe_cache(void)
> +{
> +    return cap_ppc_safe_cache;
> +}
> +
> +int kvmppc_get_cap_safe_bounds_check(void)
> +{
> +    return cap_ppc_safe_bounds_check;
> +}
> +
> +int kvmppc_get_cap_safe_indirect_branch(void)
> +{
> +    return cap_ppc_safe_indirect_branch;
> +}
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr = mfpvr();
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index ecb55493cc..39830baa77 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -59,6 +59,9 @@ bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
>  bool kvmppc_has_cap_mmu_radix(void);
>  bool kvmppc_has_cap_mmu_hash_v3(void);
> +int kvmppc_get_cap_safe_cache(void);
> +int kvmppc_get_cap_safe_bounds_check(void);
> +int kvmppc_get_cap_safe_indirect_branch(void);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> @@ -290,6 +293,21 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
>      return false;
>  }
> 
> +static inline int kvmppc_get_cap_safe_cache(void)
> +{
> +    return 0;
> +}
> +
> +static inline int kvmppc_get_cap_safe_bounds_check(void)
> +{
> +    return 0;
> +}
> +
> +static inline int kvmppc_get_cap_safe_indirect_branch(void)
> +{
> +    return 0;
> +}
> +
>  static inline int kvmppc_enable_hwrng(void)
>  {
>      return -1;
> -- 
> 2.13.6
> 
> 
