Received: from eggs.gnu.org ([2001:4830:134:3::10]:49071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zt-0001GB-5v
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zs-0001dd-6s
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY9zs-0001cn-2K
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E39540770E7
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:56:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 27 Jun 2018 14:55:59 +0200
Message-Id: <20180627125604.15275-12-quintela@redhat.com>
In-Reply-To: <20180627125604.15275-1-quintela@redhat.com>
References: <20180627125604.15275-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 11/16] migration: Start sending messages
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 050e2f2000..b9c8f65059 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -736,9 +736,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     RAMBlock *block;
     int i;
 
-    /* ToDo: We can't use it until we haven't received a message */
-    return 0;
-
     be32_to_cpus(&packet->magic);
     if (packet->magic != MULTIFD_MAGIC) {
         error_setg(errp, "multifd: received packet "
@@ -994,6 +991,7 @@ static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
     Error *local_err = NULL;
+    int ret;
 
     trace_multifd_send_thread_start(p->id);
 
@@ -1021,7 +1019,16 @@ static void *multifd_send_thread(void *opaque)
 
             trace_multifd_send(p->id, packet_num, used, flags);
 
-            /* ToDo: send packet here */
+            ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                        p->packet_len, &local_err);
+            if (ret != 0) {
+                break;
+            }
+
+            ret = qio_channel_writev_all(p->c, p->pages->iov, used, &local_err);
+            if (ret != 0) {
+                break;
+            }
 
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
@@ -1230,7 +1237,14 @@ static void *multifd_recv_thread(void *opaque)
         uint32_t used;
         uint32_t flags;
 
-        /* ToDo: recv packet here */
+        ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
+                                       p->packet_len, &local_err);
+        if (ret == 0) {   /* EOF */
+            break;
+        }
+        if (ret == -1) {   /* Error */
+            break;
+        }
 
         qemu_mutex_lock(&p->mutex);
         ret = multifd_recv_unfill_packet(p, &local_err);
@@ -1247,6 +1261,11 @@ static void *multifd_recv_thread(void *opaque)
         p->num_pages += used;
         qemu_mutex_unlock(&p->mutex);
 
+        ret = qio_channel_readv_all(p->c, p->pages->iov, used, &local_err);
+        if (ret != 0) {
+            break;
+        }
+
         if (flags & MULTIFD_FLAG_SYNC) {
             qemu_sem_post(&multifd_recv_state->sem_sync);
             qemu_sem_wait(&p->sem_sync);
-- 
2.17.1
