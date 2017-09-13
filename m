Received: from eggs.gnu.org ([2001:4830:134:3::10]:42350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5PN-0006UK-BO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5PM-0006yY-4o
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds5PL-0006xr-PK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C56137EBDC
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:00:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 13 Sep 2017 12:59:47 +0200
Message-Id: <20170913105953.13760-15-quintela@redhat.com>
In-Reply-To: <20170913105953.13760-1-quintela@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v8 14/20] migration: Really use multiple pages
 at a time
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

We now send several pages at a time each time that we wakeup a thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Use iovec's instead of creating the equivalent.
Clear memory used by pages (dave)
Use g_new0(danp)
define MULTIFD_CONTINUE
---
 migration/ram.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1381bfaf8a..179b45eea7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -49,6 +49,7 @@
 #include "migration/colo.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
+#include "qemu/iov.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -362,6 +363,15 @@ static void compress_threads_save_setup(void)
 
 /* Multiple fd's */
 
+/* used to continue on the same multifd group */
+#define MULTIFD_CONTINUE UINT16_MAX
+
+typedef struct {
+    int num;
+    size_t size;
+    struct iovec *iov;
+} multifd_pages_t;
+
 struct MultiFDSendParams {
     /* not changed */
     uint8_t id;
@@ -372,11 +382,7 @@ struct MultiFDSendParams {
     QemuMutex mutex;
     /* protected by param mutex */
     bool quit;
-    /* This is a temp field.  We are using it now to transmit
-       something the address of the page.  Later in the series, we
-       change it for the real page.
-    */
-    uint8_t *address;
+    multifd_pages_t pages;
     /* protected by multifd mutex */
     /* has the thread finish the last submitted job */
     bool done;
@@ -389,8 +395,24 @@ struct {
     int count;
     QemuMutex mutex;
     QemuSemaphore sem;
+    multifd_pages_t pages;
 } *multifd_send_state;
 
+static void multifd_init_pages(multifd_pages_t *pages)
+{
+    pages->num = 0;
+    pages->size = migrate_multifd_page_count();
+    pages->iov = g_new0(struct iovec, pages->size);
+}
+
+static void multifd_clear_pages(multifd_pages_t *pages)
+{
+    pages->num = 0;
+    pages->size = 0;
+    g_free(pages->iov);
+    pages->iov = NULL;
+}
+
 static void terminate_multifd_send_threads(Error *errp)
 {
     int i;
@@ -429,9 +451,11 @@ int multifd_save_cleanup(Error **errp)
         socket_send_channel_destroy(p->c);
         g_free(p->name);
         p->name = NULL;
+        multifd_clear_pages(&p->pages);
     }
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
+    multifd_clear_pages(&multifd_send_state->pages);
     g_free(multifd_send_state);
     multifd_send_state = NULL;
     return ret;
@@ -471,8 +495,8 @@ static void *multifd_send_thread(void *opaque)
             qemu_mutex_unlock(&p->mutex);
             break;
         }
-        if (p->address) {
-            p->address = 0;
+        if (p->pages.num) {
+            p->pages.num = 0;
             qemu_mutex_unlock(&p->mutex);
             qemu_mutex_lock(&multifd_send_state->mutex);
             p->done = true;
@@ -522,6 +546,7 @@ int multifd_save_setup(void)
     multifd_send_state->count = 0;
     qemu_mutex_init(&multifd_send_state->mutex);
     qemu_sem_init(&multifd_send_state->sem, 0);
+    multifd_init_pages(&multifd_send_state->pages);
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -530,7 +555,7 @@ int multifd_save_setup(void)
         p->quit = false;
         p->id = i;
         p->done = true;
-        p->address = 0;
+        multifd_init_pages(&p->pages);
         p->name = g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_channel_async, p);
     }
@@ -541,6 +566,17 @@ static uint16_t multifd_send_page(uint8_t *address, bool last_page)
 {
     int i;
     MultiFDSendParams *p = NULL; /* make happy gcc */
+    multifd_pages_t *pages = &multifd_send_state->pages;
+
+    pages->iov[pages->num].iov_base = address;
+    pages->iov[pages->num].iov_len = TARGET_PAGE_SIZE;
+    pages->num++;
+
+    if (!last_page) {
+        if (pages->num < (pages->size - 1)) {
+            return MULTIFD_CONTINUE;
+        }
+    }
 
     qemu_sem_wait(&multifd_send_state->sem);
     qemu_mutex_lock(&multifd_send_state->mutex);
@@ -554,7 +590,10 @@ static uint16_t multifd_send_page(uint8_t *address, bool last_page)
     }
     qemu_mutex_unlock(&multifd_send_state->mutex);
     qemu_mutex_lock(&p->mutex);
-    p->address = address;
+    p->pages.num = pages->num;
+    iov_copy(p->pages.iov, pages->num, pages->iov, pages->num, 0,
+             iov_size(pages->iov, pages->num));
+    pages->num = 0;
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
-- 
2.13.5
