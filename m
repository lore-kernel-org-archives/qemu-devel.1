Received: from eggs.gnu.org ([2001:4830:134:3::10]:38939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94e-0007Uu-W6
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94e-0005Z0-52
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cg94d-0005Yh-Su
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:56:44 +0000
Message-Id: <20170221115644.28264-25-stefanha@redhat.com>
In-Reply-To: <20170221115644.28264-1-stefanha@redhat.com>
References: <20170221115644.28264-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 24/24] coroutine-lock: make CoRwlock
 thread-safe and fair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

This adds a CoMutex around the existing CoQueue.  Because the write-side
can just take CoMutex, the old "writer" field is not necessary anymore.
Instead of removing it altogether, count the number of pending writers
during a read-side critical section and forbid further readers from
entering.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170213181244.16297-7-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/coroutine.h   |  3 ++-
 util/qemu-coroutine-lock.c | 35 ++++++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index d2de268..e60beaf 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -204,8 +204,9 @@ bool qemu_co_queue_empty(CoQueue *queue);
 
 
 typedef struct CoRwlock {
-    bool writer;
+    int pending_writer;
     int reader;
+    CoMutex mutex;
     CoQueue queue;
 } CoRwlock;
 
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index b0a554f..6328eed 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -346,16 +346,22 @@ void qemu_co_rwlock_init(CoRwlock *lock)
 {
     memset(lock, 0, sizeof(*lock));
     qemu_co_queue_init(&lock->queue);
+    qemu_co_mutex_init(&lock->mutex);
 }
 
 void qemu_co_rwlock_rdlock(CoRwlock *lock)
 {
     Coroutine *self = qemu_coroutine_self();
 
-    while (lock->writer) {
-        qemu_co_queue_wait(&lock->queue, NULL);
+    qemu_co_mutex_lock(&lock->mutex);
+    /* For fairness, wait if a writer is in line.  */
+    while (lock->pending_writer) {
+        qemu_co_queue_wait(&lock->queue, &lock->mutex);
     }
     lock->reader++;
+    qemu_co_mutex_unlock(&lock->mutex);
+
+    /* The rest of the read-side critical section is run without the mutex.  */
     self->locks_held++;
 }
 
@@ -364,10 +370,13 @@ void qemu_co_rwlock_unlock(CoRwlock *lock)
     Coroutine *self = qemu_coroutine_self();
 
     assert(qemu_in_coroutine());
-    if (lock->writer) {
-        lock->writer = false;
+    if (!lock->reader) {
+        /* The critical section started in qemu_co_rwlock_wrlock.  */
         qemu_co_queue_restart_all(&lock->queue);
     } else {
+        self->locks_held--;
+
+        qemu_co_mutex_lock(&lock->mutex);
         lock->reader--;
         assert(lock->reader >= 0);
         /* Wakeup only one waiting writer */
@@ -375,16 +384,20 @@ void qemu_co_rwlock_unlock(CoRwlock *lock)
             qemu_co_queue_next(&lock->queue);
         }
     }
-    self->locks_held--;
+    qemu_co_mutex_unlock(&lock->mutex);
 }
 
 void qemu_co_rwlock_wrlock(CoRwlock *lock)
 {
-    Coroutine *self = qemu_coroutine_self();
-
-    while (lock->writer || lock->reader) {
-        qemu_co_queue_wait(&lock->queue, NULL);
+    qemu_co_mutex_lock(&lock->mutex);
+    lock->pending_writer++;
+    while (lock->reader) {
+        qemu_co_queue_wait(&lock->queue, &lock->mutex);
     }
-    lock->writer = true;
-    self->locks_held++;
+    lock->pending_writer--;
+
+    /* The rest of the write-side critical section is run with
+     * the mutex taken, so that lock->reader remains zero.
+     * There is no need to update self->locks_held.
+     */
 }
-- 
2.9.3
