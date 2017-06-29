Received: from eggs.gnu.org ([2001:4830:134:3::10]:57939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYW5-0004Ns-8U
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYW2-0003LO-Il
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:25:49 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:46227 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYW2-0003Ki-5r
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:25:46 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 29 Jun 2017 15:25:36 +0300
Message-Id: <149873913645.9180.8565004941097105027.stgit@frigg.lan>
In-Reply-To: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
References: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 3/7] trace: [tcg] Delay changes to dynamic
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
Cc: "Emilio G. Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This keeps consistency across all decisions taken during translation
when the dynamic state of a vCPU is changed in the middle of translating
some guest code.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 include/qom/cpu.h      |    3 +++
 trace/control-target.c |   20 +++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index bc6e20f056..29f4a32572 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -303,6 +303,8 @@ struct qemu_work_item;
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
@@ -375,6 +377,7 @@ struct CPUState {
     struct kvm_run *kvm_run;
=20
     /* Used for events with 'vcpu' and *without* the 'disabled' properti=
es */
+    DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
     DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
=20
     /* TODO Move common fields from CPUArchState here. */
diff --git a/trace/control-target.c b/trace/control-target.c
index 6266e6380d..d30fa5df75 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -1,7 +1,7 @@
 /*
  * Interface for configuring and controlling the state of tracing events.
  *
- * Copyright (C) 2014-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ * Copyright (C) 2014-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -57,6 +57,13 @@ void trace_event_set_state_dynamic(TraceEvent *ev, boo=
l state)
     }
 }
=20
+static void trace_event_synchronize_vcpu_state_dynamic(
+    CPUState *vcpu, run_on_cpu_data ignored)
+{
+    bitmap_copy(vcpu->trace_dstate, vcpu->trace_dstate_delayed,
+                CPU_TRACE_DSTATE_MAX_EVENTS);
+}
+
 void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
                                         TraceEvent *ev, bool state)
 {
@@ -69,13 +76,20 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcp=
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
