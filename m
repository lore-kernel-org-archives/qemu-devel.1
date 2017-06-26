Received: from eggs.gnu.org ([2001:4830:134:3::10]:57017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7k-0007h6-Gq
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7h-0005N1-BA
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPc7g-0005MI-W0
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 26 Jun 2017 18:04:37 -0400
Message-Id: <1498514681-3059-4-git-send-email-cota@braap.org>
In-Reply-To: <1498514681-3059-1-git-send-email-cota@braap.org>
References: <1498514681-3059-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/7] trace: [tcg] Delay changes to dynamic
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Desnogues <laurent.desnogues@gmail.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

This keeps consistency across all decisions taken during translation
when the dynamic state of a vCPU is changed in the middle of translating
some guest code.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
[cota: use CPU_TRACE_DSTATE_MAX_EVENTS instead of trace_get_vcpu_event_count()]
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h      |  3 +++
 trace/control-target.c | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index bc6e20f..29f4a32 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -303,6 +303,8 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to queued_work_*.
  * @queued_work_first: First asynchronous work pending.
+ * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
+ *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
  *
  * State of one CPU core or thread.
@@ -375,6 +377,7 @@ struct CPUState {
     struct kvm_run *kvm_run;
 
     /* Used for events with 'vcpu' and *without* the 'disabled' properties */
+    DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
     DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
 
     /* TODO Move common fields from CPUArchState here. */
diff --git a/trace/control-target.c b/trace/control-target.c
index 99a8ed5..c3a83d2 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qom/cpu.h"
 #include "cpu.h"
 #include "trace-root.h"
 #include "trace/control.h"
@@ -34,6 +35,13 @@ void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state)
     }
 }
 
+static void trace_event_synchronize_vcpu_state_dynamic(
+    CPUState *vcpu, run_on_cpu_data ignored)
+{
+    bitmap_copy(vcpu->trace_dstate, vcpu->trace_dstate_delayed,
+                CPU_TRACE_DSTATE_MAX_EVENTS);
+}
+
 void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
 {
     CPUState *vcpu;
@@ -73,13 +81,20 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
     if (state_pre != state) {
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
+         * Delay changes until next TB; we want all TBs to be built from a
+         * single set of dstate values to ensure consistency of generated
+         * tracing code.
+         */
+        async_run_on_cpu(vcpu, trace_event_synchronize_vcpu_state_dynamic,
+                         RUN_ON_CPU_NULL);
     }
 }
 
-- 
2.7.4
