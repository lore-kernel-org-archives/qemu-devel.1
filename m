Received: from eggs.gnu.org ([2001:4830:134:3::10]:47834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8IL-0006zG-Kk
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8IK-0004il-B5
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:49 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:35588)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8IJ-0004cf-RO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:48 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 22 Dec 2016 19:35:59 +0100
Message-Id: <148243175909.7321.16929978099968945723.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
References: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/6] exec: [tcg] Switch physical TB cache
 based on vCPU tracing state
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

Uses the per-vCPU event state in CPUState->trace_dstate (a bitmap) as an
index to a physical TB cache that will contain code specific to the set
of dynamically enabled events.

Two vCPUs tracing different events will execute code from different
physical TB caches. Two vCPUs tracing the same events will execute code
from the same physical TB cache.

This is used on the next patch to optimize TCG code related to event
tracing.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 cpu-exec.c             |    6 ++++++
 include/qom/cpu.h      |    1 +
 qom/cpu.c              |    1 +
 trace/control-target.c |    1 +
 trace/control.h        |    3 +++
 translate-all.c        |   24 ++++++++++++++++++++++++
 translate-all.h        |   26 ++++++++++++++++++++++++++
 7 files changed, 62 insertions(+)

diff --git a/cpu-exec.c b/cpu-exec.c
index a3d9eee17e..3a18b2fa68 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -29,6 +29,7 @@
 #include "qemu/rcu.h"
 #include "exec/tb-hash.h"
 #include "exec/log.h"
+#include "translate-all.h"
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
 #include "hw/i386/apic.h"
 #endif
@@ -526,6 +527,11 @@ static inline void cpu_handle_interrupt(CPUState *cp=
u,
             *last_tb =3D NULL;
         }
     }
+    if (unlikely(cpu_tb_cache_set_requested(cpu))) {
+        cpu_tb_cache_set_apply(cpu);
+        /* avoid chaning TBs across physical TB caches */
+        *last_tb =3D NULL;
+    }
     if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt=
())) {
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index =3D EXCP_INTERRUPT;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 486872b752..910f326cbe 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -371,6 +371,7 @@ struct CPUState {
      * Dynamically allocated based on bitmap requried to hold up to
      * trace_get_vcpu_event_count() entries.
      */
+    bool tb_cache_idx_req;
     unsigned long *tb_cache_idx;
     unsigned long *trace_dstate;
=20
diff --git a/qom/cpu.c b/qom/cpu.c
index 8c702b7818..a40ce45242 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -367,6 +367,7 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
=20
+    cpu->tb_cache_idx_req =3D false;
     cpu->tb_cache_idx =3D bitmap_new(trace_get_vcpu_event_count());
     cpu->trace_dstate =3D bitmap_new(trace_get_vcpu_event_count());
=20
diff --git a/trace/control-target.c b/trace/control-target.c
index 7ebf6e0bcb..ecae94dc0a 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -76,6 +76,7 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
             clear_bit(vcpu_id, vcpu->trace_dstate);
             (*ev->dstate)--;
         }
+        cpu_tb_cache_set_request(vcpu);
     }
 }
=20
diff --git a/trace/control.h b/trace/control.h
index 80d326c4d1..cab84a0308 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -165,6 +165,9 @@ void trace_event_set_state_dynamic(TraceEvent *ev, bo=
ol state);
  * Set the dynamic tracing state of an event for the given vCPU.
  *
  * Pre-condition: trace_event_get_vcpu_state_static(ev) =3D=3D true
+ *
+ * Note: Changes for execution-time events with the 'tcg' property will =
not be
+ *       propagated until the next TB is executed (iff executing in TCG =
mode).
  */
 void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
                                         TraceEvent *ev, bool state);
diff --git a/translate-all.c b/translate-all.c
index 1051ec6271..e9ebd93ece 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1288,6 +1288,30 @@ static void tb_link_page(TranslationBlock *tb, tb_=
page_addr_t phys_pc,
 #endif
 }
=20
+void cpu_tb_cache_set_request(CPUState *cpu)
+{
+    /*
+     * Request is taken from cpu->trace_dstate and lazily applied into
+     * cpu->tb_cache_idx at cpu_tb_cache_set_apply().
+     */
+    /* NOTE: Checked by all TBs in gen_tb_start(). */
+    atomic_set(&cpu->tb_cache_idx_req, true);
+    atomic_set(&cpu->tcg_exit_req, 1);
+}
+
+bool cpu_tb_cache_set_requested(CPUState *cpu)
+{
+    return cpu->tb_cache_idx_req;
+}
+
+void cpu_tb_cache_set_apply(CPUState *cpu)
+{
+    cpu->tb_cache_idx_req =3D false;
+    bitmap_copy(cpu->tb_cache_idx, cpu->trace_dstate,
+                trace_get_vcpu_event_count());
+    tb_flush_jmp_cache_all(cpu);
+}
+
 /* Called with mmap_lock held for user mode emulation.  */
 TranslationBlock *tb_gen_code(CPUState *cpu,
                               target_ulong pc, target_ulong cs_base,
diff --git a/translate-all.h b/translate-all.h
index d39bf325d9..fcc7fb04fc 100644
--- a/translate-all.h
+++ b/translate-all.h
@@ -36,6 +36,32 @@ static size_t tb_caches_count(void);
  */
 static struct qht *tb_caches_get(TBContext *tb_ctx, unsigned long *bitma=
p);
=20
+/**
+ * cpu_tb_cache_set_request:
+ *
+ * Request a physical TB cache switch on this @cpu.
+ */
+void cpu_tb_cache_set_request(CPUState *cpu);
+
+/**
+ * cpu_tb_cache_set_requested:
+ *
+ * Returns: %true if @cpu requested a physical TB cache switch, %false
+ *          otherwise.
+ */
+bool cpu_tb_cache_set_requested(CPUState *cpu);
+
+/**
+ * cput_tb_cache_set_apply:
+ *
+ * Apply a physical TB cache switch.
+ *
+ * Precondition: @cpu is not currently executing any TB.
+ *
+ * Note: Invalidates the jump cache of the given vCPU.
+ */
+void cpu_tb_cache_set_apply(CPUState *cpu);
+
 /* translate-all.c */
 void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t =
end,
