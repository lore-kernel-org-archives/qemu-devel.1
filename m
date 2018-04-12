Received: from eggs.gnu.org ([2001:4830:134:3::10]:34056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6Ut0-00018s-Ty
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6Usx-0007vr-Q8
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:35:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f6Usx-0007ut-LG
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:35:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9108A4072CC4
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 05:34:58 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 12 Apr 2018 13:34:44 +0800
Message-Id: <20180412053444.17801-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qemu-thread: always keep the posix wrapper
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
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

We will conditionally have a wrapper layer depending on whether the host
has the PTHREAD_SETNAME capability.  It complicates stuff.  Let's keep
the wrapper there; we opt out the pthread_setname_np() call only.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- set thread name only conditionally [Eric]
---
 util/qemu-thread-posix.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b789cf32e9..a1c34ba6f2 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -482,7 +482,6 @@ static void __attribute__((constructor)) qemu_thread_atexit_init(void)
 }
 
 
-#ifdef CONFIG_PTHREAD_SETNAME_NP
 typedef struct {
     void *(*start_routine)(void *);
     void *arg;
@@ -495,16 +494,18 @@ static void *qemu_thread_start(void *args)
     void *(*start_routine)(void *) = qemu_thread_args->start_routine;
     void *arg = qemu_thread_args->arg;
 
+#ifdef CONFIG_PTHREAD_SETNAME_NP
     /* Attempt to set the threads name; note that this is for debug, so
      * we're not going to fail if we can't set it.
      */
-    pthread_setname_np(pthread_self(), qemu_thread_args->name);
+    if (name_threads && qemu_thread_args->name) {
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
