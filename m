Received: from eggs.gnu.org ([2001:4830:134:3::10]:39015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYwpu-000714-4J
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYwpp-0007OP-6s
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:05:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 29 Jun 2018 19:05:20 +0200
Message-Id: <20180629170520.13671-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x/tcg: fix locking problem with
 tcg_s390_tod_updated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

tcg_s390_tod_updated() is always called with the iothread being locked
(e.g. from S390TODClass->set() e.g. via HELPER(sck) or on incomming
migration). The helper we call takes the lock itself - bad.

Let's change that by factoring out updating the ckc timer. This now looks
much nicer than having to call a helper from another function.

While touch it we also make sure that env->ckc is updated even if the new
value is -1ULL, for now it would not have been modified in that case.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

This survives my tests and the iotests Christian mentioned.

 target/s390x/misc_helper.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 7656a9b90a..3f91579570 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -149,26 +149,23 @@ uint64_t HELPER(stck)(CPUS390XState *env)
     return tod.low;
 }
 
-/* Set Clock Comparator */
-void HELPER(sckc)(CPUS390XState *env, uint64_t time)
+static void update_ckc_timer(CPUS390XState *env)
 {
     S390TODState *td = s390_get_todstate();
+    uint64_t time;
 
     /* stop the timer and remove pending CKC IRQs */
     timer_del(env->tod_timer);
-    qemu_mutex_lock_iothread();
+    g_assert(qemu_mutex_iothread_locked());
     env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
-    qemu_mutex_unlock_iothread();
 
     /* the tod has to exceed the ckc, this can never happen if ckc is all 1's */
-    if (time == -1ULL) {
+    if (env->ckc == -1ULL) {
         return;
     }
 
-    env->ckc = time;
-
     /* difference between origins */
-    time -= td->base.low;
+    time = env->ckc - td->base.low;
 
     /* nanoseconds */
     time = tod2time(time);
@@ -176,12 +173,21 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
     timer_mod(env->tod_timer, time);
 }
 
+/* Set Clock Comparator */
+void HELPER(sckc)(CPUS390XState *env, uint64_t ckc)
+{
+    env->ckc = ckc;
+
+    qemu_mutex_lock_iothread();
+    update_ckc_timer(env);
+    qemu_mutex_unlock_iothread();
+}
+
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
 {
     S390CPU *cpu = S390_CPU(cs);
-    CPUS390XState *env = &cpu->env;
 
-    helper_sckc(env, env->ckc);
+    update_ckc_timer(&cpu->env);
 }
 
 /* Set Clock */
-- 
2.17.1
