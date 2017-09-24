Received: from eggs.gnu.org ([2001:4830:134:3::10]:51805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEyW-00005r-Up
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEyT-0006Ue-QX
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:02:08 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:36 +0300
Message-Id: <f958231f3371e17ca98440cf42d405a5365f67d6.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 18/31] util/qemu-thread-posix.c: Replace OS
 ifdefs with CONFIG_HAVE_SEM_TIMEDWAIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

In qemu-thread-posix.c we have two implementations of the
various qemu_sem_* functions, one of which uses native POSIX
sem_* and the other of which emulates them with pthread conditions.
This is necessary because not all our host OSes support
sem_timedwait().

Instead of a hard-coded list of OSes which don't implement
sem_timedwait(), which gets out of date, make configure
test for the presence of the function and set a new
CONFIG_HAVE_SEM_TIMEDWAIT appropriately.

In particular, newer NetBSDs have sem_timedwait(), so this
commit will switch them over to using it. OSX still does
not have an implementation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure                   | 15 +++++++++++++++
 include/qemu/thread-posix.h |  2 +-
 util/qemu-thread-posix.c    | 10 +++++-----
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 12d4e4ebfa..1f7b4f03ce 100755
--- a/configure
+++ b/configure
@@ -4425,6 +4425,18 @@ if compile_prog "" "" ; then
 fi
 
 ##########################################
+# check if we have sem_timedwait
+
+sem_timedwait=no
+cat > $TMPC << EOF
+#include <semaphore.h>
+int main(void) { return sem_timedwait(0, 0); }
+EOF
+if compile_prog "" "" ; then
+    sem_timedwait=yes
+fi
+
+##########################################
 # check if trace backend exists
 
 $python "$source_path/scripts/tracetool.py" "--backends=$trace_backends" --check-backends  > /dev/null 2> /dev/null
@@ -5678,6 +5690,9 @@ fi
 if test "$inotify1" = "yes" ; then
   echo "CONFIG_INOTIFY1=y" >> $config_host_mak
 fi
+if test "$sem_timedwait" = "yes" ; then
+  echo "CONFIG_SEM_TIMEDWAIT=y" >> $config_host_mak
+fi
 if test "$byteswap_h" = "yes" ; then
   echo "CONFIG_BYTESWAP_H=y" >> $config_host_mak
 fi
diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index e5e3a0ff97..f4296d31c4 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -21,7 +21,7 @@ struct QemuCond {
 };
 
 struct QemuSemaphore {
-#if defined(__APPLE__) || defined(__NetBSD__)
+#ifndef CONFIG_SEM_TIMEDWAIT
     pthread_mutex_t lock;
     pthread_cond_t cond;
     unsigned int count;
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 4e95d272dc..7306475899 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -168,7 +168,7 @@ void qemu_sem_init(QemuSemaphore *sem, int init)
 {
     int rc;
 
-#if defined(__APPLE__) || defined(__NetBSD__)
+#ifndef CONFIG_SEM_TIMEDWAIT
     rc = pthread_mutex_init(&sem->lock, NULL);
     if (rc != 0) {
         error_exit(rc, __func__);
@@ -196,7 +196,7 @@ void qemu_sem_destroy(QemuSemaphore *sem)
 
     assert(sem->initialized);
     sem->initialized = false;
-#if defined(__APPLE__) || defined(__NetBSD__)
+#ifndef CONFIG_SEM_TIMEDWAIT
     rc = pthread_cond_destroy(&sem->cond);
     if (rc < 0) {
         error_exit(rc, __func__);
@@ -218,7 +218,7 @@ void qemu_sem_post(QemuSemaphore *sem)
     int rc;
 
     assert(sem->initialized);
-#if defined(__APPLE__) || defined(__NetBSD__)
+#ifndef CONFIG_SEM_TIMEDWAIT
     pthread_mutex_lock(&sem->lock);
     if (sem->count == UINT_MAX) {
         rc = EINVAL;
@@ -256,7 +256,7 @@ int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
     struct timespec ts;
 
     assert(sem->initialized);
-#if defined(__APPLE__) || defined(__NetBSD__)
+#ifndef CONFIG_SEM_TIMEDWAIT
     rc = 0;
     compute_abs_deadline(&ts, ms);
     pthread_mutex_lock(&sem->lock);
@@ -304,7 +304,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
     int rc;
 
     assert(sem->initialized);
-#if defined(__APPLE__) || defined(__NetBSD__)
+#ifndef CONFIG_SEM_TIMEDWAIT
     pthread_mutex_lock(&sem->lock);
     while (sem->count == 0) {
         rc = pthread_cond_wait(&sem->cond, &sem->lock);
-- 
2.11.0
