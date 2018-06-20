Received: from eggs.gnu.org ([2001:4830:134:3::10]:58626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVYHL-00043u-6m
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVYHK-0001Lt-7L
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVYHK-0001Li-2g
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC725401EF0D
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 08:15:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Jun 2018 10:15:23 +0200
Message-Id: <20180620081524.5751-12-quintela@redhat.com>
In-Reply-To: <20180620081524.5751-1-quintela@redhat.com>
References: <20180620081524.5751-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v14 11/12] migration: Remove not needed
 semaphore and quit
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

We know quit closing the QIO.

Signed-off-by: Juan Quintela <quintela@redhat.com>
--
Add comment
don't object_ref() twice.
---
 migration/ram.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2c3a452a7d..57d3ad1c45 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -594,14 +594,10 @@ typedef struct {
     QemuThread thread;
     /* communication channel */
     QIOChannel *c;
-    /* sem where to wait for more work */
-    QemuSemaphore sem;
     /* this mutex protects the following parameters */
     QemuMutex mutex;
     /* is this channel thread running */
     bool running;
-    /* should this thread finish */
-    bool quit;
     /* array of pages to receive */
     MultiFDPages_t *pages;
     /* packet allocated len */
@@ -1152,8 +1148,12 @@ static void multifd_recv_terminate_threads(Error *err)
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         qemu_mutex_lock(&p->mutex);
-        p->quit = true;
-        qemu_sem_post(&p->sem);
+        /* We could arrive here for two reasons:
+           - normal quit, i.e. everything went fine, just finished
+           - error quit: We close the channels so the channel threads
+             finish the qio_channel_read_all_eof() */
+        object_unref(OBJECT(p->c));
+        p->c = NULL;
         qemu_mutex_unlock(&p->mutex);
     }
 }
@@ -1173,10 +1173,7 @@ int multifd_load_cleanup(Error **errp)
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
-        object_unref(OBJECT(p->c));
-        p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
-        qemu_sem_destroy(&p->sem);
         qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
         p->name = NULL;
@@ -1299,9 +1296,7 @@ int multifd_load_setup(void)
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         qemu_mutex_init(&p->mutex);
-        qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
-        p->quit = false;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
-- 
2.17.1
