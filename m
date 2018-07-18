Received: from eggs.gnu.org ([2001:4830:134:3::10]:52958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003He-Db
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000IK-NB
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000F9-AA
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:46 +0300
Message-Id: <20180718154200.26777-4-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 03/17] threads: add infrastructure to
 process sigsegv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

Allows to define sigsegv handler temporary for all threads.
This is useful to implement copy-on-write logic while
linux usefaultfd doesn't support write-protected faults.
In the future, switch to using WP userfaultfd when it's
available.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/qemu/thread.h    |  5 ++++
 util/qemu-thread-posix.c | 52 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9910f49b3a..d6fed833fa 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -210,4 +210,9 @@ void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt);
  */
 unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt);
 
+
+typedef void (*sigsegv_handler)(int signum, siginfo_t *siginfo, void *sigctx);
+void sigsegv_user_handler_set(sigsegv_handler handler);
+void sigsegv_user_handler_reset(void);
+
 #endif
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 7306475899..5424b7106d 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -489,6 +489,47 @@ static void qemu_thread_set_name(QemuThread *thread, const char *name)
 #endif
 }
 
+static sigsegv_handler sigsegv_user_handler;
+
+void sigsegv_user_handler_set(sigsegv_handler handler)
+{
+    assert(handler);
+    atomic_set(&sigsegv_user_handler, handler);
+}
+
+static sigsegv_handler sigsegv_user_handler_get(void)
+{
+    return atomic_read(&sigsegv_user_handler);
+}
+
+void sigsegv_user_handler_reset(void)
+{
+    atomic_set(&sigsegv_user_handler, NULL);
+}
+
+static void sigsegv_default_handler(int signum, siginfo_t *siginfo, void *sigctx)
+{
+    sigsegv_handler handler = sigsegv_user_handler_get();
+
+    if (!handler) {
+        /*
+         * remove the sigsegv handler if it's not set by user
+         * this will lead to re-raising the error without a handler
+         * and exiting from the program with "Segmentation fault"
+         */
+        int err;
+        struct sigaction act;
+        memset(&act, 0, sizeof(act));
+        act.sa_flags = SA_RESETHAND;
+        err = sigaction(SIGSEGV, &act, NULL);
+        if (err) {
+            error_exit(err, __func__);
+        }
+    } else {
+        handler(signum, siginfo, sigctx);
+    }
+}
+
 void qemu_thread_create(QemuThread *thread, const char *name,
                        void *(*start_routine)(void*),
                        void *arg, int mode)
@@ -496,14 +537,25 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     sigset_t set, oldset;
     int err;
     pthread_attr_t attr;
+    struct sigaction act;
 
     err = pthread_attr_init(&attr);
     if (err) {
         error_exit(err, __func__);
     }
 
+    memset(&act, 0, sizeof(act));
+    act.sa_flags = SA_SIGINFO;
+    act.sa_sigaction = sigsegv_default_handler;
+    err = sigaction(SIGSEGV, &act, NULL);
+    if (err) {
+        error_exit(err, __func__);
+    }
+
     /* Leave signal handling to the iothread.  */
     sigfillset(&set);
+    /* ...all but SIGSEGV */
+    sigdelset(&set, SIGSEGV);
     pthread_sigmask(SIG_SETMASK, &set, &oldset);
     err = pthread_create(&thread->thread, &attr, start_routine, arg);
     if (err)
-- 
2.17.0
