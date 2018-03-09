Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euI5Y-0008E7-Ug
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euI5V-0003oz-Qe
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37623 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1euI5V-0003o0-KY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Mar 2018 14:29:20 +0100
Message-Id: <20180309132922.24211-3-pbonzini@redhat.com>
In-Reply-To: <20180309132922.24211-1-pbonzini@redhat.com>
References: <20180309132922.24211-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] rcu: make memory barriers more explicit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>

Prepare for introducing smp_mb_placeholder() and smp_mb_global().
The new smp_mb() in synchronize_rcu() is not strictly necessary, since
the first atomic_mb_set for rcu_gp_ctr provides the required ordering.
However, synchronize_rcu is not performance critical, and it *will* be
necessary to introduce a smp_mb_global before calling wait_for_readers().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/rcu.h | 15 +++++++++++++--
 util/rcu.c         | 12 +++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index f19413d649..625f09ac09 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -79,7 +79,10 @@ static inline void rcu_read_lock(void)
     }
 
     ctr = atomic_read(&rcu_gp_ctr);
-    atomic_xchg(&p_rcu_reader->ctr, ctr);
+    atomic_set(&p_rcu_reader->ctr, ctr);
+
+    /* Write p_rcu_reader->ctr before reading RCU-protected pointers.  */
+    smp_mb();
 }
 
 static inline void rcu_read_unlock(void)
@@ -91,7 +94,15 @@ static inline void rcu_read_unlock(void)
         return;
     }
 
-    atomic_xchg(&p_rcu_reader->ctr, 0);
+    /* Ensure that the critical section is seen to precede the
+     * store to p_rcu_reader->ctr.  Together with the following
+     * smp_mb(), this ensures writes to p_rcu_reader->ctr
+     * are sequentially consistent.
+     */
+    atomic_store_release(&p_rcu_reader->ctr, 0);
+
+    /* Write p_rcu_reader->ctr before reading p_rcu_reader->waiting.  */
+    smp_mb();
     if (unlikely(atomic_read(&p_rcu_reader->waiting))) {
         atomic_set(&p_rcu_reader->waiting, false);
         qemu_event_set(&rcu_gp_event);
diff --git a/util/rcu.c b/util/rcu.c
index f4d09c8304..7366dc50dd 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -92,8 +92,9 @@ static void wait_for_readers(void)
             atomic_set(&index->waiting, true);
         }
 
-        /* Here, order the stores to index->waiting before the
-         * loads of index->ctr.
+        /* Here, order the stores to index->waiting before the loads of
+         * index->ctr.  Pairs with smp_mb() in rcu_read_unlock(),
+         * ensuring that the loads of index->ctr are sequentially consistent.
          */
         smp_mb();
 
@@ -142,8 +143,13 @@ static void wait_for_readers(void)
 void synchronize_rcu(void)
 {
     qemu_mutex_lock(&rcu_sync_lock);
-    qemu_mutex_lock(&rcu_registry_lock);
 
+    /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
+     * Pairs with smp_mb() in rcu_read_lock().
+     */
+    smp_mb();
+
+    qemu_mutex_lock(&rcu_registry_lock);
     if (!QLIST_EMPTY(&registry)) {
         /* In either case, the atomic_mb_set below blocks stores that free
          * old RCU-protected pointers.
-- 
2.14.3
