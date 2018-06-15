Received: from eggs.gnu.org ([2001:4830:134:3::10]:42901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTeI4-0004hs-1q
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTeI0-0002JJ-9b
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:16:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Jun 2018 12:16:28 +1000
Message-Id: <20180615021628.20594-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target/ppc,
 spapr: Move VPA information to machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

CPUPPCState currently contains a number of fields containing the state of
the VPA.  The VPA is a PAPR specific concept covering several guest/host
shared memory areas used to communicate some information with the
hypervisor.

As a PAPR concept this is really machine specific information, although i=
t
is per-cpu, so it doesn't really belong in the core CPU state structure.

There's also other information that's per-cpu, but platform/machine
specific.  So create a (void *)machine_data in PowerPCCPU which can be
used by the machine to locate per-cpu data.  Intialization, lifetime and
cleanup of machine_data is entirely up to the machine type.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c         | 13 ++++++
 hw/ppc/spapr_hcall.c            | 77 ++++++++++++++++++---------------
 include/hw/ppc/spapr_cpu_core.h | 11 +++++
 target/ppc/cpu.h                |  7 +--
 target/ppc/kvm.c                | 39 +++++++++--------
 target/ppc/translate_init.inc.c |  8 ----
 6 files changed, 88 insertions(+), 67 deletions(-)

I pulled out the earlier pathces adding machine_data, since putting
intc there broke C=C3=A9dric's XIVE work.  Here's a version of just the V=
PA
part revised to be standalone.

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 4f0c168784..c4db975d70 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -28,6 +28,7 @@ static void spapr_cpu_reset(void *opaque)
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
     target_ulong lpcr;
=20
     cpu_reset(cs);
@@ -69,6 +70,12 @@ static void spapr_cpu_reset(void *opaque)
=20
     /* Set a full AMOR so guest can use the AMR as it sees fit */
     env->spr[SPR_AMOR] =3D 0xffffffffffffffffull;
+
+    spapr_cpu->vpa_addr =3D 0;
+    spapr_cpu->slb_shadow_addr =3D 0;
+    spapr_cpu->slb_shadow_size =3D 0;
+    spapr_cpu->dtl_addr =3D 0;
+    spapr_cpu->dtl_size =3D 0;
 }
=20
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
@@ -104,8 +111,12 @@ const char *spapr_get_cpu_core_type(const char *cpu_=
type)
=20
 static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
 {
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+
     qemu_unregister_reset(spapr_cpu_reset, cpu);
     object_unparent(cpu->intc);
+    cpu->machine_data =3D NULL;
+    g_free(spapr_cpu);
     cpu_remove_sync(CPU(cpu));
     object_unparent(OBJECT(cpu));
 }
@@ -128,6 +139,8 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
     CPUPPCState *env =3D &cpu->env;
     Error *local_err =3D NULL;
=20
+    cpu->machine_data =3D g_new0(sPAPRCPUState, 1);
+
     object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
     if (local_err) {
         goto error;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8b9a4b577f..ae913d070f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -8,6 +8,7 @@
 #include "exec/exec-all.h"
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_cpu_core.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
 #include "trace.h"
@@ -908,9 +909,11 @@ unmap_out:
 #define VPA_SHARED_PROC_OFFSET 0x9
 #define VPA_SHARED_PROC_VAL    0x2
=20
-static target_ulong register_vpa(CPUPPCState *env, target_ulong vpa)
+static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
 {
-    CPUState *cs =3D CPU(ppc_env_get_cpu(env));
+    CPUState *cs =3D CPU(cpu);
+    CPUPPCState *env =3D &cpu->env;
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
     uint16_t size;
     uint8_t tmp;
=20
@@ -935,32 +938,34 @@ static target_ulong register_vpa(CPUPPCState *env, =
target_ulong vpa)
         return H_PARAMETER;
     }
=20
-    env->vpa_addr =3D vpa;
+    spapr_cpu->vpa_addr =3D vpa;
=20
-    tmp =3D ldub_phys(cs->as, env->vpa_addr + VPA_SHARED_PROC_OFFSET);
+    tmp =3D ldub_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFS=
ET);
     tmp |=3D VPA_SHARED_PROC_VAL;
-    stb_phys(cs->as, env->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
+    stb_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
=20
     return H_SUCCESS;
 }
=20
-static target_ulong deregister_vpa(CPUPPCState *env, target_ulong vpa)
+static target_ulong deregister_vpa(PowerPCCPU *cpu, target_ulong vpa)
 {
-    if (env->slb_shadow_addr) {
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+
+    if (spapr_cpu->slb_shadow_addr) {
         return H_RESOURCE;
     }
=20
-    if (env->dtl_addr) {
+    if (spapr_cpu->dtl_addr) {
         return H_RESOURCE;
     }
=20
-    env->vpa_addr =3D 0;
+    spapr_cpu->vpa_addr =3D 0;
     return H_SUCCESS;
 }
=20
-static target_ulong register_slb_shadow(CPUPPCState *env, target_ulong a=
ddr)
+static target_ulong register_slb_shadow(PowerPCCPU *cpu, target_ulong ad=
dr)
 {
-    CPUState *cs =3D CPU(ppc_env_get_cpu(env));
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
     uint32_t size;
=20
     if (addr =3D=3D 0) {
@@ -968,7 +973,7 @@ static target_ulong register_slb_shadow(CPUPPCState *=
env, target_ulong addr)
         return H_HARDWARE;
     }
=20
-    size =3D ldl_be_phys(cs->as, addr + 0x4);
+    size =3D ldl_be_phys(CPU(cpu)->as, addr + 0x4);
     if (size < 0x8) {
         return H_PARAMETER;
     }
@@ -977,26 +982,28 @@ static target_ulong register_slb_shadow(CPUPPCState=
 *env, target_ulong addr)
         return H_PARAMETER;
     }
=20
-    if (!env->vpa_addr) {
+    if (!spapr_cpu->vpa_addr) {
         return H_RESOURCE;
     }
=20
-    env->slb_shadow_addr =3D addr;
-    env->slb_shadow_size =3D size;
+    spapr_cpu->slb_shadow_addr =3D addr;
+    spapr_cpu->slb_shadow_size =3D size;
=20
     return H_SUCCESS;
 }
=20
-static target_ulong deregister_slb_shadow(CPUPPCState *env, target_ulong=
 addr)
+static target_ulong deregister_slb_shadow(PowerPCCPU *cpu, target_ulong =
addr)
 {
-    env->slb_shadow_addr =3D 0;
-    env->slb_shadow_size =3D 0;
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+
+    spapr_cpu->slb_shadow_addr =3D 0;
+    spapr_cpu->slb_shadow_size =3D 0;
     return H_SUCCESS;
 }
=20
-static target_ulong register_dtl(CPUPPCState *env, target_ulong addr)
+static target_ulong register_dtl(PowerPCCPU *cpu, target_ulong addr)
 {
-    CPUState *cs =3D CPU(ppc_env_get_cpu(env));
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
     uint32_t size;
=20
     if (addr =3D=3D 0) {
@@ -1004,26 +1011,28 @@ static target_ulong register_dtl(CPUPPCState *env=
, target_ulong addr)
         return H_HARDWARE;
     }
=20
-    size =3D ldl_be_phys(cs->as, addr + 0x4);
+    size =3D ldl_be_phys(CPU(cpu)->as, addr + 0x4);
=20
     if (size < 48) {
         return H_PARAMETER;
     }
=20
-    if (!env->vpa_addr) {
+    if (!spapr_cpu->vpa_addr) {
         return H_RESOURCE;
     }
=20
-    env->dtl_addr =3D addr;
-    env->dtl_size =3D size;
+    spapr_cpu->dtl_addr =3D addr;
+    spapr_cpu->dtl_size =3D size;
=20
     return H_SUCCESS;
 }
=20
-static target_ulong deregister_dtl(CPUPPCState *env, target_ulong addr)
+static target_ulong deregister_dtl(PowerPCCPU *cpu, target_ulong addr)
 {
-    env->dtl_addr =3D 0;
-    env->dtl_size =3D 0;
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+
+    spapr_cpu->dtl_addr =3D 0;
+    spapr_cpu->dtl_size =3D 0;
=20
     return H_SUCCESS;
 }
@@ -1035,38 +1044,36 @@ static target_ulong h_register_vpa(PowerPCCPU *cp=
u, sPAPRMachineState *spapr,
     target_ulong procno =3D args[1];
     target_ulong vpa =3D args[2];
     target_ulong ret =3D H_PARAMETER;
-    CPUPPCState *tenv;
     PowerPCCPU *tcpu;
=20
     tcpu =3D spapr_find_cpu(procno);
     if (!tcpu) {
         return H_PARAMETER;
     }
-    tenv =3D &tcpu->env;
=20
     switch (flags) {
     case FLAGS_REGISTER_VPA:
-        ret =3D register_vpa(tenv, vpa);
+        ret =3D register_vpa(tcpu, vpa);
         break;
=20
     case FLAGS_DEREGISTER_VPA:
-        ret =3D deregister_vpa(tenv, vpa);
+        ret =3D deregister_vpa(tcpu, vpa);
         break;
=20
     case FLAGS_REGISTER_SLBSHADOW:
-        ret =3D register_slb_shadow(tenv, vpa);
+        ret =3D register_slb_shadow(tcpu, vpa);
         break;
=20
     case FLAGS_DEREGISTER_SLBSHADOW:
-        ret =3D deregister_slb_shadow(tenv, vpa);
+        ret =3D deregister_slb_shadow(tcpu, vpa);
         break;
=20
     case FLAGS_REGISTER_DTL:
-        ret =3D register_dtl(tenv, vpa);
+        ret =3D register_dtl(tcpu, vpa);
         break;
=20
     case FLAGS_DEREGISTER_DTL:
-        ret =3D deregister_dtl(tenv, vpa);
+        ret =3D deregister_dtl(tcpu, vpa);
         break;
     }
=20
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 47dcfda12b..8ceea2973a 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -41,4 +41,15 @@ typedef struct sPAPRCPUCoreClass {
 const char *spapr_get_cpu_core_type(const char *cpu_type);
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3);
=20
+typedef struct sPAPRCPUState {
+    uint64_t vpa_addr;
+    uint64_t slb_shadow_addr, slb_shadow_size;
+    uint64_t dtl_addr, dtl_size;
+} sPAPRCPUState;
+
+static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
+{
+    return (sPAPRCPUState *)cpu->machine_data;
+}
+
 #endif
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a91f1a8777..874da6efbc 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1091,12 +1091,6 @@ struct CPUPPCState {
     target_ulong rmls;
 #endif
=20
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-    uint64_t vpa_addr;
-    uint64_t slb_shadow_addr, slb_shadow_size;
-    uint64_t dtl_addr, dtl_size;
-#endif /* TARGET_PPC64 */
-
     int error_code;
     uint32_t pending_interrupts;
 #if !defined(CONFIG_USER_ONLY)
@@ -1205,6 +1199,7 @@ struct PowerPCCPU {
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
     Object *intc;
+    void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
=20
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7fe9d0126b..5c0e313ca6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -829,22 +829,22 @@ static int kvm_get_fp(CPUState *cs)
 static int kvm_get_vpa(CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    CPUPPCState *env =3D &cpu->env;
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
     struct kvm_one_reg reg;
     int ret;
=20
     reg.id =3D KVM_REG_PPC_VPA_ADDR;
-    reg.addr =3D (uintptr_t)&env->vpa_addr;
+    reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
         DPRINTF("Unable to get VPA address from KVM: %s\n", strerror(err=
no));
         return ret;
     }
=20
-    assert((uintptr_t)&env->slb_shadow_size
-           =3D=3D ((uintptr_t)&env->slb_shadow_addr + 8));
+    assert((uintptr_t)&spapr_cpu->slb_shadow_size
+           =3D=3D ((uintptr_t)&spapr_cpu->slb_shadow_addr + 8));
     reg.id =3D KVM_REG_PPC_VPA_SLB;
-    reg.addr =3D (uintptr_t)&env->slb_shadow_addr;
+    reg.addr =3D (uintptr_t)&spapr_cpu->slb_shadow_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
         DPRINTF("Unable to get SLB shadow state from KVM: %s\n",
@@ -852,9 +852,10 @@ static int kvm_get_vpa(CPUState *cs)
         return ret;
     }
=20
-    assert((uintptr_t)&env->dtl_size =3D=3D ((uintptr_t)&env->dtl_addr +=
 8));
+    assert((uintptr_t)&spapr_cpu->dtl_size
+           =3D=3D ((uintptr_t)&spapr_cpu->dtl_addr + 8));
     reg.id =3D KVM_REG_PPC_VPA_DTL;
-    reg.addr =3D (uintptr_t)&env->dtl_addr;
+    reg.addr =3D (uintptr_t)&spapr_cpu->dtl_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
         DPRINTF("Unable to get dispatch trace log state from KVM: %s\n",
@@ -868,7 +869,7 @@ static int kvm_get_vpa(CPUState *cs)
 static int kvm_put_vpa(CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    CPUPPCState *env =3D &cpu->env;
+    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
     struct kvm_one_reg reg;
     int ret;
=20
@@ -876,11 +877,12 @@ static int kvm_put_vpa(CPUState *cs)
      * registered.  That means when restoring state, if a VPA *is*
      * registered, we need to set that up first.  If not, we need to
      * deregister the others before deregistering the master VPA */
-    assert(env->vpa_addr || !(env->slb_shadow_addr || env->dtl_addr));
+    assert(spapr_cpu->vpa_addr
+           || !(spapr_cpu->slb_shadow_addr || spapr_cpu->dtl_addr));
=20
-    if (env->vpa_addr) {
+    if (spapr_cpu->vpa_addr) {
         reg.id =3D KVM_REG_PPC_VPA_ADDR;
-        reg.addr =3D (uintptr_t)&env->vpa_addr;
+        reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
         ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
             DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(e=
rrno));
@@ -888,19 +890,20 @@ static int kvm_put_vpa(CPUState *cs)
         }
     }
=20
-    assert((uintptr_t)&env->slb_shadow_size
-           =3D=3D ((uintptr_t)&env->slb_shadow_addr + 8));
+    assert((uintptr_t)&spapr_cpu->slb_shadow_size
+           =3D=3D ((uintptr_t)&spapr_cpu->slb_shadow_addr + 8));
     reg.id =3D KVM_REG_PPC_VPA_SLB;
-    reg.addr =3D (uintptr_t)&env->slb_shadow_addr;
+    reg.addr =3D (uintptr_t)&spapr_cpu->slb_shadow_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
     if (ret < 0) {
         DPRINTF("Unable to set SLB shadow state to KVM: %s\n", strerror(=
errno));
         return ret;
     }
=20
-    assert((uintptr_t)&env->dtl_size =3D=3D ((uintptr_t)&env->dtl_addr +=
 8));
+    assert((uintptr_t)&spapr_cpu->dtl_size
+           =3D=3D ((uintptr_t)&spapr_cpu->dtl_addr + 8));
     reg.id =3D KVM_REG_PPC_VPA_DTL;
-    reg.addr =3D (uintptr_t)&env->dtl_addr;
+    reg.addr =3D (uintptr_t)&spapr_cpu->dtl_addr;
     ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
     if (ret < 0) {
         DPRINTF("Unable to set dispatch trace log state to KVM: %s\n",
@@ -908,9 +911,9 @@ static int kvm_put_vpa(CPUState *cs)
         return ret;
     }
=20
-    if (!env->vpa_addr) {
+    if (!spapr_cpu->vpa_addr) {
         reg.id =3D KVM_REG_PPC_VPA_ADDR;
-        reg.addr =3D (uintptr_t)&env->vpa_addr;
+        reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
         ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
             DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(e=
rrno));
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index bb9296f5a3..76d6f3fd5e 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10316,14 +10316,6 @@ static void ppc_cpu_reset(CPUState *s)
     s->exception_index =3D POWERPC_EXCP_NONE;
     env->error_code =3D 0;
=20
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-    env->vpa_addr =3D 0;
-    env->slb_shadow_addr =3D 0;
-    env->slb_shadow_size =3D 0;
-    env->dtl_addr =3D 0;
-    env->dtl_size =3D 0;
-#endif /* TARGET_PPC64 */
-
     for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr =3D &env->spr_cb[i];
=20
--=20
2.17.1
