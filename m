Received: from eggs.gnu.org ([2001:4830:134:3::10]:58732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EG-0000V2-JP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EC-0004uP-Rw
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:12 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:51204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e20EC-0004u1-Lu
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:08 -0400
Received: by mail-pf0-x231.google.com with SMTP id n14so16371872pfh.8
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:30:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Oct 2017 12:29:44 -0700
Message-Id: <20171010193003.28857-2-richard.henderson@linaro.org>
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 01/20] cputlb: bring back tlb_flush_count
 under !TLB_DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Commit f0aff0f124 ("cputlb: add assert_cpu_is_self checks") buried
the increment of tlb_flush_count under TLB_DEBUG. This results in
"info jit" always (mis)reporting 0 TLB flushes when !TLB_DEBUG.

Besides, under MTTCG tlb_flush_count is updated by several threads,
so in order not to lose counts we'd either have to use atomic ops
or distribute the counter, which is more scalable.

This patch does the latter by embedding tlb_flush_count in CPUArchState.
The global count is then easily obtained by iterating over the CPU list.

Note that this change also requires updating the accessors to
tlb_flush_count to use atomic_read/set whenever there may be conflicting
accesses (as defined in C11) to it.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h   |  1 +
 include/exec/cputlb.h     |  3 +--
 accel/tcg/cputlb.c        | 17 ++++++++++++++---
 accel/tcg/translate-all.c |  2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index bc8e7f848d..e43ff8346b 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -137,6 +137,7 @@ typedef struct CPUIOTLBEntry {
     CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
     CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];                    \
     CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];                 \
+    size_t tlb_flush_count;                                             \
     target_ulong tlb_flush_addr;                                        \
     target_ulong tlb_flush_mask;                                        \
     target_ulong vtlb_index;                                            \
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 3f941783c5..c91db211bc 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -23,7 +23,6 @@
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
-extern int tlb_flush_count;
-
+size_t tlb_flush_count(void);
 #endif
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bcbcc4db6c..5b1ef1442c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -92,8 +92,18 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
     }
 }
 
-/* statistics */
-int tlb_flush_count;
+size_t tlb_flush_count(void)
+{
+    CPUState *cpu;
+    size_t count = 0;
+
+    CPU_FOREACH(cpu) {
+        CPUArchState *env = cpu->env_ptr;
+
+        count += atomic_read(&env->tlb_flush_count);
+    }
+    return count;
+}
 
 /* This is OK because CPU architectures generally permit an
  * implementation to drop entries from the TLB at any time, so
@@ -112,7 +122,8 @@ static void tlb_flush_nocheck(CPUState *cpu)
     }
 
     assert_cpu_is_self(cpu);
-    tlb_debug("(count: %d)\n", tlb_flush_count++);
+    atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
+    tlb_debug("(count: %zu)\n", tlb_flush_count());
 
     tb_lock();
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2d1ed06065..6b5d4bece2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1936,7 +1936,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
             atomic_read(&tcg_ctx.tb_ctx.tb_flush_count));
     cpu_fprintf(f, "TB invalidate count %d\n",
             tcg_ctx.tb_ctx.tb_phys_invalidate_count);
-    cpu_fprintf(f, "TLB flush count     %d\n", tlb_flush_count);
+    cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
     tcg_dump_info(f, cpu_fprintf);
 
     tb_unlock();
-- 
2.13.6
