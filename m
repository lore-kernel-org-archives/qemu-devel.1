Received: from eggs.gnu.org ([2001:4830:134:3::10]:47436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCl-0001NF-Nh
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCi-0002Ql-2y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:19 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41996)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCh-0002Q6-LH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:15 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:27:16 +0300
Message-ID: <20180111082716.27295.11796.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 25/30] util/qemu-thread-*: add qemu_lock,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

---
v1
  - fix merge conflicts with existing tracing
  - add trylock/cond_wait traces
---
 include/qemu/thread.h    |   19 +++++++++++++++----
 util/qemu-thread-posix.c |   21 ++++++++++++---------
 util/trace-events        |    7 ++++---
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9910f49..35375f0 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -22,9 +22,16 @@ typedef struct QemuThread QemuThread;
=20
 void qemu_mutex_init(QemuMutex *mutex);
 void qemu_mutex_destroy(QemuMutex *mutex);
-void qemu_mutex_lock(QemuMutex *mutex);
-int qemu_mutex_trylock(QemuMutex *mutex);
-void qemu_mutex_unlock(QemuMutex *mutex);
+int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const in=
t line);
+void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int =
line);
+void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const in=
t line);
+
+#define qemu_mutex_lock(mutex) \
+        qemu_mutex_lock_impl(mutex, __FILE__, __LINE__)
+#define qemu_mutex_trylock(mutex) \
+        qemu_mutex_trylock_impl(mutex, __FILE__, __LINE__)
+#define qemu_mutex_unlock(mutex) \
+        qemu_mutex_unlock_impl(mutex, __FILE__, __LINE__)
=20
 /* Prototypes for other functions are in thread-posix.h/thread-win32.h. =
 */
 void qemu_rec_mutex_init(QemuRecMutex *mutex);
@@ -39,7 +46,11 @@ void qemu_cond_destroy(QemuCond *cond);
  */
 void qemu_cond_signal(QemuCond *cond);
 void qemu_cond_broadcast(QemuCond *cond);
-void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex);
+void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex,
+                         const char *file, const int line);
+
+#define qemu_cond_wait(cond, mutex) \
+        qemu_cond_wait_impl(cond, mutex, __FILE__, __LINE__)
=20
 void qemu_sem_init(QemuSemaphore *sem, int init);
 void qemu_sem_post(QemuSemaphore *sem);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 959a570..b789cf3 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -57,26 +57,28 @@ void qemu_mutex_destroy(QemuMutex *mutex)
         error_exit(err, __func__);
 }
=20
-void qemu_mutex_lock(QemuMutex *mutex)
+void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int =
line)
 {
     int err;
=20
     assert(mutex->initialized);
+    trace_qemu_mutex_lock(mutex, file, line);
+
     err =3D pthread_mutex_lock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
=20
-    trace_qemu_mutex_locked(mutex);
+    trace_qemu_mutex_locked(mutex, file, line);
 }
=20
-int qemu_mutex_trylock(QemuMutex *mutex)
+int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const in=
t line)
 {
     int err;
=20
     assert(mutex->initialized);
     err =3D pthread_mutex_trylock(&mutex->lock);
     if (err =3D=3D 0) {
-        trace_qemu_mutex_locked(mutex);
+        trace_qemu_mutex_locked(mutex, file, line);
         return 0;
     }
     if (err !=3D EBUSY) {
@@ -85,15 +87,16 @@ int qemu_mutex_trylock(QemuMutex *mutex)
     return -EBUSY;
 }
=20
-void qemu_mutex_unlock(QemuMutex *mutex)
+void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const in=
t line)
 {
     int err;
=20
     assert(mutex->initialized);
-    trace_qemu_mutex_unlocked(mutex);
     err =3D pthread_mutex_unlock(&mutex->lock);
     if (err)
         error_exit(err, __func__);
+
+    trace_qemu_mutex_unlock(mutex, file, line);
 }
=20
 void qemu_rec_mutex_init(QemuRecMutex *mutex)
@@ -152,14 +155,14 @@ void qemu_cond_broadcast(QemuCond *cond)
         error_exit(err, __func__);
 }
=20
-void qemu_cond_wait(QemuCond *cond, QemuMutex *mutex)
+void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const char *f=
ile, const int line)
 {
     int err;
=20
     assert(cond->initialized);
-    trace_qemu_mutex_unlocked(mutex);
+    trace_qemu_mutex_unlock(mutex, file, line);
     err =3D pthread_cond_wait(&cond->cond, &mutex->lock);
-    trace_qemu_mutex_locked(mutex);
+    trace_qemu_mutex_locked(mutex, file, line);
     if (err)
         error_exit(err, __func__);
 }
diff --git a/util/trace-events b/util/trace-events
index 025499f..515e625 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -56,6 +56,7 @@ lockcnt_futex_wait(const void *lockcnt, int val) "lockc=
nt %p waiting on %d"
 lockcnt_futex_wait_resume(const void *lockcnt, int new) "lockcnt %p afte=
r wait: %d"
 lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter=
"
=20
-# util/qemu-thread-posix.c
-qemu_mutex_locked(void *lock) "locked mutex %p"
-qemu_mutex_unlocked(void *lock) "unlocked mutex %p"
+# util/qemu-thread.c
+qemu_mutex_lock(void *mutex, const char *file, const int line) "waiting =
on mutex %p (%s:%d)"
+qemu_mutex_locked(void *mutex, const char *file, const int line) "taken =
mutex %p (%s:%d)"
+qemu_mutex_unlock(void *mutex, const char *file, const int line) "releas=
ed mutex %p (%s:%d)"
