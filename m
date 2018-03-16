Received: from eggs.gnu.org ([2001:4830:134:3::10]:59083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwE-0006dy-V0
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwD-0002Z9-Tj
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33548 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwD-0002Yo-NZ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40BA7401CC41
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:53:55 +0100
Message-Id: <20180316115403.4148-8-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 07/15] migration: Synchronize send threads
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
 migration/ram.c        | 52 +++++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events |  3 +++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7e60fc82a6..6aeb63f6ef 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -403,6 +403,7 @@ struct MultiFDSendParams {
     QemuMutex mutex;
     bool running;
     bool quit;
+    bool sync;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
 
@@ -410,6 +411,8 @@ struct {
     MultiFDSendParams *params;
     /* number of created threads */
     int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_main;
 } *multifd_send_state;
 
 static void multifd_send_terminate_threads(Error *errp)
@@ -456,6 +459,7 @@ int multifd_save_cleanup(Error **errp)
         g_free(p->name);
         p->name = NULL;
     }
+    qemu_sem_destroy(&multifd_send_state->sem_main);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
     g_free(multifd_send_state);
@@ -463,19 +467,59 @@ int multifd_save_cleanup(Error **errp)
     return ret;
 }
 
+static void multifd_send_sync_main(void)
+{
+    int i;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        trace_multifd_send_sync_signal(p->id, p->quit, p->running);
+
+        qemu_mutex_lock(&p->mutex);
+        p->sync = true;
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_post(&p->sem);
+    }
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+        bool wait;
+
+        trace_multifd_send_sync_wait(p->id, p->quit, p->running);
+
+        qemu_mutex_lock(&p->mutex);
+        wait = p->running;
+        qemu_mutex_unlock(&p->mutex);
+
+        if (wait) {
+            qemu_sem_wait(&multifd_send_state->sem_main);
+        }
+    }
+    trace_multifd_send_sync_main();
+}
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
 
     while (true) {
+        qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
+        if (p->sync) {
+            p->sync = false;
+            qemu_mutex_unlock(&p->mutex);
+            qemu_sem_post(&multifd_send_state->sem_main);
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
@@ -493,6 +537,8 @@ int multifd_save_setup(void)
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     atomic_set(&multifd_send_state->count, 0);
+    qemu_sem_init(&multifd_send_state->sem_main, 0);
+
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -507,6 +553,7 @@ int multifd_save_setup(void)
 
         atomic_inc(&multifd_send_state->count);
     }
+
     return 0;
 }
 
@@ -2283,6 +2330,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
 
+    multifd_send_sync_main();
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
 
     return 0;
@@ -2358,6 +2406,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      */
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
 
+    multifd_send_sync_main();
 out:
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ram_counters.transferred += 8;
@@ -2411,6 +2460,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     rcu_read_unlock();
 
+    multifd_send_sync_main();
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
 
     return 0;
diff --git a/migration/trace-events b/migration/trace-events
index 93961dea16..845612c177 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -77,6 +77,9 @@ ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
+multifd_send_sync_main(void) ""
+multifd_send_sync_signal(uint8_t id, bool quit, bool running) "channel %d quit %d running %d"
+multifd_send_sync_wait(uint8_t id, bool quit, bool running) "channel %d quit %d running %d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
