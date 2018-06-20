Received: from eggs.gnu.org ([2001:4830:134:3::10]:56942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVa2U-0001jX-Pb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVa2T-0001sE-7l
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:08:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 20 Jun 2018 12:08:21 +0200
Message-Id: <20180620100825.22476-4-david@redhat.com>
In-Reply-To: <20180620100825.22476-1-david@redhat.com>
References: <20180620100825.22476-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/7] s390x/tcg: properly implement the TOD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Right now, each CPU has its own TOD. Especially, the TOD will differ
based on creation time of a CPU - e.g. when hotplugging a CPU the times
will differ quite a lot, resulting in stall warnings in the guest.

Let's use a single TOD by implementing our new TOD device. Prepare it
for TOD-clock epoch extension.

Most importantly, whenever we set the TOD, we have to update the CKC
timer.

Introduce "tcg_s390x.h" just like "kvm_s390x.h" for tcg specific
function declarations that should not go into cpu.h.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/tod-qemu.c        | 46 ++++++++++++++++++++++++++++++++++----
 hw/s390x/tod.c             | 11 +++++++++
 include/hw/s390x/tod.h     | 19 ++++++++++++++++
 target/s390x/cpu.c         |  7 ------
 target/s390x/cpu.h         |  1 -
 target/s390x/internal.h    | 15 -------------
 target/s390x/misc_helper.c | 33 ++++++++++++++++++++++-----
 target/s390x/tcg_s390x.h   | 18 +++++++++++++++
 8 files changed, 117 insertions(+), 33 deletions(-)
 create mode 100644 target/s390x/tcg_s390x.h

diff --git a/hw/s390x/tod-qemu.c b/hw/s390x/tod-qemu.c
index 7997ba2b1a..da2b82cd51 100644
--- a/hw/s390x/tod-qemu.c
+++ b/hw/s390x/tod-qemu.c
@@ -11,17 +11,41 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/s390x/tod.h"
+#include "qemu/timer.h"
+#include "qemu/cutils.h"
+#include "cpu.h"
+#include "tcg_s390x.h"
 
 static void qemu_s390_tod_get(S390TODState *td, S390TOD *tod, Error **errp)
 {
-    /* FIXME */
-    tod->high = 0;
-    tod->low = 0;
+    *tod = td->base;
+
+    tod->low += time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    if (tod->low < td->base.low) {
+        tod->high++;
+    }
 }
 
 static void qemu_s390_tod_set(S390TODState *td, S390TOD *tod, Error **errp)
 {
-    /* FIXME */
+    CPUState *cpu;
+
+    td->base = *tod;
+
+    td->base.low -= time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    if (tod->low < td->base.low) {
+        td->base.high--;
+    }
+
+    /*
+     * The TOD has been changed and we have to recalculate the CKC values
+     * for all CPUs. We do this asynchronously, as "SET CLOCK should be
+     * issued only while all other activity on all CPUs .. has been
+     * suspended".
+     */
+    CPU_FOREACH(cpu) {
+        async_run_on_cpu(cpu, tcg_s390_tod_updated, RUN_ON_CPU_NULL);
+    }
 }
 
 static void qemu_s390_tod_class_init(ObjectClass *oc, void *data)
@@ -32,10 +56,24 @@ static void qemu_s390_tod_class_init(ObjectClass *oc, void *data)
     tdc->set = qemu_s390_tod_set;
 }
 
+static void qemu_s390_tod_init(Object *obj)
+{
+    S390TODState *td = S390_TOD(obj);
+    struct tm tm;
+
+    qemu_get_timedate(&tm, 0);
+    td->base.high = 0;
+    td->base.low = TOD_UNIX_EPOCH + (time2tod(mktimegm(&tm)) * 1000000000ULL);
+    if (td->base.low < TOD_UNIX_EPOCH) {
+        td->base.high += 1;
+    }
+}
+
 static TypeInfo qemu_s390_tod_info = {
     .name = TYPE_QEMU_S390_TOD,
     .parent = TYPE_S390_TOD,
     .instance_size = sizeof(S390TODState),
+    .instance_init = qemu_s390_tod_init,
     .class_init = qemu_s390_tod_class_init,
     .class_size = sizeof(S390TODClass),
 };
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index c1b3438452..7495d8c057 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -30,6 +30,17 @@ void s390_init_tod(void)
     qdev_init_nofail(DEVICE(obj));
 }
 
+S390TODState *s390_get_tod(void)
+{
+    static S390TODState *ts;
+
+    if (!ts) {
+        ts = S390_TOD(object_resolve_path_type("", TYPE_S390_TOD, NULL));
+    }
+
+    return ts;
+}
+
 #define S390_TOD_CLOCK_VALUE_MISSING    0x00
 #define S390_TOD_CLOCK_VALUE_PRESENT    0x01
 
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 43ed71600f..5491245b86 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -30,6 +30,9 @@ typedef struct S390TOD {
 typedef struct S390TODState {
     /* private */
     DeviceState parent_obj;
+
+    /* unused by KVM implementation */
+    S390TOD base;
 } S390TODState;
 
 typedef struct S390TODClass {
@@ -41,6 +44,22 @@ typedef struct S390TODClass {
     void (*set)(S390TODState *td, S390TOD *tod, Error **errp);
 } S390TODClass;
 
+/* The value of the TOD clock for 1.1.1970. */
+#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
+
+/* Converts ns to s390's clock format */
+static inline uint64_t time2tod(uint64_t ns)
+{
+    return (ns << 9) / 125;
+}
+
+/* Converts s390's clock format to ns */
+static inline uint64_t tod2time(uint64_t t)
+{
+    return (t * 125) >> 9;
+}
+
 void s390_init_tod(void);
+S390TODState *s390_get_tod(void);
 
 #endif
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index a41b3f34ab..40d6980229 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -30,7 +30,6 @@
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
 #include "qemu-common.h"
-#include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -275,9 +274,6 @@ static void s390_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     S390CPU *cpu = S390_CPU(obj);
     CPUS390XState *env = &cpu->env;
-#if !defined(CONFIG_USER_ONLY)
-    struct tm tm;
-#endif
 
     cs->env_ptr = env;
     cs->halted = 1;
@@ -286,9 +282,6 @@ static void s390_cpu_initfn(Object *obj)
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
-    qemu_get_timedate(&tm, 0);
-    env->tod_offset = TOD_UNIX_EPOCH +
-                      (time2tod(mktimegm(&tm)) * 1000000000ULL);
     env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
     env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 4abfe88a3d..2c3dd2d189 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -130,7 +130,6 @@ struct CPUS390XState {
     uint64_t cpuid;
 #endif
 
-    uint64_t tod_offset;
     QEMUTimer *tod_timer;
 
     QEMUTimer *cpu_timer;
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index e392a02d12..f2a771e2b4 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -237,21 +237,6 @@ enum cc_op {
     CC_OP_MAX
 };
 
-/* The value of the TOD clock for 1.1.1970. */
-#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
-
-/* Converts ns to s390's clock format */
-static inline uint64_t time2tod(uint64_t ns)
-{
-    return (ns << 9) / 125;
-}
-
-/* Converts s390's clock format to ns */
-static inline uint64_t tod2time(uint64_t t)
-{
-    return (t * 125) >> 9;
-}
-
 static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
                                        uint8_t *ar)
 {
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index dd5273949b..6ccbe1fe9a 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "tcg_s390x.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "sysemu/cpus.h"
@@ -39,6 +40,7 @@
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/boards.h"
+#include "hw/s390x/tod.h"
 #endif
 
 /* #define DEBUG_HELPER */
@@ -138,25 +140,36 @@ void HELPER(spx)(CPUS390XState *env, uint64_t a1)
 /* Store Clock */
 uint64_t HELPER(stck)(CPUS390XState *env)
 {
-    uint64_t time;
+    S390TODState *td = s390_get_tod();
+    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
+    Error *err = NULL;
+    S390TOD tod;
 
-    time = env->tod_offset +
-        time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-
-    return time;
+    tdc->get(td, &tod, &err);
+    g_assert(!err);
+    return tod.low;
 }
 
 /* Set Clock Comparator */
 void HELPER(sckc)(CPUS390XState *env, uint64_t time)
 {
+    S390TODState *td = s390_get_tod();
+    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
+    Error *err = NULL;
+    S390TOD tod_base;
+
     if (time == -1ULL) {
         return;
     }
 
     env->ckc = time;
 
+    tdc->get(td, &tod_base, &err);
+    g_assert(!err);
+    tod_base.low -= time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+
     /* difference between origins */
-    time -= env->tod_offset;
+    time -= tod_base.low;
 
     /* nanoseconds */
     time = tod2time(time);
@@ -164,6 +177,14 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
     timer_mod(env->tod_timer, time);
 }
 
+void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
+    helper_sckc(env, env->ckc);
+}
+
 /* Set Tod Programmable Field */
 void HELPER(sckpf)(CPUS390XState *env, uint64_t r0)
 {
diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
new file mode 100644
index 0000000000..4e308aa0ce
--- /dev/null
+++ b/target/s390x/tcg_s390x.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU TCG support -- s390x specific functions.
+ *
+ * Copyright 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TCG_S390X_H
+#define TCG_S390X_H
+
+void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
+
+#endif /* TCG_S390X_H */
-- 
2.17.1
