Received: from eggs.gnu.org ([2001:4830:134:3::10]:41271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnm2-0008N7-H1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnm1-0001QN-9A
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 16:36:04 +1000
Message-Id: <20180618063606.2513-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180618063606.2513-1-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 7/9] target/ppc: Add
 ppc_hash64_filter_pagesizes()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The paravirtualized PAPR platform sometimes needs to restrict the guest to
using only some of the page sizes actually supported by the host's MMU.
At the moment this is handled in KVM specific code, but for consistency we
want to apply the same limitations to all accelerators.

This makes a start on this by providing a helper function in the cpu code
to allow platform code to remove some of the cpu's page size definitions
via a caller supplied callback.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 59 +++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash64.h |  3 +++
 2 files changed, 62 insertions(+)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index aa200cba4c..276d9015e7 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1166,3 +1166,62 @@ const PPCHash64Options ppc_hash64_opts_POWER7 = {
         },
     }
 };
+
+void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
+                                 bool (*cb)(void *, uint32_t, uint32_t),
+                                 void *opaque)
+{
+    PPCHash64Options *opts = cpu->hash64_opts;
+    int i;
+    int n = 0;
+    bool ci_largepage = false;
+
+    assert(opts);
+
+    n = 0;
+    for (i = 0; i < ARRAY_SIZE(opts->sps); i++) {
+        PPCHash64SegmentPageSizes *sps = &opts->sps[i];
+        int j;
+        int m = 0;
+
+        assert(n <= i);
+
+        if (!sps->page_shift) {
+            break;
+        }
+
+        for (j = 0; j < ARRAY_SIZE(sps->enc); j++) {
+            PPCHash64PageSize *ps = &sps->enc[j];
+
+            assert(m <= j);
+            if (!ps->page_shift) {
+                break;
+            }
+
+            if (cb(opaque, sps->page_shift, ps->page_shift)) {
+                if (ps->page_shift >= 16) {
+                    ci_largepage = true;
+                }
+                sps->enc[m++] = *ps;
+            }
+        }
+
+        /* Clear rest of the row */
+        for (j = m; j < ARRAY_SIZE(sps->enc); j++) {
+            memset(&sps->enc[j], 0, sizeof(sps->enc[j]));
+        }
+
+        if (m) {
+            n++;
+        }
+    }
+
+    /* Clear the rest of the table */
+    for (i = n; i < ARRAY_SIZE(opts->sps); i++) {
+        memset(&opts->sps[i], 0, sizeof(opts->sps[i]));
+    }
+
+    if (!ci_largepage) {
+        opts->flags &= ~PPC_HASH64_CI_LARGEPAGE;
+    }
+}
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 53dcec5b93..f11efc9cbc 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -20,6 +20,9 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
 void ppc_hash64_init(PowerPCCPU *cpu);
 void ppc_hash64_finalize(PowerPCCPU *cpu);
+void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
+                                 bool (*cb)(void *, uint32_t, uint32_t),
+                                 void *opaque);
 #endif
 
 /*
-- 
2.17.1
