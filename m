Received: from eggs.gnu.org ([2001:4830:134:3::10]:49458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLclI-0007xa-Hp
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLclD-00021f-MH
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:52 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:44300)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLclD-00021V-7c
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 16:24:47 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 26 Dec 2016 22:24:46 +0100
Message-Id: <148278748597.1404.10546320797997984932.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
References: <148278746972.1404.10574428039766667311.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] trace: Add event "guest_cpu_exit"
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

Signals the hot-unplugging of a virtual (guest) CPU.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 trace-events    |    6 ++++++
 trace/control.c |    3 +++
 2 files changed, 9 insertions(+)

diff --git a/trace-events b/trace-events
index f74e1d3d22..f3894f5b38 100644
--- a/trace-events
+++ b/trace-events
@@ -135,6 +135,12 @@ memory_region_ram_device_write(int cpu_index, void *=
mr, uint64_t addr, uint64_t
 # Targets: all
 vcpu guest_cpu_enter(void)
=20
+# Hot-unplug a virtual (guest) CPU
+#
+# Mode: user, softmmu
+# Targets: all
+vcpu guest_cpu_exit(void)
+
 # Reset the state of a virtual (guest) CPU
 #
 # Mode: user, softmmu
diff --git a/trace/control.c b/trace/control.c
index cb79bb17ec..56a2632584 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
+#include "trace.h"
=20
 int trace_events_enabled_count;
=20
@@ -264,6 +265,8 @@ void trace_fini_vcpu(CPUState *vcpu)
     TraceEventIter iter;
     TraceEvent *ev;
=20
+    trace_guest_cpu_exit(vcpu);
+
     trace_event_iter_init(&iter, NULL);
     while ((ev =3D trace_event_iter_next(&iter)) !=3D NULL) {
         if (trace_event_is_vcpu(ev) &&
