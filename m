Received: from eggs.gnu.org ([2001:4830:134:3::10]:60779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJj-0006lU-3V
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJh-0000uj-LT
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4311)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csXJh-0000tO-CC
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:25 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Mar 2017 18:16:12 +0200
Message-Id: <20170327161615.19637-7-pbonzini@redhat.com>
In-Reply-To: <20170327161615.19637-1-pbonzini@redhat.com>
References: <20170327161615.19637-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] win32: replace custom mutex and condition
 variable with native primitives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Shedel <ashedel@microsoft.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>

From: Andrey Shedel <ashedel@microsoft.com>

The multithreaded TCG implementation exposed deadlocks in the win32
condition variables: as implemented, qemu_cond_broadcast waited on
receivers, whereas the pthreads API it was intended to emulate does
not. This was causing a deadlock because broadcast was called while
holding the IO lock, as well as all possible waiters blocked on the
same lock.

This patch replaces all the custom synchronisation code for mutexes
and condition variables with native Windows primitives (SRWlocks and
condition variables) with the same semantics as their POSIX
equivalents. To enable that, it requires a Windows Vista or newer host
OS.

Signed-off-by: Andrey Shedel <ashedel@microsoft.com>
[AB: edited commit message]
Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Message-Id: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/thread-win32.h |   7 +--
 util/qemu-thread-win32.c    | 136 +++++---------------------------------------
 2 files changed, 17 insertions(+), 126 deletions(-)

diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index 5fb6541..4c4a261 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -4,8 +4,7 @@
 #include <windows.h>
 
 struct QemuMutex {
-    CRITICAL_SECTION lock;
-    LONG owner;
+    SRWLOCK lock;
 };
 
 typedef struct QemuRecMutex QemuRecMutex;
@@ -19,9 +18,7 @@ int qemu_rec_mutex_trylock(QemuRecMutex *mutex);
 void qemu_rec_mutex_unlock(QemuRecMutex *mutex);
 
 struct QemuCond {
-    LONG waiters, target;
-    HANDLE sema;
-    HANDLE continue_event;
+    CONDITION_VARIABLE var;
 };
 
 struct QemuSemaphore {
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 29c3e4d..59befd5 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -10,6 +10,11 @@
  * See the COPYING file in the top-level directory.
  *
  */
+
+#ifndef _WIN32_WINNT
+#define _WIN32_WINNT 0x0600
+#endif
+
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
@@ -39,44 +44,30 @@ static void error_exit(int err, const char *msg)
 
 void qemu_mutex_init(QemuMutex *mutex)
 {
-    mutex->owner = 0;
-    InitializeCriticalSection(&mutex->lock);
+    InitializeSRWLock(&mutex->lock);
 }
 
 void qemu_mutex_destroy(QemuMutex *mutex)
 {
-    assert(mutex->owner == 0);
-    DeleteCriticalSection(&mutex->lock);
+    InitializeSRWLock(&mutex->lock);
 }
 
 void qemu_mutex_lock(QemuMutex *mutex)
 {
-    EnterCriticalSection(&mutex->lock);
-
-    /* Win32 CRITICAL_SECTIONs are recursive.  Assert that we're not
-     * using them as such.
-     */
-    assert(mutex->owner == 0);
-    mutex->owner = GetCurrentThreadId();
+    AcquireSRWLockExclusive(&mutex->lock);
 }
 
 int qemu_mutex_trylock(QemuMutex *mutex)
 {
     int owned;
 
-    owned = TryEnterCriticalSection(&mutex->lock);
-    if (owned) {
-        assert(mutex->owner == 0);
-        mutex->owner = GetCurrentThreadId();
-    }
+    owned = TryAcquireSRWLockExclusive(&mutex->lock);
     return !owned;
 }
 
 void qemu_mutex_unlock(QemuMutex *mutex)
 {
-    assert(mutex->owner == GetCurrentThreadId());
-    mutex->owner = 0;
-    LeaveCriticalSection(&mutex->lock);
+    ReleaseSRWLockExclusive(&mutex->lock);
 }
 
 void qemu_rec_mutex_init(QemuRecMutex *mutex)
@@ -107,124 +98,27 @@ void qemu_rec_mutex_unlock(QemuRecMutex *mutex)
 void qemu_cond_init(QemuCond *cond)
 {
     memset(cond, 0, sizeof(*cond));
-
-    cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
-    if (!cond->sema) {
-        error_exit(GetLastError(), __func__);
-    }
-    cond->continue_event = CreateEvent(NULL,    /* security */
-                                       FALSE,   /* auto-reset */
-                                       FALSE,   /* not signaled */
-                                       NULL);   /* name */
-    if (!cond->continue_event) {
-        error_exit(GetLastError(), __func__);
-    }
+    InitializeConditionVariable(&cond->var);
 }
 
 void qemu_cond_destroy(QemuCond *cond)
 {
-    BOOL result;
-    result = CloseHandle(cond->continue_event);
-    if (!result) {
-        error_exit(GetLastError(), __func__);
-    }
-    cond->continue_event = 0;
-    result = CloseHandle(cond->sema);
-    if (!result) {
-        error_exit(GetLastError(), __func__);
-    }
-    cond->sema = 0;
+    InitializeConditionVariable(&cond->var);
 }
 
 void qemu_cond_signal(QemuCond *cond)
 {
-    DWORD result;
-
-    /*
-     * Signal only when there are waiters.  cond->waiters is
-     * incremented by pthread_cond_wait under the external lock,
-     * so we are safe about that.
-     */
-    if (cond->waiters == 0) {
-        return;
-    }
-
-    /*
-     * Waiting threads decrement it outside the external lock, but
-     * only if another thread is executing pthread_cond_broadcast and
-     * has the mutex.  So, it also cannot be decremented concurrently
-     * with this particular access.
-     */
-    cond->target = cond->waiters - 1;
-    result = SignalObjectAndWait(cond->sema, cond->continue_event,
-                                 INFINITE, FALSE);
-    if (result == WAIT_ABANDONED || result == WAIT_FAILED) {
-        error_exit(GetLastError(), __func__);
-    }
+    WakeConditionVariable(&cond->var);
 }
 
 void qemu_cond_broadcast(QemuCond *cond)
 {
-    BOOLEAN result;
-    /*
-     * As in pthread_cond_signal, access to cond->waiters and
-     * cond->target is locked via the external mutex.
-     */
-    if (cond->waiters == 0) {
-        return;
-    }
-
-    cond->target = 0;
-    result = ReleaseSemaphore(cond->sema, cond->waiters, NULL);
-    if (!result) {
-        error_exit(GetLastError(), __func__);
-    }
-
-    /*
-     * At this point all waiters continue. Each one takes its
-     * slice of the semaphore. Now it's our turn to wait: Since
-     * the external mutex is held, no thread can leave cond_wait,
-     * yet. For this reason, we can be sure that no thread gets
-     * a chance to eat *more* than one slice. OTOH, it means
-     * that the last waiter must send us a wake-up.
-     */
-    WaitForSingleObject(cond->continue_event, INFINITE);
+    WakeAllConditionVariable(&cond->var);
 }
 
 void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
 {
-    /*
-     * This access is protected under the mutex.
-     */
-    cond->waiters++;
-
-    /*
-     * Unlock external mutex and wait for signal.
-     * NOTE: we've held mutex locked long enough to increment
-     * waiters count above, so there's no problem with
-     * leaving mutex unlocked before we wait on semaphore.
-     */
-    qemu_mutex_unlock(mutex);
-    WaitForSingleObject(cond->sema, INFINITE);
-
-    /* Now waiters must rendez-vous with the signaling thread and
-     * let it continue.  For cond_broadcast this has heavy contention
-     * and triggers thundering herd.  So goes life.
-     *
-     * Decrease waiters count.  The mutex is not taken, so we have
-     * to do this atomically.
-     *
-     * All waiters contend for the mutex at the end of this function
-     * until the signaling thread relinquishes it.  To ensure
-     * each waiter consumes exactly one slice of the semaphore,
-     * the signaling thread stops until it is told by the last
-     * waiter that it can go on.
-     */
-    if (InterlockedDecrement(&cond->waiters) == cond->target) {
-        SetEvent(cond->continue_event);
-    }
-
-    qemu_mutex_lock(mutex);
+    SleepConditionVariableSRW(&cond->var, &mutex->lock, INFINITE, 0);
 }
 
 void qemu_sem_init(QemuSemaphore *sem, int init)
-- 
2.9.3
