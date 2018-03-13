Received: from eggs.gnu.org ([2001:4830:134:3::10]:58071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsi1-0005kr-Up
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsi1-0003JV-2n
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:53 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsi0-0003I8-RY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:52 -0400
Received: by mail-wm0-x242.google.com with SMTP id s206so16179041wme.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:52 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:34 +0100
Message-Id: <20180313224719.4954-25-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/69] rcu: make memory barriers more explicit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
