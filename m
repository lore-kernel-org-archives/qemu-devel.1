Received: from eggs.gnu.org ([2001:4830:134:3::10]:43348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5siC-0004ES-Fn
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5siB-0000k5-EM
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5siB-0000jl-9Y
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:23 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Apr 2018 20:49:12 +0800
Message-Id: <20180410124913.10832-2-peterx@redhat.com>
In-Reply-To: <20180410124913.10832-1-peterx@redhat.com>
References: <20180410124913.10832-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-thread: always keep the posix wrapper
 layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

We will conditionally have a wrapper layer depending on whether the host
has the PTHREAD_SETNAME capability.  It complicates stuff.  Let's just
keep the wrapper there, meanwhile we opt out the pthread_setname_np()
call only.  The layer can be helpful in future patches to pass data from
the parent thread to the child thread.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/qemu-thread-posix.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b789cf32e9..3ae96210d6 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -482,7 +482,6 @@ static void __attribute__((constructor)) qemu_thread_atexit_init(void)
 }
 
 
-#ifdef CONFIG_PTHREAD_SETNAME_NP
 typedef struct {
     void *(*start_routine)(void *);
     void *arg;
@@ -498,13 +497,15 @@ static void *qemu_thread_start(void *args)
     /* Attempt to set the threads name; note that this is for debug, so
      * we're not going to fail if we can't set it.
      */
-    pthread_setname_np(pthread_self(), qemu_thread_args->name);
+#ifdef CONFIG_PTHREAD_SETNAME_NP
+    if (qemu_thread_args->name) {
+        pthread_setname_np(pthread_self(), qemu_thread_args->name);
+    }
+#endif
     g_free(qemu_thread_args->name);
     g_free(qemu_thread_args);
     return start_routine(arg);
 }
-#endif
-
 
 void qemu_thread_create(QemuThread *thread, const char *name,
                        void *(*start_routine)(void*),
@@ -513,6 +514,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     sigset_t set, oldset;
     int err;
     pthread_attr_t attr;
+    QemuThreadArgs *qemu_thread_args;
 
     err = pthread_attr_init(&attr);
     if (err) {
@@ -527,22 +529,13 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     sigfillset(&set);
     pthread_sigmask(SIG_SETMASK, &set, &oldset);
 
-#ifdef CONFIG_PTHREAD_SETNAME_NP
-    if (name_threads) {
-        QemuThreadArgs *qemu_thread_args;
-        qemu_thread_args = g_new0(QemuThreadArgs, 1);
-        qemu_thread_args->name = g_strdup(name);
-        qemu_thread_args->start_routine = start_routine;
-        qemu_thread_args->arg = arg;
-
-        err = pthread_create(&thread->thread, &attr,
-                             qemu_thread_start, qemu_thread_args);
-    } else
-#endif
-    {
-        err = pthread_create(&thread->thread, &attr,
-                             start_routine, arg);
-    }
+    qemu_thread_args = g_new0(QemuThreadArgs, 1);
+    qemu_thread_args->name = g_strdup(name);
+    qemu_thread_args->start_routine = start_routine;
+    qemu_thread_args->arg = arg;
+
+    err = pthread_create(&thread->thread, &attr,
+                         qemu_thread_start, qemu_thread_args);
 
     if (err)
         error_exit(err, __func__);
-- 
2.14.3
