Received: from eggs.gnu.org ([209.51.188.92]:60197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2IlG-0003XD-DQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2IlE-00063d-BF
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  8 Mar 2019 16:53:40 +0000
Message-Id: <20190308165344.10685-4-stefanha@redhat.com>
In-Reply-To: <20190308165344.10685-1-stefanha@redhat.com>
References: <20190308165344.10685-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] iothread: replace init_done_cond with a
 semaphore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Only sending an init-done message using lock+cond seems an overkill to
me.  Replacing it with a simpler semaphore.

Meanwhile, init the semaphore unconditionally, then we can destroy it
unconditionally too in finalize which seems cleaner.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-id: 20190306115532.23025-2-peterx@redhat.com
Message-Id: <20190306115532.23025-2-peterx@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/iothread.h |  3 +--
 iothread.c                | 17 ++++-------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 8a7ac2c528..50411ba54a 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -27,8 +27,7 @@ typedef struct {
     GMainContext *worker_context;
     GMainLoop *main_loop;
     GOnce once;
-    QemuMutex init_done_lock;
-    QemuCond init_done_cond;    /* is thread initialization done? */
+    QemuSemaphore init_done_sem; /* is thread init done? */
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
diff --git a/iothread.c b/iothread.c
index e615b7ae52..6e297e9ef1 100644
--- a/iothread.c
+++ b/iothread.c
@@ -55,10 +55,8 @@ static void *iothread_run(void *opaque)
     rcu_register_thread();
=20
     my_iothread =3D iothread;
-    qemu_mutex_lock(&iothread->init_done_lock);
     iothread->thread_id =3D qemu_get_thread_id();
-    qemu_cond_signal(&iothread->init_done_cond);
-    qemu_mutex_unlock(&iothread->init_done_lock);
+    qemu_sem_post(&iothread->init_done_sem);
=20
     while (iothread->running) {
         aio_poll(iothread->ctx, true);
@@ -115,6 +113,7 @@ static void iothread_instance_init(Object *obj)
=20
     iothread->poll_max_ns =3D IOTHREAD_POLL_MAX_NS_DEFAULT;
     iothread->thread_id =3D -1;
+    qemu_sem_init(&iothread->init_done_sem, 0);
 }
=20
 static void iothread_instance_finalize(Object *obj)
@@ -123,10 +122,6 @@ static void iothread_instance_finalize(Object *obj)
=20
     iothread_stop(iothread);
=20
-    if (iothread->thread_id !=3D -1) {
-        qemu_cond_destroy(&iothread->init_done_cond);
-        qemu_mutex_destroy(&iothread->init_done_lock);
-    }
     /*
      * Before glib2 2.33.10, there is a glib2 bug that GSource context
      * pointer may not be cleared even if the context has already been
@@ -145,6 +140,7 @@ static void iothread_instance_finalize(Object *obj)
         g_main_context_unref(iothread->worker_context);
         iothread->worker_context =3D NULL;
     }
+    qemu_sem_destroy(&iothread->init_done_sem);
 }
=20
 static void iothread_complete(UserCreatable *obj, Error **errp)
@@ -173,8 +169,6 @@ static void iothread_complete(UserCreatable *obj, Err=
or **errp)
         return;
     }
=20
-    qemu_mutex_init(&iothread->init_done_lock);
-    qemu_cond_init(&iothread->init_done_cond);
     iothread->once =3D (GOnce) G_ONCE_INIT;
=20
     /* This assumes we are called from a thread with useful CPU affinity=
 for us
@@ -188,12 +182,9 @@ static void iothread_complete(UserCreatable *obj, Er=
ror **errp)
     g_free(name);
=20
     /* Wait for initialization to complete */
-    qemu_mutex_lock(&iothread->init_done_lock);
     while (iothread->thread_id =3D=3D -1) {
-        qemu_cond_wait(&iothread->init_done_cond,
-                       &iothread->init_done_lock);
+        qemu_sem_wait(&iothread->init_done_sem);
     }
-    qemu_mutex_unlock(&iothread->init_done_lock);
 }
=20
 typedef struct {
--=20
2.20.1
