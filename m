Received: from eggs.gnu.org ([2001:4830:134:3::10]:50311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DL-0001UG-1E
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DK-0006TG-0J
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:43 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:47949)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fx9DJ-0006Rj-Lt
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:41 -0400
From: Fei Li <fli@suse.com>
Date: Tue,  4 Sep 2018 19:08:21 +0800
Message-Id: <20180904110822.12863-5-fli@suse.com>
In-Reply-To: <20180904110822.12863-1-fli@suse.com>
References: <20180904110822.12863-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH 4/5] qemu_thread_create: propagate the error to
 callers to check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fli@suse.com

Add a new Error paramater for qemu_thread_create() to indicate if it
succeeds rather than failing with an error. And propagate the error
to let the callers check it.

Besides, directly return if thread->data is NULL to avoid the
segmentation fault in qemu_thread_join in qemu-thread-win32.c.

Signed-off-by: Fei Li <fli@suse.com>
---
 include/qemu/thread.h    |  2 +-
 util/qemu-thread-posix.c | 15 +++++++++++----
 util/qemu-thread-win32.c | 12 +++++++++---
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index dacebcfff0..71d8be5851 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -137,7 +137,7 @@ void qemu_event_destroy(QemuEvent *ev);
 
 void qemu_thread_create(QemuThread *thread, const char *name,
                         void *(*start_routine)(void *),
-                        void *arg, int mode);
+                        void *arg, int mode, Error **errp);
 void *qemu_thread_join(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index dfa66ff2fb..a31c00abfd 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -15,6 +15,7 @@
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qapi/error.h"
 
 static bool name_threads;
 
@@ -506,16 +507,17 @@ static void *qemu_thread_start(void *args)
 
 void qemu_thread_create(QemuThread *thread, const char *name,
                        void *(*start_routine)(void*),
-                       void *arg, int mode)
+                       void *arg, int mode, Error **errp)
 {
     sigset_t set, oldset;
     int err;
     pthread_attr_t attr;
     QemuThreadArgs *qemu_thread_args;
+    Error *local_err = NULL;
 
     err = pthread_attr_init(&attr);
     if (err) {
-        error_exit(err, __func__);
+        goto fail;
     }
 
     if (mode == QEMU_THREAD_DETACHED) {
@@ -534,12 +536,17 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     err = pthread_create(&thread->thread, &attr,
                          qemu_thread_start, qemu_thread_args);
 
-    if (err)
-        error_exit(err, __func__);
+    if (err) {
+        goto fail;
+    }
 
     pthread_sigmask(SIG_SETMASK, &oldset, NULL);
 
     pthread_attr_destroy(&attr);
+    return;
+fail:
+    error_setg(&local_err, "%s", strerror(err));
+    error_propagate(errp, local_err);
 }
 
 void qemu_thread_get_self(QemuThread *thread)
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 4a363ca675..725200abc9 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -20,6 +20,7 @@
 #include "qemu/thread.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qapi/error.h"
 #include <process.h>
 
 static bool name_threads;
@@ -366,7 +367,7 @@ void *qemu_thread_join(QemuThread *thread)
     HANDLE handle;
 
     data = thread->data;
-    if (data->mode == QEMU_THREAD_DETACHED) {
+    if (data == NULL || data->mode == QEMU_THREAD_DETACHED) {
         return NULL;
     }
 
@@ -390,10 +391,11 @@ void *qemu_thread_join(QemuThread *thread)
 
 void qemu_thread_create(QemuThread *thread, const char *name,
                        void *(*start_routine)(void *),
-                       void *arg, int mode)
+                       void *arg, int mode, Error **errp)
 {
     HANDLE hThread;
     struct QemuThreadData *data;
+    Error *local_err = NULL;
 
     data = g_malloc(sizeof *data);
     data->start_routine = start_routine;
@@ -409,7 +411,11 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     hThread = (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
                                       data, 0, &thread->tid);
     if (!hThread) {
-        error_exit(GetLastError(), __func__);
+        error_setg_win32(&local_err, GetLastError(),
+                         "failed to creat win32_start_routine");
+        g_free(data);
+        error_propagate(errp, local_err);
+        return;
     }
     CloseHandle(hThread);
     thread->data = data;
-- 
2.13.7
