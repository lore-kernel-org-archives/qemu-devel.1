Received: from eggs.gnu.org ([2001:4830:134:3::10]:55455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSMre-0005KD-Ki
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSMrZ-0003rt-Lo
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSMrZ-0003re-Ce
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:23:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64B9AA4FB5
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 12:23:28 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 20:23:25 +0800
Message-Id: <20170704122325.25634-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-thread: Assert locks are initialized
 before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Not all platforms check whether a lock is initialized before used.  In
particular Linux seems to be more permissive than OSX.

Check initialization state explicitly in our code to catch such bugs
earlier.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/thread-posix.h |  4 ++++
 include/qemu/thread-win32.h |  5 +++++
 util/qemu-thread-posix.c    | 27 +++++++++++++++++++++++++++
 util/qemu-thread-win32.c    | 34 +++++++++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index 09d1e15..e5e3a0f 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -12,10 +12,12 @@ typedef QemuMutex QemuRecMutex;
 
 struct QemuMutex {
     pthread_mutex_t lock;
+    bool initialized;
 };
 
 struct QemuCond {
     pthread_cond_t cond;
+    bool initialized;
 };
 
 struct QemuSemaphore {
@@ -26,6 +28,7 @@ struct QemuSemaphore {
 #else
     sem_t sem;
 #endif
+    bool initialized;
 };
 
 struct QemuEvent {
@@ -34,6 +37,7 @@ struct QemuEvent {
     pthread_cond_t cond;
 #endif
     unsigned value;
+    bool initialized;
 };
 
 struct QemuThread {
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index 4c4a261..3a05e3b 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -5,11 +5,13 @@
 
 struct QemuMutex {
     SRWLOCK lock;
+    bool initialized;
 };
 
 typedef struct QemuRecMutex QemuRecMutex;
 struct QemuRecMutex {
     CRITICAL_SECTION lock;
+    bool initialized;
 };
 
 void qemu_rec_mutex_destroy(QemuRecMutex *mutex);
@@ -19,15 +21,18 @@ void qemu_rec_mutex_unlock(QemuRecMutex *mutex);
 
 struct QemuCond {
     CONDITION_VARIABLE var;
+    bool initialized;
 };
 
 struct QemuSemaphore {
     HANDLE sema;
+    bool initialized;
 };
 
 struct QemuEvent {
     int value;
     HANDLE event;
+    bool initialized;
 };
 
 typedef struct QemuThreadData QemuThreadData;
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index eacd99e..4e95d27 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -43,12 +43,15 @@ void qemu_mutex_init(QemuMutex *mutex)
     err = pthread_mutex_init(&mutex->lock, NULL);
     if (err)
         error_exit(err, __func__);
+    mutex->initialized = true;
 }
 
 void qemu_mutex_destroy(QemuMutex *mutex)
 {
     int err;
 
+    assert(mutex->initialized);
+    mutex->initialized = false;
     err = pthread_mutex_destroy(&mutex->lock);
     if (err)
         error_exit(err, __func__);
@@ -58,6 +61,7 @@ void qemu_mutex_lock(QemuMutex *mutex)
 {
     int err;
 
+    assert(mutex->initialized);
     err = pthread_mutex_lock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
@@ -69,6 +73,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
 {
     int err;
 
+    assert(mutex->initialized);
     err = pthread_mutex_trylock(&mutex->lock);
     if (err == 0) {
         trace_qemu_mutex_locked(mutex);
@@ -84,6 +89,7 @@ void qemu_mutex_unlock(QemuMutex *mutex)
 {
     int err;
 
+    assert(mutex->initialized);
     trace_qemu_mutex_unlocked(mutex);
     err = pthread_mutex_unlock(&mutex->lock);
     if (err)
@@ -102,6 +108,7 @@ void qemu_rec_mutex_init(QemuRecMutex *mutex)
     if (err) {
         error_exit(err, __func__);
     }
+    mutex->initialized = true;
 }
 
 void qemu_cond_init(QemuCond *cond)
@@ -111,12 +118,15 @@ void qemu_cond_init(QemuCond *cond)
     err = pthread_cond_init(&cond->cond, NULL);
     if (err)
         error_exit(err, __func__);
+    cond->initialized = true;
 }
 
 void qemu_cond_destroy(QemuCond *cond)
 {
     int err;
 
+    assert(cond->initialized);
+    cond->initialized = false;
     err = pthread_cond_destroy(&cond->cond);
     if (err)
         error_exit(err, __func__);
@@ -126,6 +136,7 @@ void qemu_cond_signal(QemuCond *cond)
 {
     int err;
 
+    assert(cond->initialized);
     err = pthread_cond_signal(&cond->cond);
     if (err)
         error_exit(err, __func__);
@@ -135,6 +146,7 @@ void qemu_cond_broadcast(QemuCond *cond)
 {
     int err;
 
+    assert(cond->initialized);
     err = pthread_cond_broadcast(&cond->cond);
     if (err)
         error_exit(err, __func__);
@@ -144,6 +156,7 @@ void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
 {
     int err;
 
+    assert(cond->initialized);
     trace_qemu_mutex_unlocked(mutex);
     err = pthread_cond_wait(&cond->cond, &mutex->lock);
     trace_qemu_mutex_locked(mutex);
@@ -174,12 +187,15 @@ void qemu_sem_init(QemuSemaphore *sem, int init)
         error_exit(errno, __func__);
     }
 #endif
+    sem->initialized = true;
 }
 
 void qemu_sem_destroy(QemuSemaphore *sem)
 {
     int rc;
 
+    assert(sem->initialized);
+    sem->initialized = false;
 #if defined(__APPLE__) || defined(__NetBSD__)
     rc = pthread_cond_destroy(&sem->cond);
     if (rc < 0) {
@@ -201,6 +217,7 @@ void qemu_sem_post(QemuSemaphore *sem)
 {
     int rc;
 
+    assert(sem->initialized);
 #if defined(__APPLE__) || defined(__NetBSD__)
     pthread_mutex_lock(&sem->lock);
     if (sem->count == UINT_MAX) {
@@ -238,6 +255,7 @@ int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
     int rc;
     struct timespec ts;
 
+    assert(sem->initialized);
 #if defined(__APPLE__) || defined(__NetBSD__)
     rc = 0;
     compute_abs_deadline(&ts, ms);
@@ -285,6 +303,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
 {
     int rc;
 
+    assert(sem->initialized);
 #if defined(__APPLE__) || defined(__NetBSD__)
     pthread_mutex_lock(&sem->lock);
     while (sem->count == 0) {
@@ -310,6 +329,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
 #else
 static inline void qemu_futex_wake(QemuEvent *ev, int n)
 {
+    assert(ev->initialized);
     pthread_mutex_lock(&ev->lock);
     if (n == 1) {
         pthread_cond_signal(&ev->cond);
@@ -321,6 +341,7 @@ static inline void qemu_futex_wake(QemuEvent *ev, int n)
 
 static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
 {
+    assert(ev->initialized);
     pthread_mutex_lock(&ev->lock);
     if (ev->value == val) {
         pthread_cond_wait(&ev->cond, &ev->lock);
@@ -355,10 +376,13 @@ void qemu_event_init(QemuEvent *ev, bool init)
 #endif
 
     ev->value = (init ? EV_SET : EV_FREE);
+    ev->initialized = true;
 }
 
 void qemu_event_destroy(QemuEvent *ev)
 {
+    assert(ev->initialized);
+    ev->initialized = false;
 #ifndef __linux__
     pthread_mutex_destroy(&ev->lock);
     pthread_cond_destroy(&ev->cond);
@@ -370,6 +394,7 @@ void qemu_event_set(QemuEvent *ev)
     /* qemu_event_set has release semantics, but because it *loads*
      * ev->value we need a full memory barrier here.
      */
+    assert(ev->initialized);
     smp_mb();
     if (atomic_read(&ev->value) != EV_SET) {
         if (atomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
@@ -383,6 +408,7 @@ void qemu_event_reset(QemuEvent *ev)
 {
     unsigned value;
 
+    assert(ev->initialized);
     value = atomic_read(&ev->value);
     smp_mb_acquire();
     if (value == EV_SET) {
@@ -398,6 +424,7 @@ void qemu_event_wait(QemuEvent *ev)
 {
     unsigned value;
 
+    assert(ev->initialized);
     value = atomic_read(&ev->value);
     smp_mb_acquire();
     if (value != EV_SET) {
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 653f29f..94f3491 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -46,15 +46,19 @@ static void error_exit(int err, const char *msg)
 void qemu_mutex_init(QemuMutex *mutex)
 {
     InitializeSRWLock(&mutex->lock);
+    mutex->initialized = true;
 }
 
 void qemu_mutex_destroy(QemuMutex *mutex)
 {
+    assert(mutex->initialized);
+    mutex->initialized = false;
     InitializeSRWLock(&mutex->lock);
 }
 
 void qemu_mutex_lock(QemuMutex *mutex)
 {
+    assert(mutex->initialized);
     AcquireSRWLockExclusive(&mutex->lock);
     trace_qemu_mutex_locked(mutex);
 }
@@ -63,6 +67,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
 {
     int owned;
 
+    assert(mutex->initialized);
     owned = TryAcquireSRWLockExclusive(&mutex->lock);
     if (owned) {
         trace_qemu_mutex_locked(mutex);
@@ -73,6 +78,7 @@ int qemu_mutex_trylock(QemuMutex *mutex)
 
 void qemu_mutex_unlock(QemuMutex *mutex)
 {
+    assert(mutex->initialized);
     trace_qemu_mutex_unlocked(mutex);
     ReleaseSRWLockExclusive(&mutex->lock);
 }
@@ -80,25 +86,31 @@ void qemu_mutex_unlock(QemuMutex *mutex)
 void qemu_rec_mutex_init(QemuRecMutex *mutex)
 {
     InitializeCriticalSection(&mutex->lock);
+    mutex->initialized = true;
 }
 
 void qemu_rec_mutex_destroy(QemuRecMutex *mutex)
 {
+    assert(mutex->initialized);
+    mutex->initialized = false;
     DeleteCriticalSection(&mutex->lock);
 }
 
 void qemu_rec_mutex_lock(QemuRecMutex *mutex)
 {
+    assert(mutex->initialized);
     EnterCriticalSection(&mutex->lock);
 }
 
 int qemu_rec_mutex_trylock(QemuRecMutex *mutex)
 {
+    assert(mutex->initialized);
     return !TryEnterCriticalSection(&mutex->lock);
 }
 
 void qemu_rec_mutex_unlock(QemuRecMutex *mutex)
 {
+    assert(mutex->initialized);
     LeaveCriticalSection(&mutex->lock);
 }
 
@@ -106,25 +118,31 @@ void qemu_cond_init(QemuCond *cond)
 {
     memset(cond, 0, sizeof(*cond));
     InitializeConditionVariable(&cond->var);
+    cond->initialized = true;
 }
 
 void qemu_cond_destroy(QemuCond *cond)
 {
+    assert(cond->initialized);
+    cond->initialized = false;
     InitializeConditionVariable(&cond->var);
 }
 
 void qemu_cond_signal(QemuCond *cond)
 {
+    assert(cond->initialized);
     WakeConditionVariable(&cond->var);
 }
 
 void qemu_cond_broadcast(QemuCond *cond)
 {
+    assert(cond->initialized);
     WakeAllConditionVariable(&cond->var);
 }
 
 void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
 {
+    assert(cond->initialized);
     trace_qemu_mutex_unlocked(mutex);
     SleepConditionVariableSRW(&cond->var, &mutex->lock, INFINITE, 0);
     trace_qemu_mutex_locked(mutex);
@@ -134,21 +152,28 @@ void qemu_sem_init(QemuSemaphore *sem, int init)
 {
     /* Manual reset.  */
     sem->sema = CreateSemaphore(NULL, init, LONG_MAX, NULL);
+    sem->initialized = true;
 }
 
 void qemu_sem_destroy(QemuSemaphore *sem)
 {
+    assert(sem->initialized);
+    sem->initialized = false;
     CloseHandle(sem->sema);
 }
 
 void qemu_sem_post(QemuSemaphore *sem)
 {
+    assert(sem->initialized);
     ReleaseSemaphore(sem->sema, 1, NULL);
 }
 
 int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
 {
-    int rc = WaitForSingleObject(sem->sema, ms);
+    int rc;
+
+    assert(sem->initialized);
+    rc = WaitForSingleObject(sem->sema, ms);
     if (rc == WAIT_OBJECT_0) {
         return 0;
     }
@@ -160,6 +185,7 @@ int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
 
 void qemu_sem_wait(QemuSemaphore *sem)
 {
+    assert(sem->initialized);
     if (WaitForSingleObject(sem->sema, INFINITE) != WAIT_OBJECT_0) {
         error_exit(GetLastError(), __func__);
     }
@@ -193,15 +219,19 @@ void qemu_event_init(QemuEvent *ev, bool init)
     /* Manual reset.  */
     ev->event = CreateEvent(NULL, TRUE, TRUE, NULL);
     ev->value = (init ? EV_SET : EV_FREE);
+    ev->initialized = true;
 }
 
 void qemu_event_destroy(QemuEvent *ev)
 {
+    assert(ev->initialized);
+    ev->initialized = false;
     CloseHandle(ev->event);
 }
 
 void qemu_event_set(QemuEvent *ev)
 {
+    assert(ev->initialized);
     /* qemu_event_set has release semantics, but because it *loads*
      * ev->value we need a full memory barrier here.
      */
@@ -218,6 +248,7 @@ void qemu_event_reset(QemuEvent *ev)
 {
     unsigned value;
 
+    assert(ev->initialized);
     value = atomic_read(&ev->value);
     smp_mb_acquire();
     if (value == EV_SET) {
@@ -232,6 +263,7 @@ void qemu_event_wait(QemuEvent *ev)
 {
     unsigned value;
 
+    assert(ev->initialized);
     value = atomic_read(&ev->value);
     smp_mb_acquire();
     if (value != EV_SET) {
-- 
2.9.4
