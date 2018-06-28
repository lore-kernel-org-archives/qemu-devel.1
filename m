Received: from eggs.gnu.org ([2001:4830:134:3::10]:37931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAX-0007BD-Vi
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAW-0000JL-D5
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:29 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:54422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAV-0000HU-IF
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:28 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i139-v6so10967516wmf.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:22 +0200
Message-Id: <1530216310-52873-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/60] qemu-thread: introduce
 qemu-thread-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Introduce some hooks for the shared part of qemu thread between POSIX
and Windows implementations.  Note that in qemu_mutex_unlock_impl() we
moved the call before unlock operation which should make more sense.
And we don't need qemu_mutex_post_unlock() hook.

Put all these shared hooks into the header files.  It should be internal
to qemu-thread but not for qemu-thread users, hence put into util/
directory.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180425025459.5258-3-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-thread-common.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c  | 19 ++++++++-----------
 util/qemu-thread-win32.c  | 17 ++++++++---------
 3 files changed, 59 insertions(+), 20 deletions(-)
 create mode 100644 util/qemu-thread-common.h

diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
new file mode 100644
index 0000000..d329208
--- /dev/null
+++ b/util/qemu-thread-common.h
@@ -0,0 +1,43 @@
+/*
+ * Common qemu-thread implementation header file.
+ *
+ * Copyright Red Hat, Inc. 2018
+ *
+ * Authors:
+ *  Peter Xu <peterx@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_THREAD_COMMON_H
+#define QEMU_THREAD_COMMON_H
+
+#include "qemu/typedefs.h"
+#include "qemu/thread.h"
+#include "trace.h"
+
+static inline void qemu_mutex_post_init(QemuMutex *mutex)
+{
+    mutex->initialized = true;
+}
+
+static inline void qemu_mutex_pre_lock(QemuMutex *mutex,
+                                       const char *file, int line)
+{
+    trace_qemu_mutex_lock(mutex, file, line);
+}
+
+static inline void qemu_mutex_post_lock(QemuMutex *mutex,
+                                        const char *file, int line)
+{
+    trace_qemu_mutex_locked(mutex, file, line);
+}
+
+static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
+                                         const char *file, int line)
+{
+    trace_qemu_mutex_unlock(mutex, file, line);
+}
+
+#endif
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index a1c34ba..dfa66ff 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,7 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
-#include "trace.h"
+#include "qemu-thread-common.h"
 
 static bool name_threads;
 
@@ -43,7 +43,7 @@ void qemu_mutex_init(QemuMutex *mutex)
     err = pthread_mutex_init(&mutex->lock, NULL);
     if (err)
         error_exit(err, __func__);
-    mutex->initialized = true;
+    qemu_mutex_post_init(mutex);
 }
 
 void qemu_mutex_destroy(QemuMutex *mutex)
@@ -62,13 +62,11 @@ void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line)
     int err;
 
     assert(mutex->initialized);
-    trace_qemu_mutex_lock(mutex, file, line);
-
+    qemu_mutex_pre_lock(mutex, file, line);
     err = pthread_mutex_lock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
-
-    trace_qemu_mutex_locked(mutex, file, line);
+    qemu_mutex_post_lock(mutex, file, line);
 }
 
 int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
@@ -78,7 +76,7 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
     assert(mutex->initialized);
     err = pthread_mutex_trylock(&mutex->lock);
     if (err == 0) {
-        trace_qemu_mutex_locked(mutex, file, line);
+        qemu_mutex_post_lock(mutex, file, line);
         return 0;
     }
     if (err != EBUSY) {
@@ -92,11 +90,10 @@ void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line)
     int err;
 
     assert(mutex->initialized);
+    qemu_mutex_pre_unlock(mutex, file, line);
     err = pthread_mutex_unlock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
-
-    trace_qemu_mutex_unlock(mutex, file, line);
 }
 
 void qemu_rec_mutex_init(QemuRecMutex *mutex)
@@ -160,9 +157,9 @@ void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const char *file, con
     int err;
 
     assert(cond->initialized);
-    trace_qemu_mutex_unlock(mutex, file, line);
+    qemu_mutex_pre_unlock(mutex, file, line);
     err = pthread_cond_wait(&cond->cond, &mutex->lock);
-    trace_qemu_mutex_locked(mutex, file, line);
+    qemu_mutex_post_lock(mutex, file, line);
     if (err)
         error_exit(err, __func__);
 }
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index ab60c0d..b303188 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -19,7 +19,7 @@
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
-#include "trace.h"
+#include "qemu-thread-common.h"
 #include <process.h>
 
 static bool name_threads;
@@ -46,7 +46,7 @@ static void error_exit(int err, const char *msg)
 void qemu_mutex_init(QemuMutex *mutex)
 {
     InitializeSRWLock(&mutex->lock);
-    mutex->initialized = true;
+    qemu_mutex_post_init(mutex);
 }
 
 void qemu_mutex_destroy(QemuMutex *mutex)
@@ -59,10 +59,9 @@ void qemu_mutex_destroy(QemuMutex *mutex)
 void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     assert(mutex->initialized);
-    trace_qemu_mutex_lock(mutex, file, line);
-
+    qemu_mutex_pre_lock(mutex, file, line);
     AcquireSRWLockExclusive(&mutex->lock);
-    trace_qemu_mutex_locked(mutex, file, line);
+    qemu_mutex_post_lock(mutex, file, line);
 }
 
 int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
@@ -72,7 +71,7 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
     assert(mutex->initialized);
     owned = TryAcquireSRWLockExclusive(&mutex->lock);
     if (owned) {
-        trace_qemu_mutex_locked(mutex, file, line);
+        qemu_mutex_post_lock(mutex, file, line);
         return 0;
     }
     return -EBUSY;
@@ -81,7 +80,7 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
 void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     assert(mutex->initialized);
-    trace_qemu_mutex_unlock(mutex, file, line);
+    qemu_mutex_pre_unlock(mutex, file, line);
     ReleaseSRWLockExclusive(&mutex->lock);
 }
 
@@ -145,9 +144,9 @@ void qemu_cond_broadcast(QemuCond *cond)
 void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const char *file, const int line)
 {
     assert(cond->initialized);
-    trace_qemu_mutex_unlock(mutex, file, line);
+    qemu_mutex_pre_unlock(mutex, file, line);
     SleepConditionVariableSRW(&cond->var, &mutex->lock, INFINITE, 0);
-    trace_qemu_mutex_locked(mutex, file, line);
+    qemu_mutex_post_lock(mutex, file, line);
 }
 
 void qemu_sem_init(QemuSemaphore *sem, int init)
-- 
1.8.3.1
