Received: from eggs.gnu.org ([2001:4830:134:3::10]:58947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7K2-0000dC-IX
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7K1-000743-66
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df7K0-00073e-Tu
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:25:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E94D13A47
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 16:25:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  8 Aug 2017 18:22:18 +0200
Message-Id: <20170808162224.32419-14-quintela@redhat.com>
In-Reply-To: <20170808162224.32419-1-quintela@redhat.com>
References: <20170808162224.32419-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 13/19] migration: Really use multiple pages
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
index 03f3427..7310da9 100644
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
@@ -371,11 +381,7 @@ struct MultiFDSendParams {
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
@@ -388,8 +394,24 @@ struct {
     int count;
     QemuMutex mutex;
     QemuSemaphore sem;
+    multifd_pages_t pages;
 } *multifd_send_state;
 
+static void multifd_init_group(multifd_pages_t *pages)
+{
+    pages->num = 0;
+    pages->size = migrate_multifd_group();
+    pages->iov = g_new0(struct iovec, pages->size);
+}
+
+static void multifd_clear_group(multifd_pages_t *pages)
+{
+    pages->num = 0;
+    pages->size = 0;
+    g_free(pages->iov);
+    pages->iov = NULL;
+}
+
 static void terminate_multifd_send_threads(void)
 {
     int i;
@@ -419,9 +441,11 @@ void multifd_save_cleanup(void)
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         socket_send_channel_destroy(p->c);
+        multifd_clear_group(&p->pages);
     }
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
+    multifd_clear_group(&multifd_send_state->pages);
     g_free(multifd_send_state);
     multifd_send_state = NULL;
 }
@@ -454,8 +478,8 @@ static void *multifd_send_thread(void *opaque)
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
@@ -484,6 +508,7 @@ int multifd_save_setup(void)
     multifd_send_state->count = 0;
     qemu_mutex_init(&multifd_send_state->mutex);
     qemu_sem_init(&multifd_send_state->sem, 0);
+    multifd_init_group(&multifd_send_state->pages);
     for (i = 0; i < thread_count; i++) {
         char thread_name[16];
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -493,7 +518,7 @@ int multifd_save_setup(void)
         p->quit = false;
         p->id = i;
         p->done = true;
-        p->address = 0;
+        multifd_init_group(&p->pages);
         p->c = socket_send_channel_create();
         if (!p->c) {
             error_report("Error creating a send channel");
@@ -512,6 +537,17 @@ static uint16_t multifd_send_page(uint8_t *address, bool last_page)
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
@@ -525,7 +561,10 @@ static uint16_t multifd_send_page(uint8_t *address, bool last_page)
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
2.9.4
