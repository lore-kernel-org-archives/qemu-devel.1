Received: from eggs.gnu.org ([2001:4830:134:3::10]:33822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEG-0002I4-4h
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEF-0003AW-8h
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmEF-0003AC-0l
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:43 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 376E3C04B31F
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:15 +0100
Message-Id: <1485207141-1941-12-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/17] migration: Create thread infrastructure
 for multifd send side
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

We make the locking and the transfer of information specific, even if we
are still transmiting things through the main thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index c71929e..9d7bc64 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -392,17 +392,25 @@ void migrate_compress_threads_create(void)
 /* Multiple fd's */

 struct MultiFDSendParams {
+    /* not changed */
     QemuThread thread;
     QIOChannel *c;
     QemuCond cond;
     QemuMutex mutex;
+    /* protected by param mutex */
     bool quit;
     bool started;
+    uint8_t *address;
+    /* protected by multifd mutex */
+    bool done;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;

 static MultiFDSendParams *multifd_send;

+QemuMutex multifd_send_mutex;
+QemuCond multifd_send_cond;
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *params = opaque;
@@ -416,7 +424,17 @@ static void *multifd_send_thread(void *opaque)

     qemu_mutex_lock(&params->mutex);
     while (!params->quit){
-        qemu_cond_wait(&params->cond, &params->mutex);
+        if (params->address) {
+            params->address = 0;
+            qemu_mutex_unlock(&params->mutex);
+            qemu_mutex_lock(&multifd_send_mutex);
+            params->done = true;
+            qemu_cond_signal(&multifd_send_cond);
+            qemu_mutex_unlock(&multifd_send_mutex);
+            qemu_mutex_lock(&params->mutex);
+        } else {
+            qemu_cond_wait(&params->cond, &params->mutex);
+        }
     }
     qemu_mutex_unlock(&params->mutex);

@@ -464,12 +482,16 @@ void migrate_multifd_send_threads_create(void)
     }
     thread_count = migrate_multifd_threads();
     multifd_send = g_new0(MultiFDSendParams, thread_count);
+    qemu_mutex_init(&multifd_send_mutex);
+    qemu_cond_init(&multifd_send_cond);
     for (i = 0; i < thread_count; i++) {
         char thread_name[15];
         qemu_mutex_init(&multifd_send[i].mutex);
         qemu_cond_init(&multifd_send[i].cond);
         multifd_send[i].quit = false;
         multifd_send[i].started = false;
+        multifd_send[i].done = true;
+        multifd_send[i].address = 0;
         multifd_send[i].c = socket_send_channel_create();
         if(!multifd_send[i].c) {
             error_report("Error creating a send channel");
@@ -487,6 +509,34 @@ void migrate_multifd_send_threads_create(void)
     }
 }

+static int multifd_send_page(uint8_t *address)
+{
+    int i, thread_count;
+    bool found = false;
+
+    thread_count = migrate_multifd_threads();
+    qemu_mutex_lock(&multifd_send_mutex);
+    while (!found) {
+        for (i = 0; i < thread_count; i++) {
+            if (multifd_send[i].done) {
+                multifd_send[i].done = false;
+                found = true;
+                break;
+            }
+        }
+        if (!found) {
+            qemu_cond_wait(&multifd_send_cond, &multifd_send_mutex);
+        }
+    }
+    qemu_mutex_unlock(&multifd_send_mutex);
+    qemu_mutex_lock(&multifd_send[i].mutex);
+    multifd_send[i].address = address;
+    qemu_cond_signal(&multifd_send[i].cond);
+    qemu_mutex_unlock(&multifd_send[i].mutex);
+
+    return 0;
+}
+
 struct MultiFDRecvParams {
     QemuThread thread;
     QIOChannel *c;
@@ -1015,6 +1065,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
         *bytes_transferred +=
             save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
         qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
+        multifd_send_page(p);
         *bytes_transferred += TARGET_PAGE_SIZE;
         pages = 1;
         acct_info.norm_pages++;
-- 
2.9.3
