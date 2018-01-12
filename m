Received: from eggs.gnu.org ([2001:4830:134:3::10]:42152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZO-00084P-TR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZN-00065g-Ll
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:22 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZN-00065E-Db
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:21 -0500
Received: by mail-wr0-x241.google.com with SMTP id s13so5021218wra.10
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:15 +0100
Message-Id: <1515756676-3860-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 51/52] util/qemu-thread-*: add qemu_lock,
 locked and unlock trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/thread.h    | 39 +++++++++++++++++++++++++++++++++++----
 util/qemu-thread-posix.c | 21 ++++++++++++---------
 util/qemu-thread-win32.c | 20 +++++++++++---------
 util/trace-events        |  7 ++++---
 4 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9910f49..9af4e94 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -22,9 +22,31 @@ typedef struct QemuThread QemuThread;
 
 void qemu_mutex_init(QemuMutex *mutex);
 void qemu_mutex_destroy(QemuMutex *mutex);
-void qemu_mutex_lock(QemuMutex *mutex);
-int qemu_mutex_trylock(QemuMutex *mutex);
-void qemu_mutex_unlock(QemuMutex *mutex);
+int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line);
+void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line);
+void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line);
+
+#define qemu_mutex_lock(mutex) \
+        qemu_mutex_lock_impl(mutex, __FILE__, __LINE__)
+#define qemu_mutex_trylock(mutex) \
+        qemu_mutex_trylock_impl(mutex, __FILE__, __LINE__)
+#define qemu_mutex_unlock(mutex) \
+        qemu_mutex_unlock_impl(mutex, __FILE__, __LINE__)
+
+static inline void (qemu_mutex_lock)(QemuMutex *mutex)
+{
+    qemu_mutex_lock(mutex);
+}
+
+static inline int (qemu_mutex_trylock)(QemuMutex *mutex)
+{
+    return qemu_mutex_trylock(mutex);
+}
+
+static inline void (qemu_mutex_unlock)(QemuMutex *mutex)
+{
+    qemu_mutex_unlock(mutex);
+}
 
 /* Prototypes for other functions are in thread-posix.h/thread-win32.h.  */
 void qemu_rec_mutex_init(QemuRecMutex *mutex);
@@ -39,7 +61,16 @@ void qemu_cond_destroy(QemuCond *cond);
  */
 void qemu_cond_signal(QemuCond *cond);
 void qemu_cond_broadcast(QemuCond *cond);
-void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex);
+void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex,
+                         const char *file, const int line);
+
+#define qemu_cond_wait(cond, mutex) \
+        qemu_cond_wait_impl(cond, mutex, __FILE__, __LINE__)
+
+static inline void (qemu_cond_wait)(QemuCond *cond, QemuMutex *mutex)
+{
+    qemu_cond_wait(cond, mutex);
+}
 
 void qemu_sem_init(QemuSemaphore *sem, int init);
 void qemu_sem_post(QemuSemaphore *sem);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 959a570..b789cf3 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -57,26 +57,28 @@ void qemu_mutex_destroy(QemuMutex *mutex)
         error_exit(err, __func__);
 }
 
-void qemu_mutex_lock(QemuMutex *mutex)
+void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     int err;
 
     assert(mutex->initialized);
+    trace_qemu_mutex_lock(mutex, file, line);
+
     err = pthread_mutex_lock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
 
-    trace_qemu_mutex_locked(mutex);
+    trace_qemu_mutex_locked(mutex, file, line);
 }
 
-int qemu_mutex_trylock(QemuMutex *mutex)
+int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     int err;
 
     assert(mutex->initialized);
     err = pthread_mutex_trylock(&mutex->lock);
     if (err == 0) {
-        trace_qemu_mutex_locked(mutex);
+        trace_qemu_mutex_locked(mutex, file, line);
         return 0;
     }
     if (err != EBUSY) {
@@ -85,15 +87,16 @@ int qemu_mutex_trylock(QemuMutex *mutex)
     return -EBUSY;
 }
 
-void qemu_mutex_unlock(QemuMutex *mutex)
+void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     int err;
 
     assert(mutex->initialized);
-    trace_qemu_mutex_unlocked(mutex);
     err = pthread_mutex_unlock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
+
+    trace_qemu_mutex_unlock(mutex, file, line);
 }
 
 void qemu_rec_mutex_init(QemuRecMutex *mutex)
@@ -152,14 +155,14 @@ void qemu_cond_broadcast(QemuCond *cond)
         error_exit(err, __func__);
 }
 
-void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
+void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const char *file, const int line)
 {
     int err;
 
     assert(cond->initialized);
-    trace_qemu_mutex_unlocked(mutex);
+    trace_qemu_mutex_unlock(mutex, file, line);
     err = pthread_cond_wait(&cond->cond, &mutex->lock);
-    trace_qemu_mutex_locked(mutex);
+    trace_qemu_mutex_locked(mutex, file, line);
     if (err)
         error_exit(err, __func__);
 }
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 94f3491..ab60c0d 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -56,30 +56,32 @@ void qemu_mutex_destroy(QemuMutex *mutex)
     InitializeSRWLock(&mutex->lock);
 }
 
-void qemu_mutex_lock(QemuMutex *mutex)
+void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     assert(mutex->initialized);
+    trace_qemu_mutex_lock(mutex, file, line);
+
     AcquireSRWLockExclusive(&mutex->lock);
-    trace_qemu_mutex_locked(mutex);
+    trace_qemu_mutex_locked(mutex, file, line);
 }
 
-int qemu_mutex_trylock(QemuMutex *mutex)
+int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     int owned;
 
     assert(mutex->initialized);
     owned = TryAcquireSRWLockExclusive(&mutex->lock);
     if (owned) {
-        trace_qemu_mutex_locked(mutex);
+        trace_qemu_mutex_locked(mutex, file, line);
         return 0;
     }
     return -EBUSY;
 }
 
-void qemu_mutex_unlock(QemuMutex *mutex)
+void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     assert(mutex->initialized);
-    trace_qemu_mutex_unlocked(mutex);
+    trace_qemu_mutex_unlock(mutex, file, line);
     ReleaseSRWLockExclusive(&mutex->lock);
 }
 
@@ -140,12 +142,12 @@ void qemu_cond_broadcast(QemuCond *cond)
     WakeAllConditionVariable(&cond->var);
 }
 
-void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
+void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const char *file, const int line)
 {
     assert(cond->initialized);
-    trace_qemu_mutex_unlocked(mutex);
+    trace_qemu_mutex_unlock(mutex, file, line);
     SleepConditionVariableSRW(&cond->var, &mutex->lock, INFINITE, 0);
-    trace_qemu_mutex_locked(mutex);
+    trace_qemu_mutex_locked(mutex, file, line);
 }
 
 void qemu_sem_init(QemuSemaphore *sem, int init)
diff --git a/util/trace-events b/util/trace-events
index 025499f..515e625 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -56,6 +56,7 @@ lockcnt_futex_wait(const void *lockcnt, int val) "lockcnt %p waiting on %d"
 lockcnt_futex_wait_resume(const void *lockcnt, int new) "lockcnt %p after wait: %d"
 lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter"
 
-# util/qemu-thread-posix.c
-qemu_mutex_locked(void *lock) "locked mutex %p"
-qemu_mutex_unlocked(void *lock) "unlocked mutex %p"
+# util/qemu-thread.c
+qemu_mutex_lock(void *mutex, const char *file, const int line) "waiting on mutex %p (%s:%d)"
+qemu_mutex_locked(void *mutex, const char *file, const int line) "taken mutex %p (%s:%d)"
+qemu_mutex_unlock(void *mutex, const char *file, const int line) "released mutex %p (%s:%d)"
-- 
1.8.3.1
