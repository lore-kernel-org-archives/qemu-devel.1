Received: from eggs.gnu.org ([2001:4830:134:3::10]:34121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaF-0002jp-SE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaE-0004sx-Rn
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIaE-0004sD-NC
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55E40EC016
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:27:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:27:08 +0200
Message-Id: <20180425112723.1111-7-quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
References: <20180425112723.1111-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 06/21] migration: Create multifd channels
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
index 3a01472835..54b1f8e836 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -404,6 +404,7 @@ struct MultiFDSendParams {
     uint8_t id;
     char *name;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
@@ -456,6 +457,8 @@ int multifd_save_cleanup(Error **errp)
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
+        socket_send_channel_destroy(p->c);
+        p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -489,6 +492,27 @@ static void *multifd_send_thread(void *opaque)
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
@@ -509,11 +533,7 @@ int multifd_save_setup(void)
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
@@ -522,6 +542,7 @@ struct MultiFDRecvParams {
     uint8_t id;
     char *name;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
@@ -574,6 +595,8 @@ int multifd_load_cleanup(Error **errp)
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
+        object_unref(OBJECT(p->c));
+        p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -628,10 +651,6 @@ int multifd_load_setup(void)
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
@@ -649,7 +668,20 @@ bool multifd_recv_all_channels_created(void)
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
