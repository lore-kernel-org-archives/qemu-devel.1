Received: from eggs.gnu.org ([2001:4830:134:3::10]:43742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxtNT-0003Y9-D1
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxtNQ-0004SG-Ur
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:27 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxtNQ-0004S0-Lq
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:24 -0400
Received: by mail-wm0-x232.google.com with SMTP id o81so59948034wmb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 03:50:24 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Apr 2017 11:50:29 +0100
Message-Id: <20170411105031.28904-2-alex.bennee@linaro.org>
In-Reply-To: <20170411105031.28904-1-alex.bennee@linaro.org>
References: <20170411105031.28904-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/3] cputlb: fix and enhance TLB statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com, rth@twiddle.net, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

First this fixes the fact that statistics where only being updated if
the build was built with DEBUG_TLB. Also it now counts the flush cases
based on the degree of synchronisation required to run. This is a more
useful discriminator for seeing what is slowing down the translation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cputlb.c              | 27 ++++++++++++++++++++++++---
 include/exec/cputlb.h |  4 +++-
 translate-all.c       |  4 +++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index f5d056cc08..224863ed76 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -92,8 +92,13 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
     }
 }
 
-/* statistics */
-int tlb_flush_count;
+/* Useful statistics - in rough order of expensiveness to the whole
+ * simulation. Synced flushes are the most expensive as all vCPUs need
+ * to be paused for the flush.
+ */
+int tlb_self_flush_count;        /* from vCPU context */
+int tlb_async_flush_count;       /* Deferred flush */
+int tlb_synced_flush_count;      /* Synced flush, all vCPUs halted */
 
 /* This is OK because CPU architectures generally permit an
  * implementation to drop entries from the TLB at any time, so
@@ -112,7 +117,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
     }
 
     assert_cpu_is_self(cpu);
-    tlb_debug("(count: %d)\n", tlb_flush_count++);
 
     tb_lock();
 
@@ -131,6 +135,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
 
 static void tlb_flush_global_async_work(CPUState *cpu, run_on_cpu_data data)
 {
+    atomic_inc(&tlb_async_flush_count);
     tlb_flush_nocheck(cpu);
 }
 
@@ -143,6 +148,7 @@ void tlb_flush(CPUState *cpu)
                              RUN_ON_CPU_NULL);
         }
     } else {
+        atomic_inc(&tlb_self_flush_count);
         tlb_flush_nocheck(cpu);
     }
 }
@@ -157,6 +163,7 @@ void tlb_flush_all_cpus(CPUState *src_cpu)
 void tlb_flush_all_cpus_synced(CPUState *src_cpu)
 {
     const run_on_cpu_func fn = tlb_flush_global_async_work;
+    atomic_inc(&tlb_synced_flush_count);
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_NULL);
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_NULL);
 }
@@ -168,6 +175,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
+    atomic_inc(&tlb_async_flush_count);
 
     tb_lock();
 
@@ -206,6 +214,7 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
                              RUN_ON_CPU_HOST_INT(pending_flushes));
         }
     } else {
+        atomic_inc(&tlb_self_flush_count);
         tlb_flush_by_mmuidx_async_work(cpu,
                                        RUN_ON_CPU_HOST_INT(idxmap));
     }
@@ -219,6 +228,7 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, uint16_t idxmap)
 
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
     fn(src_cpu, RUN_ON_CPU_HOST_INT(idxmap));
+    atomic_inc(&tlb_self_flush_count);
 }
 
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
@@ -230,6 +240,7 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
 
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
+    atomic_inc(&tlb_synced_flush_count);
 }
 
 
@@ -282,6 +293,8 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
     }
 
     tb_flush_jmp_cache(cpu, addr);
+
+    atomic_inc(&tlb_async_flush_count);
 }
 
 void tlb_flush_page(CPUState *cpu, target_ulong addr)
@@ -293,6 +306,7 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
                          RUN_ON_CPU_TARGET_PTR(addr));
     } else {
         tlb_flush_page_async_work(cpu, RUN_ON_CPU_TARGET_PTR(addr));
+        atomic_inc(&tlb_self_flush_count);
     }
 }
 
@@ -329,6 +343,7 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     }
 
     tb_flush_jmp_cache(cpu, addr);
+    atomic_inc(&tlb_async_flush_count);
 }
 
 static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
@@ -351,6 +366,7 @@ static void tlb_check_page_and_flush_by_mmuidx_async_work(CPUState *cpu,
                                        RUN_ON_CPU_HOST_INT(mmu_idx_bitmap));
     } else {
         tlb_flush_page_by_mmuidx_async_work(cpu, data);
+        atomic_inc(&tlb_self_flush_count);
     }
 }
 
@@ -370,6 +386,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
     } else {
         tlb_check_page_and_flush_by_mmuidx_async_work(
             cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+        atomic_inc(&tlb_self_flush_count);
     }
 }
 
@@ -387,6 +404,7 @@ void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
 
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
     fn(src_cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    atomic_inc(&tlb_self_flush_count);
 }
 
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
@@ -404,6 +422,7 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
 
     flush_all_helper(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+    atomic_inc(&tlb_synced_flush_count);
 }
 
 void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
@@ -412,6 +431,7 @@ void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
 
     flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
     fn(src, RUN_ON_CPU_TARGET_PTR(addr));
+    atomic_inc(&tlb_self_flush_count);
 }
 
 void tlb_flush_page_all_cpus_synced(CPUState *src,
@@ -421,6 +441,7 @@ void tlb_flush_page_all_cpus_synced(CPUState *src,
 
     flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
     async_safe_run_on_cpu(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
+    atomic_inc(&tlb_synced_flush_count);
 }
 
 /* update the TLBs so that writes to code in the virtual page 'addr'
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 3f941783c5..5085384014 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -23,7 +23,9 @@
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
-extern int tlb_flush_count;
+extern int tlb_self_flush_count;
+extern int tlb_async_flush_count;
+extern int tlb_synced_flush_count;
 
 #endif
 #endif
diff --git a/translate-all.c b/translate-all.c
index b3ee876526..0578ae6123 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1927,7 +1927,9 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
             atomic_read(&tcg_ctx.tb_ctx.tb_flush_count));
     cpu_fprintf(f, "TB invalidate count %d\n",
             tcg_ctx.tb_ctx.tb_phys_invalidate_count);
-    cpu_fprintf(f, "TLB flush count     %d\n", tlb_flush_count);
+    cpu_fprintf(f, "TLB flush counts    self:%d async:%d synced:%d\n",
+                tlb_self_flush_count, tlb_async_flush_count,
+                tlb_synced_flush_count);
     tcg_dump_info(f, cpu_fprintf);
 
     tb_unlock();
-- 
2.11.0
