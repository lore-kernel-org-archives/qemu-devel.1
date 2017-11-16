Received: from eggs.gnu.org ([2001:4830:134:3::10]:35369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eFBbL-0004RW-IJ
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 23:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eFBbK-0001jU-Dp
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 23:16:31 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 16 Nov 2017 15:16:07 +1100
Message-Id: <20171116041607.31852-2-sjitindarsingh@gmail.com>
In-Reply-To: <20171116041607.31852-1-sjitindarsingh@gmail.com>
References: <20171116041607.31852-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc: Update setting of cpu
 features to account for compat modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, sjitindarsingh@gmail.com

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
above to properly take into account any compat mode.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d682f01..0dab6f1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -44,6 +44,7 @@
 #include "migration/register.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
+#include "cpu-models.h"
 #include "qom/cpu.h"
 
 #include "hw/boards.h"
@@ -255,6 +256,7 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
                                       bool legacy_guest)
 {
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
     uint8_t pa_features_206[] = { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
     uint8_t pa_features_207[] = { 24, 0,
@@ -290,16 +292,36 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
     uint8_t *pa_features;
     size_t pa_size;
 
-    switch (POWERPC_MMU_VER(env->mmu_model)) {
-    case POWERPC_MMU_VER_2_06:
+    switch (cpu->compat_pvr) {
+    case 0:
+        /* If not in a compat mode then determine based on the mmu model */
+        switch (POWERPC_MMU_VER(env->mmu_model)) {
+        case POWERPC_MMU_VER_2_06:
+            pa_features = pa_features_206;
+            pa_size = sizeof(pa_features_206);
+            break;
+        case POWERPC_MMU_VER_2_07:
+            pa_features = pa_features_207;
+            pa_size = sizeof(pa_features_207);
+            break;
+        case POWERPC_MMU_VER_3_00:
+            pa_features = pa_features_300;
+            pa_size = sizeof(pa_features_300);
+            break;
+        default:
+            return;
+        }
+        break;
+    case CPU_POWERPC_LOGICAL_2_06:
+    case CPU_POWERPC_LOGICAL_2_06_PLUS:
         pa_features = pa_features_206;
         pa_size = sizeof(pa_features_206);
         break;
-    case POWERPC_MMU_VER_2_07:
+    case CPU_POWERPC_LOGICAL_2_07:
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
         break;
-    case POWERPC_MMU_VER_3_00:
+    case CPU_POWERPC_LOGICAL_3_00:
         pa_features = pa_features_300;
         pa_size = sizeof(pa_features_300);
         break;
@@ -941,6 +963,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
 static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
 {
     PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
+    CPUPPCState *env = &first_ppc_cpu->env;
 
     char val[2 * 4] = {
         23, 0x00, /* Xive mode, filled in below. */
@@ -949,7 +972,12 @@ static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
         26, 0x40, /* Radix options: GTSE == yes. */
     };
 
-    if (kvm_enabled()) {
+    if (POWERPC_MMU_VER(env->mmu_model) != POWERPC_MMU_VER_3_00 ||
+        (first_ppc_cpu->compat_pvr && (first_ppc_cpu->compat_pvr <
+                                       CPU_POWERPC_LOGICAL_3_00))) {
+        /* If we're in a pre POWER9 compat mode then the guest should do hash */
+        val[3] = 0x00; /* Hash */
+    } else if (kvm_enabled()) {
         if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) {
             val[3] = 0x80; /* OV5_MMU_BOTH */
         } else if (kvmppc_has_cap_mmu_radix()) {
-- 
2.9.5
