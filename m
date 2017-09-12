Received: from eggs.gnu.org ([2001:4830:134:3::10]:41623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drtS6-0002oA-0C
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drtRz-0005TV-LM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:14:41 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:42609 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drtRy-0005Qf-VM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:14:35 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 01:14:23 +0300
Message-Id: <150525446311.15988.14180809542310825210.stgit@frigg.lan>
In-Reply-To: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 18/22] instrument: Add event
 'guest_mem_before_trans'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 Makefile.target                 |    1 +
 instrument/control.c            |   15 +++++++++
 instrument/control.h            |   36 +++++++++++++++++++++-
 instrument/control.inc.h        |   16 +++++++---
 instrument/events.h             |   21 +++++++++++++
 instrument/events.inc.h         |   20 ++++++++++++
 instrument/load.c               |    1 +
 instrument/qemu-instr/control.h |   16 ++++++++++
 instrument/qemu-instr/types.h   |   64 +++++++++++++++++++++++++++++++++=
++++++
 stubs/instrument.c              |    4 ++
 tcg/tcg-op.c                    |    5 +++
 trace/control.h                 |   23 ++++++++++++++
 trace/mem.h                     |   23 --------------
 13 files changed, 214 insertions(+), 31 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 7f42c45db8..6997b921c9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -196,6 +196,7 @@ $(QEMU_PROG_BUILD): config-devices.mak
 COMMON_LDADDS =3D ../libqemuutil.a ../libqemustub.a
=20
 # build either PROG or PROGW
+$(QEMU_PROG_BUILD): CFLAGS +=3D -DQEMU_TARGET_BUILD=3D1
 $(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $(filter-out %.mak, $^))
 ifdef CONFIG_DARWIN
diff --git a/instrument/control.c b/instrument/control.c
index 401189db2e..0424dd57ab 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -17,7 +17,7 @@
 #include "qom/cpu.h"
=20
=20
-__thread InstrState instr_cur_state;
+__thread InstrInfo instr_cur_info;
=20
=20
 unsigned int instr_cpus_count;
@@ -142,3 +142,16 @@ SYM_PUBLIC void qi_event_set_guest_cpu_reset(void (*=
fn)(QICPU vcpu))
     ERROR_IF(!instr_get_state(), "called outside instrumentation");
     instr_set_event(guest_cpu_reset, fn);
 }
+
+
+void (*instr_event__guest_mem_before_trans)(
+    QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIMemInfo info=
);
+
+SYM_PUBLIC void qi_event_set_guest_mem_before_trans(
+    void (*fn)(QICPU vcpu_trans, QITCGv_cpu vcpu_exec,
+               QITCGv vaddr, QIMemInfo info))
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
+    ERROR_IF(!tcg_enabled(), "called without TCG");
+    instr_set_event(guest_mem_before_trans, fn);
+}
diff --git a/instrument/control.h b/instrument/control.h
index 03e87b2b8f..3e44702f75 100644
--- a/instrument/control.h
+++ b/instrument/control.h
@@ -86,12 +86,21 @@ typedef enum {
     INSTR_STATE_ENABLE,
 } InstrState;
=20
+#define INSTR_MAX_TCG_REGS 16
+
+typedef struct InstrInfo {
+    InstrState state;
+    unsigned int max;
+    void *tcg_regs[INSTR_MAX_TCG_REGS];
+} InstrInfo;
+
 /**
  * instr_set_state:
  *
- * Set the instrumentation state of the current host thread.
+ * Set the instrumentation state of the current host thread, and return =
its
+ * #InstrInfo.
  */
-static inline void instr_set_state(InstrState state);
+static inline InstrInfo *instr_set_state(InstrState state);
=20
 /**
  * instr_get_state:
@@ -100,6 +109,29 @@ static inline void instr_set_state(InstrState state)=
;
  */
 static inline InstrState instr_get_state(void);
=20
+/**
+ * instr_tcg_to_qitcg:
+ * @info: Pointer to #InstrInfo.
+ * @num: Number of TCG register used by instrumentation.
+ * @arg: TCG register.
+ *
+ * Get a suitable QITCGv* from a TCGv* value.
+ */
+#define instr_tcg_to_qitcg(info, num, arg) \
+    ({                                \
+        info->tcg_regs[num] =3D arg;    \
+        (void *)num;                  \
+    })
+
+/**
+ * instr_tcg_count:
+ * @info: Pointer to #InstrInfo.
+ * @count: Number of TCG registers used by instrumentation.
+ *
+ * Set the number of TCG registers used by instrumentation.
+ */
+static inline void instr_tcg_count(InstrInfo *info, unsigned int count);
+
=20
 #include "instrument/control.inc.h"
=20
diff --git a/instrument/control.inc.h b/instrument/control.inc.h
index 6d65b23ead..3eba9b7c85 100644
--- a/instrument/control.inc.h
+++ b/instrument/control.inc.h
@@ -46,14 +46,22 @@ static inline CPUState *instr_cpu_from_qicpu(QICPU vc=
pu)
 }
=20
=20
-extern __thread InstrState instr_cur_state;
+extern __thread InstrInfo instr_cur_info;
=20
-static inline void instr_set_state(InstrState state)
+static inline InstrInfo *instr_set_state(InstrState state)
 {
-    atomic_store_release(&instr_cur_state, state);
+    InstrInfo *info =3D &instr_cur_info;
+    atomic_store_release(&info->state, state);
+    return info;
 }
=20
 static inline InstrState instr_get_state(void)
 {
-    return atomic_load_acquire(&instr_cur_state);
+    return atomic_load_acquire(&instr_cur_info.state);
+}
+
+
+static inline void instr_tcg_count(InstrInfo *info, unsigned int count)
+{
+    info->max =3D count;
 }
diff --git a/instrument/events.h b/instrument/events.h
index 4a0560490a..1cc4dbb052 100644
--- a/instrument/events.h
+++ b/instrument/events.h
@@ -12,6 +12,8 @@
=20
 #include "instrument/qemu-instr/control.h"
 #include "instrument/qemu-instr/types.h"
+#include "trace/control.h"
+
=20
 /**
  * instr_get_event:
@@ -30,6 +32,20 @@
     atomic_store_release(&instr_event__ ## name, fn)
=20
=20
+/*
+ * Re-define types used by some instrumentation events. We need some arb=
itrary
+ * definition for non-target objects.
+ */
+#if defined(QEMU_TARGET_BUILD)
+#include "tcg/tcg.h"
+#else
+typedef struct TCGv_d *TCGv;
+typedef struct TCGv_env_d *TCGv_env;
+typedef struct TCGv_i32_d *TCGv_i32;
+typedef struct TCGv_i64_d *TCGv_i64;
+#endif
+
+
 extern qi_fini_fn instr_event__fini_fn;
 extern void *instr_event__fini_data;
=20
@@ -42,6 +58,11 @@ static inline void instr_guest_cpu_exit(CPUState *vcpu=
);
 extern void (*instr_event__guest_cpu_reset)(QICPU vcpu);
 static inline void instr_guest_cpu_reset(CPUState *vcpu);
=20
+extern void (*instr_event__guest_mem_before_trans)(
+    QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIMemInfo info=
);
+static inline void instr_guest_mem_before_trans(
+    CPUState *vcpu_trans, TCGv_env vcpu_exec, TCGv vaddr, TraceMemInfo i=
nfo);
+
=20
 #include "instrument/events.inc.h"
=20
diff --git a/instrument/events.inc.h b/instrument/events.inc.h
index a126ba5ae6..365c715db4 100644
--- a/instrument/events.inc.h
+++ b/instrument/events.inc.h
@@ -8,6 +8,7 @@
  */
=20
 #include "instrument/control.h"
+#include "trace/control.h"
=20
=20
 static inline void instr_guest_cpu_enter(CPUState *vcpu)
@@ -42,3 +43,22 @@ static inline void instr_guest_cpu_reset(CPUState *vcp=
u)
         instr_set_state(INSTR_STATE_DISABLE);
     }
 }
+
+static inline void instr_guest_mem_before_trans(
+    CPUState *vcpu_trans, TCGv_env vcpu_exec, TCGv vaddr, TraceMemInfo i=
nfo)
+{
+    void (*cb)(QICPU vcpu_trans, QITCGv_cpu vcpu_exec,
+               QITCGv vaddr, QIMemInfo info)
+        =3D instr_get_event(guest_mem_before_trans);
+    if (cb) {
+        InstrInfo *iinfo =3D instr_set_state(INSTR_STATE_ENABLE);
+        QICPU vcpu_trans_ =3D instr_cpu_to_qicpu(vcpu_trans);
+        QITCGv_cpu vcpu_exec_ =3D instr_tcg_to_qitcg(iinfo, 0, vcpu_exec=
);
+        QITCGv vaddr_ =3D instr_tcg_to_qitcg(iinfo, 1, vaddr);
+        QIMemInfo info_;
+        info_.raw =3D info.raw;
+        instr_tcg_count(iinfo, 2);
+        (*cb)(vcpu_trans_, vcpu_exec_, vaddr_, info_);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/load.c b/instrument/load.c
index 8c15a73a8c..e8f869201b 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -162,6 +162,7 @@ InstrUnloadError instr_unload(const char *id)
     instr_set_event(guest_cpu_enter, NULL);
     instr_set_event(guest_cpu_exit, NULL);
     instr_set_event(guest_cpu_reset, NULL);
+    instr_set_event(guest_mem_before_trans, NULL);
=20
     instr_cpu_stop_all_end(&info);
     cpu_list_unlock();
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index 322009100d..c3c8c3988d 100644
--- a/instrument/qemu-instr/control.h
+++ b/instrument/qemu-instr/control.h
@@ -105,6 +105,22 @@ void qi_event_set_guest_cpu_exit(void (*fn)(QICPU vc=
pu));
  */
 void qi_event_set_guest_cpu_reset(void (*fn)(QICPU vcpu));
=20
+/*
+ * Start virtual memory access (before any potential access violation).
+ *
+ * @vaddr: Access' virtual address.
+ * @info : Access' information.
+ *
+ * Does not include memory accesses performed by devices.
+ *
+ * Mode: user, softmmu
+ * Targets: TCG(all)
+ * Time: trans
+ */
+void qi_event_set_guest_mem_before_trans(
+    void (*fn)(QICPU vcpu_trans, QITCGv_cpu vcpu_exec,
+               QITCGv vaddr, QIMemInfo info));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/instrument/qemu-instr/types.h b/instrument/qemu-instr/types.=
h
index ea3a032b4f..11cbe1ccaa 100644
--- a/instrument/qemu-instr/types.h
+++ b/instrument/qemu-instr/types.h
@@ -14,10 +14,18 @@
 extern "C" {
 #endif
=20
+#include <stdbool.h>
+#include <stdint.h>
+
+
 /**
  * SECTION: types
  * @section_id: qi-types
  * @title: Common types
+ *
+ * Data of architecture-specific length is always passed as an #int64_t =
to
+ * provide binary compatibility between the instrumentation library and =
QEMU,
+ * regardless of the guest architecture being instrumented.
  */
=20
 /**
@@ -41,6 +49,62 @@ typedef struct QITraceEventIter QITraceEventIter;
  */
 typedef struct QICPU_d *QICPU;
=20
+/**
+ * QIMemInfo:
+ * @size_shift: Memoy access size, interpreted as "1 << size_shift" byte=
s.
+ * @sign_extend: Whether the access is sign-extended.
+ * @endianness: Endianness type (0: little, 1: big).
+ * @store: Whether it's a store operation.
+ *
+ * Memory access information.
+ */
+typedef struct QIMemInfo {
+    union {
+        struct {
+            uint8_t size_shift : 2;
+            bool    sign_extend: 1;
+            uint8_t endianness : 1;
+            bool    store      : 1;
+        };
+        uint8_t raw;
+    };
+} QIMemInfo;
+
+/**
+ * QITCGv_cpu:
+ *
+ * TCG register with QICPU.
+ */
+typedef struct QITCGv_cpu_d *QITCGv_cpu;
+
+/**
+ * QITCGv:
+ *
+ * TCG register with data of architecture-specific length.
+ */
+typedef struct QITCGv_d *QITCGv;
+
+/**
+ * QITCGv_i32:
+ *
+ * TCG register with 32-bit data.
+ */
+typedef struct QITCGv_i32_d *QITCGv_i32;
+
+/**
+ * QITCGv_i64:
+ *
+ * TCG register with 64-bit data.
+ */
+typedef struct QITCGv_i64_d *QITCGv_i64;
+
+/*
+ * QITCGv_ptr:
+ *
+ * TCG register with pointer of architecture-specific length.
+ */
+typedef struct QITCGv_ptr_d *QITCGv_ptr;
+
=20
 #include <qemu-instr/types.inc.h>
=20
diff --git a/stubs/instrument.c b/stubs/instrument.c
index dda2ae88c5..2387b61840 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -45,7 +45,9 @@ void qmp_instr_unload(const char *id, Error **errp)
 }
=20
=20
-__thread InstrState instr_cur_state;
+__thread InstrInfo instr_cur_info;
 void (*instr_event__guest_cpu_enter)(QICPU *vcpu);
 void (*instr_event__guest_cpu_exit)(QICPU *vcpu);
 void (*instr_event__guest_cpu_reset)(QICPU *vcpu);
+void (*instr_event__guest_mem_before_trans)(
+    QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIMemInfo info=
);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6edf70bdfc..295c0c5a4a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "instrument/events.h"
 #include "tcg.h"
 #include "tcg-op.h"
 #include "tcg-mo.h"
@@ -2680,6 +2681,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, T=
CGArg idx, TCGMemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop =3D tcg_canonicalize_memop(memop, 0, 0);
     meminfo =3D trace_mem_get_info(memop, 0);
+    instr_guest_mem_before_trans(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, mem=
info);
     trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, memin=
fo.raw);
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
 }
@@ -2690,6 +2692,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, T=
CGArg idx, TCGMemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop =3D tcg_canonicalize_memop(memop, 0, 1);
     meminfo =3D trace_mem_get_info(memop, 1);
+    instr_guest_mem_before_trans(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, mem=
info);
     trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, memin=
fo.raw);
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
 }
@@ -2711,6 +2714,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, T=
CGArg idx, TCGMemOp memop)
=20
     memop =3D tcg_canonicalize_memop(memop, 1, 0);
     meminfo =3D trace_mem_get_info(memop, 0);
+    instr_guest_mem_before_trans(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, mem=
info);
     trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, memin=
fo.raw);
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
 }
@@ -2727,6 +2731,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, T=
CGArg idx, TCGMemOp memop)
=20
     memop =3D tcg_canonicalize_memop(memop, 1, 1);
     meminfo =3D trace_mem_get_info(memop, 1);
+    instr_guest_mem_before_trans(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, mem=
info);
     trace_guest_mem_before_tcg(tcg_ctx.cpu, tcg_ctx.tcg_env, addr, memin=
fo.raw);
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
 }
diff --git a/trace/control.h b/trace/control.h
index 3e6da24c98..6b3fe9a28f 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -20,6 +20,29 @@ typedef struct TraceEventIter {
     const char *pattern;
 } TraceEventIter;
=20
+/**
+ * TraceMemInfo:
+ * @size_shift: Memoy access size, interpreted as "1 << size_shift" byte=
s.
+ * @sign_extend: Whether the access is sign-extended.
+ * @endianness: Endinness type (0: little, 1: big).
+ * @store: Whether it's a store operation.
+ *
+ * Memory access information.
+ *
+ * NOTE: Keep in sync with QIMemInfo.
+ */
+typedef struct TraceMemInfo {
+    union {
+        struct {
+            uint8_t size_shift : 2;
+            bool    sign_extend: 1;
+            uint8_t endianness : 1;
+            bool    store      : 1;
+        };
+        uint8_t raw;
+    };
+} TraceMemInfo;
+
=20
 /**
  * trace_event_iter_init:
diff --git a/trace/mem.h b/trace/mem.h
index 9866b41401..bc89673272 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -12,29 +12,6 @@
=20
 #include "tcg/tcg.h"
=20
-/**
- * TraceMemInfo:
- * @size_shift: Memoy access size, interpreted as "1 << size_shift" byte=
s.
- * @sign_extend: Whether the access is sign-extended.
- * @endianness: Endinness type (0: little, 1: big).
- * @store: Whether it's a store operation.
- *
- * Memory access information.
- *
- * NOTE: Keep in sync with QIMemInfo.
- */
-typedef struct TraceMemInfo {
-    union {
-        struct {
-            uint8_t size_shift : 2;
-            bool    sign_extend: 1;
-            uint8_t endianness : 1;
-            bool    store      : 1;
-        };
-        uint8_t raw;
-    };
-} TraceMemInfo;
-
=20
 /**
  * trace_mem_get_info:
