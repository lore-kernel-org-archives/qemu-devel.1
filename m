Received: from eggs.gnu.org ([2001:4830:134:3::10]:42263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7at-0004yW-Ua
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7aq-0005Ho-4E
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7ap-0005HZ-V4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:04 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:44:54 +0000
Message-Id: <20170116134455.28636-4-stefanha@redhat.com>
In-Reply-To: <20170116134455.28636-1-stefanha@redhat.com>
References: <20170116134455.28636-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] trace: Fix dynamic event state on vCPU
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

We need to disable per-vCPU events on a vCPU that is hot-unplugged to
keep the dynamic event state global counters consistent.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Message-id: 148278748055.1404.1570530281528619895.stgit@fimbulvetr.bsc.es
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control.h |  8 ++++++++
 qom/cpu.c       |  2 ++
 trace/control.c | 16 ++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/trace/control.h b/trace/control.h
index ccaeac8..4ea53e2 100644
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
diff --git a/qom/cpu.c b/qom/cpu.c
index 03d9190..93e4105 100644
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
index 1a7bee6..cb79bb1 100644
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
--=20
2.9.3
