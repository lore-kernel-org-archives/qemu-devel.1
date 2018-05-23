Received: from eggs.gnu.org ([2001:4830:134:3::10]:50979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRmv-0006OU-Hy
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRmu-0007Fy-NW
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fLRmu-0007Fl-JS
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:18:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E2AB195478
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 11:18:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 23 May 2018 13:18:16 +0200
Message-Id: <20180523111817.1463-12-quintela@redhat.com>
In-Reply-To: <20180523111817.1463-1-quintela@redhat.com>
References: <20180523111817.1463-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v13 11/12] migration: Remove not needed
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
---
 migration/ram.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a707d3ae80..62eea9e02f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -587,14 +587,10 @@ typedef struct {
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
@@ -1115,8 +1111,8 @@ static void multifd_recv_terminate_threads(Error *err)
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         qemu_mutex_lock(&p->mutex);
-        p->quit = true;
-        qemu_sem_post(&p->sem);
+        object_unref(OBJECT(p->c));
+        p->c = NULL;
         qemu_mutex_unlock(&p->mutex);
     }
 }
@@ -1139,7 +1135,6 @@ int multifd_load_cleanup(Error **errp)
         object_unref(OBJECT(p->c));
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
-        qemu_sem_destroy(&p->sem);
         qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
         p->name = NULL;
@@ -1262,9 +1257,7 @@ int multifd_load_setup(void)
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         qemu_mutex_init(&p->mutex);
-        qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
-        p->quit = false;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
-- 
2.17.0
