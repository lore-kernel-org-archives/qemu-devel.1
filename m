Received: from eggs.gnu.org ([2001:4830:134:3::10]:58128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYY-0002z9-OM
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYX-0001jE-J5
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjYX-0001iq-8Y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB4517C6B1
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:40:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:39:46 +0200
Message-Id: <20180515234017.2277-10-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/40] migration: Create multifd channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

In both sides.  We still don't transmit anything through them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 migration/ram.c | 52 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d5335c10b6..87434d3fce 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -437,6 +437,7 @@ struct MultiFDSendParams {
     uint8_t id;
     char *name;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
@@ -491,6 +492,8 @@ int multifd_save_cleanup(Error **errp)
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
+        socket_send_channel_destroy(p->c);
+        p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -524,6 +527,27 @@ static void *multifd_send_thread(void *opaque)
     return NULL;
 }
=20
+static void multifd_new_send_channel_async(QIOTask *task, gpointer opaqu=
e)
+{
+    MultiFDSendParams *p =3D opaque;
+    QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task));
+    Error *local_err =3D NULL;
+
+    if (qio_task_propagate_error(task, &local_err)) {
+        if (multifd_save_cleanup(&local_err) !=3D 0) {
+            migrate_set_error(migrate_get_current(), local_err);
+        }
+    } else {
+        p->c =3D QIO_CHANNEL(sioc);
+        qio_channel_set_delay(p->c, false);
+        p->running =3D true;
+        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                           QEMU_THREAD_JOINABLE);
+
+        atomic_inc(&multifd_send_state->count);
+    }
+}
+
 int multifd_save_setup(void)
 {
     int thread_count;
@@ -544,11 +568,7 @@ int multifd_save_setup(void)
         p->quit =3D false;
         p->id =3D i;
         p->name =3D g_strdup_printf("multifdsend_%d", i);
-        p->running =3D true;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
-
-        atomic_inc(&multifd_send_state->count);
+        socket_send_channel_create(multifd_new_send_channel_async, p);
     }
     return 0;
 }
@@ -557,6 +577,7 @@ struct MultiFDRecvParams {
     uint8_t id;
     char *name;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
@@ -609,6 +630,8 @@ int multifd_load_cleanup(Error **errp)
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
+        object_unref(OBJECT(p->c));
+        p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -663,10 +686,6 @@ int multifd_load_setup(void)
         p->quit =3D false;
         p->id =3D i;
         p->name =3D g_strdup_printf("multifdrecv_%d", i);
-        p->running =3D true;
-        qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                           QEMU_THREAD_JOINABLE);
-        atomic_inc(&multifd_recv_state->count);
     }
     return 0;
 }
@@ -684,7 +703,20 @@ bool multifd_recv_all_channels_created(void)
=20
 void multifd_recv_new_channel(QIOChannel *ioc)
 {
-    /* nothing to do yet */
+    MultiFDRecvParams *p;
+    /* we need to invent channels id's until we transmit */
+    /* we will remove this on a later patch */
+    static int i;
+
+    p =3D &multifd_recv_state->params[i];
+    i++;
+    p->c =3D ioc;
+    object_ref(OBJECT(ioc));
+
+    p->running =3D true;
+    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                       QEMU_THREAD_JOINABLE);
+    atomic_inc(&multifd_recv_state->count);
 }
=20
 /**
--=20
2.17.0
