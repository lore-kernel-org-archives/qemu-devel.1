Received: from eggs.gnu.org ([2001:4830:134:3::10]:50836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRml-0006E8-43
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRmk-0007Bq-4d
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fLRmj-0007Bk-Vk
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CBF4195478
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 11:18:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 23 May 2018 13:18:08 +0200
Message-Id: <20180523111817.1463-4-quintela@redhat.com>
In-Reply-To: <20180523111817.1463-1-quintela@redhat.com>
References: <20180523111817.1463-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v13 03/12] migration: Add multifd traces for
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
--
sort trace-events (dave)
---
 migration/ram.c        | 22 ++++++++++++++++++++++
 migration/trace-events |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 54350db8b0..ab715cc148 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -563,6 +563,11 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint32_t seq;
+    /* thread local variables */
+    /* packets sent through this channel */
+    uint32_t num_packets;
+    /* pages sent through this channel */
+    uint32_t num_pages;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -593,6 +598,11 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint32_t seq;
+    /* thread local variables */
+    /* packets sent through this channel */
+    uint32_t num_packets;
+    /* pages sent through this channel */
+    uint32_t num_pages;
 } MultiFDRecvParams;
 
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
@@ -849,9 +859,13 @@ static void *multifd_send_thread(void *opaque)
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
@@ -873,6 +887,8 @@ out:
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
 
+    trace_multifd_send_thread_end(p->id, p->num_packets, p->num_pages);
+
     return NULL;
 }
 
@@ -1000,6 +1016,8 @@ static void *multifd_recv_thread(void *opaque)
     Error *local_err = NULL;
     int ret;
 
+    trace_multifd_recv_thread_start(p->id);
+
     while (true) {
         qemu_mutex_lock(&p->mutex);
         if (false)  {
@@ -1022,6 +1040,8 @@ static void *multifd_recv_thread(void *opaque)
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
 
+    trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);
+
     return NULL;
 }
 
@@ -1087,6 +1107,8 @@ void multifd_recv_new_channel(QIOChannel *ioc)
     }
     p->c = ioc;
     object_ref(OBJECT(ioc));
+    /* initial packet */
+    p->num_packets = 1;
 
     p->running = true;
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
diff --git a/migration/trace-events b/migration/trace-events
index 3c798ddd11..3c7a9a8332 100644
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
2.17.0
