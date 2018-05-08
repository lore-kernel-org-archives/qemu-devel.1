Received: from eggs.gnu.org ([2001:4830:134:3::10]:41246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt0-0002yW-6Y
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsz-0001NV-2x
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:06 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAsy-0001NB-Ss
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:05 -0400
Received: by mail-wm0-x244.google.com with SMTP id a137-v6so20817234wme.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:28 +0200
Message-Id: <1525817687-34620-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/30] qemu-thread: always keep the posix
 wrapper layer
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

We will conditionally have a wrapper layer depending on whether the host
has the PTHREAD_SETNAME capability.  It complicates stuff.  Let's keep
the wrapper there; we opt out the pthread_setname_np() call only.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180412053444.17801-1-peterx@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-thread-posix.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b789cf3..a1c34ba 100644
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
1.8.3.1
