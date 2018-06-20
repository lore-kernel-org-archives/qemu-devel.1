Received: from eggs.gnu.org ([2001:4830:134:3::10]:58493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVYH8-0003tr-Ro
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVYH7-0001Fn-7D
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVYH7-0001Fe-1N
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAF7A401EF00
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 08:15:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Jun 2018 10:15:14 +0200
Message-Id: <20180620081524.5751-3-quintela@redhat.com>
In-Reply-To: <20180620081524.5751-1-quintela@redhat.com>
References: <20180620081524.5751-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v14 02/12] migration: Create multifd packet
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

We still don't put anything there.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>

--
fix magic (dave)
check offset/ramblock  (dave)
s/seq/packet_num/ and make it 64bit
---
 migration/ram.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index ed4401ee46..6504b492da 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -517,6 +517,17 @@ typedef struct {
     uint8_t id;
 } __attribute__((packed)) MultiFDInit_t;
 
+typedef struct {
+    uint32_t magic;
+    uint32_t version;
+    uint32_t flags;
+    uint32_t size;
+    uint32_t used;
+    uint64_t packet_num;
+    char ramblock[256];
+    uint64_t offset[];
+} __attribute__((packed)) MultiFDPacket_t;
+
 typedef struct {
     /* number of used pages */
     uint32_t used;
@@ -551,6 +562,14 @@ typedef struct {
     bool quit;
     /* array of pages to sent */
     MultiFDPages_t *pages;
+    /* packet allocated len */
+    uint32_t packet_len;
+    /* pointer to the packet */
+    MultiFDPacket_t *packet;
+    /* multifd flags for each packet */
+    uint32_t flags;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -573,6 +592,14 @@ typedef struct {
     bool quit;
     /* array of pages to receive */
     MultiFDPages_t *pages;
+    /* packet allocated len */
+    uint32_t packet_len;
+    /* pointer to the packet */
+    MultiFDPacket_t *packet;
+    /* multifd flags for each packet */
+    uint32_t flags;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
 } MultiFDRecvParams;
 
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
@@ -661,6 +688,99 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
     g_free(pages);
 }
 
+static void multifd_send_fill_packet(MultiFDSendParams *p)
+{
+    MultiFDPacket_t *packet = p->packet;
+    int i;
+
+    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
+    packet->version = cpu_to_be32(MULTIFD_VERSION);
+    packet->flags = cpu_to_be32(p->flags);
+    packet->size = cpu_to_be32(migrate_multifd_page_count());
+    packet->used = cpu_to_be32(p->pages->used);
+    packet->packet_num = cpu_to_be64(p->packet_num);
+
+    if (p->pages->block) {
+        strncpy(packet->ramblock, p->pages->block->idstr, 256);
+    }
+
+    for (i = 0; i < p->pages->used; i++) {
+        packet->offset[i] = cpu_to_be64(p->pages->offset[i]);
+    }
+}
+
+static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDPacket_t *packet = p->packet;
+    RAMBlock *block;
+    int i;
+
+    /* ToDo: We can't use it until we haven't received a message */
+    return 0;
+
+    be32_to_cpus(&packet->magic);
+    if (packet->magic != MULTIFD_MAGIC) {
+        error_setg(errp, "multifd: received packet "
+                   "magic %x and expected magic %x",
+                   packet->magic, MULTIFD_MAGIC);
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
+    p->flags = be32_to_cpu(packet->flags);
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
+    p->packet_num = be64_to_cpu(packet->packet_num);
+
+    if (p->pages->used) {
+        /* make sure that ramblock is 0 terminated */
+        packet->ramblock[255] = 0;
+        block = qemu_ram_block_by_name(packet->ramblock);
+        if (!block) {
+            error_setg(errp, "multifd: unknown ram block %s",
+                       packet->ramblock);
+            return -1;
+        }
+    }
+
+    for (i = 0; i < p->pages->used; i++) {
+        ram_addr_t offset = be64_to_cpu(packet->offset[i]);
+
+        if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
+            error_setg(errp, "multifd: offset too long %" PRId64
+                       " (max %" PRId64 ")",
+                       offset, block->max_length);
+            return -1;
+        }
+        p->pages->iov[i].iov_base = block->host + offset;
+        p->pages->iov[i].iov_len = TARGET_PAGE_SIZE;
+    }
+
+    return 0;
+}
+
 struct {
     MultiFDSendParams *params;
     /* number of created threads */
@@ -718,6 +838,9 @@ int multifd_save_cleanup(Error **errp)
         p->name = NULL;
         multifd_pages_clear(p->pages);
         p->pages = NULL;
+        p->packet_len = 0;
+        g_free(p->packet);
+        p->packet = NULL;
     }
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
@@ -739,6 +862,7 @@ static void *multifd_send_thread(void *opaque)
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
+        multifd_send_fill_packet(p);
         if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
@@ -803,6 +927,9 @@ int multifd_save_setup(void)
         p->quit = false;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
+        p->packet_len = sizeof(MultiFDPacket_t)
+                      + sizeof(ram_addr_t) * page_count;
+        p->packet = g_malloc0(p->packet_len);
         p->name = g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
     }
@@ -862,6 +989,9 @@ int multifd_load_cleanup(Error **errp)
         p->name = NULL;
         multifd_pages_clear(p->pages);
         p->pages = NULL;
+        p->packet_len = 0;
+        g_free(p->packet);
+        p->packet = NULL;
     }
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
@@ -874,10 +1004,20 @@ int multifd_load_cleanup(Error **errp)
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
+    Error *local_err = NULL;
+    int ret;
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
-        if (p->quit) {
+        if (false)  {
+            /* ToDo: Packet reception goes here */
+
+            ret = multifd_recv_unfill_packet(p, &local_err);
+            qemu_mutex_unlock(&p->mutex);
+            if (ret) {
+                break;
+            }
+        } else if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
         }
@@ -914,6 +1054,9 @@ int multifd_load_setup(void)
         p->quit = false;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
+        p->packet_len = sizeof(MultiFDPacket_t)
+                      + sizeof(ram_addr_t) * page_count;
+        p->packet = g_malloc0(p->packet_len);
         p->name = g_strdup_printf("multifdrecv_%d", i);
     }
     return 0;
-- 
2.17.1
