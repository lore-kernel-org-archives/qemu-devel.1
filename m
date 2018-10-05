Received: from eggs.gnu.org ([2001:4830:134:3::10]:56691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM6-0006XU-St
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM1-000667-Hp
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:29 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM0-00064G-MV
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id n1-v6so14042960wrt.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:57 +0100
Message-Id: <20181005154910.3099-9-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 08/21] accel/tcg/cputlb: convert remaining
 tlb_debug() to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

The last remaining user of tlb_debug() is the set page code. We can
convert this to a trace event and remove associated logging machinery.
The DEBUG_TLB define remains to enable self-check code when debugging.

To avoid overly long lines in trace events I've split the event into
tlb_set_page and tlb_set_page_attrs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c     | 27 +++++----------------------
 accel/tcg/trace-events |  5 +++++
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f1d4f7da44..abdc4c5d25 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,31 +34,16 @@
 #include "exec/helper-proto.h"
 #include "qemu/atomic.h"
 
-/* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
+/* DEBUG_TLB turns on internal self-checks, actions are logged via
+ * trace-events */
 /* #define DEBUG_TLB */
-/* #define DEBUG_TLB_LOG */
 
 #ifdef DEBUG_TLB
 # define DEBUG_TLB_GATE 1
-# ifdef DEBUG_TLB_LOG
-#  define DEBUG_TLB_LOG_GATE 1
-# else
-#  define DEBUG_TLB_LOG_GATE 0
-# endif
 #else
 # define DEBUG_TLB_GATE 0
-# define DEBUG_TLB_LOG_GATE 0
 #endif
 
-#define tlb_debug(fmt, ...) do { \
-    if (DEBUG_TLB_LOG_GATE) { \
-        qemu_log_mask(CPU_LOG_MMU, "%s: " fmt, __func__, \
-                      ## __VA_ARGS__); \
-    } else if (DEBUG_TLB_GATE) { \
-        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
-    } \
-} while (0)
-
 #define assert_cpu_is_self(this_cpu) do {                         \
         if (DEBUG_TLB_GATE) {                                     \
             g_assert(!cpu->created || qemu_cpu_is_self(cpu));     \
@@ -124,7 +109,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
 
     assert_cpu_is_self(cpu);
     atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
-    tlb_debug("(count: %zu)\n", tlb_flush_count());
 
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
@@ -629,6 +613,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 
     assert_cpu_is_self(cpu);
 
+    trace_tlb_set_page(cpu->cpu_index, vaddr, paddr);
+    trace_tlb_set_page_attrs(*(unsigned int *) &attrs, prot, mmu_idx, size);
+
     if (size < TARGET_PAGE_SIZE) {
         sz = TARGET_PAGE_SIZE;
     } else {
@@ -644,10 +631,6 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
                                                 &xlat, &sz, attrs, &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
-    tlb_debug("vaddr=" TARGET_FMT_lx " paddr=0x" TARGET_FMT_plx
-              " prot=%x idx=%d\n",
-              vaddr, paddr, prot, mmu_idx);
-
     address = vaddr_page;
     if (size < TARGET_PAGE_SIZE) {
         /*
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 0d2b1c47ac..82705632f2 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -15,6 +15,11 @@ tlb_flush_synced_schedule(int line, int from, int to) "cputlb.c:%d from_cpu=%d t
 tlb_flush_all_work(int vcpu) "cpu %d"
 tlb_flush_work(int line, int vcpu, unsigned long data) "cputlb.c:%d cpu %d, %lux"
 tlb_flush_work_complete(int line, int vcpu) "cputlb.c:%d cpu %d"
+#
+# TLB entries
+#
+tlb_set_page(int vcpu, unsigned long vaddr, unsigned long paddr) "cpu:%d vaddr:0x%lx paddr:0x%lx"
+tlb_set_page_attrs(unsigned int attrs, int prot, int mmu_idx, int size) "attrs:0x%x prot:0x%x mmu_idx:%d size:%d"
 
 # TCG related tracing (you still need -d nochain to get a full picture
 # as otherwise you'll only see the first TB executed in a chain)
-- 
2.17.1
