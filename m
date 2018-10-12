Received: from eggs.gnu.org ([2001:4830:134:3::10]:48567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAmb8-00085d-Fz
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAmb5-0004c1-6R
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gAmb4-0004al-Lj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:35 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 12 Oct 2018 09:50:25 +0800
Message-Id: <20181012015026.17441-2-famz@redhat.com>
In-Reply-To: <20181012015026.17441-1-famz@redhat.com>
References: <20181012015026.17441-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] iothread: fix crash with invalid properties
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

-object iothread,id=3Dfoo,? will crash qemu:

qemu-system-x86_64:qemu-thread-posix.c:128: qemu_cond_destroy: Assertion =
`cond->initialized' failed.

Use thread_id !=3D -1 to check if iothread_complete() finished
successfully and the mutex/cond have been initialized.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180821100716.13803-1-marcandre.lureau@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 iothread.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/iothread.c b/iothread.c
index aff1281257..2fb1cdf55d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -110,6 +110,7 @@ static void iothread_instance_init(Object *obj)
     IOThread *iothread =3D IOTHREAD(obj);
=20
     iothread->poll_max_ns =3D IOTHREAD_POLL_MAX_NS_DEFAULT;
+    iothread->thread_id =3D -1;
 }
=20
 static void iothread_instance_finalize(Object *obj)
@@ -117,6 +118,11 @@ static void iothread_instance_finalize(Object *obj)
     IOThread *iothread =3D IOTHREAD(obj);
=20
     iothread_stop(iothread);
+
+    if (iothread->thread_id !=3D -1) {
+        qemu_cond_destroy(&iothread->init_done_cond);
+        qemu_mutex_destroy(&iothread->init_done_lock);
+    }
     /*
      * Before glib2 2.33.10, there is a glib2 bug that GSource context
      * pointer may not be cleared even if the context has already been
@@ -135,8 +141,6 @@ static void iothread_instance_finalize(Object *obj)
         g_main_context_unref(iothread->worker_context);
         iothread->worker_context =3D NULL;
     }
-    qemu_cond_destroy(&iothread->init_done_cond);
-    qemu_mutex_destroy(&iothread->init_done_lock);
 }
=20
 static void iothread_complete(UserCreatable *obj, Error **errp)
@@ -147,7 +151,6 @@ static void iothread_complete(UserCreatable *obj, Err=
or **errp)
=20
     iothread->stopping =3D false;
     iothread->running =3D true;
-    iothread->thread_id =3D -1;
     iothread->ctx =3D aio_context_new(&local_error);
     if (!iothread->ctx) {
         error_propagate(errp, local_error);
--=20
2.17.1
