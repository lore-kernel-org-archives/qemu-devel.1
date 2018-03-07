Received: from eggs.gnu.org ([2001:4830:134:3::10]:59612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoE-0004sm-S1
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoD-0006BU-QY
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoD-0006B1-Lt
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F364EBFE6
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 11:59:57 +0100
Message-Id: <20180307110010.2205-12-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 11/24] migration: terminate_* can be called
 for other threads
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

Once there, make  count field to always be accessed with atomic
operations.  To make blocking operations, we need to know that the
thread is running, so create a bool to indicate that.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4a56a85d53..977e675f46 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -400,6 +400,7 @@ struct MultiFDSendParams {
     QemuThread thread;
     QemuSemaphore sem;
     QemuMutex mutex;
+    bool running;
     bool quit;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
@@ -424,7 +425,7 @@ static void terminate_multifd_send_threads(Error *errp)
         }
     }
 
-    for (i = 0; i < multifd_send_state->count; i++) {
+    for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         qemu_mutex_lock(&p->mutex);
@@ -443,10 +444,13 @@ int multifd_save_cleanup(Error **errp)
         return 0;
     }
     terminate_multifd_send_threads(NULL);
-    for (i = 0; i < multifd_send_state->count; i++) {
+    for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_thread_join(&p->thread);
+        if (p->running) {
+            qemu_thread_join(&p->thread);
+            p->running = false;
+        }
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -487,7 +491,7 @@ int multifd_save_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
-    multifd_send_state->count = 0;
+    atomic_set(&multifd_send_state->count, 0);
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -496,10 +500,11 @@ int multifd_save_setup(void)
         p->quit = false;
         p->id = i;
         p->name = g_strdup_printf("multifdsend_%d", i);
+        p->running = true;
         qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                            QEMU_THREAD_JOINABLE);
 
-        multifd_send_state->count++;
+        atomic_inc(&multifd_send_state->count);
     }
     return 0;
 }
@@ -510,6 +515,7 @@ struct MultiFDRecvParams {
     QemuThread thread;
     QemuSemaphore sem;
     QemuMutex mutex;
+    bool running;
     bool quit;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
@@ -534,7 +540,7 @@ static void terminate_multifd_recv_threads(Error *errp)
         }
     }
 
-    for (i = 0; i < multifd_recv_state->count; i++) {
+    for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         qemu_mutex_lock(&p->mutex);
@@ -553,10 +559,13 @@ int multifd_load_cleanup(Error **errp)
         return 0;
     }
     terminate_multifd_recv_threads(NULL);
-    for (i = 0; i < multifd_recv_state->count; i++) {
+    for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        qemu_thread_join(&p->thread);
+        if (p->running) {
+            qemu_thread_join(&p->thread);
+            p->running = false;
+        }
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -598,7 +607,7 @@ int multifd_load_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
-    multifd_recv_state->count = 0;
+    atomic_set(&multifd_recv_state->count, 0);
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -607,9 +616,10 @@ int multifd_load_setup(void)
         p->quit = false;
         p->id = i;
         p->name = g_strdup_printf("multifdrecv_%d", i);
+        p->running = true;
         qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                            QEMU_THREAD_JOINABLE);
-        multifd_recv_state->count++;
+        atomic_inc(&multifd_recv_state->count);
     }
     return 0;
 }
-- 
2.14.3
