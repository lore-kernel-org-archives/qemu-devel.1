Received: from eggs.gnu.org ([2001:4830:134:3::10]:49769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpevA-0003i3-Tx
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpev6-0005w3-Sr
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:19:28 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:39560)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpev6-0005vr-Hn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:19:24 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 21:19:14 +0300
Message-Id: <150472195416.24907.15859962605541218107.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 14/20] instrument: Add event
 'guest_cpu_reset'
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
 instrument/control.c            |    9 +++++++++
 instrument/events.h             |    3 +++
 instrument/events.inc.h         |   11 +++++++++++
 instrument/load.c               |    1 +
 instrument/qemu-instr/control.h |    9 +++++++++
 qom/cpu.c                       |    2 ++
 stubs/instrument.c              |    1 +
 7 files changed, 36 insertions(+)

diff --git a/instrument/control.c b/instrument/control.c
index 09ba682483..3cec1028e5 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -66,3 +66,12 @@ QI_VPUBLIC void qi_event_set_guest_cpu_exit(void (*fn)=
(QICPU vcpu))
     ERROR_IF(!instr_get_state(), "called outside instrumentation");
     instr_set_event(guest_cpu_exit, fn);
 }
+
+
+void (*instr_event__guest_cpu_reset)(QICPU vcpu);
+
+QI_VPUBLIC void qi_event_set_guest_cpu_reset(void (*fn)(QICPU vcpu))
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
+    instr_set_event(guest_cpu_reset, fn);
+}
diff --git a/instrument/events.h b/instrument/events.h
index c743cb8180..4a0560490a 100644
--- a/instrument/events.h
+++ b/instrument/events.h
@@ -39,6 +39,9 @@ static inline void instr_guest_cpu_enter(CPUState *vcpu=
);
 extern void (*instr_event__guest_cpu_exit)(QICPU vcpu);
 static inline void instr_guest_cpu_exit(CPUState *vcpu);
=20
+extern void (*instr_event__guest_cpu_reset)(QICPU vcpu);
+static inline void instr_guest_cpu_reset(CPUState *vcpu);
+
=20
 #include "instrument/events.inc.h"
=20
diff --git a/instrument/events.inc.h b/instrument/events.inc.h
index bcbf0cb32a..2f2cd324aa 100644
--- a/instrument/events.inc.h
+++ b/instrument/events.inc.h
@@ -31,3 +31,14 @@ static inline void instr_guest_cpu_exit(CPUState *vcpu=
)
         instr_set_state(INSTR_STATE_DISABLE);
     }
 }
+
+static inline void instr_guest_cpu_reset(CPUState *vcpu)
+{
+    void (*cb)(QICPU vcpu) =3D instr_get_event(guest_cpu_reset);
+    if (cb) {
+        QICPU vcpu_ =3D instr_cpu_set(vcpu);
+        instr_set_state(INSTR_STATE_ENABLE);
+        (*cb)(vcpu_);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/load.c b/instrument/load.c
index 63b7d564ec..d9310d1979 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -150,6 +150,7 @@ InstrUnloadError instr_unload(int64_t handle_id)
     instr_set_event(fini_fn, NULL);
     instr_set_event(guest_cpu_enter, NULL);
     instr_set_event(guest_cpu_exit, NULL);
+    instr_set_event(guest_cpu_reset, NULL);
=20
     /* this should never fail */
     if (dlclose(handle->dlhandle) < 0) {
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index c37a380ab0..238ea63301 100644
--- a/instrument/qemu-instr/control.h
+++ b/instrument/qemu-instr/control.h
@@ -89,6 +89,15 @@ void qi_event_set_guest_cpu_enter(void (*fn)(QICPU vcp=
u));
  */
 void qi_event_set_guest_cpu_exit(void (*fn)(QICPU vcpu));
=20
+/*
+ * Reset the state of a virtual (guest) CPU.
+ *
+ * Mode: user, softmmu
+ * Targets: all
+ * Time: exec
+ */
+void qi_event_set_guest_cpu_reset(void (*fn)(QICPU vcpu));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/qom/cpu.c b/qom/cpu.c
index 4f38db0dac..d09cf583eb 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "instrument/events.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qom/cpu.h"
@@ -271,6 +272,7 @@ void cpu_reset(CPUState *cpu)
         (*klass->reset)(cpu);
     }
=20
+    instr_guest_cpu_reset(cpu);
     trace_guest_cpu_reset(cpu);
 }
=20
diff --git a/stubs/instrument.c b/stubs/instrument.c
index ea8df6d467..74935975da 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -13,3 +13,4 @@
 __thread InstrState instr_cur_state;
 void (*instr_event__guest_cpu_enter)(QICPU *vcpu);
 void (*instr_event__guest_cpu_exit)(QICPU *vcpu);
+void (*instr_event__guest_cpu_reset)(QICPU *vcpu);
