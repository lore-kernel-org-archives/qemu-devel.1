Received: from eggs.gnu.org ([2001:4830:134:3::10]:59218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwQ-0006nI-1Z
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwP-0002jT-8Z
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwP-0002jJ-45
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A56964023156
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:54:02 +0100
Message-Id: <20180316115403.4148-15-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 14/15] migration: Create pages structure
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
 migration/ram.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 9919777a21..0132de6e02 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -775,6 +775,7 @@ static void multifd_send_page(RAMBlock *block, ram_addr_t offset,
 }
 
 struct MultiFDRecvParams {
+    /* not changed */
     uint8_t id;
     char *name;
     QemuThread thread;
@@ -782,8 +783,13 @@ struct MultiFDRecvParams {
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
+    /* protected by param mutex */
     bool quit;
     bool sync;
+    /* how many patckets has recv this channel */
+    uint32_t packets_recv;
+    MultiFDPages_t *pages;
+    bool done;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
 
@@ -840,6 +846,8 @@ int multifd_load_cleanup(Error **errp)
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
         p->name = NULL;
+        multifd_pages_clear(p->pages);
+        p->pages = NULL;
     }
     qemu_sem_destroy(&multifd_recv_state->sem_main);
     g_free(multifd_recv_state->params);
@@ -914,6 +922,7 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_load_setup(void)
 {
     int thread_count;
+    uint32_t page_count = migrate_multifd_page_count();
     uint8_t i;
 
     if (!migrate_use_multifd()) {
@@ -924,6 +933,7 @@ int multifd_load_setup(void)
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     atomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_main, 0);
+
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -932,6 +942,7 @@ int multifd_load_setup(void)
         p->quit = false;
         p->id = i;
         p->name = g_strdup_printf("multifdrecv_%d", i);
+        multifd_pages_init(&p->pages, page_count);
     }
     return 0;
 }
-- 
2.14.3
