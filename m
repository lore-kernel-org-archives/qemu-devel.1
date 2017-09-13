Received: from eggs.gnu.org ([2001:4830:134:3::10]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5JQ-0001X4-51
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5JM-0006d4-5j
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:54:32 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:55619 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5JL-0006cj-Q1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:54:28 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 13:54:17 +0300
Message-Id: <150530005730.10902.5901070506412662130.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 15/22] instrument: Add event 'guest_cpu_exit'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 instrument/control.c            |    9 +++++++++
 instrument/events.h             |    3 +++
 instrument/events.inc.h         |   11 +++++++++++
 instrument/load.c               |   17 +++++++++++++++++
 instrument/qemu-instr/control.h |   11 +++++++++++
 stubs/instrument.c              |    1 +
 trace/control.c                 |    4 +++-
 7 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/instrument/control.c b/instrument/control.c
index 4f9c138ccf..7ed4bf3505 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -125,3 +125,12 @@ SYM_PUBLIC void qi_event_set_guest_cpu_enter(void (*=
fn)(QICPU vcpu))
     ERROR_IF(!instr_get_state(), "called outside instrumentation");
     instr_set_event(guest_cpu_enter, fn);
 }
+
+
+void (*instr_event__guest_cpu_exit)(QICPU vcpu);
+
+SYM_PUBLIC void qi_event_set_guest_cpu_exit(void (*fn)(QICPU vcpu))
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
+    instr_set_event(guest_cpu_exit, fn);
+}
diff --git a/instrument/events.h b/instrument/events.h
index 947f120aa9..c743cb8180 100644
--- a/instrument/events.h
+++ b/instrument/events.h
@@ -36,6 +36,9 @@ extern void *instr_event__fini_data;
 extern void (*instr_event__guest_cpu_enter)(QICPU vcpu);
 static inline void instr_guest_cpu_enter(CPUState *vcpu);
=20
+extern void (*instr_event__guest_cpu_exit)(QICPU vcpu);
+static inline void instr_guest_cpu_exit(CPUState *vcpu);
+
=20
 #include "instrument/events.inc.h"
=20
diff --git a/instrument/events.inc.h b/instrument/events.inc.h
index e3f8024716..c88df7e42f 100644
--- a/instrument/events.inc.h
+++ b/instrument/events.inc.h
@@ -20,3 +20,14 @@ static inline void instr_guest_cpu_enter(CPUState *vcp=
u)
         instr_set_state(INSTR_STATE_DISABLE);
     }
 }
+
+static inline void instr_guest_cpu_exit(CPUState *vcpu)
+{
+    void (*cb)(QICPU vcpu) =3D instr_get_event(guest_cpu_exit);
+    if (cb) {
+        QICPU vcpu_ =3D instr_cpu_to_qicpu(vcpu);
+        instr_set_state(INSTR_STATE_ENABLE);
+        (*cb)(vcpu_);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/load.c b/instrument/load.c
index 218bca74b2..6808d361b5 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -11,7 +11,9 @@
 #include "qemu-common.h"
=20
 #include <dlfcn.h>
+#include "cpu.h"
 #include "exec/cpu-common.h"
+#include "exec/exec-all.h"
 #include "instrument/control.h"
 #include "instrument/events.h"
 #include "instrument/load.h"
@@ -127,6 +129,13 @@ out:
     return res;
 }
=20
+
+static void instr_unload__cb(CPUState *cpu, void *data)
+{
+    tb_flush_sync(cpu);
+    instr_guest_cpu_exit(cpu);
+}
+
 InstrUnloadError instr_unload(const char *id)
 {
     InstrUnloadError res;
@@ -139,6 +148,10 @@ InstrUnloadError instr_unload(const char *id)
         goto out;
     }
=20
+    InstrCPUStop info;
+    cpu_list_lock();
+    instr_cpu_stop_all_begin(&info, instr_unload__cb, NULL);
+
     qi_fini_fn fini_fn =3D instr_get_event(fini_fn);
     if (fini_fn) {
         void *fini_data =3D instr_get_event(fini_data);
@@ -147,6 +160,10 @@ InstrUnloadError instr_unload(const char *id)
=20
     instr_set_event(fini_fn, NULL);
     instr_set_event(guest_cpu_enter, NULL);
+    instr_set_event(guest_cpu_exit, NULL);
+
+    instr_cpu_stop_all_end(&info);
+    cpu_list_unlock();
=20
     /* this should never fail */
     if (dlclose(handle->dlhandle) < 0) {
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index f61e7a2b6e..107ee8afe0 100644
--- a/instrument/qemu-instr/control.h
+++ b/instrument/qemu-instr/control.h
@@ -85,6 +85,17 @@ void qi_set_fini(qi_fini_fn fn, void *data);
  */
 void qi_event_set_guest_cpu_enter(void (*fn)(QICPU vcpu));
=20
+/*
+ * Hot-unplug a virtual (guest) CPU.
+ *
+ * Also triggered on each CPU when an instrumentation library is unloade=
d.
+ *
+ * Mode: user, softmmu
+ * Targets: all
+ * Time: exec
+ */
+void qi_event_set_guest_cpu_exit(void (*fn)(QICPU vcpu));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/stubs/instrument.c b/stubs/instrument.c
index abed583a56..e7adea1aad 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -43,3 +43,4 @@ void qmp_instr_unload(const char *id, Error **errp)
=20
 __thread InstrState instr_cur_state;
 void (*instr_event__guest_cpu_enter)(QICPU *vcpu);
+void (*instr_event__guest_cpu_exit)(QICPU *vcpu);
diff --git a/trace/control.c b/trace/control.c
index 82d8989c4d..946a0af818 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -1,13 +1,14 @@
 /*
  * Interface for configuring and controlling the state of tracing events.
  *
- * Copyright (C) 2011-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2011-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
=20
 #include "qemu/osdep.h"
+#include "instrument/events.h"
 #include "trace/control.h"
 #include "qemu/help_option.h"
 #ifdef CONFIG_TRACE_SIMPLE
@@ -272,6 +273,7 @@ void trace_fini_vcpu(CPUState *vcpu)
     TraceEventIter iter;
     TraceEvent *ev;
=20
+    instr_guest_cpu_exit(vcpu);
     trace_guest_cpu_exit(vcpu);
=20
     trace_event_iter_init(&iter, NULL);
