Received: from eggs.gnu.org ([2001:4830:134:3::10]:34356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaW-00032q-0F
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaR-0005EP-Uh
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIaR-0005Dm-Oc
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61BAA402314E
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:27:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:27:18 +0200
Message-Id: <20180425112723.1111-17-quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
References: <20180425112723.1111-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v12 16/21] migration: Synchronize multifd
 threads with main thread
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
 migration/ram.c        | 118 +++++++++++++++++++++++++++++++++++++----
 migration/trace-events |   6 +++
 2 files changed, 113 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c4c185cc4c..398cb0af3b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -405,6 +405,8 @@ static void compress_threads_save_setup(void)
 #define MULTIFD_MAGIC 0x11223344U
 #define MULTIFD_VERSION 1
 
+#define MULTIFD_FLAG_SYNC (1 << 0)
+
 typedef struct {
     uint32_t magic;
     uint32_t version;
@@ -471,6 +473,8 @@ typedef struct {
     uint32_t num_packets;
     /* pages sent through this channel */
     uint32_t num_pages;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -507,6 +511,8 @@ typedef struct {
     uint32_t num_packets;
     /* pages sent through this channel */
     uint32_t num_pages;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
 } MultiFDRecvParams;
 
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
@@ -682,6 +688,10 @@ struct {
     int count;
     /* array of pages to sent */
     MultiFDPages_t *pages;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+    /* global number of generated multifd packets */
+    uint32_t seq;
 } *multifd_send_state;
 
 static void multifd_send_terminate_threads(Error *err)
@@ -727,6 +737,7 @@ int multifd_save_cleanup(Error **errp)
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
         p->name = NULL;
         multifd_pages_clear(p->pages);
@@ -735,6 +746,7 @@ int multifd_save_cleanup(Error **errp)
         g_free(p->packet);
         p->packet = NULL;
     }
+    qemu_sem_destroy(&multifd_send_state->sem_sync);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
     multifd_pages_clear(multifd_send_state->pages);
@@ -744,6 +756,33 @@ int multifd_save_cleanup(Error **errp)
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
+        trace_multifd_send_sync_main_signal(p->id);
+
+        qemu_mutex_lock(&p->mutex);
+        p->flags |= MULTIFD_FLAG_SYNC;
+        p->pending_job++;
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_post(&p->sem);
+    }
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        trace_multifd_send_sync_main_wait(p->id);
+        qemu_sem_wait(&multifd_send_state->sem_sync);
+    }
+    trace_multifd_send_sync_main(multifd_send_state->seq);
+}
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
@@ -778,17 +817,20 @@ static void *multifd_send_thread(void *opaque)
             /* ToDo: send packet here */
 
             qemu_mutex_lock(&p->mutex);
+            p->flags = 0;
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
-            continue;
+
+            if (flags & MULTIFD_FLAG_SYNC) {
+                qemu_sem_post(&multifd_send_state->sem_sync);
+            }
         } else if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
+        } else {
+            qemu_mutex_unlock(&p->mutex);
+            /* sometimes there are spurious wakeups */
         }
-        qemu_mutex_unlock(&p->mutex);
-        /* this is impossible */
-        error_setg(&local_err, "multifd_send_thread: Unknown command");
-        break;
     }
 
 out:
@@ -840,12 +882,14 @@ int multifd_save_setup(void)
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     atomic_set(&multifd_send_state->count, 0);
     multifd_pages_init(&multifd_send_state->pages, page_count);
+    qemu_sem_init(&multifd_send_state->sem_sync, 0);
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->sem_sync, 0);
         p->quit = false;
         p->pending_job = 0;
         p->id = i;
@@ -863,6 +907,10 @@ struct {
     MultiFDRecvParams *params;
     /* number of created threads */
     int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+    /* global number of generated multifd packets */
+    uint32_t seq;
 } *multifd_recv_state;
 
 static void multifd_recv_terminate_threads(Error *err)
@@ -908,6 +956,7 @@ int multifd_load_cleanup(Error **errp)
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
         p->name = NULL;
         multifd_pages_clear(p->pages);
@@ -916,6 +965,7 @@ int multifd_load_cleanup(Error **errp)
         g_free(p->packet);
         p->packet = NULL;
     }
+    qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
     g_free(multifd_recv_state);
@@ -924,6 +974,42 @@ int multifd_load_cleanup(Error **errp)
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
+        trace_multifd_recv_sync_main_signal(p->id);
+        qemu_mutex_lock(&p->mutex);
+        p->pending_job = true;
+        qemu_mutex_unlock(&p->mutex);
+    }
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+        trace_multifd_recv_sync_main_wait(p->id);
+        qemu_sem_wait(&multifd_recv_state->sem_sync);
+        qemu_mutex_lock(&p->mutex);
+        if (multifd_recv_state->seq < p->seq) {
+            multifd_recv_state->seq = p->seq;
+        }
+        qemu_mutex_unlock(&p->mutex);
+    }
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+        trace_multifd_recv_sync_main_signal(p->id);
+
+        qemu_sem_post(&p->sem_sync);
+    }
+    trace_multifd_recv_sync_main(multifd_recv_state->seq);
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
@@ -933,9 +1019,8 @@ static void *multifd_recv_thread(void *opaque)
     trace_multifd_recv_thread_start(p->id);
 
     while (true) {
-        qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
-        if (p->pending_job) {
+        if (true || p->pending_job) {
             uint32_t used;
             uint32_t flags;
             qemu_mutex_unlock(&p->mutex);
@@ -956,14 +1041,18 @@ static void *multifd_recv_thread(void *opaque)
             p->num_packets++;
             p->num_pages += used;
             qemu_mutex_unlock(&p->mutex);
+
+            if (flags & MULTIFD_FLAG_SYNC) {
+                qemu_sem_post(&multifd_recv_state->sem_sync);
+                qemu_sem_wait(&p->sem_sync);
+            }
         } else if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
+        } else {
+            qemu_mutex_unlock(&p->mutex);
+            /* sometimes there are spurious wakeups */
         }
-        qemu_mutex_unlock(&p->mutex);
-        /* this is impossible */
-        error_setg(&local_err, "multifd_recv_thread: Unknown command");
-        break;
     }
 
     if (local_err) {
@@ -991,12 +1080,14 @@ int multifd_load_setup(void)
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     atomic_set(&multifd_recv_state->count, 0);
+    qemu_sem_init(&multifd_recv_state->sem_sync, 0);
 
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->sem_sync, 0);
         p->quit = false;
         p->pending_job = false;
         p->id = i;
@@ -2695,6 +2786,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
 
+    multifd_send_sync_main();
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
 
     return 0;
@@ -2770,6 +2862,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      */
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
 
+    multifd_send_sync_main();
 out:
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ram_counters.transferred += 8;
@@ -2823,6 +2916,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     rcu_read_unlock();
 
+    multifd_send_sync_main();
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
 
     return 0;
@@ -3253,6 +3347,7 @@ static int ram_load_postcopy(QEMUFile *f)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
+            multifd_recv_sync_main();
             break;
         default:
             error_report("Unknown combination of migration flags: %#x"
@@ -3438,6 +3533,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
+            multifd_recv_sync_main();
             break;
         default:
             if (flags & RAM_SAVE_FLAG_HOOK) {
diff --git a/migration/trace-events b/migration/trace-events
index 9eee048287..b0ab8e2d03 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -83,6 +83,12 @@ multifd_recv_thread_start(uint8_t id) "%d"
 multifd_recv_thread_end(uint8_t id, uint32_t packets, uint32_t pages) "channel %d packets %d pages %d"
 multifd_send(uint8_t id, uint32_t seq, uint32_t used, uint32_t flags) "channel %d seq number %d pages %d flags 0x%x"
 multifd_recv(uint8_t id, uint32_t seq, uint32_t used, uint32_t flags) "channel %d seq number %d pages %d flags 0x%x"
+multifd_send_sync_main(uint32_t seq) "seq %d"
+multifd_send_sync_main_signal(uint8_t id) "channel %d"
+multifd_send_sync_main_wait(uint8_t id) "channel %d"
+multifd_recv_sync_main(uint32_t seq) "seq %d"
+multifd_recv_sync_main_signal(uint8_t id) "channel %d"
+multifd_recv_sync_main_wait(uint8_t id) "channel %d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.17.0
