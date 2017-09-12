Received: from eggs.gnu.org ([2001:4830:134:3::10]:50071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drt0g-0004RF-31
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drt0c-0002qr-ML
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:46:22 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:35374)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drt0c-0002pi-BK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:46:18 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 00:46:07 +0300
Message-Id: <150525276755.15988.10713051972672554822.stgit@frigg.lan>
In-Reply-To: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 11/22] instrument: Track vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

Keep a translation between instrumentation's QICPU and CPUState objects t=
o avoid
exposing QEMU's internals to instrumentation clients.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 cpus-common.c            |    9 +++++++++
 instrument/control.c     |   23 +++++++++++++++++++++++
 instrument/control.h     |   36 ++++++++++++++++++++++++++++++++++++
 instrument/control.inc.h |   23 +++++++++++++++++++++++
 4 files changed, 91 insertions(+)

diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..ec5f46cc3d 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -22,6 +22,9 @@
 #include "exec/cpu-common.h"
 #include "qom/cpu.h"
 #include "sysemu/cpus.h"
+#if defined(CONFIG_INSTRUMENT)
+#include "instrument/control.h"
+#endif
=20
 static QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
@@ -84,6 +87,9 @@ void cpu_list_add(CPUState *cpu)
     } else {
         assert(!cpu_index_auto_assigned);
     }
+#if defined(CONFIG_INSTRUMENT)
+    instr_cpu_add(cpu);
+#endif
     QTAILQ_INSERT_TAIL(&cpus, cpu, node);
     qemu_mutex_unlock(&qemu_cpu_list_lock);
=20
@@ -102,6 +108,9 @@ void cpu_list_remove(CPUState *cpu)
     assert(!(cpu_index_auto_assigned && cpu !=3D QTAILQ_LAST(&cpus, CPUT=
ailQ)));
=20
     QTAILQ_REMOVE(&cpus, cpu, node);
+#if defined(CONFIG_INSTRUMENT)
+    instr_cpu_remove(cpu);
+#endif
     cpu->cpu_index =3D UNASSIGNED_CPU_INDEX;
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
diff --git a/instrument/control.c b/instrument/control.c
index 3630d6b3be..8cf2b4f967 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -13,10 +13,33 @@
 #include "instrument/load.h"
 #include "instrument/qemu-instr/control.h"
 #include "qemu/compiler.h"
+#include "qom/cpu.h"
+
=20
 __thread InstrState instr_cur_state;
=20
=20
+unsigned int instr_cpus_count;
+CPUState **instr_cpus;
+
+void instr_cpu_add(CPUState *vcpu)
+{
+    unsigned int idx =3D vcpu->cpu_index;
+    if (idx >=3D instr_cpus_count) {
+        instr_cpus_count =3D idx + 1;
+        instr_cpus =3D realloc(instr_cpus,
+                             sizeof(*instr_cpus) * instr_cpus_count);
+    }
+    instr_cpus[idx] =3D vcpu;
+}
+
+void instr_cpu_remove(CPUState *vcpu)
+{
+    unsigned int idx =3D vcpu->cpu_index;
+    instr_cpus[idx] =3D NULL;
+}
+
+
 qi_fini_fn instr_event__fini_fn;
 void *instr_event__fini_data;
=20
diff --git a/instrument/control.h b/instrument/control.h
index f2b085f69b..57cea07fa7 100644
--- a/instrument/control.h
+++ b/instrument/control.h
@@ -10,6 +10,42 @@
 #ifndef INSTRUMENT__CONTROL_H
 #define INSTRUMENT__CONTROL_H
=20
+#include "qemu/typedefs.h"
+#include "instrument/qemu-instr/types.h"
+
+
+/**
+ * instr_cpu_add:
+ *
+ * Make @vcpu available to instrumentation clients.
+ *
+ * Precondition: cpu_list_lock().
+ */
+void instr_cpu_add(CPUState *vcpu);
+
+/**
+ * instr_cpu_remove:
+ *
+ * Make @vcpu unavailable to instrumentation clients.
+ *
+ * Precondition: cpu_list_lock().
+ */
+void instr_cpu_remove(CPUState *vcpu);
+
+/**
+ * instr_cpu_to_qicpu:
+ *
+ * Get the #QICPU corresponding to the given #CPUState.
+ */
+static inline QICPU instr_cpu_to_qicpu(CPUState *vcpu);
+
+/**
+ * instr_cpu_from_qicpu:
+ *
+ * Get the #CPUState corresponding to the given #QICPU.
+ */
+static inline CPUState *instr_cpu_from_qicpu(QICPU vcpu);
+
=20
 /**
  * InstrState:
diff --git a/instrument/control.inc.h b/instrument/control.inc.h
index 0f649f4caa..45daae7d1d 100644
--- a/instrument/control.inc.h
+++ b/instrument/control.inc.h
@@ -7,9 +7,32 @@
  * See the COPYING file in the top-level directory.
  */
=20
+#include "qemu/osdep.h"
 #include "qemu/atomic.h"
 #include "qemu/compiler.h"
+#include "qom/cpu.h"
 #include <stdbool.h>
+#include <stdint.h>
+
+
+extern unsigned int instr_cpus_count;
+extern CPUState **instr_cpus;
+
+static inline QICPU instr_cpu_to_qicpu(CPUState *vcpu)
+{
+    uintptr_t idx =3D vcpu->cpu_index;
+    return (QICPU)idx;
+}
+
+static inline CPUState *instr_cpu_from_qicpu(QICPU vcpu)
+{
+    unsigned int idx =3D (uintptr_t)vcpu;
+    if (idx >=3D instr_cpus_count) {
+        return NULL;
+    } else {
+        return instr_cpus[idx];
+    }
+}
=20
=20
 extern __thread InstrState instr_cur_state;
