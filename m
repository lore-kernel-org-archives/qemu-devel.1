Received: from eggs.gnu.org ([209.51.188.92]:60383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Ild-0003sg-Fh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Ilb-0006Ko-Fe
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:41 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  8 Mar 2019 16:53:43 +0000
Message-Id: <20190308165344.10685-7-stefanha@redhat.com>
In-Reply-To: <20190308165344.10685-1-stefanha@redhat.com>
References: <20190308165344.10685-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] iothread: push gcontext earlier in the
 thread_fn
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

We were pushing the context until right before running the gmainloop.
Now since we have everything unconditionally, we can move this
earlier.

One benefit is that now it's done even before init_done_sem, so as
long as the iothread user calls iothread_create() and completes, we
know that the thread stack is ready.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-id: 20190306115532.23025-5-peterx@redhat.com
Message-Id: <20190306115532.23025-5-peterx@redhat.com>

[Tweaked comment wording as discussed with Peter Xu.
--Stefan]

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 iothread.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/iothread.c b/iothread.c
index 9abdbace66..ad64c757ac 100644
--- a/iothread.c
+++ b/iothread.c
@@ -53,7 +53,11 @@ static void *iothread_run(void *opaque)
     IOThread *iothread =3D opaque;
=20
     rcu_register_thread();
-
+    /*
+     * g_main_context_push_thread_default() must be called before anythi=
ng
+     * in this new thread uses glib.
+     */
+    g_main_context_push_thread_default(iothread->worker_context);
     my_iothread =3D iothread;
     iothread->thread_id =3D qemu_get_thread_id();
     qemu_sem_post(&iothread->init_done_sem);
@@ -66,12 +70,11 @@ static void *iothread_run(void *opaque)
          * changed in previous aio_poll()
          */
         if (iothread->running && atomic_read(&iothread->run_gcontext)) {
-            g_main_context_push_thread_default(iothread->worker_context)=
;
             g_main_loop_run(iothread->main_loop);
-            g_main_context_pop_thread_default(iothread->worker_context);
         }
     }
=20
+    g_main_context_pop_thread_default(iothread->worker_context);
     rcu_unregister_thread();
     return NULL;
 }
--=20
2.20.1
