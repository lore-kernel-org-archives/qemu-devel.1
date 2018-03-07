Received: from eggs.gnu.org ([2001:4830:134:3::10]:59858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoV-00057z-Mp
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoU-0006O3-PV
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoU-0006Nn-Kt
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 298F2404084A
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 12:00:09 +0100
Message-Id: <20180307110010.2205-24-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 23/24] migration: Create pages structure
 for reception
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
---
 migration/ram.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index df9646ed2e..264d2e462a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -698,6 +698,7 @@ static void multifd_send_page(RAMBlock *block, ram_addr_t offset,
 }
 
 struct MultiFDRecvParams {
+    /* not changed */
     uint8_t id;
     char *name;
     QemuThread thread;
@@ -705,8 +706,13 @@ struct MultiFDRecvParams {
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
+    /* protected by param mutex */
     bool quit;
     bool sync;
+    /* how many patckets has recv this channel */
+    uint32_t packets_recv;
+    multifd_pages_t *pages;
+    bool done;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
 
@@ -716,6 +722,7 @@ struct {
     int count;
     /* syncs main thread and channels */
     QemuSemaphore sem_main;
+    multifd_pages_t *pages;
 } *multifd_recv_state;
 
 static void terminate_multifd_recv_threads(Error *errp)
@@ -764,10 +771,14 @@ int multifd_load_cleanup(Error **errp)
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
         p->name = NULL;
+        multifd_pages_clear(p->pages);
+        p->pages = NULL;
     }
     qemu_sem_destroy(&multifd_recv_state->sem_main);
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
+    multifd_pages_clear(multifd_recv_state->pages);
+    multifd_recv_state->pages = NULL;
     g_free(multifd_recv_state);
     multifd_recv_state = NULL;
 
@@ -834,6 +845,9 @@ int multifd_load_setup(void)
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     atomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_main, 0);
+    multifd_pages_init(&multifd_recv_state->pages,
+                       migrate_multifd_page_count());
+
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -842,6 +856,7 @@ int multifd_load_setup(void)
         p->quit = false;
         p->id = i;
         p->name = g_strdup_printf("multifdrecv_%d", i);
+        multifd_pages_init(&p->pages, migrate_multifd_page_count());
     }
 
     return 0;
-- 
2.14.3
