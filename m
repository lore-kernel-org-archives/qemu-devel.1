Received: from eggs.gnu.org ([2001:4830:134:3::10]:34242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaM-0002rX-Q9
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaK-00051h-2q
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIaJ-000512-Uk
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B9C081A88D2
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:27:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:27:12 +0200
Message-Id: <20180425112723.1111-11-quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
References: <20180425112723.1111-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v12 10/21] migration: Create multipage support
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

We only create/destry the page list here.  We will use it later.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index ffefa73099..b19300992e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -412,6 +412,20 @@ typedef struct {
     uint8_t id;
 } __attribute__((packed)) MultiFDInit_t;
 
+typedef struct {
+    /* number of used pages */
+    uint32_t used;
+    /* number of allocated pages */
+    uint32_t allocated;
+    /* global number of generated multifd packets */
+    uint32_t seq;
+    /* offset of each page */
+    ram_addr_t *offset;
+    /* pointer to each page */
+    struct iovec *iov;
+    RAMBlock *block;
+} MultiFDPages_t;
+
 typedef struct {
     /* this fields are not changed once the thread is created */
     /* channel number */
@@ -430,6 +444,8 @@ typedef struct {
     bool running;
     /* should this thread finish */
     bool quit;
+    /* array of pages to sent */
+    MultiFDPages_t *pages;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -450,6 +466,8 @@ typedef struct {
     bool running;
     /* should this thread finish */
     bool quit;
+    /* array of pages to receive */
+    MultiFDPages_t *pages;
 } MultiFDRecvParams;
 
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
@@ -511,10 +529,35 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     return msg.id;
 }
 
+static void multifd_pages_init(MultiFDPages_t **ppages, size_t size)
+{
+    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
+
+    pages->allocated = size;
+    pages->iov = g_new0(struct iovec, size);
+    pages->offset = g_new0(ram_addr_t, size);
+    *ppages = pages;
+}
+
+static void multifd_pages_clear(MultiFDPages_t *pages)
+{
+    pages->used = 0;
+    pages->allocated = 0;
+    pages->seq = 0;
+    pages->block = NULL;
+    g_free(pages->iov);
+    pages->iov = NULL;
+    g_free(pages->offset);
+    pages->offset = NULL;
+    g_free(pages);
+}
+
 struct {
     MultiFDSendParams *params;
     /* number of created threads */
     int count;
+    /* array of pages to sent */
+    MultiFDPages_t *pages;
 } *multifd_send_state;
 
 static void multifd_send_terminate_threads(Error *err)
@@ -562,9 +605,13 @@ int multifd_save_cleanup(Error **errp)
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
         p->name = NULL;
+        multifd_pages_clear(p->pages);
+        p->pages = NULL;
     }
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
+    multifd_pages_clear(multifd_send_state->pages);
+    multifd_send_state->pages = NULL;
     g_free(multifd_send_state);
     multifd_send_state = NULL;
     return ret;
@@ -625,6 +672,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 int multifd_save_setup(void)
 {
     int thread_count;
+    uint32_t page_count = migrate_multifd_page_count();
     uint8_t i;
 
     if (!migrate_use_multifd()) {
@@ -634,6 +682,8 @@ int multifd_save_setup(void)
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     atomic_set(&multifd_send_state->count, 0);
+    multifd_pages_init(&multifd_send_state->pages, page_count);
+
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -641,6 +691,7 @@ int multifd_save_setup(void)
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
         p->id = i;
+        multifd_pages_init(&p->pages, page_count);
         p->name = g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
     }
@@ -698,6 +749,8 @@ int multifd_load_cleanup(Error **errp)
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
         p->name = NULL;
+        multifd_pages_clear(p->pages);
+        p->pages = NULL;
     }
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
@@ -731,6 +784,7 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_load_setup(void)
 {
     int thread_count;
+    uint32_t page_count = migrate_multifd_page_count();
     uint8_t i;
 
     if (!migrate_use_multifd()) {
@@ -740,6 +794,7 @@ int multifd_load_setup(void)
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     atomic_set(&multifd_recv_state->count, 0);
+
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -747,6 +802,7 @@ int multifd_load_setup(void)
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
         p->id = i;
+        multifd_pages_init(&p->pages, page_count);
         p->name = g_strdup_printf("multifdrecv_%d", i);
     }
     return 0;
-- 
2.17.0
