Received: from eggs.gnu.org ([2001:4830:134:3::10]:54400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f9NsR-0004Yr-1u
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f9NsP-00077v-K3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f9NsP-00077N-Et
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:25 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Apr 2018 12:42:10 +0800
Message-Id: <20180420044212.28765-2-peterx@redhat.com>
In-Reply-To: <20180420044212.28765-1-peterx@redhat.com>
References: <20180420044212.28765-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] qemu-thread: introduce
 qemu-thread-common.[ch]
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

Put all the shared qemu-thread implementations into these files.  The
header should be internal to qemu-thread but not for qemu-thread users.

Introduce some hooks correspondingly for the shared part.  Note that in
qemu_mutex_unlock_impl() we moved the call before unlock operation which
should make more sense.  And we don't need qemu_mutex_post_unlock() hook.

Currently the hooks only calls the tracepoints.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/qemu-thread-common.h | 23 +++++++++++++++++++++++
 util/qemu-thread-common.c | 30 ++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c  | 17 +++++++----------
 util/qemu-thread-win32.c  | 15 +++++++--------
 util/Makefile.objs        |  4 ++--
 5 files changed, 69 insertions(+), 20 deletions(-)
 create mode 100644 util/qemu-thread-common.h
 create mode 100644 util/qemu-thread-common.c

diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
new file mode 100644
index 0000000000..f3f66613e9
--- /dev/null
+++ b/util/qemu-thread-common.h
@@ -0,0 +1,23 @@
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
+
+void qemu_mutex_pre_lock(QemuMutex *mutex, const char *file, int line);
+void qemu_mutex_post_lock(QemuMutex *mutex, const char *file, int line);
+void qemu_mutex_pre_unlock(QemuMutex *mutex, const char *file, int line);
+
+#endif
diff --git a/util/qemu-thread-common.c b/util/qemu-thread-common.c
new file mode 100644
index 0000000000..fc1f1aa969
--- /dev/null
+++ b/util/qemu-thread-common.c
@@ -0,0 +1,30 @@
+/*
+ * Common qemu-thread implementation shared for all platforms.
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
+#include "qemu/osdep.h"
+#include "qemu-thread-common.h"
+#include "trace.h"
+
+void qemu_mutex_pre_lock(QemuMutex *mutex, const char *file, int line)
+{
+    trace_qemu_mutex_lock(mutex, file, line);
+}
+
+void qemu_mutex_post_lock(QemuMutex *mutex, const char *file, int line)
+{
+    trace_qemu_mutex_locked(mutex, file, line);
+}
+
+void qemu_mutex_pre_unlock(QemuMutex *mutex, const char *file, int line)
+{
+    trace_qemu_mutex_unlock(mutex, file, line);
+}
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
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 728c3541db..04d6713daf 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -9,12 +9,12 @@ util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
 util-obj-$(CONFIG_POSIX) += mmap-alloc.o
 util-obj-$(CONFIG_POSIX) += oslib-posix.o
 util-obj-$(CONFIG_POSIX) += qemu-openpty.o
-util-obj-$(CONFIG_POSIX) += qemu-thread-posix.o
+util-obj-$(CONFIG_POSIX) += qemu-thread-posix.o qemu-thread-common.o
 util-obj-$(CONFIG_POSIX) += memfd.o
 util-obj-$(CONFIG_WIN32) += aio-win32.o
 util-obj-$(CONFIG_WIN32) += event_notifier-win32.o
 util-obj-$(CONFIG_WIN32) += oslib-win32.o
-util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
+util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o qemu-thread-common.o
 util-obj-y += envlist.o path.o module.o
 util-obj-y += host-utils.o
 util-obj-y += bitmap.o bitops.o hbitmap.o
-- 
2.14.3
