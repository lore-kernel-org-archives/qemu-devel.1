Received: from eggs.gnu.org ([209.51.188.92]:60370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Ila-0003pX-C8
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2IlZ-0006IP-Jg
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  8 Mar 2019 16:53:42 +0000
Message-Id: <20190308165344.10685-6-stefanha@redhat.com>
In-Reply-To: <20190308165344.10685-1-stefanha@redhat.com>
References: <20190308165344.10685-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/7] iothread: create main loop unconditionally
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

Since we've have the gcontext always there, create the main loop
altogether.  The iothread_run() is even cleaner.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-id: 20190306115532.23025-4-peterx@redhat.com
Message-Id: <20190306115532.23025-4-peterx@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 iothread.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/iothread.c b/iothread.c
index 6fa87876e0..9abdbace66 100644
--- a/iothread.c
+++ b/iothread.c
@@ -66,17 +66,8 @@ static void *iothread_run(void *opaque)
          * changed in previous aio_poll()
          */
         if (iothread->running && atomic_read(&iothread->run_gcontext)) {
-            GMainLoop *loop;
-
             g_main_context_push_thread_default(iothread->worker_context)=
;
-            iothread->main_loop =3D
-                g_main_loop_new(iothread->worker_context, TRUE);
-            loop =3D iothread->main_loop;
-
             g_main_loop_run(iothread->main_loop);
-            iothread->main_loop =3D NULL;
-            g_main_loop_unref(loop);
-
             g_main_context_pop_thread_default(iothread->worker_context);
         }
     }
@@ -141,6 +132,8 @@ static void iothread_instance_finalize(Object *obj)
     if (iothread->worker_context) {
         g_main_context_unref(iothread->worker_context);
         iothread->worker_context =3D NULL;
+        g_main_loop_unref(iothread->main_loop);
+        iothread->main_loop =3D NULL;
     }
     qemu_sem_destroy(&iothread->init_done_sem);
 }
@@ -153,6 +146,7 @@ static void iothread_init_gcontext(IOThread *iothread=
)
     source =3D aio_get_g_source(iothread_get_aio_context(iothread));
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
+    iothread->main_loop =3D g_main_loop_new(iothread->worker_context, TR=
UE);
 }
=20
 static void iothread_complete(UserCreatable *obj, Error **errp)
--=20
2.20.1
