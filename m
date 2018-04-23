Received: from eggs.gnu.org ([2001:4830:134:3::10]:42878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fAUCe-0004Yy-2c
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fAUCc-0001ss-V7
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:39:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fAUCc-0001sY-Pk
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:39:50 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 23 Apr 2018 13:39:25 +0800
Message-Id: <20180423053927.13715-3-peterx@redhat.com>
In-Reply-To: <20180423053927.13715-1-peterx@redhat.com>
References: <20180423053927.13715-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/4] qemu-thread: introduce
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G . Cota" <cota@braap.org>, peterx@redhat.com

Introduce some hooks for the shared part of qemu thread between POSIX
and Windows implementations.  Note that in qemu_mutex_unlock_impl() we
moved the call before unlock operation which should make more sense.
And we don't need qemu_mutex_post_unlock() hook.

Currently the hooks only calls the tracepoints.

Put all these shared hooks into the header files.  It should be internal
to qemu-thread but not for qemu-thread users, hence put into util/
directory.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/qemu-thread-common.h | 38 ++++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c  | 17 +++++++----------
 util/qemu-thread-win32.c  | 15 +++++++--------
 3 files changed, 52 insertions(+), 18 deletions(-)
 create mode 100644 util/qemu-thread-common.h

diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
new file mode 100644
index 0000000000..324915fb80
--- /dev/null
+++ b/util/qemu-thread-common.h
@@ -0,0 +1,38 @@
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
+#ifndef __QEMU_THREAD_COMMON_H__
+#define __QEMU_THREAD_COMMON_H__
+
+#include "qemu/typedefs.h"
+#include "qemu/thread.h"
+#include "trace.h"
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
index b789cf32e9..b0e7008db3 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,7 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
-#include "trace.h"
+#include "qemu-thread-common.h"
 
 static bool name_threads;
 
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
index ab60c0d557..f9fb0581f2 100644
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
2.14.3
