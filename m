Received: from eggs.gnu.org ([2001:4830:134:3::10]:51676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9cC-0000Y1-4B
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9c8-00069G-U7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJ9c8-00068a-ET
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  8 Jun 2017 22:25:19 -0400
Message-Id: <1496975122-16999-5-git-send-email-cota@braap.org>
In-Reply-To: <1496975122-16999-1-git-send-email-cota@braap.org>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 4/7] exec: [tcg] Use different TBs according
 to the vCPU's dynamic tracing state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Every vCPU now uses a separate set of TBs for each set of dynamic
tracing event state values. Each set of TBs can be used by any number of
vCPUs to maximize TB reuse when vCPUs have the same tracing state.

This feature is later used by tracetool to optimize tracing of guest
code events.

The maximum number of TB sets is defined as 2^E, where E is the number
of events that have the 'vcpu' property (their state is stored in
CPUState->trace_dstate).

For this to work, a change on the dynamic tracing state of a vCPU will
force it to flush its virtual TB cache (which is only indexed by
address), and fall back to the physical TB cache (which now contains the
vCPU's dynamic tracing state as part of the hashing function).

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
[cota:
 - rename tb->trace_vcpu_dstate to the shorter tb->trace_ds
 - use uint32_t for tb->trace_ds instead of a typedef
 - add BUILD_BUG_ON check to make sure tb->trace_ds is big enough
 - fix xxhash
 - directly dereference cpu->trace_dstate instead of using bitmap_copy etc.
 - drop trace_dstate parameter from tb_htable_lookup; grab it directly from cpu.
]
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpu-exec.c                |  8 ++++++--
 include/exec/exec-all.h   |  3 +++
 include/exec/tb-hash-xx.h |  7 +++++--
 include/exec/tb-hash.h    |  5 +++--
 tcg-runtime.c             |  3 ++-
 tests/qht-bench.c         |  2 +-
 trace/control-target.c    |  1 +
 trace/control.h           |  3 +++
 translate-all.c           | 10 ++++++++--
 9 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 5b181c1..b6679d9 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -280,6 +280,7 @@ struct tb_desc {
     CPUArchState *env;
     tb_page_addr_t phys_page1;
     uint32_t flags;
+    uint32_t trace_ds;
 };
 
 static bool tb_cmp(const void *p, const void *d)
@@ -291,6 +292,7 @@ static bool tb_cmp(const void *p, const void *d)
         tb->page_addr[0] == desc->phys_page1 &&
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
+        tb->trace_ds == desc->trace_ds &&
         !atomic_read(&tb->invalid)) {
         /* check next page if needed */
         if (tb->page_addr[1] == -1) {
@@ -319,10 +321,11 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     desc.env = (CPUArchState *)cpu->env_ptr;
     desc.cs_base = cs_base;
     desc.flags = flags;
+    desc.trace_ds = *cpu->trace_dstate;
     desc.pc = pc;
     phys_pc = get_page_addr_code(desc.env, pc);
     desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
-    h = tb_hash_func(phys_pc, pc, flags);
+    h = tb_hash_func(phys_pc, pc, flags, *cpu->trace_dstate);
     return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
 }
 
@@ -342,7 +345,8 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
     tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)]);
     if (unlikely(!tb || tb->pc != pc || tb->cs_base != cs_base ||
-                 tb->flags != flags)) {
+                 tb->flags != flags ||
+                 tb->trace_ds != *cpu->trace_dstate)) {
         tb = tb_htable_lookup(cpu, pc, cs_base, flags);
         if (!tb) {
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b0281b0..6bdc6e5 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -324,6 +324,9 @@ struct TranslationBlock {
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
 
+    /* Tracing Dynamic State (hence '_ds') used to generate this TB */
+    uint32_t trace_ds;
+
     uint16_t invalid;
 
     void *tc_ptr;    /* pointer to the translated code */
diff --git a/include/exec/tb-hash-xx.h b/include/exec/tb-hash-xx.h
index 2c40b5c..6cd3022 100644
--- a/include/exec/tb-hash-xx.h
+++ b/include/exec/tb-hash-xx.h
@@ -49,7 +49,7 @@
  * contiguous in memory.
  */
 static inline
-uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint32_t e)
+uint32_t tb_hash_func6(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f)
 {
     uint32_t v1 = TB_HASH_XX_SEED + PRIME32_1 + PRIME32_2;
     uint32_t v2 = TB_HASH_XX_SEED + PRIME32_2;
@@ -78,11 +78,14 @@ uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint32_t e)
     v4 *= PRIME32_1;
 
     h32 = rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
-    h32 += 20;
+    h32 += 24;
 
     h32 += e * PRIME32_3;
     h32  = rol32(h32, 17) * PRIME32_4;
 
+    h32 += f * PRIME32_3;
+    h32  = rol32(h32, 17) * PRIME32_4;
+
     h32 ^= h32 >> 15;
     h32 *= PRIME32_2;
     h32 ^= h32 >> 13;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index b1fe2d0..d64c2d9 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -58,9 +58,10 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 #endif /* CONFIG_SOFTMMU */
 
 static inline
-uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags)
+uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
+                      uint32_t trace_ds)
 {
-    return tb_hash_func5(phys_pc, pc, flags);
+    return tb_hash_func6(phys_pc, pc, flags, trace_ds);
 }
 
 #endif
diff --git a/tcg-runtime.c b/tcg-runtime.c
index 7fa90ce..71d8956 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -155,9 +155,10 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
     if (likely(tb)) {
         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
         if (likely(tb->pc == addr && tb->cs_base == cs_base &&
-                   tb->flags == flags)) {
+                   tb->flags == flags && tb->trace_ds == *cpu->trace_dstate)) {
             goto found;
         }
+
         tb = tb_htable_lookup(cpu, addr, cs_base, flags);
         if (likely(tb)) {
             atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 2afa09d..11c1cec 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -103,7 +103,7 @@ static bool is_equal(const void *obj, const void *userp)
 
 static inline uint32_t h(unsigned long v)
 {
-    return tb_hash_func5(v, 0, 0);
+    return tb_hash_func6(v, 0, 0, 0);
 }
 
 /*
diff --git a/trace/control-target.c b/trace/control-target.c
index 416d14e..ce7347e 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -40,6 +40,7 @@ static void trace_event_synchronize_vcpu_state_dynamic(
 {
     bitmap_copy(vcpu->trace_dstate, vcpu->trace_dstate_delayed,
                 CPU_TRACE_DSTATE_MAX_EVENTS);
+    tb_flush_jmp_cache_all(vcpu);
 }
 
 void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
diff --git a/trace/control.h b/trace/control.h
index 4ea53e2..b931824 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -165,6 +165,9 @@ void trace_event_set_state_dynamic(TraceEvent *ev, bool state);
  * Set the dynamic tracing state of an event for the given vCPU.
  *
  * Pre-condition: trace_event_get_vcpu_state_static(ev) == true
+ *
+ * Note: Changes for execution-time events with the 'tcg' property will not be
+ *       propagated until the next TB is executed (iff executing in TCG mode).
  */
 void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
                                         TraceEvent *ev, bool state);
diff --git a/translate-all.c b/translate-all.c
index 8a5dc19..42beea2 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -53,6 +53,7 @@
 #include "exec/cputlb.h"
 #include "exec/tb-hash.h"
 #include "translate-all.h"
+#include "qemu/error-report.h"
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
@@ -112,6 +113,10 @@ typedef struct PageDesc {
 #define V_L2_BITS 10
 #define V_L2_SIZE (1 << V_L2_BITS)
 
+/* Make sure all possible CPU event bits fit in tb->trace_ds */
+QEMU_BUILD_BUG_ON(CPU_TRACE_DSTATE_MAX_EVENTS >
+                  sizeof(((TranslationBlock *)0)->trace_ds) * BITS_PER_BYTE);
+
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
@@ -1096,7 +1101,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags);
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_ds);
     qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
 
     /* remove the TB from the page list */
@@ -1241,7 +1246,7 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     }
 
     /* add in the hash table */
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags);
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_ds);
     qht_insert(&tcg_ctx.tb_ctx.htable, tb, h);
 
 #ifdef DEBUG_TB_CHECK
@@ -1286,6 +1291,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cs_base = cs_base;
     tb->flags = flags;
     tb->cflags = cflags;
+    tb->trace_ds = *cpu->trace_dstate;
 
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count1++; /* includes aborted translations because of
-- 
2.7.4
