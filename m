Received: from eggs.gnu.org ([2001:4830:134:3::10]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVYHJ-00042k-TL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVYHI-0001LI-SF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51880 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVYHI-0001L8-N1
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CC7E8780F
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 08:15:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Jun 2018 10:15:22 +0200
Message-Id: <20180620081524.5751-11-quintela@redhat.com>
In-Reply-To: <20180620081524.5751-1-quintela@redhat.com>
References: <20180620081524.5751-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v14 10/12] migration: Wait for blocking IO
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

We have three conditions here:
- channel fails -> error
- we have to quit: we close the channel and reads fails
- normal read that success, we are in bussiness

So forget the complications of waiting in a semaphore.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 09df573441..2c3a452a7d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -602,8 +602,6 @@ typedef struct {
     bool running;
     /* should this thread finish */
     bool quit;
-    /* thread has work to do */
-    bool pending_job;
     /* array of pages to receive */
     MultiFDPages_t *pages;
     /* packet allocated len */
@@ -1207,14 +1205,6 @@ static void multifd_recv_sync_main(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        trace_multifd_recv_sync_main_signal(p->id);
-        qemu_mutex_lock(&p->mutex);
-        p->pending_job = true;
-        qemu_mutex_unlock(&p->mutex);
-    }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p = &multifd_recv_state->params[i];
-
         trace_multifd_recv_sync_main_wait(p->id);
         qemu_sem_wait(&multifd_recv_state->sem_sync);
         qemu_mutex_lock(&p->mutex);
@@ -1227,7 +1217,6 @@ static void multifd_recv_sync_main(void)
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         trace_multifd_recv_sync_main_signal(p->id);
-
         qemu_sem_post(&p->sem_sync);
     }
     trace_multifd_recv_sync_main(atomic_read(&multifd_recv_state->packet_num));
@@ -1264,7 +1253,6 @@ static void *multifd_recv_thread(void *opaque)
         used = p->pages->used;
         flags = p->flags;
         trace_multifd_recv(p->id, p->packet_num, used, flags);
-        p->pending_job = false;
         p->num_packets++;
         p->num_pages += used;
         qemu_mutex_unlock(&p->mutex);
@@ -1314,7 +1302,6 @@ int multifd_load_setup(void)
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->quit = false;
-        p->pending_job = false;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
-- 
2.17.1
