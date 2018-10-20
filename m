Received: from eggs.gnu.org ([2001:4830:134:3::10]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDuCR-0002Xl-Ry
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 12:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDu9d-0001mA-47
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 12:31:12 -0400
Date: Sat, 20 Oct 2018 12:31:05 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181020163105.GA1734@flamenco>
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-49-cota@braap.org>
	<b76f9b0e-16f6-e51b-250b-4a0f3b71552c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76f9b0e-16f6-e51b-250b-4a0f3b71552c@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 48/56] ppc: acquire the BQL in cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Fri, Oct 19, 2018 at 08:58:31 +0200, Paolo Bonzini wrote:
> On 19/10/2018 03:06, Emilio G. Cota wrote:
> > Soon we will call cpu_has_work without the BQL.
> > 
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: qemu-ppc@nongnu.org
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  target/ppc/translate_init.inc.c | 77 +++++++++++++++++++++++++++++++--
> >  1 file changed, 73 insertions(+), 4 deletions(-)
> > 
> 
> Perhaps we should instead define both ->cpu_has_work and
> ->cpu_has_work_with_iothread_lock members, and move the generic
> unlock/relock code to common code?

I like this. How does the appended look?

Thanks,

		Emilio
---8<---

[PATCH] cpu: introduce cpu_has_work_with_iothread_lock

It will gain some users soon.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index ad8859d014..d9e6f5d4d2 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/main-loop.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
@@ -86,6 +87,8 @@ struct TranslationBlock;
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do. Called with the
  * CPU lock held.
+ * @has_work_with_iothread_lock: Callback for checking if there is work to do.
+ * Called with both the BQL and the CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unassigned_access: Callback for unassigned access handling.
  * (this is deprecated: new targets should use do_transaction_failed instead)
@@ -157,6 +160,7 @@ typedef struct CPUClass {
     void (*reset)(CPUState *cpu);
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
+    bool (*has_work_with_iothread_lock)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
     CPUUnassignedAccess do_unassigned_access;
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
@@ -774,6 +778,40 @@ CPUState *cpu_create(const char *typename);
  */
 const char *parse_cpu_model(const char *cpu_model);
 
+/* do not call directly; use cpu_has_work instead */
+static inline bool cpu_has_work_bql(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool has_cpu_lock = cpu_mutex_locked(cpu);
+    bool has_bql = qemu_mutex_iothread_locked();
+    bool ret;
+
+    if (has_bql) {
+        if (has_cpu_lock) {
+            return cc->has_work_with_iothread_lock(cpu);
+        }
+        cpu_mutex_lock(cpu);
+        ret = cc->has_work_with_iothread_lock(cpu);
+        cpu_mutex_unlock(cpu);
+        return ret;
+    }
+
+    if (has_cpu_lock) {
+        /* avoid deadlock by acquiring the locks in order */
+        cpu_mutex_unlock(cpu);
+    }
+    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
+
+    ret = cc->has_work_with_iothread_lock(cpu);
+
+    qemu_mutex_unlock_iothread();
+    if (!has_cpu_lock) {
+        cpu_mutex_unlock(cpu);
+    }
+    return ret;
+}
+
 /**
  * cpu_has_work:
  * @cpu: The vCPU to check.
@@ -787,6 +825,10 @@ static inline bool cpu_has_work(CPUState *cpu)
     CPUClass *cc = CPU_GET_CLASS(cpu);
     bool ret;
 
+    if (cc->has_work_with_iothread_lock) {
+        return cpu_has_work_bql(cpu);
+    }
+
     g_assert(cc->has_work);
     if (cpu_mutex_locked(cpu)) {
         return cc->has_work(cpu);
-- 
2.17.1
