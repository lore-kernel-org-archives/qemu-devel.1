Received: from eggs.gnu.org ([2001:4830:134:3::10]:53432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIU-00045z-Ad
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIR-0006JO-Df
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZIR-0006Id-54
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:03 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:24 +0100
Message-Id: <20170120133139.31080-21-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/35] qemu-thread: fix qemu_thread_set_name()
 race in qemu_thread_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caoxinhua <caoxinhua@huawei.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

From: Caoxinhua <caoxinhua@huawei.com>

QEMU will crash with the follow backtrace if the new created thread exited before
we call qemu_thread_set_name() for it.

  (gdb) bt
  #0 0x00007f9a68b095d7 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
  #1 0x00007f9a68b0acc8 in __GI_abort () at abort.c:90
  #2 0x00007f9a69cda389 in PAT_abort () from /usr/lib64/libuvpuserhotfix.so
  #3 0x00007f9a69cdda0d in patchIllInsHandler () from /usr/lib64/libuvpuserhotfix.so
  #4 <signal handler called>
  #5 pthread_setname_np (th=140298470549248, name=name@entry=0x8cc74a "io-task-worker") at ../nptl/sysdeps/unix/sysv/linux/pthread_setname.c:49
  #6 0x00000000007f5f20 in qemu_thread_set_name (thread=thread@entry=0x7ffd2ac09680, name=name@entry=0x8cc74a "io-task-worker") at util/qemu_thread_posix.c:459
  #7 0x00000000007f679e in qemu_thread_create (thread=thread@entry=0x7ffd2ac09680, name=name@entry=0x8cc74a "io-task-worker",start_routine=start_routine@entry=0x7c1300 <qio_task_thread_worker>, arg=arg@entry=0x7f99b8001720, mode=mode@entry=1) at util/qemu_thread_posix.c:498
  #8 0x00000000007c15b6 in qio_task_run_in_thread (task=task@entry=0x7f99b80033d0, worker=worker@entry=0x7bd920 <qio_channel_socket_connect_worker>, opaque=0x7f99b8003370, destroy=0x7c6220 <qapi_free_SocketAddress>) at io/task.c:133
  #9 0x00000000007bda04 in qio_channel_socket_connect_async (ioc=0x7f99b80014c0, addr=0x37235d0, callback=callback@entry=0x54ad00 <qemu_chr_socket_connected>, opaque=opaque@entry=0x38118b0, destroy=destroy@entry=0x0) at io/channel_socket.c:191
  #10 0x00000000005487f6 in socket_reconnect_timeout (opaque=0x38118b0) at qemu_char.c:4402
  #11 0x00007f9a6a1533b3 in g_timeout_dispatch () from /usr/lib64/libglib-2.0.so.0
  #12 0x00007f9a6a15299a in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
  #13 0x0000000000747386 in glib_pollfds_poll () at main_loop.c:227
  #14 0x0000000000747424 in os_host_main_loop_wait (timeout=404000000) at main_loop.c:272
  #15 0x0000000000747575 in main_loop_wait (nonblocking=nonblocking@entry=0) at main_loop.c:520
  #16 0x0000000000557d31 in main_loop () at vl.c:2170
  #17 0x000000000041c8b7 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:5083

Let's detach the new thread after calling qemu_thread_set_name().

Signed-off-by: Caoxinhua <caoxinhua@huawei.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-Id: <1483493521-9604-1-git-send-email-zhang.zhanghailiang@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-thread-posix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index d20cdde..d31793d 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -481,12 +481,6 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     if (err) {
         error_exit(err, __func__);
     }
-    if (mode == QEMU_THREAD_DETACHED) {
-        err = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
-        if (err) {
-            error_exit(err, __func__);
-        }
-    }
 
     /* Leave signal handling to the iothread.  */
     sigfillset(&set);
@@ -499,6 +493,12 @@ void qemu_thread_create(QemuThread *thread, const char *name,
         qemu_thread_set_name(thread, name);
     }
 
+    if (mode == QEMU_THREAD_DETACHED) {
+        err = pthread_detach(thread->thread);
+        if (err) {
+            error_exit(err, __func__);
+        }
+    }
     pthread_sigmask(SIG_SETMASK, &oldset, NULL);
 
     pthread_attr_destroy(&attr);
-- 
2.9.3
