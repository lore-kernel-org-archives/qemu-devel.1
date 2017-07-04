Received: from eggs.gnu.org ([2001:4830:134:3::10]:41399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dSJQ3-0003x6-Kp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dSJQ0-0005b6-Ek
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:42:51 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:46434)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dSJPz-0005aP-SW
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:42:48 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Tue,  4 Jul 2017 10:42:32 +0200
Message-Id: <149915775266.6295.10060144081246467690.stgit@frigg.lan>
In-Reply-To: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
References: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 3/6] exec: [tcg] Use different TBs
 according to the vCPU's dynamic tracing state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

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
Reviewed-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c      |    8 ++++++--
 accel/tcg/translate-all.c |   11 +++++++++--
 include/exec/exec-all.h   |    3 +++
 include/exec/tb-hash-xx.h |    7 +++++--
 include/exec/tb-hash.h    |    5 +++--
 tcg/tcg-runtime.c         |    3 ++-
 tests/qht-bench.c         |    2 +-
 trace/control-target.c    |    1 +
 trace/control.h           |    3 +++
 9 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 3581618bc0..d84b01d1b8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -280,6 +280,7 @@ struct tb_desc {
     CPUArchState *env;
     tb_page_addr_t phys_page1;
     uint32_t flags;
+    uint32_t trace_vcpu_dstate;
 };
=20
 static bool tb_cmp(const void *p, const void *d)
@@ -291,6 +292,7 @@ static bool tb_cmp(const void *p, const void *d)
         tb->page_addr[0] =3D=3D desc->phys_page1 &&
         tb->cs_base =3D=3D desc->cs_base &&
         tb->flags =3D=3D desc->flags &&
+        tb->trace_vcpu_dstate =3D=3D desc->trace_vcpu_dstate &&
         !atomic_read(&tb->invalid)) {
         /* check next page if needed */
         if (tb->page_addr[1] =3D=3D -1) {
@@ -319,10 +321,11 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, t=
arget_ulong pc,
     desc.env =3D (CPUArchState *)cpu->env_ptr;
     desc.cs_base =3D cs_base;
     desc.flags =3D flags;
+    desc.trace_vcpu_dstate =3D *cpu->trace_dstate;
     desc.pc =3D pc;
     phys_pc =3D get_page_addr_code(desc.env, pc);
     desc.phys_page1 =3D phys_pc & TARGET_PAGE_MASK;
-    h =3D tb_hash_func(phys_pc, pc, flags);
+    h =3D tb_hash_func(phys_pc, pc, flags, *cpu->trace_dstate);
     return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
 }
=20
@@ -342,7 +345,8 @@ static inline TranslationBlock *tb_find(CPUState *cpu=
,
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
     tb =3D atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)=
]);
     if (unlikely(!tb || tb->pc !=3D pc || tb->cs_base !=3D cs_base ||
-                 tb->flags !=3D flags)) {
+                 tb->flags !=3D flags ||
+                 tb->trace_vcpu_dstate !=3D *cpu->trace_dstate)) {
         tb =3D tb_htable_lookup(cpu, pc, cs_base, flags);
         if (!tb) {
=20
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 93fb9230ba..e5c193005e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -54,6 +54,7 @@
 #include "exec/tb-hash.h"
 #include "translate-all.h"
 #include "qemu/bitmap.h"
+#include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "exec/log.h"
@@ -112,6 +113,11 @@ typedef struct PageDesc {
 #define V_L2_BITS 10
 #define V_L2_SIZE (1 << V_L2_BITS)
=20
+/* Make sure all possible CPU event bits fit in tb->trace_vcpu_dstate */
+QEMU_BUILD_BUG_ON(CPU_TRACE_DSTATE_MAX_EVENTS >
+                  sizeof(((TranslationBlock *)0)->trace_vcpu_dstate)
+                  * BITS_PER_BYTE);
+
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
=20
@@ -1093,7 +1099,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_pa=
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
@@ -1238,7 +1244,7 @@ static void tb_link_page(TranslationBlock *tb, tb_p=
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
@@ -1284,6 +1290,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cs_base =3D cs_base;
     tb->flags =3D flags;
     tb->cflags =3D cflags;
+    tb->trace_vcpu_dstate =3D *cpu->trace_dstate;
     tb->invalid =3D false;
=20
 #ifdef CONFIG_PROFILER
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 724ec73dce..262a37ee56 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -324,6 +324,9 @@ struct TranslationBlock {
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
=20
+    /* Per-vCPU dynamic tracing state used to generate this TB */
+    uint32_t trace_vcpu_dstate;
+
     uint16_t invalid;
=20
     void *tc_ptr;    /* pointer to the translated code */
diff --git a/include/exec/tb-hash-xx.h b/include/exec/tb-hash-xx.h
index 2c40b5c466..6cd3022c07 100644
--- a/include/exec/tb-hash-xx.h
+++ b/include/exec/tb-hash-xx.h
@@ -49,7 +49,7 @@
  * contiguous in memory.
  */
 static inline
-uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint32_t e)
+uint32_t tb_hash_func6(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f)
 {
     uint32_t v1 =3D TB_HASH_XX_SEED + PRIME32_1 + PRIME32_2;
     uint32_t v2 =3D TB_HASH_XX_SEED + PRIME32_2;
@@ -78,11 +78,14 @@ uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint=
32_t e)
     v4 *=3D PRIME32_1;
=20
     h32 =3D rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
-    h32 +=3D 20;
+    h32 +=3D 24;
=20
     h32 +=3D e * PRIME32_3;
     h32  =3D rol32(h32, 17) * PRIME32_4;
=20
+    h32 +=3D f * PRIME32_3;
+    h32  =3D rol32(h32, 17) * PRIME32_4;
+
     h32 ^=3D h32 >> 15;
     h32 *=3D PRIME32_2;
     h32 ^=3D h32 >> 13;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index b1fe2d0161..17b5ee0edf 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -58,9 +58,10 @@ static inline unsigned int tb_jmp_cache_hash_func(targ=
et_ulong pc)
 #endif /* CONFIG_SOFTMMU */
=20
 static inline
-uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t =
flags)
+uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t =
flags,
+                      uint32_t trace_vcpu_dstate)
 {
-    return tb_hash_func5(phys_pc, pc, flags);
+    return tb_hash_func6(phys_pc, pc, flags, trace_vcpu_dstate);
 }
=20
 #endif
diff --git a/tcg/tcg-runtime.c b/tcg/tcg-runtime.c
index ec3a34e461..3e23649dd7 100644
--- a/tcg/tcg-runtime.c
+++ b/tcg/tcg-runtime.c
@@ -158,7 +158,8 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env, target=
_ulong addr)
     if (unlikely(!(tb
                    && tb->pc =3D=3D addr
                    && tb->cs_base =3D=3D cs_base
-                   && tb->flags =3D=3D flags))) {
+                   && tb->flags =3D=3D flags
+                   && tb->trace_vcpu_dstate =3D=3D *cpu->trace_dstate)))=
 {
         tb =3D tb_htable_lookup(cpu, addr, cs_base, flags);
         if (!tb) {
             return tcg_ctx.code_gen_epilogue;
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
index d30fa5df75..dc649d631d 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -62,6 +62,7 @@ static void trace_event_synchronize_vcpu_state_dynamic(
 {
     bitmap_copy(vcpu->trace_dstate, vcpu->trace_dstate_delayed,
                 CPU_TRACE_DSTATE_MAX_EVENTS);
+    cpu_tb_jmp_cache_clear(vcpu);
 }
=20
 void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
diff --git a/trace/control.h b/trace/control.h
index 4ea53e2986..b931824d60 100644
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
