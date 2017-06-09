Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9cC-0000Y6-5R
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9c8-000698-Tp
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJ9c8-00068L-DE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  8 Jun 2017 22:25:17 -0400
Message-Id: <1496975122-16999-3-git-send-email-cota@braap.org>
In-Reply-To: <1496975122-16999-1-git-send-email-cota@braap.org>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v8 2/7] cpu: allocate cpu->trace_dstate in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

There's little point in dynamically allocating the bitmap if we
know at compile-time the max number of events we want to support.
Thus, make room in the struct for the bitmap, which will make things
easier later: this paves the way for upcoming changes, in which
we'll use a u32 to fully capture cpu->trace_dstate.

This change also increases performance by saving a dereference and
improving locality--note that this is important since upcoming work
makes reading this bitmap fairly common.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 9 +++------
 qom/cpu.c         | 8 --------
 trace/control.c   | 9 ++++++++-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 89ddb68..bc6e20f 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -259,6 +259,7 @@ typedef void (*run_on_cpu_func)(CPUState *cpu, run_on_cpu_data data);
 struct qemu_work_item;
 
 #define CPU_UNSET_NUMA_NODE_ID -1
+#define CPU_TRACE_DSTATE_MAX_EVENTS 32
 
 /**
  * CPUState:
@@ -373,12 +374,8 @@ struct CPUState {
     struct KVMState *kvm_state;
     struct kvm_run *kvm_run;
 
-    /*
-     * Used for events with 'vcpu' and *without* the 'disabled' properties.
-     * Dynamically allocated based on bitmap requried to hold up to
-     * trace_get_vcpu_event_count() entries.
-     */
-    unsigned long *trace_dstate;
+    /* Used for events with 'vcpu' and *without* the 'disabled' properties */
+    DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index; /* used by alpha TCG */
diff --git a/qom/cpu.c b/qom/cpu.c
index 5069876..69fbb9c 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -382,7 +382,6 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
 
 static void cpu_common_initfn(Object *obj)
 {
-    uint32_t count;
     CPUState *cpu = CPU(obj);
     CPUClass *cc = CPU_GET_CLASS(obj);
 
@@ -397,18 +396,11 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
-    count = trace_get_vcpu_event_count();
-    if (count) {
-        cpu->trace_dstate = bitmap_new(count);
-    }
-
     cpu_exec_initfn(cpu);
 }
 
 static void cpu_common_finalize(Object *obj)
 {
-    CPUState *cpu = CPU(obj);
-    g_free(cpu->trace_dstate);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/trace/control.c b/trace/control.c
index 9b157b0..83740aa 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -65,8 +65,15 @@ void trace_event_register_group(TraceEvent **events)
     size_t i;
     for (i = 0; events[i] != NULL; i++) {
         events[i]->id = next_id++;
-        if (events[i]->vcpu_id != TRACE_VCPU_EVENT_NONE) {
+        if (events[i]->vcpu_id == TRACE_VCPU_EVENT_NONE) {
+            continue;
+        }
+
+        if (likely(next_vcpu_id < CPU_TRACE_DSTATE_MAX_EVENTS)) {
             events[i]->vcpu_id = next_vcpu_id++;
+        } else {
+            error_report("WARNING: too many vcpu trace events; dropping '%s'",
+                         events[i]->name);
         }
     }
     event_groups = g_renew(TraceEventGroup, event_groups, nevent_groups + 1);
-- 
2.7.4
