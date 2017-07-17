Received: from eggs.gnu.org ([2001:4830:134:3::10]:45025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX4sF-0002O7-1q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX4sD-0006w7-MV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX4sD-0006vY-Dj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:11:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 17 Jul 2017 13:11:21 +0100
Message-Id: <20170717121127.25154-2-stefanha@redhat.com>
In-Reply-To: <20170717121127.25154-1-stefanha@redhat.com>
References: <20170717121127.25154-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] trace: Allocate cpu->trace_dstate in place
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
Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Message-id: 149915725977.6295.15069969323605305641.stgit@frigg.lan
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qom/cpu.h | 9 +++------
 qom/cpu.c         | 8 --------
 trace/control.c   | 9 ++++++++-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 04c31e6..5f188d4 100644
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
@@ -370,12 +371,8 @@ struct CPUState {
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
index a39ff6c..4f38db0 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -380,7 +380,6 @@ static void cpu_common_unrealizefn(DeviceState *dev, =
Error **errp)
=20
 static void cpu_common_initfn(Object *obj)
 {
-    uint32_t count;
     CPUState *cpu =3D CPU(obj);
     CPUClass *cc =3D CPU_GET_CLASS(obj);
=20
@@ -395,18 +394,11 @@ static void cpu_common_initfn(Object *obj)
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
index f5fb11d..82d8989 100644
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
--=20
2.9.4
