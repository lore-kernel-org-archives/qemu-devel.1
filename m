Received: from eggs.gnu.org ([2001:4830:134:3::10]:53220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMG-0006Ea-UL
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMF-00020X-QZ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:04 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:15 +1100
Message-Id: <1484288903-18807-10-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 09/17] target/ppc/POWER9: Remove SDR1
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The SDR1 registers was used to store the location of the hash page table.

This register no longer exists on POWER9 processors, so don't create it.

We now store the hash page table location in the process table entry.

We now check if the SDR1 register exists before printing its value when
displaying register debug info.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/kvm.c            | 10 +++++++++-
 target/ppc/mmu-hash64.c     | 15 ++++++++++++++-
 target/ppc/translate.c      |  6 ++++--
 target/ppc/translate_init.c | 16 +++++++++++++---
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9c4834c..6016930 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -930,7 +930,15 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
 
     sregs.pvr = env->spr[SPR_PVR];
 
-    sregs.u.s.sdr1 = env->spr[SPR_SDR1];
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        if (env->external_patbe)
+            sregs.u.s.sdr1 = env->external_patbe->patbe0;
+        break;
+    default:
+        sregs.u.s.sdr1 = env->spr[SPR_SDR1];
+        break;
+    }
 
     /* Sync SLB */
 #ifdef TARGET_PPC64
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index fe7da18..b9d4f4e 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -291,7 +291,20 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
     CPUPPCState *env = &cpu->env;
     target_ulong htabsize = value & SDR_64_HTABSIZE;
 
-    env->spr[SPR_SDR1] = value;
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        /*
+         * Technically P9 doesn't have a SDR1, the hash table address should be
+         * stored in the partition table entry instead.
+         */
+        if (env->external_patbe)
+            env->external_patbe->patbe0 = value;
+        break;
+    default:
+        env->spr[SPR_SDR1] = value;
+        break;
+    }
+
     if (htabsize > 28) {
         error_setg(errp,
                    "Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1",
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 1212180..521aed3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6922,9 +6922,11 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     case POWERPC_MMU_2_06a:
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_3_00:
 #endif
-        cpu_fprintf(f, " SDR1 " TARGET_FMT_lx "   DAR " TARGET_FMT_lx
-                       "  DSISR " TARGET_FMT_lx "\n", env->spr[SPR_SDR1],
+        if (env->spr_cb[SPR_SDR1].name)
+            cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1]);
+        cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "\n",
                     env->spr[SPR_DAR], env->spr[SPR_DSISR]);
         break;
     case POWERPC_MMU_BOOKE206:
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index a1994d3..c771ba3 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
+#include "mmu.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -722,8 +723,8 @@ static void gen_spr_generic (CPUPPCState *env)
                  0x00000000);
 }
 
-/* SPR common to all non-embedded PowerPC, including 601 */
-static void gen_spr_ne_601 (CPUPPCState *env)
+/* SPR common to all non-embedded PowerPC, including POWER9 */
+static void gen_spr_ne_power9 (CPUPPCState *env)
 {
     /* Exception processing */
     spr_register_kvm(env, SPR_DSISR, "DSISR",
@@ -739,6 +740,12 @@ static void gen_spr_ne_601 (CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_decr, &spr_write_decr,
                  0x00000000);
+}
+
+/* SPR common to all non-embedded PowerPC, including 601 */
+static void gen_spr_ne_601 (CPUPPCState *env)
+{
+    gen_spr_ne_power9(env);
     /* Memory management */
     spr_register(env, SPR_SDR1, "SDR1",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -8222,7 +8229,6 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
 
 static void init_proc_book3s_64(CPUPPCState *env, int version)
 {
-    gen_spr_ne_601(env);
     gen_tbl(env);
     gen_spr_book3s_altivec(env);
     gen_spr_book3s_pmu_sup(env);
@@ -8280,6 +8286,10 @@ static void init_proc_book3s_64(CPUPPCState *env, int version)
         gen_spr_power8_book4(env);
         gen_spr_power8_rpr(env);
     }
+    if (version >= BOOK3S_CPU_POWER9)
+        gen_spr_ne_power9(env);
+    else
+        gen_spr_ne_601(env);
     if (version < BOOK3S_CPU_POWER8) {
         gen_spr_book3s_dbg(env);
     } else {
-- 
2.5.5
