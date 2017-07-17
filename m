Received: from eggs.gnu.org ([2001:4830:134:3::10]:46215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JB-0004K6-1t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JA-0005WT-0i
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6J9-0005Vv-OD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4E6CC04B303
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:43:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:32 +0200
Message-Id: <20170717134238.1966-12-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 11/17] migration: Really use multiple pages
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

We now send several pages at a time each time that we wakeup a thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Use iovec's insead of creating the equivalent.
---
 migration/ram.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2bf3fa7..90e1bcb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -362,6 +362,13 @@ static void compress_threads_save_setup(void)
 
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
     uint8_t id;
@@ -371,7 +378,7 @@ struct MultiFDSendParams {
     QemuMutex mutex;
     /* protected by param mutex */
     bool quit;
-    uint8_t *address;
+    multifd_pages_t pages;
     /* protected by multifd mutex */
     bool done;
 };
@@ -459,8 +466,8 @@ static void *multifd_send_thread(void *opaque)
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
@@ -475,6 +482,13 @@ static void *multifd_send_thread(void *opaque)
     return NULL;
 }
 
+static void multifd_init_group(multifd_pages_t *pages)
+{
+    pages->num = 0;
+    pages->size = migrate_multifd_group();
+    pages->iov = g_malloc0(pages->size * sizeof(struct iovec));
+}
+
 int multifd_save_setup(void)
 {
     int thread_count;
@@ -498,7 +512,7 @@ int multifd_save_setup(void)
         p->quit = false;
         p->id = i;
         p->done = true;
-        p->address = 0;
+        multifd_init_group(&p->pages);
         p->c = socket_send_channel_create();
         if (!p->c) {
             error_report("Error creating a send channel");
@@ -515,8 +529,23 @@ int multifd_save_setup(void)
 
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
@@ -530,7 +559,12 @@ static int multifd_send_page(uint8_t *address)
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
2.9.4
