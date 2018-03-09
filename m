Received: from eggs.gnu.org ([2001:4830:134:3::10]:47257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euI5Y-0008E2-UD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euI5V-0003oo-Pb
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1euI5V-0003nx-KA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Mar 2018 14:29:21 +0100
Message-Id: <20180309132922.24211-4-pbonzini@redhat.com>
In-Reply-To: <20180309132922.24211-1-pbonzini@redhat.com>
References: <20180309132922.24211-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] membarrier: introduce qemu/sys_membarrier.h
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

This new header file provides heavy-weight "global" memory barriers that
enforce memory ordering on each running thread belonging to the current
process.  For now, use a dummy implementation that issues memory barriers
on both sides (matching what QEMU has been doing so far).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/rcu.h            |  7 ++++---
 include/qemu/sys_membarrier.h | 17 +++++++++++++++++
 util/rcu.c                    |  9 +++++----
 3 files changed, 26 insertions(+), 7 deletions(-)
 create mode 100644 include/qemu/sys_membarrier.h

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 625f09ac09..22876d1428 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -27,6 +27,7 @@
 #include "qemu/thread.h"
 #include "qemu/queue.h"
 #include "qemu/atomic.h"
+#include "qemu/sys_membarrier.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -82,7 +83,7 @@ static inline void rcu_read_lock(void)
     atomic_set(&p_rcu_reader->ctr, ctr);
 
     /* Write p_rcu_reader->ctr before reading RCU-protected pointers.  */
-    smp_mb();
+    smp_mb_placeholder();
 }
 
 static inline void rcu_read_unlock(void)
@@ -96,13 +97,13 @@ static inline void rcu_read_unlock(void)
 
     /* Ensure that the critical section is seen to precede the
      * store to p_rcu_reader->ctr.  Together with the following
-     * smp_mb(), this ensures writes to p_rcu_reader->ctr
+     * smp_mb_placeholder(), this ensures writes to p_rcu_reader->ctr
      * are sequentially consistent.
      */
     atomic_store_release(&p_rcu_reader->ctr, 0);
 
     /* Write p_rcu_reader->ctr before reading p_rcu_reader->waiting.  */
-    smp_mb();
+    smp_mb_placeholder();
     if (unlikely(atomic_read(&p_rcu_reader->waiting))) {
         atomic_set(&p_rcu_reader->waiting, false);
         qemu_event_set(&rcu_gp_event);
diff --git a/include/qemu/sys_membarrier.h b/include/qemu/sys_membarrier.h
new file mode 100644
index 0000000000..9ce7f5210b
--- /dev/null
+++ b/include/qemu/sys_membarrier.h
@@ -0,0 +1,17 @@
+/*
+ * Process-global memory barriers
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ */
+
+#ifndef QEMU_SYS_MEMBARRIER_H
+#define QEMU_SYS_MEMBARRIER_H 1
+
+/* Keep it simple, execute a real memory barrier on both sides.  */
+static inline void smp_mb_global_init(void) {}
+#define smp_mb_global()            smp_mb()
+#define smp_mb_placeholder()       smp_mb()
+
+#endif
diff --git a/util/rcu.c b/util/rcu.c
index 7366dc50dd..5676c22bd1 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -93,10 +93,10 @@ static void wait_for_readers(void)
         }
 
         /* Here, order the stores to index->waiting before the loads of
-         * index->ctr.  Pairs with smp_mb() in rcu_read_unlock(),
+         * index->ctr.  Pairs with smp_mb_placeholder() in rcu_read_unlock(),
          * ensuring that the loads of index->ctr are sequentially consistent.
          */
-        smp_mb();
+        smp_mb_global();
 
         QLIST_FOREACH_SAFE(index, &registry, node, tmp) {
             if (!rcu_gp_ongoing(&index->ctr)) {
@@ -145,9 +145,9 @@ void synchronize_rcu(void)
     qemu_mutex_lock(&rcu_sync_lock);
 
     /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
-     * Pairs with smp_mb() in rcu_read_lock().
+     * Pairs with smp_mb_placeholder() in rcu_read_lock().
      */
-    smp_mb();
+    smp_mb_global();
 
     qemu_mutex_lock(&rcu_registry_lock);
     if (!QLIST_EMPTY(&registry)) {
@@ -376,6 +376,7 @@ static void rcu_init_child(void)
 
 static void __attribute__((__constructor__)) rcu_init(void)
 {
+    smp_mb_global_init();
 #ifdef CONFIG_POSIX
     pthread_atfork(rcu_init_lock, rcu_init_unlock, rcu_init_child);
 #endif
-- 
2.14.3
