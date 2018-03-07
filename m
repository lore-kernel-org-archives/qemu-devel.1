Received: from eggs.gnu.org ([2001:4830:134:3::10]:59838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoT-000568-9X
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoP-0006Js-8K
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoP-0006JL-33
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92AA3814F0CF
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 12:00:05 +0100
Message-Id: <20180307110010.2205-20-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 19/24] migration: Create multifd channels
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
---
 migration/ram.c | 52 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b57d9fd667..7ef0c2b7e2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -399,6 +399,7 @@ struct MultiFDSendParams {
     uint8_t id;
     char *name;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
@@ -455,6 +456,8 @@ int multifd_save_cleanup(Error **errp)
             qemu_thread_join(&p->thread);
             p->running = false;
         }
+        socket_send_channel_destroy(p->c);
+        p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -514,6 +517,27 @@ static void *multifd_send_thread(void *opaque)
     return NULL;
 }
 
+static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
+{
+    MultiFDSendParams *p = opaque;
+    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
+    Error *local_err = NULL;
+
+    if (qio_task_propagate_error(task, &local_err)) {
+        if (multifd_save_cleanup(&local_err) != 0) {
+            migrate_set_error(migrate_get_current(), local_err);
+        }
+    } else {
+        p->c = QIO_CHANNEL(sioc);
+        qio_channel_set_delay(p->c, false);
+        p->running = true;
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
@@ -536,11 +560,7 @@ int multifd_save_setup(void)
         p->quit = false;
         p->id = i;
         p->name = g_strdup_printf("multifdsend_%d", i);
-        p->running = true;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
-
-        atomic_inc(&multifd_send_state->count);
+        socket_send_channel_create(multifd_new_send_channel_async, p);
     }
 
     return 0;
@@ -550,6 +570,7 @@ struct MultiFDRecvParams {
     uint8_t id;
     char *name;
     QemuThread thread;
+    QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
@@ -606,6 +627,8 @@ int multifd_load_cleanup(Error **errp)
             qemu_thread_join(&p->thread);
             p->running = false;
         }
+        socket_recv_channel_unref(p->c);
+        p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -688,10 +711,6 @@ int multifd_load_setup(void)
         p->quit = false;
         p->id = i;
         p->name = g_strdup_printf("multifdrecv_%d", i);
-        p->running = true;
-        qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                           QEMU_THREAD_JOINABLE);
-        atomic_inc(&multifd_recv_state->count);
     }
 
     return 0;
@@ -710,7 +729,20 @@ bool multifd_recv_all_channels_created(void)
 
 void multifd_recv_new_channel(QIOChannel *ioc)
 {
-    /* nothing to do yet */
+    MultiFDRecvParams *p;
+    /* we need to invent channels id's until we transmit */
+    /* we will remove this on a later patch */
+    static int i = 0;
+
+    p = &multifd_recv_state->params[i];
+    i++;
+    p->c = ioc;
+    socket_recv_channel_ref(ioc);
+
+    p->running = true;
+    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                       QEMU_THREAD_JOINABLE);
+    atomic_inc(&multifd_recv_state->count);
 }
 
 /**
-- 
2.14.3
