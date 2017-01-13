Received: from eggs.gnu.org ([2001:4830:134:3::10]:50595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8m0-0007Lm-Dw
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8lz-0005vr-5e
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:32 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:49713)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS8ly-0005vY-PF
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:48:31 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 13 Jan 2017 21:48:28 +0100
Message-Id: <148434050859.31446.4431621165013524916.stgit@frigg.lan>
In-Reply-To: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 3/7] trace: [tcg] Delay changes to dynamic
 state when translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This keeps consistency across all decisions taken during translation
when the dynamic state of a vCPU is changed in the middle of translating
some guest code.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/qom/cpu.h      |    3 +++
 qom/cpu.c              |    2 ++
 trace/control-target.c |   21 ++++++++++++++++++---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 3f79a8e955..31c3e6018d 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -295,6 +295,8 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to queued_work_*.
  * @queued_work_first: First asynchronous work pending.
+ * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all =
changes
+ *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask=
).
  *
  * State of one CPU core or thread.
@@ -370,6 +372,7 @@ struct CPUState {
      * Dynamically allocated based on bitmap requried to hold up to
      * trace_get_vcpu_event_count() entries.
      */
+    unsigned long *trace_dstate_delayed;
     unsigned long *trace_dstate;
=20
     /* TODO Move common fields from CPUArchState here. */
diff --git a/qom/cpu.c b/qom/cpu.c
index 03d9190f8c..8e981ac6c7 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -367,6 +367,7 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
=20
+    cpu->trace_dstate_delayed =3D bitmap_new(trace_get_vcpu_event_count(=
));
     cpu->trace_dstate =3D bitmap_new(trace_get_vcpu_event_count());
=20
     cpu_exec_initfn(cpu);
@@ -375,6 +376,7 @@ static void cpu_common_initfn(Object *obj)
 static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu =3D CPU(obj);
+    g_free(cpu->trace_dstate_delayed);
     g_free(cpu->trace_dstate);
 }
=20
diff --git a/trace/control-target.c b/trace/control-target.c
index 7ebf6e0bcb..dba3b21bb0 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -1,13 +1,14 @@
 /*
  * Interface for configuring and controlling the state of tracing events.
  *
- * Copyright (C) 2014-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2014-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
=20
 #include "qemu/osdep.h"
+#include "qom/cpu.h"
 #include "cpu.h"
 #include "trace.h"
 #include "trace/control.h"
@@ -57,6 +58,13 @@ void trace_event_set_state_dynamic(TraceEvent *ev, boo=
l state)
     }
 }
=20
+static void trace_event_synchronize_vcpu_state_dynamic(
+    CPUState *vcpu, run_on_cpu_data ignored)
+{
+    bitmap_copy(vcpu->trace_dstate, vcpu->trace_dstate_delayed,
+                trace_get_vcpu_event_count());
+}
+
 void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
                                         TraceEvent *ev, bool state)
 {
@@ -69,13 +77,20 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcp=
u,
     if (state_pre !=3D state) {
         if (state) {
             trace_events_enabled_count++;
-            set_bit(vcpu_id, vcpu->trace_dstate);
+            set_bit(vcpu_id, vcpu->trace_dstate_delayed);
             (*ev->dstate)++;
         } else {
             trace_events_enabled_count--;
-            clear_bit(vcpu_id, vcpu->trace_dstate);
+            clear_bit(vcpu_id, vcpu->trace_dstate_delayed);
             (*ev->dstate)--;
         }
+        /*
+         * Delay changes until next TB; we want all TBs to be built from=
 a
+         * single set of dstate values to ensure consistency of generate=
d
+         * tracing code.
+         */
+        async_run_on_cpu(vcpu, trace_event_synchronize_vcpu_state_dynami=
c,
+                         RUN_ON_CPU_NULL);
     }
 }
=20
