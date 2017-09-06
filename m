Received: from eggs.gnu.org ([2001:4830:134:3::10]:47442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpenK-00008f-Ti
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpenG-0002iC-TL
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:11:22 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:33722)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpenG-0002hn-EG
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:11:18 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 21:11:09 +0300
Message-Id: <150472146893.24907.1040882648962239022.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 12/20] instrument: Add event
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
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 instrument/control.c            |    9 ++++++++
 instrument/events.h             |    5 ++++
 instrument/events.inc.h         |   11 ++++++++++
 instrument/load.c               |    1 +
 instrument/qemu-instr/control.h |   44 +++++++++++++++++++++++++++++++++=
++++++
 stubs/instrument.c              |    1 +
 trace/control-target.c          |    2 ++
 7 files changed, 73 insertions(+)

diff --git a/instrument/control.c b/instrument/control.c
index 83453ea561..ed0d537b88 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -48,3 +48,12 @@ QI_VPUBLIC void qi_set_fini(qi_fini_fn fn, void *data)
     instr_set_event(fini_fn, fn);
     instr_set_event(fini_data, data);
 }
+
+
+void (*instr_event__guest_cpu_enter)(QICPU vcpu);
+
+QI_VPUBLIC void qi_event_set_guest_cpu_enter(void (*fn)(QICPU vcpu))
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
index 8b1ce7fcb2..238cce9855 100644
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
+        QICPU vcpu_ =3D instr_cpu_set(vcpu);
+        instr_set_state(INSTR_STATE_ENABLE);
+        (*cb)(vcpu_);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/load.c b/instrument/load.c
index e180f03429..0fe878afa8 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -148,6 +148,7 @@ InstrUnloadError instr_unload(int64_t handle_id)
     }
=20
     instr_set_event(fini_fn, NULL);
+    instr_set_event(guest_cpu_enter, NULL);
=20
     /* this should never fail */
     if (dlclose(handle->dlhandle) < 0) {
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index f6e289daa0..26d8aa976d 100644
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
@@ -36,6 +37,49 @@ typedef void (*qi_fini_fn)(void *arg);
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
index 6731710fd5..658a872e1c 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -11,3 +11,4 @@
=20
=20
 __thread InstrState instr_cur_state;
+void (*instr_event__guest_cpu_enter)(QICPU *vcpu);
diff --git a/trace/control-target.c b/trace/control-target.c
index 0056da6a46..e47361cef8 100644
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
@@ -147,5 +148,6 @@ void trace_init_vcpu(CPUState *vcpu)
             }
         }
     }
+    instr_guest_cpu_enter(vcpu);
     trace_guest_cpu_enter(vcpu);
 }
