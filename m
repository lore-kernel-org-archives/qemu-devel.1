Received: from eggs.gnu.org ([2001:4830:134:3::10]:56511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLM-0004R0-CG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLL-0005x8-Ds
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLL-0005wf-6W
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:55 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49B9D8123F
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:29 +0100
Message-Id: <20170313124434.1043-12-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/16] migration: Really use multiple pages at
 a time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

We now send several pages at a time each time that we wakeup a thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Use iovec's insead of creating the equivalent.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ccd7fe9..4914240 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -391,6 +391,13 @@ void migrate_compress_threads_create(void)
 
 /* Multiple fd's */
 
+
+typedef struct {
+    int num;
+    int size;
+    struct iovec *iov;
+} multifd_pages_t;
+
 struct MultiFDSendParams {
     /* not changed */
     int id;
@@ -401,7 +408,7 @@ struct MultiFDSendParams {
     QemuMutex mutex;
     /* protected by param mutex */
     bool quit;
-    uint8_t *address;
+    multifd_pages_t pages;
     /* protected by multifd mutex */
     bool done;
 };
@@ -467,8 +474,8 @@ static void *multifd_send_thread(void *opaque)
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
@@ -483,6 +490,13 @@ static void *multifd_send_thread(void *opaque)
     return NULL;
 }
 
+static void multifd_init_group(multifd_pages_t *pages)
+{
+    pages->num = 0;
+    pages->size = migrate_multifd_group();
+    pages->iov = g_malloc0(pages->size * sizeof(struct iovec));
+}
+
 int migrate_multifd_send_threads_create(void)
 {
     int i, thread_count;
@@ -506,7 +520,7 @@ int migrate_multifd_send_threads_create(void)
         p->quit = false;
         p->id = i;
         p->done = true;
-        p->address = 0;
+        multifd_init_group(&p->pages);
         p->c = socket_send_channel_create();
         if (!p->c) {
             error_report("Error creating a send channel");
@@ -524,8 +538,23 @@ int migrate_multifd_send_threads_create(void)
 
 static int multifd_send_page(uint8_t *address)
 {
-    int i;
+    int i, j;
     MultiFDSendParams *p = NULL; /* make happy gcc */
+    static multifd_pages_t pages;
+    static bool once;
+
+    if (!once) {
+        multifd_init_group(&pages);
+        once = true;
+    }
+
+    pages.iov[pages.num].iov_base = address;
+    pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
+    pages.num++;
+
+    if (pages.num < (pages.size - 1)) {
+        return UINT16_MAX;
+    }
 
     qemu_sem_wait(&multifd_send_state->sem);
     qemu_mutex_lock(&multifd_send_state->mutex);
@@ -539,7 +568,12 @@ static int multifd_send_page(uint8_t *address)
     }
     qemu_mutex_unlock(&multifd_send_state->mutex);
     qemu_mutex_lock(&p->mutex);
-    p->address = address;
+    p->pages.num = pages.num;
+    for (j = 0; j < pages.size; j++) {
+        p->pages.iov[j].iov_base = pages.iov[j].iov_base;
+        p->pages.iov[j].iov_len = pages.iov[j].iov_len;
+    }
+    pages.num = 0;
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
-- 
2.9.3
