Received: from eggs.gnu.org ([2001:4830:134:3::10]:59052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwE-0006do-5n
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwA-0002Wl-5X
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwA-0002W6-16
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1E14406E96C
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:53:51 +0100
Message-Id: <20180316115403.4148-4-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 03/15] migration: terminate_* can be called
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

--

Once here, s/terminate_multifd_*-threads/multifd_*_terminate_threads/
This is consistente with every other function
---
 migration/ram.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1b8095a358..2d51c8b94c 100644
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
@@ -410,7 +411,7 @@ struct {
     int count;
 } *multifd_send_state;
 
-static void terminate_multifd_send_threads(Error *errp)
+static void multifd_send_terminate_threads(Error *errp)
 {
     int i;
 
@@ -424,7 +425,7 @@ static void terminate_multifd_send_threads(Error *errp)
         }
     }
 
-    for (i = 0; i < multifd_send_state->count; i++) {
+    for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         qemu_mutex_lock(&p->mutex);
@@ -442,11 +443,13 @@ int multifd_save_cleanup(Error **errp)
     if (!migrate_use_multifd()) {
         return 0;
     }
-    terminate_multifd_send_threads(NULL);
-    for (i = 0; i < multifd_send_state->count; i++) {
+    multifd_send_terminate_threads(NULL);
+    for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_thread_join(&p->thread);
+        if (p->running) {
+            qemu_thread_join(&p->thread);
+        }
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -466,6 +469,7 @@ static void *multifd_send_thread(void *opaque)
     while (true) {
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
+            p->running = false;
             qemu_mutex_unlock(&p->mutex);
             break;
         }
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
@@ -520,7 +526,7 @@ struct {
     int count;
 } *multifd_recv_state;
 
-static void terminate_multifd_recv_threads(Error *errp)
+static void multifd_recv_terminate_threads(Error *errp)
 {
     int i;
 
@@ -534,7 +540,7 @@ static void terminate_multifd_recv_threads(Error *errp)
         }
     }
 
-    for (i = 0; i < multifd_recv_state->count; i++) {
+    for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         qemu_mutex_lock(&p->mutex);
@@ -552,11 +558,13 @@ int multifd_load_cleanup(Error **errp)
     if (!migrate_use_multifd()) {
         return 0;
     }
-    terminate_multifd_recv_threads(NULL);
-    for (i = 0; i < multifd_recv_state->count; i++) {
+    multifd_recv_terminate_threads(NULL);
+    for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        qemu_thread_join(&p->thread);
+        if (p->running) {
+            qemu_thread_join(&p->thread);
+        }
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -577,6 +585,7 @@ static void *multifd_recv_thread(void *opaque)
     while (true) {
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
+            p->running = false;
             qemu_mutex_unlock(&p->mutex);
             break;
         }
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
