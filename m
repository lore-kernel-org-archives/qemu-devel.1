Received: from eggs.gnu.org ([2001:4830:134:3::10]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds57e-00016g-F1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds57a-0005Qz-ER
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:42:22 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:35527)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds57a-0005PN-0R
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:42:18 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 13:42:07 +0300
Message-Id: <150529932725.10902.6569724074050775920.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 12/22] instrument: Add event
 'guest_cpu_enter'
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
 instrument/control.c            |    9 ++++++++
 instrument/events.h             |    5 ++++
 instrument/events.inc.h         |   11 +++++++++
 instrument/load.c               |    9 ++++++++
 instrument/qemu-instr/control.h |   46 +++++++++++++++++++++++++++++++++=
++++++
 stubs/instrument.c              |    1 +
 trace/control-target.c          |    2 ++
 7 files changed, 83 insertions(+)

diff --git a/instrument/control.c b/instrument/control.c
index 8cf2b4f967..c4b3ca0440 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -49,3 +49,12 @@ SYM_PUBLIC void qi_set_fini(qi_fini_fn fn, void *data)
     instr_set_event(fini_fn, fn);
     instr_set_event(fini_data, data);
 }
+
+
+void (*instr_event__guest_cpu_enter)(QICPU vcpu);
+
+SYM_PUBLIC void qi_event_set_guest_cpu_enter(void (*fn)(QICPU vcpu))
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
+    instr_set_event(guest_cpu_enter, fn);
+}
diff --git a/instrument/events.h b/instrument/events.h
index 82ad0bd827..947f120aa9 100644
--- a/instrument/events.h
+++ b/instrument/events.h
@@ -11,6 +11,7 @@
 #define INSTRUMENT__EVENTS_H
=20
 #include "instrument/qemu-instr/control.h"
+#include "instrument/qemu-instr/types.h"
=20
 /**
  * instr_get_event:
@@ -32,6 +33,10 @@
 extern qi_fini_fn instr_event__fini_fn;
 extern void *instr_event__fini_data;
=20
+extern void (*instr_event__guest_cpu_enter)(QICPU vcpu);
+static inline void instr_guest_cpu_enter(CPUState *vcpu);
+
+
 #include "instrument/events.inc.h"
=20
 #endif  /* INSTRUMENT__EVENTS_H */
diff --git a/instrument/events.inc.h b/instrument/events.inc.h
index 8b1ce7fcb2..e3f8024716 100644
--- a/instrument/events.inc.h
+++ b/instrument/events.inc.h
@@ -7,5 +7,16 @@
  * See the COPYING file in the top-level directory.
  */
=20
+#include "instrument/control.h"
=20
=20
+static inline void instr_guest_cpu_enter(CPUState *vcpu)
+{
+    void (*cb)(QICPU vcpu) =3D instr_get_event(guest_cpu_enter);
+    if (cb) {
+        QICPU vcpu_ =3D instr_cpu_to_qicpu(vcpu);
+        instr_set_state(INSTR_STATE_ENABLE);
+        (*cb)(vcpu_);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/load.c b/instrument/load.c
index a01d66a4d4..218bca74b2 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -11,6 +11,7 @@
 #include "qemu-common.h"
=20
 #include <dlfcn.h>
+#include "exec/cpu-common.h"
 #include "instrument/control.h"
 #include "instrument/events.h"
 #include "instrument/load.h"
@@ -109,6 +110,13 @@ InstrLoadError instr_load(const char *path, int argc=
, const char **argv,
         goto err;
     }
=20
+    cpu_list_lock();
+    CPUState *cpu;
+    CPU_FOREACH(cpu) {
+        instr_guest_cpu_enter(cpu);
+    }
+    cpu_list_unlock();
+
     res =3D INSTR_LOAD_OK;
     goto out;
=20
@@ -138,6 +146,7 @@ InstrUnloadError instr_unload(const char *id)
     }
=20
     instr_set_event(fini_fn, NULL);
+    instr_set_event(guest_cpu_enter, NULL);
=20
     /* this should never fail */
     if (dlclose(handle->dlhandle) < 0) {
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index b841afaa31..f61e7a2b6e 100644
--- a/instrument/qemu-instr/control.h
+++ b/instrument/qemu-instr/control.h
@@ -16,6 +16,7 @@ extern "C" {
=20
 #include <stdbool.h>
 #include <stddef.h>
+#include <qemu-instr/types.h>
=20
=20
 /**
@@ -39,6 +40,51 @@ typedef void (*qi_fini_fn)(void *arg);
  */
 void qi_set_fini(qi_fini_fn fn, void *data);
=20
+
+/*
+ * Set callbacks for available events. Each event has a short descriptio=
n and
+ * various indicators of when it can be triggered:
+ *
+ * - Mode :: user
+ *   Triggered in QEMU user application emulation (e.g., linux-user).
+ *
+ * - Mode :: softmmy
+ *   Triggered in QEMU full-system emulation.
+ *
+ *
+ * - Targets :: all
+ *   Triggered on all targets, both using TCG or native hardware virtual=
ization
+ *   (e.g., KVM).
+ *
+ * - Targets :: TCG(<arch>)
+ *   Triggered on the given guest target architectures when executing wi=
th TCG
+ *   (no native hardware virtualization).
+ *
+ *
+ * - Time :: exec
+ *   Triggered when the guest executes the described operation.
+ *
+ * - Time :: trans
+ *   Triggered when QEMU translates a guest operation. This is only avai=
lable
+ *   when executing with TCG. Guest instructions are decompiled and tran=
slated
+ *   into the intermediate TCG language (when "Time: trans" events are
+ *   triggered). Then, the TCG compiler translates TCG code into the nat=
ive host
+ *   code that QEMU will execute to emulate the guest (when "Time: exec"=
 events
+ *   are triggered). As QEMU uses a cache of translated code, the same
+ *   instruction might be translated more than once (when the cache over=
flows).
+ */
+
+/*
+ * Hot-plug a new virtual (guest) CPU.
+ *
+ * Also triggered on each CPU when an instrumentation library is loaded.
+ *
+ * Mode: user, softmmu
+ * Targets: all
+ * Time: exec
+ */
+void qi_event_set_guest_cpu_enter(void (*fn)(QICPU vcpu));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/stubs/instrument.c b/stubs/instrument.c
index 560844469c..abed583a56 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -42,3 +42,4 @@ void qmp_instr_unload(const char *id, Error **errp)
=20
=20
 __thread InstrState instr_cur_state;
+void (*instr_event__guest_cpu_enter)(QICPU *vcpu);
diff --git a/trace/control-target.c b/trace/control-target.c
index 706b2cee9d..f22688bcd5 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "instrument/events.h"
 #include "trace-root.h"
 #include "trace/control.h"
 #include "translate-all.h"
@@ -146,5 +147,6 @@ void trace_init_vcpu(CPUState *vcpu)
             }
         }
     }
+    instr_guest_cpu_enter(vcpu);
     trace_guest_cpu_enter(vcpu);
 }
