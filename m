Received: from eggs.gnu.org ([2001:4830:134:3::10]:35375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRwKI-0007wa-10
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRwKE-0006AW-Rh
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:37 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:44639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRwKE-00068u-Hp
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:34 -0500
Received: by mail-wm0-x242.google.com with SMTP id t8so14328761wmc.3
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 00:35:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Dec 2017 09:35:27 +0100
Message-Id: <20171221083529.6982-2-pbonzini@redhat.com>
In-Reply-To: <20171221083529.6982-1-pbonzini@redhat.com>
References: <20171221083529.6982-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/41] qemu-thread: fix races on threads that
 exit very quickly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linzhecheng <linzhecheng@huawei.com>

From: linzhecheng <linzhecheng@huawei.com>

If we create a thread with QEMU_THREAD_DETACHED mode, QEMU may get a segfault with low probability.

The backtrace is:
   #0  0x00007f46c60291d7 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
   #1  0x00007f46c602a8c8 in __GI_abort () at abort.c:90
   #2  0x00000000008543c9 in PAT_abort ()
   #3  0x000000000085140d in patchIllInsHandler ()
   #4  <signal handler called>
   #5  pthread_detach (th=139933037614848) at pthread_detach.c:50
   #6  0x0000000000829759 in qemu_thread_create (thread=thread@entry=0x7ffdaa8205e0, name=name@entry=0x94d94a "io-task-worker", start_routine=start_routine@entry=0x7eb9a0 <qio_task_thread_worker>,
       arg=arg@entry=0x3f5cf70, mode=mode@entry=1) at util/qemu_thread_posix.c:512
   #7  0x00000000007ebc96 in qio_task_run_in_thread (task=0x31db2c0, worker=worker@entry=0x7e7e40 <qio_channel_socket_connect_worker>, opaque=0xcd23380, destroy=0x7f1180 <qapi_free_SocketAddress>)
       at io/task.c:141
   #8  0x00000000007e7f33 in qio_channel_socket_connect_async (ioc=ioc@entry=0x626c0b0, addr=<optimized out>, callback=callback@entry=0x55e080 <qemu_chr_socket_connected>, opaque=opaque@entry=0x42862c0,
       destroy=destroy@entry=0x0) at io/channel_socket.c:194
   #9  0x000000000055bdd1 in socket_reconnect_timeout (opaque=0x42862c0) at qemu_char.c:4744
   #10 0x00007f46c72483b3 in g_timeout_dispatch () from /usr/lib64/libglib-2.0.so.0
   #11 0x00007f46c724799a in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
   #12 0x000000000076c646 in glib_pollfds_poll () at main_loop.c:228
   #13 0x000000000076c6eb in os_host_main_loop_wait (timeout=348000000) at main_loop.c:273
   #14 0x000000000076c815 in main_loop_wait (nonblocking=nonblocking@entry=0) at main_loop.c:521
   #15 0x000000000056a511 in main_loop () at vl.c:2076
   #16 0x0000000000420705 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4940

The cause of this problem is a glibc bug; for more information, see
https://sourceware.org/bugzilla/show_bug.cgi?id=19951.
The solution for this bug is to use pthread_attr_setdetachstate.

There is a similar issue with pthread_setname_np, which is moved
from creating thread to created thread.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Message-Id: <20171128044656.10592-1-linzhecheng@huawei.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
[Simplify the code by removing qemu_thread_set_name, and free the arguments
 before invoking the start routine. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-thread-posix.c | 59 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 7306475899..959a57079f 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -479,15 +479,29 @@ static void __attribute__((constructor)) qemu_thread_atexit_init(void)
 }
 
 
-/* Attempt to set the threads name; note that this is for debug, so
- * we're not going to fail if we can't set it.
- */
-static void qemu_thread_set_name(QemuThread *thread, const char *name)
-{
 #ifdef CONFIG_PTHREAD_SETNAME_NP
-    pthread_setname_np(thread->thread, name);
-#endif
+typedef struct {
+    void *(*start_routine)(void *);
+    void *arg;
+    char *name;
+} QemuThreadArgs;
+
+static void *qemu_thread_start(void *args)
+{
+    QemuThreadArgs *qemu_thread_args = args;
+    void *(*start_routine)(void *) = qemu_thread_args->start_routine;
+    void *arg = qemu_thread_args->arg;
+
+    /* Attempt to set the threads name; note that this is for debug, so
+     * we're not going to fail if we can't set it.
+     */
+    pthread_setname_np(pthread_self(), qemu_thread_args->name);
+    g_free(qemu_thread_args->name);
+    g_free(qemu_thread_args);
+    return start_routine(arg);
 }
+#endif
+
 
 void qemu_thread_create(QemuThread *thread, const char *name,
                        void *(*start_routine)(void*),
@@ -502,23 +516,34 @@ void qemu_thread_create(QemuThread *thread, const char *name,
         error_exit(err, __func__);
     }
 
+    if (mode == QEMU_THREAD_DETACHED) {
+        pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+    }
+
     /* Leave signal handling to the iothread.  */
     sigfillset(&set);
     pthread_sigmask(SIG_SETMASK, &set, &oldset);
-    err = pthread_create(&thread->thread, &attr, start_routine, arg);
-    if (err)
-        error_exit(err, __func__);
 
+#ifdef CONFIG_PTHREAD_SETNAME_NP
     if (name_threads) {
-        qemu_thread_set_name(thread, name);
+        QemuThreadArgs *qemu_thread_args;
+        qemu_thread_args = g_new0(QemuThreadArgs, 1);
+        qemu_thread_args->name = g_strdup(name);
+        qemu_thread_args->start_routine = start_routine;
+        qemu_thread_args->arg = arg;
+
+        err = pthread_create(&thread->thread, &attr,
+                             qemu_thread_start, qemu_thread_args);
+    } else
+#endif
+    {
+        err = pthread_create(&thread->thread, &attr,
+                             start_routine, arg);
     }
 
-    if (mode == QEMU_THREAD_DETACHED) {
-        err = pthread_detach(thread->thread);
-        if (err) {
-            error_exit(err, __func__);
-        }
-    }
+    if (err)
+        error_exit(err, __func__);
+
     pthread_sigmask(SIG_SETMASK, &oldset, NULL);
 
     pthread_attr_destroy(&attr);
-- 
2.14.3
