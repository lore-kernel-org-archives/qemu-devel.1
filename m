Received: from eggs.gnu.org ([2001:4830:134:3::10]:52611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acR-0001ml-Uw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acQ-0006mC-VG
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:51 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6acQ-0006ku-PC
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:50 -0400
Received: by mail-wm0-x231.google.com with SMTP id 142so2195740wma.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:37:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 May 2017 11:38:21 +0100
Message-Id: <20170505103822.20641-9-alex.bennee@linaro.org>
In-Reply-To: <20170505103822.20641-1-alex.bennee@linaro.org>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 8/9] util/qemu-thread-*: add qemu_lock,
 locked and unlock trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/thread.h    |  7 +++++--
 util/qemu-thread-posix.c | 11 +++++++++--
 util/trace-events        |  5 +++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9910f49b3a..ddea4990c0 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -22,9 +22,12 @@ typedef struct QemuThread QemuThread;
 
 void qemu_mutex_init(QemuMutex *mutex);
 void qemu_mutex_destroy(QemuMutex *mutex);
-void qemu_mutex_lock(QemuMutex *mutex);
 int qemu_mutex_trylock(QemuMutex *mutex);
-void qemu_mutex_unlock(QemuMutex *mutex);
+void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line);
+void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line);
+
+#define qemu_mutex_lock(mutex) qemu_mutex_lock_impl(mutex, __FILE__, __LINE__)
+#define qemu_mutex_unlock(mutex) qemu_mutex_unlock_impl(mutex, __FILE__, __LINE__)
 
 /* Prototypes for other functions are in thread-posix.h/thread-win32.h.  */
 void qemu_rec_mutex_init(QemuRecMutex *mutex);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 73e3a0edf5..9da1c9e756 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,6 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
+#include "trace.h"
 
 static bool name_threads;
 
@@ -53,13 +54,17 @@ void qemu_mutex_destroy(QemuMutex *mutex)
         error_exit(err, __func__);
 }
 
-void qemu_mutex_lock(QemuMutex *mutex)
+void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     int err;
 
+    trace_qemu_mutex_lock(mutex, file, line);
+
     err = pthread_mutex_lock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
+
+    trace_qemu_mutex_locked(mutex, file, line);
 }
 
 int qemu_mutex_trylock(QemuMutex *mutex)
@@ -67,13 +72,15 @@ int qemu_mutex_trylock(QemuMutex *mutex)
     return pthread_mutex_trylock(&mutex->lock);
 }
 
-void qemu_mutex_unlock(QemuMutex *mutex)
+void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     int err;
 
     err = pthread_mutex_unlock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
+
+    trace_qemu_mutex_unlock(mutex, file, line);
 }
 
 void qemu_rec_mutex_init(QemuRecMutex *mutex)
diff --git a/util/trace-events b/util/trace-events
index b44ef4f895..972d7e1786 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -34,6 +34,11 @@ qemu_co_mutex_lock_return(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_unlock_entry(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_unlock_return(void *mutex, void *self) "mutex %p self %p"
 
+# util/qemu-thread.c
+qemu_mutex_lock(void *mutex, const char *file, const int line) "waiting on mutex %p (%s:%d)"
+qemu_mutex_locked(void *mutex, const char *file, const int line) "taken mutex %p (%s:%d)"
+qemu_mutex_unlock(void *mutex, const char *file, const int line) "released mutex %p (%s:%d)"
+
 # util/oslib-win32.c
 # util/oslib-posix.c
 qemu_memalign(size_t alignment, size_t size, void *ptr) "alignment %zu size %zu ptr %p"
-- 
2.11.0
