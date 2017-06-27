Received: from eggs.gnu.org ([2001:4830:134:3::10]:34978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPnIC-0003BC-CW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPnI6-0005ZA-F5
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:00:20 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:53791)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPnI6-0005X6-2b
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:00:14 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Tue, 27 Jun 2017 13:00:04 +0300
Message-Id: <149855760385.4578.10043287211933656139.stgit@frigg.lan>
In-Reply-To: <149855711979.4578.11884555663631849051.stgit@frigg.lan>
References: <149855711979.4578.11884555663631849051.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 2/7] trace: Allocate cpu->trace_dstate in
 place
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

There's little point in dynamically allocating the bitmap if we
know at compile-time the max number of events we want to support.
Thus, make room in the struct for the bitmap, which will make things
easier later: this paves the way for upcoming changes, in which
we'll use a u32 to fully capture cpu->trace_dstate.

This change also increases performance by saving a dereference and
improving locality--note that this is important since upcoming work
makes reading this bitmap fairly common.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/qom/cpu.h |    9 +++------
 qom/cpu.c         |    8 --------
 trace/control.c   |    9 ++++++++-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 89ddb686fb..bc6e20f056 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -259,6 +259,7 @@ typedef void (*run_on_cpu_func)(CPUState *cpu, run_on=
_cpu_data data);
 struct qemu_work_item;
=20
 #define CPU_UNSET_NUMA_NODE_ID -1
+#define CPU_TRACE_DSTATE_MAX_EVENTS 32
=20
 /**
  * CPUState:
@@ -373,12 +374,8 @@ struct CPUState {
     struct KVMState *kvm_state;
     struct kvm_run *kvm_run;
=20
-    /*
-     * Used for events with 'vcpu' and *without* the 'disabled' properti=
es.
-     * Dynamically allocated based on bitmap requried to hold up to
-     * trace_get_vcpu_event_count() entries.
-     */
-    unsigned long *trace_dstate;
+    /* Used for events with 'vcpu' and *without* the 'disabled' properti=
es */
+    DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
=20
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index; /* used by alpha TCG */
diff --git a/qom/cpu.c b/qom/cpu.c
index 50698767dd..69fbb9cc95 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -382,7 +382,6 @@ static void cpu_common_unrealizefn(DeviceState *dev, =
Error **errp)
=20
 static void cpu_common_initfn(Object *obj)
 {
-    uint32_t count;
     CPUState *cpu =3D CPU(obj);
     CPUClass *cc =3D CPU_GET_CLASS(obj);
=20
@@ -397,18 +396,11 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
=20
-    count =3D trace_get_vcpu_event_count();
-    if (count) {
-        cpu->trace_dstate =3D bitmap_new(count);
-    }
-
     cpu_exec_initfn(cpu);
 }
=20
 static void cpu_common_finalize(Object *obj)
 {
-    CPUState *cpu =3D CPU(obj);
-    g_free(cpu->trace_dstate);
 }
=20
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/trace/control.c b/trace/control.c
index 9b157b0ca7..83740aa7ee 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -65,8 +65,15 @@ void trace_event_register_group(TraceEvent **events)
     size_t i;
     for (i =3D 0; events[i] !=3D NULL; i++) {
         events[i]->id =3D next_id++;
-        if (events[i]->vcpu_id !=3D TRACE_VCPU_EVENT_NONE) {
+        if (events[i]->vcpu_id =3D=3D TRACE_VCPU_EVENT_NONE) {
+            continue;
+        }
+
+        if (likely(next_vcpu_id < CPU_TRACE_DSTATE_MAX_EVENTS)) {
             events[i]->vcpu_id =3D next_vcpu_id++;
+        } else {
+            error_report("WARNING: too many vcpu trace events; dropping =
'%s'",
+                         events[i]->name);
         }
     }
     event_groups =3D g_renew(TraceEventGroup, event_groups, nevent_group=
s + 1);
