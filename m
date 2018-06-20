Received: from eggs.gnu.org ([2001:4830:134:3::10]:48379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVmX9-0001a4-KT
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVmX8-0007Cb-Kv
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVmX8-0007CL-G5
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C2B1401EF03
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:29:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 21 Jun 2018 01:28:42 +0200
Message-Id: <20180620232851.7152-4-quintela@redhat.com>
In-Reply-To: <20180620232851.7152-1-quintela@redhat.com>
References: <20180620232851.7152-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v15 03/12] migration: Add multifd traces for
 start/end thread
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

We want to know how many pages/packets each channel has sent.  Add
counters for those.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
--
sort trace-events (dave)
---
 migration/ram.c        | 22 ++++++++++++++++++++++
 migration/trace-events |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 6504b492da..d146689d3a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -570,6 +570,11 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    /* thread local variables */
+    /* packets sent through this channel */
+    uint32_t num_packets;
+    /* pages sent through this channel */
+    uint32_t num_pages;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -600,6 +605,11 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    /* thread local variables */
+    /* packets sent through this channel */
+    uint32_t num_packets;
+    /* pages sent through this channel */
+    uint32_t num_pages;
 } MultiFDRecvParams;
 
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
@@ -856,9 +866,13 @@ static void *multifd_send_thread(void *opaque)
     MultiFDSendParams *p = opaque;
     Error *local_err = NULL;
 
+    trace_multifd_send_thread_start(p->id);
+
     if (multifd_send_initial_packet(p, &local_err) < 0) {
         goto out;
     }
+    /* initial packet */
+    p->num_packets = 1;
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -880,6 +894,8 @@ out:
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
 
+    trace_multifd_send_thread_end(p->id, p->num_packets, p->num_pages);
+
     return NULL;
 }
 
@@ -1007,6 +1023,8 @@ static void *multifd_recv_thread(void *opaque)
     Error *local_err = NULL;
     int ret;
 
+    trace_multifd_recv_thread_start(p->id);
+
     while (true) {
         qemu_mutex_lock(&p->mutex);
         if (false)  {
@@ -1029,6 +1047,8 @@ static void *multifd_recv_thread(void *opaque)
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
 
+    trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);
+
     return NULL;
 }
 
@@ -1094,6 +1114,8 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     }
     p->c = ioc;
     object_ref(OBJECT(ioc));
+    /* initial packet */
+    p->num_packets = 1;
 
     p->running = true;
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
diff --git a/migration/trace-events b/migration/trace-events
index 3f67758893..6d499448b3 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -76,6 +76,10 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
+multifd_recv_thread_end(uint8_t id, uint32_t packets, uint32_t pages) "channel %d packets %d pages %d"
+multifd_recv_thread_start(uint8_t id) "%d"
+multifd_send_thread_end(uint8_t id, uint32_t packets, uint32_t pages) "channel %d packets %d pages %d"
+multifd_send_thread_start(uint8_t id) "%d"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
 ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
-- 
2.17.1
