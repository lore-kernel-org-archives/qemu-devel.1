Received: from eggs.gnu.org ([2001:4830:134:3::10]:40434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9Cq-0002qu-FI
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93X-0001S7-1E
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93W-0000h8-41
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id s10-v6so12270266wmc.5
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:38:03 +0100
Message-Id: <1541540283-45699-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/17] util/qemu-thread-posix: Fix
 qemu_thread_atexit* for OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Our current implementation of qemu_thread_atexit* is broken on OSX.
This is because it works by cerating a piece of thread-specific
data with pthread_key_create() and using the destructor function
for that data to run the notifier function passed to it by
the caller of qemu_thread_atexit_add(). The expected use case
is that the caller uses a __thread variable as the notifier,
and uses the callback to clean up information that it is
keeping per-thread in __thread variables.

Unfortunately, on OSX this does not work, because on OSX
a __thread variable may be destroyed (freed) before the
pthread_key_create() destructor runs. (POSIX imposes no
ordering constraint here; the OSX implementation happens
to implement __thread variables in terms of pthread_key_create((),
whereas Linux uses different mechanisms that mean the __thread
variables will still be present when the pthread_key_create()
destructor is run.)

Fix this by switching to a scheme similar to the one qemu-thread-win32
uses for qemu_thread_atexit: keep the thread's notifiers on a
__thread variable, and run the notifiers on calls to
qemu_thread_exit() and on return from the start routine passed
to qemu_thread_start(). We do this with the pthread_cleanup_push()
API.

We take advantage of the qemu_thread_atexit_add() API
permission not to run thread notifiers on process exit to
avoid having to special case the main thread.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181105135538.28025-3-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-thread-posix.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index dfa66ff..865e476 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -443,42 +443,34 @@ void qemu_event_wait(QemuEvent *ev)
     }
 }
 
-static pthread_key_t exit_key;
-
-union NotifierThreadData {
-    void *ptr;
-    NotifierList list;
-};
-QEMU_BUILD_BUG_ON(sizeof(union NotifierThreadData) != sizeof(void *));
+static __thread NotifierList thread_exit;
 
+/*
+ * Note that in this implementation you can register a thread-exit
+ * notifier for the main thread, but it will never be called.
+ * This is OK because main thread exit can only happen when the
+ * entire process is exiting, and the API allows notifiers to not
+ * be called on process exit.
+ */
 void qemu_thread_atexit_add(Notifier *notifier)
 {
-    union NotifierThreadData ntd;
-    ntd.ptr = pthread_getspecific(exit_key);
-    notifier_list_add(&ntd.list, notifier);
-    pthread_setspecific(exit_key, ntd.ptr);
+    notifier_list_add(&thread_exit, notifier);
 }
 
 void qemu_thread_atexit_remove(Notifier *notifier)
 {
-    union NotifierThreadData ntd;
-    ntd.ptr = pthread_getspecific(exit_key);
     notifier_remove(notifier);
-    pthread_setspecific(exit_key, ntd.ptr);
-}
-
-static void qemu_thread_atexit_run(void *arg)
-{
-    union NotifierThreadData ntd = { .ptr = arg };
-    notifier_list_notify(&ntd.list, NULL);
 }
 
-static void __attribute__((constructor)) qemu_thread_atexit_init(void)
+static void qemu_thread_atexit_notify(void *arg)
 {
-    pthread_key_create(&exit_key, qemu_thread_atexit_run);
+    /*
+     * Called when non-main thread exits (via qemu_thread_exit()
+     * or by returning from its start routine.)
+     */
+    notifier_list_notify(&thread_exit, NULL);
 }
 
-
 typedef struct {
     void *(*start_routine)(void *);
     void *arg;
@@ -490,6 +482,7 @@ static void *qemu_thread_start(void *args)
     QemuThreadArgs *qemu_thread_args = args;
     void *(*start_routine)(void *) = qemu_thread_args->start_routine;
     void *arg = qemu_thread_args->arg;
+    void *r;
 
 #ifdef CONFIG_PTHREAD_SETNAME_NP
     /* Attempt to set the threads name; note that this is for debug, so
@@ -501,7 +494,10 @@ static void *qemu_thread_start(void *args)
 #endif
     g_free(qemu_thread_args->name);
     g_free(qemu_thread_args);
-    return start_routine(arg);
+    pthread_cleanup_push(qemu_thread_atexit_notify, NULL);
+    r = start_routine(arg);
+    pthread_cleanup_pop(1);
+    return r;
 }
 
 void qemu_thread_create(QemuThread *thread, const char *name,
-- 
1.8.3.1
