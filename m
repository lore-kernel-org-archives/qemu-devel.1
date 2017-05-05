Received: from eggs.gnu.org ([2001:4830:134:3::10]:47093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFG-0002Ka-LW
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFE-0006e4-VD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFE-0006dn-Lv
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:52 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:26 +0200
Message-Id: <20170505101337.4650-11-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/21] trace: add qemu mutex lock and unlock
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

These trace events were very useful to help me to understand and find a
reordering issue in vfio, for example:

qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2020c, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8
qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc4, 0xa0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8

that also helped me to see the desired result after the fix:

qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2000c, 4)
  vfio_region_write  (0001:03:00.0:region1+0xc4, 0xb0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8

So it could be a good idea to have these traces implemented. It's worth
mentioning that they should be surgically enabled during the debugging,
otherwise it can flood the trace logs with lock/unlock messages.

How to use it:
trace-event qemu_mutex_lock on|off
trace-event qemu_mutex_unlock on|off
or
trace-event qemu_mutex* on|off

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Message-Id: <1493054398-26013-1-git-send-email-joserz@linux.vnet.ibm.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
[Also handle trylock, cond_wait and win32; trace "unlocked" while still
 in the critical section, so that "unlocked" always comes before the
 next "locked" tracepoint. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-thread-posix.c | 18 +++++++++++++++++-
 util/qemu-thread-win32.c | 11 ++++++++++-
 util/trace-events        |  4 ++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 73e3a0edf5..eacd99e497 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,6 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
+#include "trace.h"
 
 static bool name_threads;
 
@@ -60,17 +61,30 @@ void qemu_mutex_lock(QemuMutex *mutex)
     err = pthread_mutex_lock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
+
+    trace_qemu_mutex_locked(mutex);
 }
 
 int qemu_mutex_trylock(QemuMutex *mutex)
 {
-    return pthread_mutex_trylock(&mutex->lock);
+    int err;
+
+    err = pthread_mutex_trylock(&mutex->lock);
+    if (err == 0) {
+        trace_qemu_mutex_locked(mutex);
+        return 0;
+    }
+    if (err != EBUSY) {
+        error_exit(err, __func__);
+    }
+    return -EBUSY;
 }
 
 void qemu_mutex_unlock(QemuMutex *mutex)
 {
     int err;
 
+    trace_qemu_mutex_unlocked(mutex);
     err = pthread_mutex_unlock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
@@ -130,7 +144,9 @@ void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
 {
     int err;
 
+    trace_qemu_mutex_unlocked(mutex);
     err = pthread_cond_wait(&cond->cond, &mutex->lock);
+    trace_qemu_mutex_locked(mutex);
     if (err)
         error_exit(err, __func__);
 }
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 59befd5202..653f29f442 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -19,6 +19,7 @@
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
+#include "trace.h"
 #include <process.h>
 
 static bool name_threads;
@@ -55,6 +56,7 @@ void qemu_mutex_destroy(QemuMutex *mutex)
 void qemu_mutex_lock(QemuMutex *mutex)
 {
     AcquireSRWLockExclusive(&mutex->lock);
+    trace_qemu_mutex_locked(mutex);
 }
 
 int qemu_mutex_trylock(QemuMutex *mutex)
@@ -62,11 +64,16 @@ int qemu_mutex_trylock(QemuMutex *mutex)
     int owned;
 
     owned = TryAcquireSRWLockExclusive(&mutex->lock);
-    return !owned;
+    if (owned) {
+        trace_qemu_mutex_locked(mutex);
+        return 0;
+    }
+    return -EBUSY;
 }
 
 void qemu_mutex_unlock(QemuMutex *mutex)
 {
+    trace_qemu_mutex_unlocked(mutex);
     ReleaseSRWLockExclusive(&mutex->lock);
 }
 
@@ -118,7 +125,9 @@ void qemu_cond_broadcast(QemuCond *cond)
 
 void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
 {
+    trace_qemu_mutex_unlocked(mutex);
     SleepConditionVariableSRW(&cond->var, &mutex->lock, INFINITE, 0);
+    trace_qemu_mutex_locked(mutex);
 }
 
 void qemu_sem_init(QemuSemaphore *sem, int init)
diff --git a/util/trace-events b/util/trace-events
index b44ef4f895..fa540c620b 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -55,3 +55,7 @@ lockcnt_futex_wait_prepare(const void *lockcnt, int expected, int new) "lockcnt
 lockcnt_futex_wait(const void *lockcnt, int val) "lockcnt %p waiting on %d"
 lockcnt_futex_wait_resume(const void *lockcnt, int new) "lockcnt %p after wait: %d"
 lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter"
+
+# util/qemu-thread-posix.c
+qemu_mutex_locked(void *lock) "locked mutex %p"
+qemu_mutex_unlocked(void *lock) "unlocked mutex %p"
-- 
2.12.2
