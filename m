Received: from eggs.gnu.org ([2001:4830:134:3::10]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoP-000544-QY
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoL-0006H2-1V
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoK-0006GZ-Sk
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 672BC404084A
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 12:00:02 +0100
Message-Id: <20180307110010.2205-17-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 16/24] migration: Synchronize recv threads
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
 migration/ram.c        | 37 ++++++++++++++++++++++++++++++++++++-
 migration/trace-events |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 153c7560cb..0266bd200c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -551,6 +551,7 @@ struct MultiFDRecvParams {
     QemuMutex mutex;
     bool running;
     bool quit;
+    bool sync;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
 
@@ -558,6 +559,8 @@ struct {
     MultiFDRecvParams *params;
     /* number of created threads */
     int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_main;
 } *multifd_recv_state;
 
 static void terminate_multifd_recv_threads(Error *errp)
@@ -605,6 +608,7 @@ int multifd_load_cleanup(Error **errp)
         g_free(p->name);
         p->name = NULL;
     }
+    qemu_sem_destroy(&multifd_recv_state->sem_main);
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
     g_free(multifd_recv_state);
@@ -613,18 +617,45 @@ int multifd_load_cleanup(Error **errp)
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
+        qemu_mutex_lock(&p->mutex);
+        p->sync = true;
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_post(&p->sem);
+    }
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        qemu_sem_wait(&multifd_recv_state->sem_main);
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
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
     }
 
     return NULL;
@@ -642,6 +673,7 @@ int multifd_load_setup(void)
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     atomic_set(&multifd_recv_state->count, 0);
+    qemu_sem_init(&multifd_recv_state->sem_main, 0);
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -655,6 +687,7 @@ int multifd_load_setup(void)
                            QEMU_THREAD_JOINABLE);
         atomic_inc(&multifd_recv_state->count);
     }
+
     return 0;
 }
 
@@ -2868,6 +2901,7 @@ static int ram_load_postcopy(QEMUFile *f)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
+            multifd_recv_sync_main();
             break;
         default:
             error_report("Unknown combination of migration flags: %#x"
@@ -3053,6 +3087,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
+            multifd_recv_sync_main();
             break;
         default:
             if (flags & RAM_SAVE_FLAG_HOOK) {
diff --git a/migration/trace-events b/migration/trace-events
index 97b5ac564f..76075c26bc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -78,6 +78,7 @@ ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
 multifd_send_sync_main(void) ""
+multifd_recv_sync_main(void) ""
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
