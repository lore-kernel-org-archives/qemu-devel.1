Received: from eggs.gnu.org ([2001:4830:134:3::10]:58990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMDFo-0003Oc-Jp
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 07:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMDFn-00026M-I9
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 07:22:48 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:48964 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMDFn-000263-5a
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 07:22:47 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Dec 2016 13:22:45 +0100
Message-Id: <148292776560.380.13402046316067770536.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148292774946.380.3638349228328753405.stgit@fimbulvetr.bsc.es>
References: <148292774946.380.3638349228328753405.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/7] trace: [tcg] Delay changes to dynamic
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
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This keeps consistency across all decisions taken during translation
when the dynamic state of a vCPU is changed in the middle of translating
some guest code.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 cpu-exec.c             |   26 ++++++++++++++++++++++++++
 include/qom/cpu.h      |    7 +++++++
 qom/cpu.c              |    4 ++++
 trace/control-target.c |   11 +++++++++--
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 4188fed3c6..1b7366efb0 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -33,6 +33,7 @@
 #include "hw/i386/apic.h"
 #endif
 #include "sysemu/replay.h"
+#include "trace/control.h"
=20
 /* -icount align implementation. */
=20
@@ -451,9 +452,21 @@ static inline bool cpu_handle_exception(CPUState *cp=
u, int *ret)
 #ifndef CONFIG_USER_ONLY
     } else if (replay_has_exception()
                && cpu->icount_decr.u16.low + cpu->icount_extra =3D=3D 0)=
 {
+        /* delay changes to this vCPU's dstate during translation */
+        atomic_set(&cpu->trace_dstate_delayed_req, false);
+        atomic_set(&cpu->trace_dstate_must_delay, true);
+
         /* try to cause an exception pending in the log */
         cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
         *ret =3D -1;
+
+        /* apply and disable delayed dstate changes */
+        atomic_set(&cpu->trace_dstate_must_delay, false);
+        if (unlikely(atomic_read(&cpu->trace_dstate_delayed_req))) {
+            bitmap_copy(cpu->trace_dstate, cpu->trace_dstate_delayed,
+                        trace_get_vcpu_event_count());
+        }
+
         return true;
 #endif
     }
@@ -634,8 +647,21 @@ int cpu_exec(CPUState *cpu)
=20
             for(;;) {
                 cpu_handle_interrupt(cpu, &last_tb);
+
+                /* delay changes to this vCPU's dstate during translatio=
n */
+                atomic_set(&cpu->trace_dstate_delayed_req, false);
+                atomic_set(&cpu->trace_dstate_must_delay, true);
+
                 tb =3D tb_find(cpu, last_tb, tb_exit);
                 cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
+
+                /* apply and disable delayed dstate changes */
+                atomic_set(&cpu->trace_dstate_must_delay, false);
+                if (unlikely(atomic_read(&cpu->trace_dstate_delayed_req)=
)) {
+                    bitmap_copy(cpu->trace_dstate, cpu->trace_dstate_del=
ayed,
+                                trace_get_vcpu_event_count());
+                }
+
                 /* Try to align the host and virtual clocks
                    if the guest is in advance */
                 align_clocks(&sc, cpu);
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 3f79a8e955..58255d06fa 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -295,6 +295,10 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to queued_work_*.
  * @queued_work_first: First asynchronous work pending.
+ * @trace_dstate_must_delay: Whether a change to trace_dstate must be de=
layed.
+ * @trace_dstate_delayed_req: Whether a change to trace_dstate was delay=
ed.
+ * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all =
changes
+ *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask=
).
  *
  * State of one CPU core or thread.
@@ -370,6 +374,9 @@ struct CPUState {
      * Dynamically allocated based on bitmap requried to hold up to
      * trace_get_vcpu_event_count() entries.
      */
+    bool trace_dstate_must_delay;
+    bool trace_dstate_delayed_req;
+    unsigned long *trace_dstate_delayed;
     unsigned long *trace_dstate;
=20
     /* TODO Move common fields from CPUArchState here. */
diff --git a/qom/cpu.c b/qom/cpu.c
index 03d9190f8c..d56496d28d 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -367,6 +367,9 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
=20
+    cpu->trace_dstate_must_delay =3D false;
+    cpu->trace_dstate_delayed_req =3D false;
+    cpu->trace_dstate_delayed =3D bitmap_new(trace_get_vcpu_event_count(=
));
     cpu->trace_dstate =3D bitmap_new(trace_get_vcpu_event_count());
=20
     cpu_exec_initfn(cpu);
@@ -375,6 +378,7 @@ static void cpu_common_initfn(Object *obj)
 static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu =3D CPU(obj);
+    g_free(cpu->trace_dstate_delayed);
     g_free(cpu->trace_dstate);
 }
=20
diff --git a/trace/control-target.c b/trace/control-target.c
index 7ebf6e0bcb..aba8db55de 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -69,13 +69,20 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcp=
u,
     if (state_pre !=3D state) {
         if (state) {
             trace_events_enabled_count++;
-            set_bit(vcpu_id, vcpu->trace_dstate);
+            set_bit(vcpu_id, vcpu->trace_dstate_delayed);
+            if (!atomic_read(&vcpu->trace_dstate_must_delay)) {
+                set_bit(vcpu_id, vcpu->trace_dstate);
+            }
             (*ev->dstate)++;
         } else {
             trace_events_enabled_count--;
-            clear_bit(vcpu_id, vcpu->trace_dstate);
+            clear_bit(vcpu_id, vcpu->trace_dstate_delayed);
+            if (!atomic_read(&vcpu->trace_dstate_must_delay)) {
+                clear_bit(vcpu_id, vcpu->trace_dstate);
+            }
             (*ev->dstate)--;
         }
+        atomic_set(&vcpu->trace_dstate_delayed_req, true);
     }
 }
=20
