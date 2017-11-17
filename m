Received: from eggs.gnu.org ([2001:4830:134:3::10]:48497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eFZMz-0000qc-QK
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eFZMy-0000zj-J5
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 00:39:17 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 17 Nov 2017 16:39:00 +1100
Message-Id: <20171117053900.2536-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3] target/ppc: Update setting of
 cpu features to account for compat modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, sjitindarsingh@gmail.com

The device tree nodes ibm,arch-vec-5-platform-support and ibm,pa-features
are used to communicate features of the cpu to the guest operating
system. The properties of each of these are determined based on the
selected cpu model and the availability of hypervisor features.
Currently the compatibility mode of the cpu is not taken into account.

The ibm,arch-vec-5-platform-support node is used to communicate the
level of support for various ISAv3 processor features to the guest
before CAS to inform the guests' request. The available mmu mode should
only be hash unless the cpu is a POWER9 which is not in a prePOWER9
compat mode, in which case the available modes depend on the
accelerator and the hypervisor capabilities.

The ibm,pa-featues node is used to communicate the level of cpu support
for various features to the guest os. This should only contain features
relevant to the operating mode of the processor, that is the selected
cpu model taking into account any compat mode. This means that the
compat mode should be taken into account when choosing the properties of
ibm,pa-features and they should match the compat mode selected, or the
cpu model selected if no compat mode.

Update the setting of these cpu features in the device tree as described
above to properly take into account any compat mode. We use the
ppc_check_compat function which takes into account the current processor
model and the cpu compat mode.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V1 -> V2:
- Pass cpu pointer to spapr_populate_pa_features to avoid extracting it
  back out from env
- Slight reword of spapr_dt_ov5_platform_support logic to avoid
  duplicate case
V2 -> V3:
- Use ppc_check_compat() to avoid having to check both the cpu model
  and the compat mode separately since it does it for us
---
 hw/ppc/spapr.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d682f01..6841bd2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -44,6 +44,7 @@
 #include "migration/register.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
+#include "cpu-models.h"
 #include "qom/cpu.h"
 
 #include "hw/boards.h"
@@ -252,9 +253,10 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 }
 
 /* Populate the "ibm,pa-features" property */
-static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
-                                      bool legacy_guest)
+static void spapr_populate_pa_features(PowerPCCPU *cpu, void *fdt, int offset,
+                                       bool legacy_guest)
 {
+    CPUPPCState *env = &cpu->env;
     uint8_t pa_features_206[] = { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
     uint8_t pa_features_207[] = { 24, 0,
@@ -287,23 +289,22 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
         /* 60: NM atomic, 62: RNG */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
     };
-    uint8_t *pa_features;
+    uint8_t *pa_features = NULL;
     size_t pa_size;
 
-    switch (POWERPC_MMU_VER(env->mmu_model)) {
-    case POWERPC_MMU_VER_2_06:
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06, 0, cpu->compat_pvr)) {
         pa_features = pa_features_206;
         pa_size = sizeof(pa_features_206);
-        break;
-    case POWERPC_MMU_VER_2_07:
+    }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07, 0, cpu->compat_pvr)) {
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
-        break;
-    case POWERPC_MMU_VER_3_00:
+    }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0, cpu->compat_pvr)) {
         pa_features = pa_features_300;
         pa_size = sizeof(pa_features_300);
-        break;
-    default:
+    }
+    if (!pa_features) {
         return;
     }
 
@@ -340,7 +341,6 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *env = &cpu->env;
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int index = spapr_vcpu_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
@@ -384,7 +384,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
             return ret;
         }
 
-        spapr_populate_pa_features(env, fdt, offset,
+        spapr_populate_pa_features(cpu, fdt, offset,
                                          spapr->cas_legacy_guest_workaround);
     }
     return ret;
@@ -579,7 +579,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                           page_sizes_prop, page_sizes_prop_size)));
     }
 
-    spapr_populate_pa_features(env, fdt, offset, false);
+    spapr_populate_pa_features(cpu, fdt, offset, false);
 
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
@@ -949,7 +949,11 @@ static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
         26, 0x40, /* Radix options: GTSE == yes. */
     };
 
-    if (kvm_enabled()) {
+    if (!ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                          first_ppc_cpu->compat_pvr)) {
+        /* If we're in a pre POWER9 compat mode then the guest should do hash */
+        val[3] = 0x00; /* Hash */
+    } else if (kvm_enabled()) {
         if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) {
             val[3] = 0x80; /* OV5_MMU_BOTH */
         } else if (kvmppc_has_cap_mmu_radix()) {
@@ -958,13 +962,8 @@ static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
             val[3] = 0x00; /* Hash */
         }
     } else {
-        if (first_ppc_cpu->env.mmu_model & POWERPC_MMU_V3) {
-            /* V3 MMU supports both hash and radix (with dynamic switching) */
-            val[3] = 0xC0;
-        } else {
-            /* Otherwise we can only do hash */
-            val[3] = 0x00;
-        }
+        /* V3 MMU supports both hash and radix in tcg (with dynamic switching) */
+        val[3] = 0xC0;
     }
     _FDT(fdt_setprop(fdt, chosen, "ibm,arch-vec-5-platform-support",
                      val, sizeof(val)));
-- 
2.9.5
