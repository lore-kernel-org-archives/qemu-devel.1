Received: from eggs.gnu.org ([2001:4830:134:3::10]:50746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0gNC-0001zs-0c
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0gNA-0002qi-AX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:38:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 27 Mar 2018 15:37:37 +1100
Message-Id: <20180327043741.7705-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180327043741.7705-1-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.13 08/12] target/ppc: Make hash64_opts
 field mandatory for 64-bit hash MMUs
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

Currently some cpus set the hash64_opts field in the class structure, with
specific details of their variant of the 64-bit hash mmu.  For the
remaining cpus with that mmu, ppc_hash64_realize() fills in defaults.

But there are only a couple of cpus that use those fallbacks, so just have
them to set the has64_opts field instead, simplifying the logic.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c     | 36 ++++++++++++++++++------------------
 target/ppc/mmu-hash64.h     |  1 +
 target/ppc/translate_init.c |  2 ++
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d7a0e5615f..d369b1bf86 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1100,25 +1100,12 @@ void ppc_hash64_init(PowerPCCPU *cpu)
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    if (pcc->hash64_opts) {
-        cpu->hash64_opts = g_memdup(pcc->hash64_opts,
-                                    sizeof(*cpu->hash64_opts));
-    } else if (env->mmu_model & POWERPC_MMU_64) {
-        /* Use default sets of page sizes. We don't support MPSS */
-        static const PPCHash64Options defopts = {
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
-        cpu->hash64_opts = g_memdup(&defopts, sizeof(*cpu->hash64_opts));
+    if (!pcc->hash64_opts) {
+        assert(!(env->mmu_model & POWERPC_MMU_64));
+        return;
     }
+
+    cpu->hash64_opts = g_memdup(pcc->hash64_opts, sizeof(*cpu->hash64_opts));
 }
 
 void ppc_hash64_finalize(PowerPCCPU *cpu)
@@ -1126,6 +1113,19 @@ void ppc_hash64_finalize(PowerPCCPU *cpu)
     g_free(cpu->hash64_opts);
 }
 
+const PPCHash64Options ppc_hash64_opts_basic = {
+    .sps = {
+        { .page_shift = 12, /* 4K */
+          .slb_enc = 0,
+          .enc = { { .page_shift = 12, .pte_enc = 0 } }
+        },
+        { .page_shift = 24, /* 16M */
+          .slb_enc = 0x100,
+          .enc = { { .page_shift = 24, .pte_enc = 0 } }
+        },
+    },
+};
+
 const PPCHash64Options ppc_hash64_opts_POWER7 = {
     .sps = {
         {
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index d42cbc2762..ff0c48af55 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -155,6 +155,7 @@ struct PPCHash64Options {
     struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
 };
 
+extern const PPCHash64Options ppc_hash64_opts_basic;
 extern const PPCHash64Options ppc_hash64_opts_POWER7;
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 040d6fbac3..ae005b2a54 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8242,6 +8242,7 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
     pcc->mmu_model = POWERPC_MMU_64B;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
+    pcc->hash64_opts = &ppc_hash64_opts_basic;
 #endif
     pcc->excp_model = POWERPC_EXCP_970;
     pcc->bus_model = PPC_FLAGS_INPUT_970;
@@ -8319,6 +8320,7 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
     pcc->mmu_model = POWERPC_MMU_2_03;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
+    pcc->hash64_opts = &ppc_hash64_opts_basic;
 #endif
     pcc->excp_model = POWERPC_EXCP_970;
     pcc->bus_model = PPC_FLAGS_INPUT_970;
-- 
2.14.3
