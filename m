Received: from eggs.gnu.org ([2001:4830:134:3::10]:58172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJaN-0005NA-PU
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJaI-0007aF-Cw
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJaI-0007ZS-3j
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:43 +0000
Message-Id: <20171219151144.11120-23-stefanha@redhat.com>
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 22/23] iothread: fix iothread_stop() race
 condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

There is a small chance that iothread_stop() hangs as follows:

  Thread 3 (Thread 0x7f63eba5f700 (LWP 16105)):
  #0  0x00007f64012c09b6 in ppoll () at /lib64/libc.so.6
  #1  0x000055959992eac9 in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/bits/poll2.h:77
  #2  0x000055959992eac9 in qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=<optimized out>) at util/qemu-timer.c:322
  #3  0x0000559599930711 in aio_poll (ctx=0x55959bdb83c0, blocking=blocking@entry=true) at util/aio-posix.c:629
  #4  0x00005595996806fe in iothread_run (opaque=0x55959bd78400) at iothread.c:59
  #5  0x00007f640159f609 in start_thread () at /lib64/libpthread.so.0
  #6  0x00007f64012cce6f in clone () at /lib64/libc.so.6

  Thread 1 (Thread 0x7f640b45b280 (LWP 16103)):
  #0  0x00007f64015a0b6d in pthread_join () at /lib64/libpthread.so.0
  #1  0x00005595999332ef in qemu_thread_join (thread=<optimized out>) at util/qemu-thread-posix.c:547
  #2  0x00005595996808ae in iothread_stop (iothread=<optimized out>) at iothread.c:91
  #3  0x000055959968094d in iothread_stop_iter (object=<optimized out>, opaque=<optimized out>) at iothread.c:102
  #4  0x0000559599857d97 in do_object_child_foreach (obj=obj@entry=0x55959bdb8100, fn=fn@entry=0x559599680930 <iothread_stop_iter>, opaque=opaque@entry=0x0, recurse=recurse@entry=false) at qom/object.c:852
  #5  0x0000559599859477 in object_child_foreach (obj=obj@entry=0x55959bdb8100, fn=fn@entry=0x559599680930 <iothread_stop_iter>, opaque=opaque@entry=0x0) at qom/object.c:867
  #6  0x0000559599680a6e in iothread_stop_all () at iothread.c:341
  #7  0x000055959955b1d5 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4913

The relevant code from iothread_run() is:

  while (!atomic_read(&iothread->stopping)) {
      aio_poll(iothread->ctx, true);

and iothread_stop():

  iothread->stopping = true;
  aio_notify(iothread->ctx);
  ...
  qemu_thread_join(&iothread->thread);

The following scenario can occur:

1. IOThread:
  while (!atomic_read(&iothread->stopping)) -> stopping=false

2. Main loop:
  iothread->stopping = true;
  aio_notify(iothread->ctx);

3. IOThread:
  aio_poll(iothread->ctx, true); -> hang

The bug is explained by the AioContext->notify_me doc comments:

  "If this field is 0, everything (file descriptors, bottom halves,
  timers) will be re-evaluated before the next blocking poll(), thus the
  event_notifier_set call can be skipped."

The problem is that "everything" does not include checking
iothread->stopping.  This means iothread_run() will block in aio_poll()
if aio_notify() was called just before aio_poll().

This patch fixes the hang by replacing aio_notify() with
aio_bh_schedule_oneshot().  This makes aio_poll() or g_main_loop_run()
to return.

Implementing this properly required a new bool running flag.  The new
flag prevents races that are tricky if we try to use iothread->stopping.
Now iothread->stopping is purely for iothread_stop() and
iothread->running is purely for the iothread_run() thread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171207201320.19284-6-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h |  3 ++-
 iothread.c                | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 55de1715c7..799614ffd2 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -29,7 +29,8 @@ typedef struct {
     GOnce once;
     QemuMutex init_done_lock;
     QemuCond init_done_cond;    /* is thread initialization done? */
-    bool stopping;
+    bool stopping;              /* has iothread_stop() been called? */
+    bool running;               /* should iothread_run() continue? */
     int thread_id;
 
     /* AioContext poll parameters */
diff --git a/iothread.c b/iothread.c
index e7b93e02a3..d8b6c1fb27 100644
--- a/iothread.c
+++ b/iothread.c
@@ -55,7 +55,7 @@ static void *iothread_run(void *opaque)
     qemu_cond_signal(&iothread->init_done_cond);
     qemu_mutex_unlock(&iothread->init_done_lock);
 
-    while (!atomic_read(&iothread->stopping)) {
+    while (iothread->running) {
         aio_poll(iothread->ctx, true);
 
         if (atomic_read(&iothread->worker_context)) {
@@ -78,16 +78,25 @@ static void *iothread_run(void *opaque)
     return NULL;
 }
 
+/* Runs in iothread_run() thread */
+static void iothread_stop_bh(void *opaque)
+{
+    IOThread *iothread = opaque;
+
+    iothread->running = false; /* stop iothread_run() */
+
+    if (iothread->main_loop) {
+        g_main_loop_quit(iothread->main_loop);
+    }
+}
+
 void iothread_stop(IOThread *iothread)
 {
     if (!iothread->ctx || iothread->stopping) {
         return;
     }
     iothread->stopping = true;
-    aio_notify(iothread->ctx);
-    if (atomic_read(&iothread->main_loop)) {
-        g_main_loop_quit(iothread->main_loop);
-    }
+    aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
     qemu_thread_join(&iothread->thread);
 }
 
@@ -134,6 +143,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
     char *name, *thread_name;
 
     iothread->stopping = false;
+    iothread->running = true;
     iothread->thread_id = -1;
     iothread->ctx = aio_context_new(&local_error);
     if (!iothread->ctx) {
-- 
2.14.3
