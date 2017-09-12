Received: from eggs.gnu.org ([2001:4830:134:3::10]:53775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drt8U-0000CL-N6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drt8R-0003Px-9n
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:54:26 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:39968)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drt8Q-0003Pl-Tj
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:54:23 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 00:54:12 +0300
Message-Id: <150525325219.15988.2418594999948440514.stgit@frigg.lan>
In-Reply-To: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 13/22] instrument: Support synchronous
 modification of vCPU state
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

Stops all vCPUs to allow performing management operations like TB
invalidations. These are later necessary to ensure translated code does n=
ot
reference unloaded instrumentation libraries.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 instrument/control.c     |   66 ++++++++++++++++++++++++++++++++++++++++=
++++++
 instrument/control.h     |   26 ++++++++++++++++++
 instrument/control.inc.h |   11 ++++++++
 3 files changed, 103 insertions(+)

diff --git a/instrument/control.c b/instrument/control.c
index c4b3ca0440..20ddffdc28 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -13,6 +13,7 @@
 #include "instrument/load.h"
 #include "instrument/qemu-instr/control.h"
 #include "qemu/compiler.h"
+#include "qemu/main-loop.h"
 #include "qom/cpu.h"
=20
=20
@@ -40,6 +41,71 @@ void instr_cpu_remove(CPUState *vcpu)
 }
=20
=20
+static void instr_cpu_stop_all__cb(CPUState *cpu, run_on_cpu_data data)
+{
+    InstrCPUStop *info =3D data.host_ptr;
+    /* run posted function */
+    if (info->fun) {
+        info->fun(cpu, info->data);
+    }
+#if !defined(CONFIG_USER_ONLY)
+    /* signal we're out of the main vCPU loop */
+    unsigned int count =3D atomic_load_acquire(&info->count);
+    atomic_store_release(&info->count, count + 1);
+    atomic_store_release(&info->stopped, true);
+    /* wait until we're good to go again */
+    qemu_cond_wait(&info->cond, &info->mutex);
+    count =3D atomic_load_acquire(&info->count);
+    atomic_store_release(&info->count, count - 1);
+    qemu_mutex_unlock(&info->mutex);
+#endif
+}
+
+void instr_cpu_stop_all_begin(InstrCPUStop *info,
+                              instr_cpu_stop_fun fun, void *data)
+{
+    CPUState *cpu;
+
+    info->fun =3D fun;
+    info->data =3D data;
+
+#if !defined(CONFIG_USER_ONLY)
+    info->count =3D 0;
+    qemu_cond_init(&info->cond);
+    qemu_mutex_init(&info->mutex);
+
+    /* main dispatch loop and run_on_cpu() lock the BQL */
+    qemu_mutex_unlock_iothread();
+#endif
+
+    CPU_FOREACH(cpu) {
+#if !defined(CONFIG_USER_ONLY)
+        atomic_store_release(&info->stopped, false);
+        qemu_mutex_lock(&info->mutex);
+        async_run_on_cpu(cpu, instr_cpu_stop_all__cb, RUN_ON_CPU_HOST_PT=
R(info));
+        while (!atomic_load_acquire(&info->stopped)) {
+            /* wait for vCPU to signal it's stopped */
+        }
+#else
+        instr_cpu_stop_all__cb(cpu, RUN_ON_CPU_HOST_PTR(info));
+#endif
+    }
+}
+
+void instr_cpu_stop_all_end(InstrCPUStop *info)
+{
+#if !defined(CONFIG_USER_ONLY)
+    qemu_cond_broadcast(&info->cond);
+    while (atomic_load_acquire(&info->count)) {
+        /* wait for all vCPUs to continue before we can destroy info */
+    }
+    qemu_cond_destroy(&info->cond);
+    qemu_mutex_destroy(&info->mutex);
+    qemu_mutex_lock_iothread();
+#endif
+}
+
+
 qi_fini_fn instr_event__fini_fn;
 void *instr_event__fini_data;
=20
diff --git a/instrument/control.h b/instrument/control.h
index 57cea07fa7..03e87b2b8f 100644
--- a/instrument/control.h
+++ b/instrument/control.h
@@ -46,6 +46,32 @@ static inline QICPU instr_cpu_to_qicpu(CPUState *vcpu)=
;
  */
 static inline CPUState *instr_cpu_from_qicpu(QICPU vcpu);
=20
+typedef struct InstrCPUStop InstrCPUStop;
+typedef void (*instr_cpu_stop_fun)(CPUState *cpu, void *data);
+
+/**
+ * instr_cpu_stop_all_begin:
+ * @info: Opaque structure describing the operation.
+ * @fun: Function to run on the context of each vCPU once stopped.
+ * @data: Pointer to pass to @fun.
+ *
+ * Ensure all vCPUs stop executing guest code, and execute @fun on their=
 context
+ * in turn. Returns with all vCPUs still stopped.
+ *
+ * Assumes cpu_list_lock() and that the QBL is locked before calling.
+ */
+void instr_cpu_stop_all_begin(InstrCPUStop *info,
+                              instr_cpu_stop_fun fun, void *data);
+
+/**
+ * instr_cpu_stop_all_end:
+ * @info: Opaque structure passed to a previous instr_cpu_stop_all_begin=
()
+ *     call.
+ *
+ * Resume execution on all vCPUs stopped by instr_cpu_stop_all_begin().
+ */
+void instr_cpu_stop_all_end(InstrCPUStop *info);
+
=20
 /**
  * InstrState:
diff --git a/instrument/control.inc.h b/instrument/control.inc.h
index 45daae7d1d..6d65b23ead 100644
--- a/instrument/control.inc.h
+++ b/instrument/control.inc.h
@@ -15,6 +15,17 @@
 #include <stdint.h>
=20
=20
+struct InstrCPUStop {
+    instr_cpu_stop_fun fun;
+    void *data;
+#if !defined(CONFIG_USER_ONLY)
+    bool stopped;
+    unsigned int count;
+    QemuCond cond;
+    QemuMutex mutex;
+#endif
+};
+
 extern unsigned int instr_cpus_count;
 extern CPUState **instr_cpus;
=20
