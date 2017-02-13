Received: from eggs.gnu.org ([2001:4830:134:3::10]:57877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIS-00088A-22
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIQ-00051d-Fg
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIQ-00051H-5f
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:14 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 615D54E05D
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:46 +0100
Message-Id: <1487006388-7966-11-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] migration: Really use multiple pages at a
 time
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
---
 migration/ram.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f7df6cb..8d85c49 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -391,6 +391,13 @@ void migrate_compress_threads_create(void)

 /* Multiple fd's */

+
+typedef struct {
+    int num;
+    int size;
+    uint8_t **address;
+} MultiFDPages;
+
 struct MultiFDSendParams {
     /* not changed */
     QemuThread thread;
@@ -400,7 +407,7 @@ struct MultiFDSendParams {
     QemuMutex mutex;
     /* protected by param mutex */
     bool quit;
-    uint8_t *address;
+    MultiFDPages pages;
     /* protected by multifd mutex */
     bool done;
 };
@@ -426,8 +433,8 @@ static void *multifd_send_thread(void *opaque)
             qemu_mutex_unlock(&params->mutex);
             break;
         }
-        if (params->address) {
-            params->address = 0;
+        if (params->pages.num) {
+            params->pages.num = 0;
             qemu_mutex_unlock(&params->mutex);
             qemu_mutex_lock(&multifd_send_mutex);
             params->done = true;
@@ -480,6 +487,13 @@ void migrate_multifd_send_threads_join(void)
     multifd_send = NULL;
 }

+static void multifd_init_group(MultiFDPages *pages)
+{
+    pages->num = 0;
+    pages->size = migrate_multifd_group();
+    pages->address = g_new0(uint8_t *, pages->size);
+}
+
 void migrate_multifd_send_threads_create(void)
 {
     int i, thread_count;
@@ -500,7 +514,7 @@ void migrate_multifd_send_threads_create(void)
         qemu_sem_init(&p->init, 0);
         p->quit = false;
         p->done = true;
-        p->address = 0;
+        multifd_init_group(&multifd_send[i].pages);
         p->c = socket_send_channel_create();
         if (!p->c) {
             error_report("Error creating a send channel");
@@ -515,7 +529,21 @@ void migrate_multifd_send_threads_create(void)

 static int multifd_send_page(uint8_t *address)
 {
-    int i, thread_count;
+    int i, j, thread_count;
+    static MultiFDPages pages;
+    static bool once;
+
+    if (!once) {
+        multifd_init_group(&pages);
+        once = true;
+    }
+
+    pages.address[pages.num] = address;
+    pages.num++;
+
+    if (pages.num < (pages.size - 1)) {
+        return UINT16_MAX;
+    }

     thread_count = migrate_multifd_threads();
     qemu_sem_wait(&multifd_send_sem);
@@ -528,7 +556,11 @@ static int multifd_send_page(uint8_t *address)
     }
     qemu_mutex_unlock(&multifd_send_mutex);
     qemu_mutex_lock(&multifd_send[i].mutex);
-    multifd_send[i].address = address;
+    multifd_send[i].pages.num = pages.num;
+    for (j = 0; j < pages.size; j++) {
+        multifd_send[i].pages.address[j] = pages.address[j];
+    }
+    pages.num = 0;
     qemu_mutex_unlock(&multifd_send[i].mutex);
     qemu_sem_post(&multifd_send[i].sem);

-- 
2.7.4
