Received: from eggs.gnu.org ([2001:4830:134:3::10]:49434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl8-0007oa-Vs
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl8-000203-4K
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:43 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:44298)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLcl7-0001zc-OR
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:42 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 26 Dec 2016 22:24:40 +0100
Message-Id: <148278748055.1404.1570530281528619895.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
References: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] trace: Fix dynamic event state on vCPU
 hot-unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

We need to disable per-vCPU events on a vCPU that is hot-unplugged to
keep the dynamic event state global counters consistent.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 qom/cpu.c       |    2 ++
 trace/control.c |   16 ++++++++++++++++
 trace/control.h |    8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/qom/cpu.c b/qom/cpu.c
index 03d9190f8c..93e41056d9 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -348,6 +348,8 @@ static void cpu_common_realizefn(DeviceState *dev, Er=
ror **errp)
 static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu =3D CPU(dev);
+    /* NOTE: latest generic point before the cpu is fully unrealized */
+    trace_fini_vcpu(cpu);
     cpu_exec_unrealizefn(cpu);
 }
=20
diff --git a/trace/control.c b/trace/control.c
index 1a7bee6ddc..cb79bb17ec 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -259,6 +259,22 @@ void trace_init_file(const char *file)
 #endif
 }
=20
+void trace_fini_vcpu(CPUState *vcpu)
+{
+    TraceEventIter iter;
+    TraceEvent *ev;
+
+    trace_event_iter_init(&iter, NULL);
+    while ((ev =3D trace_event_iter_next(&iter)) !=3D NULL) {
+        if (trace_event_is_vcpu(ev) &&
+            trace_event_get_state_static(ev) &&
+            trace_event_get_vcpu_state_dynamic(vcpu, ev)) {
+            /* must disable to affect the global counter */
+            trace_event_set_vcpu_state_dynamic(vcpu, ev, false);
+        }
+    }
+}
+
 bool trace_init_backends(void)
 {
 #ifdef CONFIG_TRACE_SIMPLE
diff --git a/trace/control.h b/trace/control.h
index ccaeac8552..4ea53e2986 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -202,6 +202,14 @@ void trace_init_file(const char *file);
 void trace_init_vcpu(CPUState *vcpu);
=20
 /**
+ * trace_fini_vcpu:
+ * @vcpu: Removed vCPU.
+ *
+ * Disable dynamic event state for a hot-unplugged vCPU.
+ */
+void trace_fini_vcpu(CPUState *vcpu);
+
+/**
  * trace_list_events:
  *
  * List all available events.
