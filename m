Received: from eggs.gnu.org ([2001:4830:134:3::10]:48940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zl-00018S-B3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zk-0001ZE-D4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY9zk-0001Z6-7z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAB26805A530
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:56:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 27 Jun 2018 14:55:53 +0200
Message-Id: <20180627125604.15275-6-quintela@redhat.com>
In-Reply-To: <20180627125604.15275-1-quintela@redhat.com>
References: <20180627125604.15275-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 05/16] migration: Add multifd traces for
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--
sort trace-events (dave)
---
 migration/ram.c        | 22 ++++++++++++++++++++++
 migration/trace-events |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index fd144fdf9a..5c040e3ae5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -570,6 +570,11 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    /* thread local variables */
+    /* packets sent through this channel */
+    uint64_t num_packets;
+    /* pages sent through this channel */
+    uint64_t num_pages;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -600,6 +605,11 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    /* thread local variables */
+    /* packets sent through this channel */
+    uint64_t num_packets;
+    /* pages sent through this channel */
+    uint64_t num_pages;
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
index 3f67758893..a80aaa8b3f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -76,6 +76,10 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
+multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %" PRIu64
+multifd_recv_thread_start(uint8_t id) "%d"
+multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %"  PRIu64
+multifd_send_thread_start(uint8_t id) "%d"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
 ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
-- 
2.17.1
