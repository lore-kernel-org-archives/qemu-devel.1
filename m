Received: from eggs.gnu.org ([2001:4830:134:3::10]:59887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoX-00059Q-Ns
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoW-0006Ou-7K
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoW-0006Oc-0W
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 895578D74A
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 12:00:10 +0100
Message-Id: <20180307110010.2205-25-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 24/24] [RFC] migration: Send pages through
 the multifd channels
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

Migration ends correctly, but there is still a race between clean up
and last synchronization.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 132 ++++++++++++++++++++++++++++++++++++++++++++++---
 migration/trace-events |   3 +-
 2 files changed, 126 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 264d2e462a..577b448db3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -398,6 +398,19 @@ static void compress_threads_save_setup(void)
 
 /* Multiple fd's */
 
+#define MULTIFD_MAGIC 0x112233d
+#define MULTIFD_VERSION 1
+
+typedef struct {
+    uint32_t magic;
+    uint32_t version;
+    uint32_t size;
+    uint32_t used;
+    uint32_t seq;
+    char ramblock[256];
+    ram_addr_t offset[];
+} __attribute__((packed)) MultiFDPacket_t;
+
 typedef struct {
     /* number of used pages */
     uint32_t used;
@@ -407,6 +420,8 @@ typedef struct {
     uint32_t seq;
     struct iovec *iov;
     RAMBlock *block;
+    uint32_t packet_len;
+    MultiFDPacket_t *packet;
 } multifd_pages_t;
 
 struct MultiFDSendParams {
@@ -447,6 +462,8 @@ static void multifd_pages_init(multifd_pages_t **ppages, size_t size)
 
     pages->allocated = size;
     pages->iov = g_new0(struct iovec, size);
+    pages->packet_len = sizeof(MultiFDPacket_t) + sizeof(ram_addr_t) * size;
+    pages->packet = g_malloc0(pages->packet_len);
     *ppages = pages;
 }
 
@@ -458,6 +475,9 @@ static void multifd_pages_clear(multifd_pages_t *pages)
     pages->block = NULL;
     g_free(pages->iov);
     pages->iov = NULL;
+    pages->packet_len = 0;
+    g_free(pages->packet);
+    pages->packet = NULL;
     g_free(pages);
 }
 
@@ -499,7 +519,6 @@ int multifd_save_cleanup(Error **errp)
 
         if (p->running) {
             qemu_thread_join(&p->thread);
-            p->running = false;
         }
         socket_send_channel_destroy(p->c);
         p->c = NULL;
@@ -535,7 +554,16 @@ static void multifd_send_sync_main(void)
         qemu_sem_post(&p->sem);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
-        qemu_sem_wait(&multifd_send_state->sem_main);
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+        bool wait = true;
+
+        qemu_mutex_lock(&p->mutex);
+        wait = p->running;
+        qemu_mutex_unlock(&p->mutex);
+
+        if (wait) {
+            qemu_sem_wait(&multifd_send_state->sem_main);
+        }
     }
     trace_multifd_send_sync_main();
 }
@@ -575,16 +603,37 @@ static void *multifd_send_thread(void *opaque)
             continue;
         }
         if (p->quit) {
+            p->running = false;
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         if (p->pages->used) {
+            MultiFDPacket_t *packet = p->pages->packet;
+            Error *local_err = NULL;
+            size_t ret;
+
+            packet->used = p->pages->used;
             p->pages->used = 0;
             qemu_mutex_unlock(&p->mutex);
+            packet->magic = MULTIFD_MAGIC;
+            packet->version = MULTIFD_VERSION;
 
-            trace_multifd_send(p->id, p->pages->seq, p->pages->used);
-            /* ToDo: send page here */
-
+            strncpy(packet->ramblock, p->pages->block->idstr, 256);
+            packet->size = migrate_multifd_page_count();
+            packet->seq = p->pages->seq;
+            ret = qio_channel_write_all(p->c, (void *)packet,
+                                        p->pages->packet_len, &local_err);
+            if (ret != 0) {
+                terminate_multifd_send_threads(local_err);
+                return NULL;
+            }
+            trace_multifd_send(p->id, p->pages->seq, packet->used);
+            ret = qio_channel_writev_all(p->c, p->pages->iov,
+                                         packet->used, &local_err);
+            if (ret != 0) {
+                terminate_multifd_send_threads(local_err);
+                return NULL;
+            }
             qemu_mutex_lock(&multifd_send_state->mutex);
             p->done = true;
             p->packets_sent++;
@@ -763,7 +812,6 @@ int multifd_load_cleanup(Error **errp)
 
         if (p->running) {
             qemu_thread_join(&p->thread);
-            p->running = false;
         }
         socket_recv_channel_unref(p->c);
         p->c = NULL;
@@ -801,17 +849,48 @@ static void multifd_recv_sync_main(void)
         qemu_sem_post(&p->sem);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
-        qemu_sem_wait(&multifd_recv_state->sem_main);
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+        bool wait = true;
+
+        qemu_mutex_lock(&p->mutex);
+        wait = p->running && !p->quit;
+        qemu_mutex_unlock(&p->mutex);
+
+        if (wait) {
+            qemu_sem_wait(&multifd_recv_state->sem_main);
+        }
     }
     trace_multifd_recv_sync_main();
 }
 
+static gboolean recv_channel_ready(QIOChannel *ioc,
+                                   GIOCondition condition,
+                                   gpointer opaque)
+{
+    MultiFDRecvParams *p = opaque;
+
+    if (condition != G_IO_IN) {
+        return G_SOURCE_REMOVE;
+    }
+
+    qemu_mutex_lock(&p->mutex);
+    p->done = false;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+
+    return G_SOURCE_CONTINUE;
+
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
 
     trace_multifd_recv_thread_start(p->id);
 
+    qio_channel_add_watch(p->c, G_IO_IN | G_IO_HUP | G_IO_ERR,
+                          recv_channel_ready, p, NULL);
+
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
@@ -821,14 +900,50 @@ static void *multifd_recv_thread(void *opaque)
             qemu_sem_post(&multifd_recv_state->sem_main);
             continue;
         }
+        if (!p->done) {
+            MultiFDPacket_t *packet = p->pages->packet;
+            RAMBlock *block;
+            Error *local_err = NULL;
+            size_t ret;
+            int i;
+
+            qemu_mutex_unlock(&p->mutex);
+
+            ret = qio_channel_read_all(p->c, (void *)packet,
+                                       p->pages->packet_len, &local_err);
+            if (ret != 0) {
+                terminate_multifd_recv_threads(local_err);
+                return NULL;
+            }
+            block = qemu_ram_block_by_name(packet->ramblock);
+            p->pages->seq = packet->seq;
+            for (i = 0; i < packet->used; i++) {
+                p->pages->iov[i].iov_base = block->host + packet->offset[i];
+                p->pages->iov[i].iov_len = TARGET_PAGE_SIZE;
+            }
+            trace_multifd_recv(p->id, p->pages->seq, packet->used);
+            ret = qio_channel_readv_all(p->c, p->pages->iov,
+                                        packet->used, &local_err);
+            if (ret != 0) {
+                terminate_multifd_recv_threads(local_err);
+                return NULL;
+            }
+            qemu_mutex_lock(&p->mutex);
+            p->done = true;
+            p->packets_recv++;
+            qemu_mutex_unlock(&p->mutex);
+
+            continue;
+        }
         if (p->quit) {
+            p->running = false;
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
     }
 
-    trace_multifd_recv_thread_end(p->id);
+    trace_multifd_recv_thread_end(p->id, p->packets_recv);
     return NULL;
 }
 
@@ -854,6 +969,7 @@ int multifd_load_setup(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
+        p->done = true;
         p->id = i;
         p->name = g_strdup_printf("multifdrecv_%d", i);
         multifd_pages_init(&p->pages, migrate_multifd_page_count());
diff --git a/migration/trace-events b/migration/trace-events
index f6ab2c7bcb..e9f1aae985 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -82,8 +82,9 @@ multifd_recv_sync_main(void) ""
 multifd_send_thread_start(int id) "%d"
 multifd_send_thread_end(char id, uint32_t packets) "channel %d packets %d"
 multifd_recv_thread_start(int id) "%d"
-multifd_recv_thread_end(int id) "%d"
+multifd_recv_thread_end(char id, uint32_t packets) "channel %d packets %d"
 multifd_send(char id, int seq, int num) "channel %d sequence %d num pages %d"
+multifd_recv(char id, int seq, int num) "channel %d sequence %d num pages %d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
