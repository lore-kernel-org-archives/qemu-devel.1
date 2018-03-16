Received: from eggs.gnu.org ([2001:4830:134:3::10]:59110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwG-0006ed-A0
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwF-0002b2-56
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwF-0002a2-0o
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C7664023156
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:53:56 +0100
Message-Id: <20180316115403.4148-9-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 08/15] migration: Synchronize recv threads
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

We synchronize all threads each RAM_SAVE_FLAG_EOS.  Bitmap
synchronizations don't happen inside a  ram section, so we are safe
about two channels trying to overwrite the same memory.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events |  3 +++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6aeb63f6ef..4ba03cf9c9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -565,6 +565,7 @@ struct MultiFDRecvParams {
     QemuMutex mutex;
     bool running;
     bool quit;
+    bool sync;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
 
@@ -572,6 +573,8 @@ struct {
     MultiFDRecvParams *params;
     /* number of created threads */
     int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_main;
 } *multifd_recv_state;
 
 static void multifd_recv_terminate_threads(Error *errp)
@@ -618,6 +621,7 @@ int multifd_load_cleanup(Error **errp)
         g_free(p->name);
         p->name = NULL;
     }
+    qemu_sem_destroy(&multifd_recv_state->sem_main);
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
     g_free(multifd_recv_state);
@@ -626,19 +630,59 @@ int multifd_load_cleanup(Error **errp)
     return ret;
 }
 
+static void multifd_recv_sync_main(void)
+{
+    int i;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+        trace_multifd_recv_sync_signal(p->id, p->quit, p->running);
+
+        qemu_mutex_lock(&p->mutex);
+        p->sync = true;
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_post(&p->sem);
+    }
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+        bool wait;
+
+        trace_multifd_recv_sync_wait(p->id, p->quit, p->running);
+
+        qemu_mutex_lock(&p->mutex);
+        wait = p->running;
+        qemu_mutex_unlock(&p->mutex);
+
+        if (wait) {
+            qemu_sem_wait(&multifd_recv_state->sem_main);
+        }
+    }
+    trace_multifd_recv_sync_main();
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
 
     while (true) {
+        qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
+        if (p->sync) {
+            p->sync = false;
+            qemu_mutex_unlock(&p->mutex);
+            qemu_sem_post(&multifd_recv_state->sem_main);
+            continue;
+        }
         if (p->quit) {
             p->running = false;
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
     }
 
     return NULL;
@@ -656,6 +700,7 @@ int multifd_load_setup(void)
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     atomic_set(&multifd_recv_state->count, 0);
+    qemu_sem_init(&multifd_recv_state->sem_main, 0);
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -2890,6 +2935,7 @@ static int ram_load_postcopy(QEMUFile *f)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
+            multifd_recv_sync_main();
             break;
         default:
             error_report("Unknown combination of migration flags: %#x"
@@ -3075,6 +3121,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
+            multifd_recv_sync_main();
             break;
         default:
             if (flags & RAM_SAVE_FLAG_HOOK) {
diff --git a/migration/trace-events b/migration/trace-events
index 845612c177..551d325daf 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -80,6 +80,9 @@ ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0
 multifd_send_sync_main(void) ""
 multifd_send_sync_signal(uint8_t id, bool quit, bool running) "channel %d quit %d running %d"
 multifd_send_sync_wait(uint8_t id, bool quit, bool running) "channel %d quit %d running %d"
+multifd_recv_sync_main(void) ""
+multifd_recv_sync_signal(uint8_t id, bool quit, bool running) "channel %d quit %d running %d"
+multifd_recv_sync_wait(uint8_t id, bool quit, bool running) "channel %d quit %d running %d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
