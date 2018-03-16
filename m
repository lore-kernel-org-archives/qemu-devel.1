Received: from eggs.gnu.org ([2001:4830:134:3::10]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwS-0006pt-9X
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwQ-0002lG-Jc
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwQ-0002kx-E4
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F27CE8151D47
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:54:03 +0100
Message-Id: <20180316115403.4148-16-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 15/15] [RFC] migration: Send pages through
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
 migration/ram.c        | 240 ++++++++++++++++++++++++++++++++++++++++++-------
 migration/trace-events |   3 +-
 2 files changed, 211 insertions(+), 32 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0132de6e02..d8ad456eca 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -408,6 +408,16 @@ typedef struct {
     uint8_t id;
 } __attribute__((packed)) MultiFDInit_t;
 
+typedef struct {
+    uint32_t magic;
+    uint32_t version;
+    uint32_t size;
+    uint32_t used;
+    uint32_t seq;
+    char ramblock[256];
+    uint64_t offset[];
+} __attribute__((packed)) MultiFDPacket_t;
+
 typedef struct {
     /* number of used pages */
     uint32_t used;
@@ -422,7 +432,7 @@ typedef struct {
     RAMBlock *block;
 } MultiFDPages_t;
 
-struct MultiFDSendParams {
+typedef struct {
     /* not changed */
     uint8_t id;
     char *name;
@@ -440,8 +450,29 @@ struct MultiFDSendParams {
     /* protected by multifd mutex */
     /* has the thread finish the last submitted job */
     bool done;
-};
-typedef struct MultiFDSendParams MultiFDSendParams;
+    uint32_t packet_len;
+    MultiFDPacket_t *packet;
+} MultiFDSendParams;
+
+typedef struct {
+    /* not changed */
+    uint8_t id;
+    char *name;
+    QemuThread thread;
+    QIOChannel *c;
+    QemuSemaphore sem;
+    QemuMutex mutex;
+    bool running;
+    /* protected by param mutex */
+    bool quit;
+    bool sync;
+    MultiFDPages_t *pages;
+    /* how many patckets has recv this channel */
+    uint32_t packets_recv;
+    bool done;
+    uint32_t packet_len;
+    MultiFDPacket_t *packet;
+} MultiFDRecvParams;
 
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
 {
@@ -502,6 +533,80 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     return msg.id;
 }
 
+static void multifd_send_fill_packet(MultiFDSendParams *p)
+{
+    MultiFDPacket_t *packet = p->packet;
+    int i;
+
+    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
+    packet->version = cpu_to_be32(MULTIFD_VERSION);
+    packet->size = cpu_to_be32(migrate_multifd_page_count());
+    packet->used = cpu_to_be32(p->pages->used);
+    packet->seq = cpu_to_be32(p->pages->seq);
+
+    for (i = 0; i < p->pages->used; i++) {
+        packet->offset[i] = cpu_to_be64(p->pages->offset[i]);
+    }
+
+    strncpy(packet->ramblock, p->pages->block->idstr, 256);
+}
+
+static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDPacket_t *packet = p->packet;
+    RAMBlock *block;
+    int i;
+
+    be32_to_cpus(&packet->magic);
+    if (packet->magic != MULTIFD_MAGIC) {
+        error_setg(errp, "multifd: received packet "
+                   "version %d and expected version %d",
+                   packet->magic, MULTIFD_VERSION);
+        return -1;
+    }
+
+    be32_to_cpus(&packet->version);
+    if (packet->version != MULTIFD_VERSION) {
+        error_setg(errp, "multifd: received packet "
+                   "version %d and expected version %d",
+                   packet->version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    be32_to_cpus(&packet->size);
+    if (packet->size > migrate_multifd_page_count()) {
+        error_setg(errp, "multifd: received packet "
+                   "with size %d and expected maximum size %d",
+                   packet->size, migrate_multifd_page_count()) ;
+        return -1;
+    }
+
+    p->pages->used = be32_to_cpu(packet->used);
+    if (p->pages->used > packet->size) {
+        error_setg(errp, "multifd: received packet "
+                   "with size %d and expected maximum size %d",
+                   p->pages->used, packet->size) ;
+        return -1;
+    }
+
+    be32_to_cpus(&packet->seq);
+
+    block = qemu_ram_block_by_name(packet->ramblock);
+    if (!block) {
+        error_setg(errp, "multifd: unknown ram block %s",
+                   packet->ramblock);
+        return -1;
+    }
+
+    for (i = 0; i < p->pages->used; i++) {
+        ram_addr_t offset = be64_to_cpu(packet->offset[i]);
+
+        p->pages->iov[i].iov_base = block->host + offset;
+        p->pages->iov[i].iov_len = TARGET_PAGE_SIZE;
+    }
+    return 0;
+}
+
 struct {
     MultiFDSendParams *params;
     /* number of created threads */
@@ -583,6 +688,9 @@ int multifd_save_cleanup(Error **errp)
         p->name = NULL;
         multifd_pages_clear(p->pages);
         p->pages = NULL;
+        p->packet_len = 0;
+        g_free(p->packet);
+        p->packet = NULL;
     }
     qemu_sem_destroy(&multifd_send_state->sem_main);
     g_free(multifd_send_state->params);
@@ -632,12 +740,13 @@ static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
     Error *local_err = NULL;
+    int ret;
 
     trace_multifd_send_thread_start(p->id);
 
-    if (multifd_send_initial_packet(p, &local_err) < 0) {
-        multifd_send_terminate_threads(local_err);
-        return NULL;
+    ret = multifd_send_initial_packet(p, &local_err);
+    if (ret < 0) {
+        goto out;
     }
     qemu_sem_post(&multifd_send_state->sem);
 
@@ -651,17 +760,28 @@ static void *multifd_send_thread(void *opaque)
             continue;
         }
         if (p->quit) {
-            p->running = false;
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         if (p->pages->used) {
+            Error *local_err = NULL;
+            uint32_t used;
+
+            multifd_send_fill_packet(p);
+            used = p->pages->used;
             p->pages->used = 0;
             qemu_mutex_unlock(&p->mutex);
 
-            trace_multifd_send(p->id, p->pages->seq, p->pages->used);
-            /* ToDo: send page here */
-
+            ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                        p->packet_len, &local_err);
+            if (ret != 0) {
+                break;
+            }
+            trace_multifd_send(p->id, p->pages->seq, used);
+            ret = qio_channel_writev_all(p->c, p->pages->iov, used, &local_err);
+            if (ret != 0) {
+                break;
+            }
             qemu_mutex_lock(&multifd_send_state->mutex);
             p->done = true;
             p->packets_sent++;
@@ -671,6 +791,15 @@ static void *multifd_send_thread(void *opaque)
         }
         qemu_mutex_unlock(&p->mutex);
     }
+out:
+    if (ret) {
+        multifd_send_terminate_threads(local_err);
+    }
+
+    qemu_mutex_lock(&p->mutex);
+    p->running = false;
+    qemu_mutex_unlock(&p->mutex);
+
     trace_multifd_send_thread_end(p->id, p->packets_sent);
 
     return NULL;
@@ -722,6 +851,9 @@ int multifd_save_setup(void)
         p->id = i;
         p->done = true;
         multifd_pages_init(&p->pages, page_count);
+        p->packet_len = sizeof(MultiFDPacket_t)
+                      + sizeof(ram_addr_t) * page_count;
+        p->packet = g_malloc0(p->packet_len);
         p->name = g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
     }
@@ -774,25 +906,6 @@ static void multifd_send_page(RAMBlock *block, ram_addr_t offset,
     qemu_sem_post(&p->sem);
 }
 
-struct MultiFDRecvParams {
-    /* not changed */
-    uint8_t id;
-    char *name;
-    QemuThread thread;
-    QIOChannel *c;
-    QemuSemaphore sem;
-    QemuMutex mutex;
-    bool running;
-    /* protected by param mutex */
-    bool quit;
-    bool sync;
-    /* how many patckets has recv this channel */
-    uint32_t packets_recv;
-    MultiFDPages_t *pages;
-    bool done;
-};
-typedef struct MultiFDRecvParams MultiFDRecvParams;
-
 struct {
     MultiFDRecvParams *params;
     /* number of created threads */
@@ -848,6 +961,9 @@ int multifd_load_cleanup(Error **errp)
         p->name = NULL;
         multifd_pages_clear(p->pages);
         p->pages = NULL;
+        p->packet_len = 0;
+        g_free(p->packet);
+        p->packet = NULL;
     }
     qemu_sem_destroy(&multifd_recv_state->sem_main);
     g_free(multifd_recv_state->params);
@@ -892,12 +1008,34 @@ static void multifd_recv_sync_main(void)
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
@@ -907,15 +1045,51 @@ static void *multifd_recv_thread(void *opaque)
             qemu_sem_post(&multifd_recv_state->sem_main);
             continue;
         }
+        if (!p->done) {
+            Error *local_err = NULL;
+            int ret;
+
+            qemu_mutex_unlock(&p->mutex);
+
+            ret = qio_channel_read_all(p->c, (void *)p->packet,
+                                       p->packet_len, &local_err);
+            if (ret != 0) {
+                multifd_recv_terminate_threads(local_err);
+                break;
+            }
+
+            ret = multifd_recv_unfill_packet(p, &local_err);
+            if (ret < 0) {
+                multifd_recv_terminate_threads(local_err);
+                break;
+            }
+
+            trace_multifd_recv(p->id, p->pages->seq, p->pages->used);
+            ret = qio_channel_readv_all(p->c, p->pages->iov,
+                                        p->pages->used, &local_err);
+            if (ret != 0) {
+                multifd_recv_terminate_threads(local_err);
+                break;
+            }
+            qemu_mutex_lock(&p->mutex);
+            p->done = true;
+            p->packets_recv++;
+            qemu_mutex_unlock(&p->mutex);
+
+            continue;
+        }
         if (p->quit) {
-            p->running = false;
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
     }
 
-    trace_multifd_recv_thread_end(p->id);
+    qemu_mutex_lock(&p->mutex);
+    p->running = false;
+    qemu_mutex_unlock(&p->mutex);
+
+    trace_multifd_recv_thread_end(p->id, p->packets_recv);
     return NULL;
 }
 
@@ -940,9 +1114,13 @@ int multifd_load_setup(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
+        p->done = true;
         p->id = i;
         p->name = g_strdup_printf("multifdrecv_%d", i);
         multifd_pages_init(&p->pages, page_count);
+        p->packet_len = sizeof(MultiFDPacket_t)
+                      + sizeof(ram_addr_t) * page_count;
+        p->packet = g_malloc0(p->packet_len);
     }
     return 0;
 }
diff --git a/migration/trace-events b/migration/trace-events
index 06a9ead811..a6c1c4b20c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -86,8 +86,9 @@ multifd_recv_sync_wait(uint8_t id, bool quit, bool running) "channel %d quit %d
 multifd_send_thread_start(uint8_t id) "%d"
 multifd_send_thread_end(uint8_t id, uint32_t packets) "channel %d packets %d"
 multifd_recv_thread_start(uint8_t id) "%d"
-multifd_recv_thread_end(uint8_t id) "%d"
+multifd_recv_thread_end(uint8_t id, uint32_t packets) "channel %d packets %d"
 multifd_send(uint8_t id, int seq, int num) "channel %d sequence %d num pages %d"
+multifd_recv(uint8_t id, int seq, int num) "channel %d sequence %d num pages %d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
