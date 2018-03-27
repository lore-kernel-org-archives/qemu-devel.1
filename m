Received: from eggs.gnu.org ([2001:4830:134:3::10]:50654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0gN3-0001qh-BI
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0gN1-0002n4-CH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:38:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 27 Mar 2018 15:37:35 +1100
Message-Id: <20180327043741.7705-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180327043741.7705-1-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.13 06/12] target/ppc: Move page size setup
 to helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, groug@kaod.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

Initialization of the env->sps structure at the end of instance_init is
specific to the 64-bit hash MMU, so move the code into a helper function
in mmu-hash64.c.

We also create a corresponding function to be called at finalize time -
it's empty for now, but we'll need it shortly.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c     | 29 +++++++++++++++++++++++++++++
 target/ppc/mmu-hash64.h     | 11 +++++++++++
 target/ppc/translate_init.c | 29 +++++++++--------------------
 3 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index a87fa7c83f..4cb7d1cf07 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1095,3 +1095,32 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
     ppc_hash64_update_rmls(cpu);
     ppc_hash64_update_vrma(cpu);
 }
+
+void ppc_hash64_init(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+    if (pcc->sps) {
+        env->sps = *pcc->sps;
+    } else if (env->mmu_model & POWERPC_MMU_64) {
+        /* Use default sets of page sizes. We don't support MPSS */
+        static const struct ppc_segment_page_sizes defsps = {
+            .sps = {
+                { .page_shift = 12, /* 4K */
+                  .slb_enc = 0,
+                  .enc = { { .page_shift = 12, .pte_enc = 0 } }
+                },
+                { .page_shift = 24, /* 16M */
+                  .slb_enc = 0x100,
+                  .enc = { { .page_shift = 24, .pte_enc = 0 } }
+                },
+            },
+        };
+        env->sps = defsps;
+    }
+}
+
+void ppc_hash64_finalize(PowerPCCPU *cpu)
+{
+}
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 95a8c330d6..074ded4c27 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -19,6 +19,8 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
                                           uint64_t pte0, uint64_t pte1);
 void ppc_hash64_update_vrma(PowerPCCPU *cpu);
 void ppc_hash64_update_rmls(PowerPCCPU *cpu);
+void ppc_hash64_init(PowerPCCPU *cpu);
+void ppc_hash64_finalize(PowerPCCPU *cpu);
 #endif
 
 /*
@@ -136,4 +138,13 @@ static inline uint64_t ppc_hash64_hpte1(PowerPCCPU *cpu,
 
 #endif /* CONFIG_USER_ONLY */
 
+#if defined(CONFIG_USER_ONLY) || !defined(TARGET_PPC64)
+static inline void ppc_hash64_init(PowerPCCPU *cpu)
+{
+}
+static inline void ppc_hash64_finalize(PowerPCCPU *cpu)
+{
+}
+#endif
+
 #endif /* MMU_HASH64_H */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 99be6fcd68..aa63a5dcb3 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10464,26 +10464,14 @@ static void ppc_cpu_instance_init(Object *obj)
     env->has_hv_mode = !!(env->msr_mask & MSR_HVB);
 #endif
 
-#if defined(TARGET_PPC64)
-    if (pcc->sps) {
-        env->sps = *pcc->sps;
-    } else if (env->mmu_model & POWERPC_MMU_64) {
-        /* Use default sets of page sizes. We don't support MPSS */
-        static const struct ppc_segment_page_sizes defsps = {
-            .sps = {
-                { .page_shift = 12, /* 4K */
-                  .slb_enc = 0,
-                  .enc = { { .page_shift = 12, .pte_enc = 0 } }
-                },
-                { .page_shift = 24, /* 16M */
-                  .slb_enc = 0x100,
-                  .enc = { { .page_shift = 24, .pte_enc = 0 } }
-                },
-            },
-        };
-        env->sps = defsps;
-    }
-#endif /* defined(TARGET_PPC64) */
+    ppc_hash64_init(cpu);
+}
+
+static void ppc_cpu_instance_finalize(Object *obj)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(obj);
+
+    ppc_hash64_finalize(cpu);
 }
 
 static bool ppc_pvr_match_default(PowerPCCPUClass *pcc, uint32_t pvr)
@@ -10601,6 +10589,7 @@ static const TypeInfo ppc_cpu_type_info = {
     .parent = TYPE_CPU,
     .instance_size = sizeof(PowerPCCPU),
     .instance_init = ppc_cpu_instance_init,
+    .instance_finalize = ppc_cpu_instance_finalize,
     .abstract = true,
     .class_size = sizeof(PowerPCCPUClass),
     .class_init = ppc_cpu_class_init,
-- 
2.14.3
