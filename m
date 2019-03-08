Received: from eggs.gnu.org ([209.51.188.92]:60276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2IlQ-0003fx-4j
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2IlO-0006AV-9P
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  8 Mar 2019 16:53:41 +0000
Message-Id: <20190308165344.10685-5-stefanha@redhat.com>
In-Reply-To: <20190308165344.10685-1-stefanha@redhat.com>
References: <20190308165344.10685-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/7] iothread: create the gcontext
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Peter Xu <peterx@redhat.com>

In existing code we create the gcontext dynamically at the first
access of the gcontext from caller.  That can bring some complexity
and potential races during using iothread.  Since the context itself
is not that big a resource, and we won't have millions of iothread,
let's simply create the gcontext unconditionally.

This will also be a preparation work further to move the thread
context push operation earlier than before (now it's only pushed right
before we want to start running the gmainloop).

Removing the g_once since it's not necessary, while introducing a new
run_gcontext boolean to show whether we want to run the gcontext.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-id: 20190306115532.23025-3-peterx@redhat.com
Message-Id: <20190306115532.23025-3-peterx@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h |  2 +-
 iothread.c                | 43 +++++++++++++++++++--------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 50411ba54a..5f6240d5cb 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -24,9 +24,9 @@ typedef struct {
=20
     QemuThread thread;
     AioContext *ctx;
+    bool run_gcontext;          /* whether we should run gcontext */
     GMainContext *worker_context;
     GMainLoop *main_loop;
-    GOnce once;
     QemuSemaphore init_done_sem; /* is thread init done? */
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
diff --git a/iothread.c b/iothread.c
index 6e297e9ef1..6fa87876e0 100644
--- a/iothread.c
+++ b/iothread.c
@@ -65,7 +65,7 @@ static void *iothread_run(void *opaque)
          * We must check the running state again in case it was
          * changed in previous aio_poll()
          */
-        if (iothread->running && atomic_read(&iothread->worker_context))=
 {
+        if (iothread->running && atomic_read(&iothread->run_gcontext)) {
             GMainLoop *loop;
=20
             g_main_context_push_thread_default(iothread->worker_context)=
;
@@ -114,6 +114,8 @@ static void iothread_instance_init(Object *obj)
     iothread->poll_max_ns =3D IOTHREAD_POLL_MAX_NS_DEFAULT;
     iothread->thread_id =3D -1;
     qemu_sem_init(&iothread->init_done_sem, 0);
+    /* By default, we don't run gcontext */
+    atomic_set(&iothread->run_gcontext, 0);
 }
=20
 static void iothread_instance_finalize(Object *obj)
@@ -143,6 +145,16 @@ static void iothread_instance_finalize(Object *obj)
     qemu_sem_destroy(&iothread->init_done_sem);
 }
=20
+static void iothread_init_gcontext(IOThread *iothread)
+{
+    GSource *source;
+
+    iothread->worker_context =3D g_main_context_new();
+    source =3D aio_get_g_source(iothread_get_aio_context(iothread));
+    g_source_attach(source, iothread->worker_context);
+    g_source_unref(source);
+}
+
 static void iothread_complete(UserCreatable *obj, Error **errp)
 {
     Error *local_error =3D NULL;
@@ -157,6 +169,12 @@ static void iothread_complete(UserCreatable *obj, Er=
ror **errp)
         return;
     }
=20
+    /*
+     * Init one GMainContext for the iothread unconditionally, even if
+     * it's not used
+     */
+    iothread_init_gcontext(iothread);
+
     aio_context_set_poll_params(iothread->ctx,
                                 iothread->poll_max_ns,
                                 iothread->poll_grow,
@@ -169,8 +187,6 @@ static void iothread_complete(UserCreatable *obj, Err=
or **errp)
         return;
     }
=20
-    iothread->once =3D (GOnce) G_ONCE_INIT;
-
     /* This assumes we are called from a thread with useful CPU affinity=
 for us
      * to inherit.
      */
@@ -333,27 +349,10 @@ IOThreadInfoList *qmp_query_iothreads(Error **errp)
     return head;
 }
=20
-static gpointer iothread_g_main_context_init(gpointer opaque)
-{
-    AioContext *ctx;
-    IOThread *iothread =3D opaque;
-    GSource *source;
-
-    iothread->worker_context =3D g_main_context_new();
-
-    ctx =3D iothread_get_aio_context(iothread);
-    source =3D aio_get_g_source(ctx);
-    g_source_attach(source, iothread->worker_context);
-    g_source_unref(source);
-
-    aio_notify(iothread->ctx);
-    return NULL;
-}
-
 GMainContext *iothread_get_g_main_context(IOThread *iothread)
 {
-    g_once(&iothread->once, iothread_g_main_context_init, iothread);
-
+    atomic_set(&iothread->run_gcontext, 1);
+    aio_notify(iothread->ctx);
     return iothread->worker_context;
 }
=20
--=20
2.20.1
