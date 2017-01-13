Received: from eggs.gnu.org ([2001:4830:134:3::10]:50649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8m9-0007Oh-CC
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8m6-00060O-8O
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:41 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:49717)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8m5-0005zd-Nu
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:38 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 13 Jan 2017 21:48:35 +0100
Message-Id: <148434051502.31446.15856830123123961768.stgit@frigg.lan>
In-Reply-To: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 4/7] exec: [tcg] Use different TBs according
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
Cc: Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

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

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 cpu-exec.c                |   22 +++++++++++++++++-----
 include/exec/exec-all.h   |    5 +++++
 include/exec/tb-hash-xx.h |    8 +++++++-
 include/exec/tb-hash.h    |    5 +++--
 include/qemu-common.h     |    3 +++
 tests/qht-bench.c         |    2 +-
 trace/control-target.c    |    1 +
 trace/control.h           |    3 +++
 translate-all.c           |   16 ++++++++++++++--
 9 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 4188fed3c6..36709cba1f 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -261,6 +261,7 @@ struct tb_desc {
     CPUArchState *env;
     tb_page_addr_t phys_page1;
     uint32_t flags;
+    TRACE_QHT_VCPU_DSTATE_TYPE trace_vcpu_dstate;
 };
=20
 static bool tb_cmp(const void *p, const void *d)
@@ -272,6 +273,7 @@ static bool tb_cmp(const void *p, const void *d)
         tb->page_addr[0] =3D=3D desc->phys_page1 &&
         tb->cs_base =3D=3D desc->cs_base &&
         tb->flags =3D=3D desc->flags &&
+        tb->trace_vcpu_dstate =3D=3D desc->trace_vcpu_dstate &&
         !atomic_read(&tb->invalid)) {
         /* check next page if needed */
         if (tb->page_addr[1] =3D=3D -1) {
@@ -293,7 +295,8 @@ static bool tb_cmp(const void *p, const void *d)
 static TranslationBlock *tb_htable_lookup(CPUState *cpu,
                                           target_ulong pc,
                                           target_ulong cs_base,
-                                          uint32_t flags)
+                                          uint32_t flags,
+                                          uint32_t trace_vcpu_dstate)
 {
     tb_page_addr_t phys_pc;
     struct tb_desc desc;
@@ -302,10 +305,11 @@ static TranslationBlock *tb_htable_lookup(CPUState =
*cpu,
     desc.env =3D (CPUArchState *)cpu->env_ptr;
     desc.cs_base =3D cs_base;
     desc.flags =3D flags;
+    desc.trace_vcpu_dstate =3D trace_vcpu_dstate;
     desc.pc =3D pc;
     phys_pc =3D get_page_addr_code(desc.env, pc);
     desc.phys_page1 =3D phys_pc & TARGET_PAGE_MASK;
-    h =3D tb_hash_func(phys_pc, pc, flags);
+    h =3D tb_hash_func(phys_pc, pc, flags, trace_vcpu_dstate);
     return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
 }
=20
@@ -317,16 +321,24 @@ static inline TranslationBlock *tb_find(CPUState *c=
pu,
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
+    unsigned long trace_vcpu_dstate_bitmap;
+    TRACE_QHT_VCPU_DSTATE_TYPE trace_vcpu_dstate;
     bool have_tb_lock =3D false;
=20
+    bitmap_copy(&trace_vcpu_dstate_bitmap, cpu->trace_dstate,
+                trace_get_vcpu_event_count());
+    memcpy(&trace_vcpu_dstate, &trace_vcpu_dstate_bitmap,
+           sizeof(trace_vcpu_dstate));
+
     /* we record a subset of the CPU state. It will
        always be the same before a given translated block
        is executed. */
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
     tb =3D atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)=
]);
     if (unlikely(!tb || tb->pc !=3D pc || tb->cs_base !=3D cs_base ||
-                 tb->flags !=3D flags)) {
-        tb =3D tb_htable_lookup(cpu, pc, cs_base, flags);
+                 tb->flags !=3D flags ||
+                 tb->trace_vcpu_dstate !=3D trace_vcpu_dstate)) {
+        tb =3D tb_htable_lookup(cpu, pc, cs_base, flags, trace_vcpu_dsta=
te);
         if (!tb) {
=20
             /* mmap_lock is needed by tb_gen_code, and mmap_lock must be
@@ -340,7 +352,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu=
,
             /* There's a chance that our desired tb has been translated =
while
              * taking the locks so we check again inside the lock.
              */
-            tb =3D tb_htable_lookup(cpu, pc, cs_base, flags);
+            tb =3D tb_htable_lookup(cpu, pc, cs_base, flags, trace_vcpu_=
dstate);
             if (!tb) {
                 /* if no translated code available, then translate it no=
w */
                 tb =3D tb_gen_code(cpu, pc, cs_base, flags, 0);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 57cd978578..ae74f61ea2 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -200,6 +200,10 @@ static inline void tlb_flush_by_mmuidx(CPUState *cpu=
, ...)
 #define USE_DIRECT_JUMP
 #endif
=20
+/**
+ * TranslationBlock:
+ * @trace_vcpu_dstate: Per-vCPU dynamic tracing state used to generate t=
his TB.
+ */
 struct TranslationBlock {
     target_ulong pc;   /* simulated PC corresponding to this block (EIP =
+ CS base) */
     target_ulong cs_base; /* CS base for this block */
@@ -215,6 +219,7 @@ struct TranslationBlock {
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
=20
     uint16_t invalid;
+    TRACE_QHT_VCPU_DSTATE_TYPE trace_vcpu_dstate;
=20
     void *tc_ptr;    /* pointer to the translated code */
     uint8_t *tc_search;  /* pointer to search data */
diff --git a/include/exec/tb-hash-xx.h b/include/exec/tb-hash-xx.h
index 2c40b5c466..0a18801fd3 100644
--- a/include/exec/tb-hash-xx.h
+++ b/include/exec/tb-hash-xx.h
@@ -35,6 +35,7 @@
 #define EXEC_TB_HASH_XX_H
=20
 #include "qemu/bitops.h"
+#include "qemu-common.h"
=20
 #define PRIME32_1   2654435761U
 #define PRIME32_2   2246822519U
@@ -49,7 +50,8 @@
  * contiguous in memory.
  */
 static inline
-uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint32_t e)
+uint32_t tb_hash_func6(uint64_t a0, uint64_t b0, uint32_t e,
+                       TRACE_QHT_VCPU_DSTATE_TYPE f)
 {
     uint32_t v1 =3D TB_HASH_XX_SEED + PRIME32_1 + PRIME32_2;
     uint32_t v2 =3D TB_HASH_XX_SEED + PRIME32_2;
@@ -83,6 +85,10 @@ uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint3=
2_t e)
     h32 +=3D e * PRIME32_3;
     h32  =3D rol32(h32, 17) * PRIME32_4;
=20
+    QEMU_BUILD_BUG_ON(sizeof(TRACE_QHT_VCPU_DSTATE_TYPE) !=3D sizeof(uin=
t32_t));
+    h32 +=3D f * PRIME32_3;
+    h32  =3D rol32(h32, 17) * PRIME32_4;
+
     h32 ^=3D h32 >> 15;
     h32 *=3D PRIME32_2;
     h32 ^=3D h32 >> 13;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 2c27490cb8..a042f24c97 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -46,9 +46,10 @@ static inline unsigned int tb_jmp_cache_hash_func(targ=
et_ulong pc)
 }
=20
 static inline
-uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t =
flags)
+uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
+                      uint32_t flags, uint32_t trace_vcpu_dstate)
 {
-    return tb_hash_func5(phys_pc, pc, flags);
+    return tb_hash_func6(phys_pc, pc, flags, trace_vcpu_dstate);
 }
=20
 #endif
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 1430390eb6..aaaa73a6fe 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -151,4 +151,7 @@ void page_size_init(void);
  * returned. */
 bool dump_in_progress(void);
=20
+/* Use a macro to allow safe changes to its size in the future */
+#define TRACE_QHT_VCPU_DSTATE_TYPE uint32_t
+
 #endif
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 2afa09d859..11c1cec766 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -103,7 +103,7 @@ static bool is_equal(const void *obj, const void *use=
rp)
=20
 static inline uint32_t h(unsigned long v)
 {
-    return tb_hash_func5(v, 0, 0);
+    return tb_hash_func6(v, 0, 0, 0);
 }
=20
 /*
diff --git a/trace/control-target.c b/trace/control-target.c
index dba3b21bb0..bab56cfd0a 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -63,6 +63,7 @@ static void trace_event_synchronize_vcpu_state_dynamic(
 {
     bitmap_copy(vcpu->trace_dstate, vcpu->trace_dstate_delayed,
                 trace_get_vcpu_event_count());
+    tb_flush_jmp_cache_all(vcpu);
 }
=20
 void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
diff --git a/trace/control.h b/trace/control.h
index 6dfbc53c8d..772e4f6e9f 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -165,6 +165,9 @@ void trace_event_set_state_dynamic(TraceEvent *ev, bo=
ol state);
  * Set the dynamic tracing state of an event for the given vCPU.
  *
  * Pre-condition: trace_event_get_vcpu_state_static(ev) =3D=3D true
+ *
+ * Note: Changes for execution-time events with the 'tcg' property will =
not be
+ *       propagated until the next TB is executed (iff executing in TCG =
mode).
  */
 void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
                                         TraceEvent *ev, bool state);
diff --git a/translate-all.c b/translate-all.c
index 29ccb9e546..6e1b1d474c 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -54,6 +54,7 @@
 #include "exec/tb-hash.h"
 #include "translate-all.h"
 #include "qemu/bitmap.h"
+#include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
=20
@@ -813,6 +814,12 @@ static void tb_htable_init(void)
 {
     unsigned int mode =3D QHT_MODE_AUTO_RESIZE;
=20
+    /* Ensure TB hash function covers the bitmap size */
+    if (DIV_ROUND_UP(trace_get_vcpu_event_count(), BITS_PER_BYTE) >
+        sizeof(TRACE_QHT_VCPU_DSTATE_TYPE)) {
+        error_report("too many 'vcpu' events for the TB hash function");
+    }
+
     qht_init(&tcg_ctx.tb_ctx.htable, CODE_GEN_HTABLE_SIZE, mode);
 }
=20
@@ -1106,7 +1113,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_pa=
ge_addr_t page_addr)
=20
     /* remove the TB from the hash list */
     phys_pc =3D tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
-    h =3D tb_hash_func(phys_pc, tb->pc, tb->flags);
+    h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate=
);
     qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
=20
     /* remove the TB from the page list */
@@ -1251,7 +1258,7 @@ static void tb_link_page(TranslationBlock *tb, tb_p=
age_addr_t phys_pc,
     }
=20
     /* add in the hash table */
-    h =3D tb_hash_func(phys_pc, tb->pc, tb->flags);
+    h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate=
);
     qht_insert(&tcg_ctx.tb_ctx.htable, tb, h);
=20
 #ifdef DEBUG_TB_CHECK
@@ -1270,6 +1277,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     target_ulong virt_page2;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size;
+    unsigned long trace_vcpu_dstate_bitmap;
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
@@ -1294,6 +1302,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cs_base =3D cs_base;
     tb->flags =3D flags;
     tb->cflags =3D cflags;
+    bitmap_copy(&trace_vcpu_dstate_bitmap, cpu->trace_dstate,
+                trace_get_vcpu_event_count());
+    memcpy(&tb->trace_vcpu_dstate, &trace_vcpu_dstate_bitmap,
+           sizeof(tb->trace_vcpu_dstate));
=20
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count1++; /* includes aborted translations because of
