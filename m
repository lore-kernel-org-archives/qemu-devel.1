Received: from eggs.gnu.org ([2001:4830:134:3::10]:34319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaR-0002wk-OJ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaQ-0005CS-Jc
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45568 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIaQ-0005Bo-E6
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1628A402314E
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:27:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:27:17 +0200
Message-Id: <20180425112723.1111-16-quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
References: <20180425112723.1111-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v12 15/21] migration: Add block where to
 send/receive packets
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

Once there add tracepoints.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 49 +++++++++++++++++++++++++++++++++++++-----
 migration/trace-events |  2 ++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 21b448c4ed..c4c185cc4c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -455,6 +455,8 @@ typedef struct {
     bool running;
     /* should this thread finish */
     bool quit;
+    /* thread has work to do */
+    int pending_job;
     /* array of pages to sent */
     MultiFDPages_t *pages;
     /* packet allocated len */
@@ -489,6 +491,8 @@ typedef struct {
     bool running;
     /* should this thread finish */
     bool quit;
+    /* thread has work to do */
+    bool pending_job;
     /* array of pages to receive */
     MultiFDPages_t *pages;
     /* packet allocated len */
@@ -756,8 +760,28 @@ static void *multifd_send_thread(void *opaque)
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
-        multifd_send_fill_packet(p);
-        if (p->quit) {
+
+        if (p->pending_job) {
+            uint32_t used = p->pages->used;
+            uint32_t seq = p->seq;
+            uint32_t flags = p->flags;
+
+            multifd_send_fill_packet(p);
+            p->flags = 0;
+            p->num_packets++;
+            p->num_pages += used;
+            p->pages->used = 0;
+            qemu_mutex_unlock(&p->mutex);
+
+            trace_multifd_send(p->id, seq, used, flags);
+
+            /* ToDo: send packet here */
+
+            qemu_mutex_lock(&p->mutex);
+            p->pending_job--;
+            qemu_mutex_unlock(&p->mutex);
+            continue;
+        } else if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
         }
@@ -823,6 +847,7 @@ int multifd_save_setup(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
+        p->pending_job = 0;
         p->id = i;
         multifd_pages_init(&p->pages, page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
@@ -910,14 +935,27 @@ static void *multifd_recv_thread(void *opaque)
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
-        if (false)  {
-            /* ToDo: Packet reception goes here */
+        if (p->pending_job) {
+            uint32_t used;
+            uint32_t flags;
+            qemu_mutex_unlock(&p->mutex);
 
+            /* ToDo: recv packet here */
+
+            qemu_mutex_lock(&p->mutex);
             ret = multifd_recv_unfill_packet(p, &local_err);
-            qemu_mutex_unlock(&p->mutex);
             if (ret) {
+                qemu_mutex_unlock(&p->mutex);
                 break;
             }
+
+            used = p->pages->used;
+            flags = p->flags;
+            trace_multifd_recv(p->id, p->seq, used, flags);
+            p->pending_job = false;
+            p->num_packets++;
+            p->num_pages += used;
+            qemu_mutex_unlock(&p->mutex);
         } else if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
@@ -960,6 +998,7 @@ int multifd_load_setup(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
+        p->pending_job = false;
         p->id = i;
         multifd_pages_init(&p->pages, page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
diff --git a/migration/trace-events b/migration/trace-events
index e480eb050e..9eee048287 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -81,6 +81,8 @@ multifd_send_thread_start(uint8_t id) "%d"
 multifd_send_thread_end(uint8_t id, uint32_t packets, uint32_t pages) "channel %d packets %d pages %d"
 multifd_recv_thread_start(uint8_t id) "%d"
 multifd_recv_thread_end(uint8_t id, uint32_t packets, uint32_t pages) "channel %d packets %d pages %d"
+multifd_send(uint8_t id, uint32_t seq, uint32_t used, uint32_t flags) "channel %d seq number %d pages %d flags 0x%x"
+multifd_recv(uint8_t id, uint32_t seq, uint32_t used, uint32_t flags) "channel %d seq number %d pages %d flags 0x%x"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.17.0
