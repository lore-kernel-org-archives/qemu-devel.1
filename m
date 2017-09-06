Received: from eggs.gnu.org ([2001:4830:134:3::10]:54587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpf6y-0008RG-QY
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpf6t-0002li-UB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:31:40 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:43208)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpf6t-0002lS-BE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:31:35 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 21:31:21 +0300
Message-Id: <150472268114.24907.6651243060428816063.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 17/20] instrument: Add event
 'guest_mem_before_exec'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/exec/cpu_ldst_template.h          |    4 +++
 include/exec/cpu_ldst_useronly_template.h |    4 +++
 include/exec/helper-gen.h                 |    1 +
 include/exec/helper-proto.h               |    1 +
 include/exec/helper-tcg.h                 |    1 +
 instrument/control.c                      |   35 +++++++++++++++++++++++=
++++++
 instrument/control.h                      |   15 ++++++++++++
 instrument/events.h                       |    5 ++++
 instrument/events.inc.h                   |   18 ++++++++++++++-
 instrument/helpers.h                      |    1 +
 instrument/load.c                         |    1 +
 instrument/qemu-instr/control.h           |   21 +++++++++++++++++
 stubs/instrument.c                        |    2 ++
 13 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 instrument/helpers.h

diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
index debbabcfb2..8018e8b16a 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -28,6 +28,7 @@
 #include "trace-root.h"
 #endif
=20
+#include "instrument/events.h"
 #include "trace/mem.h"
=20
 #if DATA_SIZE =3D=3D 8
@@ -89,6 +90,7 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUAr=
chState *env,
=20
 #if !defined(SOFTMMU_CODE_ACCESS)
     TraceMemInfo meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, f=
alse);
+    instr_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
     trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
=20
@@ -126,6 +128,7 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
=20
 #if !defined(SOFTMMU_CODE_ACCESS)
     TraceMemInfo meminfo =3D trace_mem_build_info(SHIFT, true, MO_TE, fa=
lse);
+    instr_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
     trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
=20
@@ -167,6 +170,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
=20
 #if !defined(SOFTMMU_CODE_ACCESS)
     TraceMemInfo meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, t=
rue);
+    instr_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
     trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
=20
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
index b0b3fc1b8d..c36c50ae41 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -27,6 +27,7 @@
 #include "trace-root.h"
 #endif
=20
+#include "instrument/events.h"
 #include "trace/mem.h"
=20
 #if DATA_SIZE =3D=3D 8
@@ -62,6 +63,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *en=
v, target_ulong ptr)
 {
 #if !defined(CODE_ACCESS)
     TraceMemInfo meminfo =3D trace_mem_build_info(DATA_SIZE, false, MO_T=
E, false);
+    instr_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
     trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
@@ -81,6 +83,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *en=
v, target_ulong ptr)
 {
 #if !defined(CODE_ACCESS)
     TraceMemInfo meminfo =3D trace_mem_build_info(DATA_SIZE, true, MO_TE=
, false);
+    instr_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
     trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
@@ -102,6 +105,7 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *e=
nv, target_ulong ptr,
 {
 #if !defined(CODE_ACCESS)
     TraceMemInfo meminfo =3D trace_mem_build_info(DATA_SIZE, false, MO_T=
E, true);
+    instr_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo);
     trace_guest_mem_before_exec(ENV_GET_CPU(env), ptr, meminfo.raw);
 #endif
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 8239ffc77c..f351c3d050 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -57,6 +57,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_de=
cl(ret)          \
 }
=20
 #include "helper.h"
+#include "instrument/helpers.h"
 #include "trace/generated-helpers.h"
 #include "trace/generated-helpers-wrappers.h"
 #include "tcg-runtime.h"
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 954bef85ce..8fdd02c132 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -27,6 +27,7 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2),=
 dh_ctype(t3), \
                             dh_ctype(t4), dh_ctype(t5));
=20
 #include "helper.h"
+#include "instrument/helpers.h"
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
=20
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index b0c5bafa99..255e73c3e6 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -40,6 +40,7 @@
     | dh_sizemask(t5, 5) },
=20
 #include "helper.h"
+#include "instrument/helpers.h"
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
=20
diff --git a/instrument/control.c b/instrument/control.c
index 3c3875dc99..f39e81d7c7 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -14,6 +14,8 @@
 #include "instrument/qemu-instr/control.h"
 #include "instrument/qemu-instr/visibility.h"
 #include "qom/cpu.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
=20
=20
 __thread InstrInfo instr_cur_info;
@@ -86,3 +88,36 @@ QI_VPUBLIC void qi_event_set_guest_mem_before_trans(
     ERROR_IF(!instr_get_state(), "called outside instrumentation");
     instr_set_event(guest_mem_before_trans, fn);
 }
+
+
+QI_VPUBLIC void qi_event_gen_guest_mem_before_exec(
+    QITCGv_cpu vcpu, QITCGv vaddr, QIMemInfo info)
+{
+    ERROR_IF(instr_get_state() !=3D INSTR_STATE_ENABLE_TCG,
+             "called outside instrumentation");
+    InstrInfo *iinfo =3D &instr_cur_info;
+    TCGv_env vcpu_ =3D instr_tcg_get(iinfo, vcpu);
+    TCGv vaddr_ =3D instr_tcg_get(iinfo, vaddr);
+    TCGv_i32 info_ =3D tcg_const_i32(info.raw);
+    gen_helper_instr_guest_mem_before_exec(vcpu_, vaddr_, info_);
+    tcg_temp_free_i32(info_);
+}
+
+void helper_instr_guest_mem_before_exec(
+    CPUArchState * vcpu, target_ulong vaddr, uint32_t info)
+{
+    TraceMemInfo info_;
+    info_.raw =3D info;
+    instr_guest_mem_before_exec(ENV_GET_CPU(vcpu), vaddr, info_);
+}
+
+
+void (*instr_event__guest_mem_before_exec)(
+    QICPU vcpu, uint64_t vaddr, QIMemInfo info);
+
+QI_VPUBLIC void qi_event_set_guest_mem_before_exec(
+    void (*fn)(QICPU vcpu, uint64_t vaddr, QIMemInfo info))
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
+    instr_set_event(guest_mem_before_exec, fn);
+}
diff --git a/instrument/control.h b/instrument/control.h
index d9e3dd3da6..19c9c9fb98 100644
--- a/instrument/control.h
+++ b/instrument/control.h
@@ -54,6 +54,7 @@ static inline QICPU instr_cpu_set(CPUState *vcpu);
 typedef enum {
     INSTR_STATE_DISABLE,
     INSTR_STATE_ENABLE,
+    INSTR_STATE_ENABLE_TCG,
 } InstrState;
=20
 #define INSTR_MAX_TCG_REGS 16
@@ -102,6 +103,20 @@ static inline InstrState instr_get_state(void);
  */
 static inline void instr_tcg_count(InstrInfo *info, unsigned int count);
=20
+/**
+ * instr_tcg_get:
+ * @info: Pointer to #InstrInfo.
+ * @arg: QITCG register.
+ *
+ * Get a suitable TCGv* from a QITCGv* value.
+ */
+#define instr_tcg_get(info, arg)                                \
+    ({                                                          \
+        unsigned int idx =3D (uintptr_t)arg;                      \
+        ERROR_IF(info->max <=3D idx, "invalid QITCGv register");  \
+        info->tcg_regs[idx];                                  \
+    })
+
=20
 #include "instrument/control.inc.h"
=20
diff --git a/instrument/events.h b/instrument/events.h
index 1cc4dbb052..6507b26867 100644
--- a/instrument/events.h
+++ b/instrument/events.h
@@ -63,6 +63,11 @@ extern void (*instr_event__guest_mem_before_trans)(
 static inline void instr_guest_mem_before_trans(
     CPUState *vcpu_trans, TCGv_env vcpu_exec, TCGv vaddr, TraceMemInfo i=
nfo);
=20
+extern void (*instr_event__guest_mem_before_exec)(
+    QICPU vcpu, uint64_t vaddr, QIMemInfo info);
+static inline void instr_guest_mem_before_exec(
+    CPUState *vcpu, uint64_t vaddr, TraceMemInfo info);
+
=20
 #include "instrument/events.inc.h"
=20
diff --git a/instrument/events.inc.h b/instrument/events.inc.h
index 2cb17049f7..d7a3065ac1 100644
--- a/instrument/events.inc.h
+++ b/instrument/events.inc.h
@@ -50,7 +50,7 @@ static inline void instr_guest_mem_before_trans(
     void (*cb)(QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIM=
emInfo info)
         =3D instr_get_event(guest_mem_before_trans);
     if (cb) {
-        InstrInfo *iinfo =3D instr_set_state(INSTR_STATE_ENABLE);
+        InstrInfo *iinfo =3D instr_set_state(INSTR_STATE_ENABLE_TCG);
         QICPU vcpu_trans_ =3D instr_cpu_set(vcpu_trans);
         QITCGv_cpu vcpu_exec_ =3D instr_tcg_set(iinfo, 0, vcpu_exec);
         QITCGv vaddr_ =3D instr_tcg_set(iinfo, 1, vaddr);
@@ -61,3 +61,19 @@ static inline void instr_guest_mem_before_trans(
         instr_set_state(INSTR_STATE_DISABLE);
     }
 }
+
+static inline void instr_guest_mem_before_exec(
+    CPUState *vcpu, uint64_t vaddr, TraceMemInfo info)
+{
+    void (*cb)(QICPU vcpu, uint64_t vaddr, QIMemInfo info)
+        =3D instr_get_event(guest_mem_before_exec);
+    if (cb) {
+        InstrInfo *iinfo =3D instr_set_state(INSTR_STATE_ENABLE);
+        QICPU vcpu_ =3D instr_cpu_set(vcpu);
+        QIMemInfo info_;
+        info_.raw =3D info.raw;
+        instr_tcg_count(iinfo, 2);
+        (*cb)(vcpu_, vaddr, info_);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/helpers.h b/instrument/helpers.h
new file mode 100644
index 0000000000..957cdc0993
--- /dev/null
+++ b/instrument/helpers.h
@@ -0,0 +1 @@
+DEF_HELPER_FLAGS_3(instr_guest_mem_before_exec, TCG_CALL_NO_RWG, void, e=
nv, tl, i32)
diff --git a/instrument/load.c b/instrument/load.c
index d5612af452..1df660d5d1 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -152,6 +152,7 @@ InstrUnloadError instr_unload(int64_t handle_id)
     instr_set_event(guest_cpu_exit, NULL);
     instr_set_event(guest_cpu_reset, NULL);
     instr_set_event(guest_mem_before_trans, NULL);
+    instr_set_event(guest_mem_before_exec, NULL);
=20
     /* this should never fail */
     if (dlclose(handle->dlhandle) < 0) {
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index af4fda138e..4fa99a968d 100644
--- a/instrument/qemu-instr/control.h
+++ b/instrument/qemu-instr/control.h
@@ -113,6 +113,27 @@ void qi_event_set_guest_cpu_reset(void (*fn)(QICPU v=
cpu));
 void qi_event_set_guest_mem_before_trans(
     void (*fn)(QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIM=
emInfo info));
=20
+/*
+ * Generate code to trigger a 'guest_mem_before_exec' from
+ * 'guest_mem_before_trans'.
+ *
+ * Mode: user, softmmu
+ * Targets: TCG(all)
+ * Time: trans
+ */
+void qi_event_gen_guest_mem_before_exec(
+    QITCGv_cpu vcpu, QITCGv vaddr, QIMemInfo info);
+
+/*
+ * Execution-time equivalent of 'guest_mem_before_trans'.
+ *
+ * Mode: user, softmmu
+ * Targets: TCG(all)
+ * Time: exec
+ */
+void qi_event_set_guest_mem_before_exec(
+    void (*fn)(QICPU vcpu, uint64_t vaddr, QIMemInfo info));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/stubs/instrument.c b/stubs/instrument.c
index 5e0d5150b5..c6c279c85e 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -16,3 +16,5 @@ void (*instr_event__guest_cpu_exit)(QICPU *vcpu);
 void (*instr_event__guest_cpu_reset)(QICPU *vcpu);
 void (*instr_event__guest_mem_before_trans)(
     QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIMemInfo info=
);
+void (*instr_event__guest_mem_before_exec)(
+    QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIMemInfo info=
);
