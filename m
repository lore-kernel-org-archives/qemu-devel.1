Received: from eggs.gnu.org ([2001:4830:134:3::10]:46714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpejT-0006gd-OV
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpejP-0008Sg-Fb
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:07:23 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:56132)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpejP-0008PE-4n
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:07:19 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 21:07:06 +0300
Message-Id: <150472122675.24907.11597641982841030964.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 11/20] instrument: Track vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

Keep a translation between instrumentation's QICPU and CPUState objects t=
o avoid
exposing QEMU's internals to instrumentation clients.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 cpus-common.c            |    9 +++++++++
 instrument/control.c     |   22 ++++++++++++++++++++++
 instrument/control.h     |   32 ++++++++++++++++++++++++++++++++
 instrument/control.inc.h |   23 +++++++++++++++++++++++
 4 files changed, 86 insertions(+)

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
index 2c2781beeb..83453ea561 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -13,10 +13,32 @@
 #include "instrument/load.h"
 #include "instrument/qemu-instr/control.h"
 #include "instrument/qemu-instr/visibility.h"
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
+        instr_cpus =3D realloc(instr_cpus, sizeof(*instr_cpus) * instr_c=
pus_count);
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
index f2b085f69b..0c37692465 100644
--- a/instrument/control.h
+++ b/instrument/control.h
@@ -10,6 +10,38 @@
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
+ */
+void instr_cpu_add(CPUState *vcpu);
+
+/**
+ * instr_cpu_remove:
+ *
+ * Make @vcpu unavailable to instrumentation clients.
+ */
+void instr_cpu_remove(CPUState *vcpu);
+
+/**
+ * instr_cpu_get:
+ *
+ * Get the #CPUState corresponding to the given #QICPU.
+ */
+static inline CPUState *instr_cpu_get(QICPU vcpu);
+
+/**
+ * instr_cpu_set:
+ *
+ * Get the #QICPU corresponding to the given #CPUState.
+ */
+static inline QICPU instr_cpu_set(CPUState *vcpu);
+
=20
 /**
  * InstrState:
diff --git a/instrument/control.inc.h b/instrument/control.inc.h
index 0f649f4caa..18ae6a34cc 100644
--- a/instrument/control.inc.h
+++ b/instrument/control.inc.h
@@ -7,9 +7,12 @@
  * See the COPYING file in the top-level directory.
  */
=20
+#include "qemu/osdep.h"
 #include "qemu/atomic.h"
 #include "qemu/compiler.h"
+#include "qom/cpu.h"
 #include <stdbool.h>
+#include <stdint.h>
=20
=20
 extern __thread InstrState instr_cur_state;
@@ -23,3 +26,23 @@ static inline InstrState instr_get_state(void)
 {
     return atomic_load_acquire(&instr_cur_state);
 }
+
+
+extern unsigned int instr_cpus_count;
+extern CPUState **instr_cpus;
+
+static inline CPUState *instr_cpu_get(QICPU vcpu)
+{
+    unsigned int idx =3D (uintptr_t)vcpu;
+    if (idx >=3D instr_cpus_count) {
+        return NULL;
+    } else {
+        return instr_cpus[idx];
+    }
+}
+
+static inline QICPU instr_cpu_set(CPUState *vcpu)
+{
+    uintptr_t idx =3D vcpu->cpu_index;
+    return (QICPU )idx;
+}
