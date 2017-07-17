Received: from eggs.gnu.org ([2001:4830:134:3::10]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX4sJ-0002R5-DL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX4sI-0006zB-5l
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX4sH-0006yk-Sl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 17 Jul 2017 13:11:22 +0100
Message-Id: <20170717121127.25154-3-stefanha@redhat.com>
In-Reply-To: <20170717121127.25154-1-stefanha@redhat.com>
References: <20170717121127.25154-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] trace: [tcg] Delay changes to dynamic state
 when translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Emilio G . Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

This keeps consistency across all decisions taken during translation
when the dynamic state of a vCPU is changed in the middle of translating
some guest code.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-id: 149915750615.6295.3713699402253529487.stgit@frigg.lan
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qom/cpu.h      |  3 +++
 trace/control-target.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5f188d4..25eefea 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -302,6 +302,8 @@ struct qemu_work_item;
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
@@ -372,6 +374,7 @@ struct CPUState {
     struct kvm_run *kvm_run;
=20
     /* Used for events with 'vcpu' and *without* the 'disabled' properti=
es */
+    DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
     DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
=20
     /* TODO Move common fields from CPUArchState here. */
diff --git a/trace/control-target.c b/trace/control-target.c
index 99a8ed5..31c2ed1 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -61,6 +61,13 @@ void trace_event_set_state_dynamic(TraceEvent *ev, boo=
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
@@ -73,13 +80,20 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcp=
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
--=20
2.9.4
