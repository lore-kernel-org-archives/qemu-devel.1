Received: from eggs.gnu.org ([2001:4830:134:3::10]:53260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMM-0006Jw-F0
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvML-00021q-BX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:10 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:16 +1100
Message-Id: <1484288903-18807-11-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 10/17] target/ppc/POWER9: Add POWER9 mmu
 fault handler
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

Add a new mmu fault handler for the POWER9 cpu and add it as the handler
for the POWER9 cpu definition.

This handler checks if the guest is radix or hash based on the value in the
partition table entry and calls the correct fault handler accordingly.

The hash fault handling code has also been updated to check if the
partition is using segment tables.

Currently only legacy hash (no segment tables) is supported.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/mmu-hash64.c     |  8 ++++++++
 target/ppc/mmu.h            |  8 ++++++++
 target/ppc/mmu_helper.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/translate_init.c |  2 +-
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index b9d4f4e..b476b3f 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -73,6 +73,14 @@ static ppc_slb_t *slb_lookup(PowerPCCPU *cpu, target_ulong eaddr)
         }
     }
 
+    /* Check if in-memory segment tables are in use */
+    if (ppc64_use_proc_tbl(cpu)) {
+        /* TODO - Unsupported */
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented - segment table support\n",
+                      __func__);
+        /* Not much we can do here, caller will generate a segment interrupt */
+    }
+
     return NULL;
 }
 
diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
index c7967c3..e07b128 100644
--- a/target/ppc/mmu.h
+++ b/target/ppc/mmu.h
@@ -3,6 +3,10 @@
 
 #ifndef CONFIG_USER_ONLY
 
+/* Common Partition Table Entry Fields */
+#define PATBE0_HR                0x8000000000000000
+#define PATBE1_GR                0x8000000000000000
+
 /* Partition Table Entry */
 struct patb_entry {
     uint64_t patbe0, patbe1;
@@ -11,6 +15,10 @@ struct patb_entry {
 #ifdef TARGET_PPC64
 
 void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error **errp);
+bool ppc64_use_proc_tbl(PowerPCCPU *cpu);
+bool ppc64_radix_guest(PowerPCCPU *cpu);
+int ppc64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                           int mmu_idx);
 
 #endif /* TARGET_PPC64 */
 
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index bc6c117..612f407 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -28,6 +28,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "helper_regs.h"
+#include "qemu/error-report.h"
 #include "mmu.h"
 
 //#define DEBUG_MMU
@@ -1281,6 +1282,17 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
     case POWERPC_MMU_2_07a:
         dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
         break;
+    case POWERPC_MMU_3_00:
+        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+            /* TODO - Unsupported */
+        } else {
+            if (ppc64_use_proc_tbl(ppc_env_get_cpu(env))) {
+                /* TODO - Unsupported */
+            } else {
+                dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
+                break;
+            }
+        }
 #endif
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);
@@ -1422,6 +1434,17 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
         return ppc_hash64_get_phys_page_debug(cpu, addr);
+    case POWERPC_MMU_3_00:
+        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+            /* TODO - Unsupported */
+        } else {
+            if (ppc64_use_proc_tbl(ppc_env_get_cpu(env))) {
+                /* TODO - Unsupported */
+            } else {
+                return ppc_hash64_get_phys_page_debug(cpu, addr);
+            }
+        }
+        break;
 #endif
 
     case POWERPC_MMU_32B:
@@ -2919,3 +2942,27 @@ void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error **errp)
 
     env->external_patbe = (struct patb_entry *) patb;
 }
+
+inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
+{
+    return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
+}
+
+inline bool ppc64_radix_guest(PowerPCCPU *cpu)
+{
+    struct patb_entry *patbe = cpu->env.external_patbe;
+
+    return patbe && (patbe->patbe1 & PATBE1_GR);
+}
+
+int ppc64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                           int mmu_idx)
+{
+    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
+        /* TODO - Unsupported */
+        error_report("Guest Radix Support Unimplemented\n");
+        abort();
+    } else { /* Guest uses hash */
+        return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
+    }
+}
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c771ba3..87297a7 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8850,7 +8850,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                     (1ull << MSR_LE);
     pcc->mmu_model = POWERPC_MMU_3_00;
 #if defined(CONFIG_SOFTMMU)
-    pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
+    pcc->handle_mmu_fault = ppc64_handle_mmu_fault;
     /* segment page size remain the same */
     pcc->sps = &POWER7_POWER8_sps;
 #endif
-- 
2.5.5
