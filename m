Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdL7R-0008Oe-MA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdL7Q-00037e-IX
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:12:57 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Feb 2017 19:12:44 +0100
Message-Id: <20170213181244.16297-7-pbonzini@redhat.com>
In-Reply-To: <20170213181244.16297-1-pbonzini@redhat.com>
References: <20170213181244.16297-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] coroutine-lock: make CoRwlock thread-safe
 and fair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

This adds a CoMutex around the existing CoQueue.  Because the write-side
can just take CoMutex, the old "writer" field is not necessary anymore.
Instead of removing it altogether, count the number of pending writers
during a read-side critical section and forbid further readers from
entering.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
