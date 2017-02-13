Received: from eggs.gnu.org ([2001:4830:134:3::10]:57848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIQ-00087E-Gr
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIO-00050V-Tp
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIO-0004zF-LK
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:12 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB82461BAA
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:45 +0100
Message-Id: <1487006388-7966-10-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 09/12] migration: Create thread infrastructure
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

--

Move synchronization to use semaphores, as paolo suggestion.
---
 migration/ram.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 45c46cb..f7df6cb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -392,17 +392,25 @@ void migrate_compress_threads_create(void)
 /* Multiple fd's */

 struct MultiFDSendParams {
+    /* not changed */
     QemuThread thread;
     QIOChannel *c;
     QemuSemaphore sem;
     QemuSemaphore init;
     QemuMutex mutex;
+    /* protected by param mutex */
     bool quit;
+    uint8_t *address;
+    /* protected by multifd mutex */
+    bool done;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;

 static MultiFDSendParams *multifd_send;

+QemuMutex multifd_send_mutex;
+QemuSemaphore multifd_send_sem;
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *params = opaque;
@@ -410,6 +418,7 @@ static void *multifd_send_thread(void *opaque)

     qio_channel_write(params->c, &start, 1, &error_abort);
     qemu_sem_post(&params->init);
+    qemu_sem_post(&multifd_send_sem);

     while (true) {
         qemu_mutex_lock(&params->mutex);
@@ -417,6 +426,15 @@ static void *multifd_send_thread(void *opaque)
             qemu_mutex_unlock(&params->mutex);
             break;
         }
+        if (params->address) {
+            params->address = 0;
+            qemu_mutex_unlock(&params->mutex);
+            qemu_mutex_lock(&multifd_send_mutex);
+            params->done = true;
+            qemu_mutex_unlock(&multifd_send_mutex);
+            qemu_sem_post(&multifd_send_sem);
+            continue;
+        }
         qemu_mutex_unlock(&params->mutex);
         qemu_sem_wait(&params->sem);
     }
@@ -471,6 +489,8 @@ void migrate_multifd_send_threads_create(void)
     }
     thread_count = migrate_multifd_threads();
     multifd_send = g_new0(MultiFDSendParams, thread_count);
+    qemu_mutex_init(&multifd_send_mutex);
+    qemu_sem_init(&multifd_send_sem, 0);
     for (i = 0; i < thread_count; i++) {
         char thread_name[15];
         MultiFDSendParams *p = &multifd_send[i];
@@ -479,6 +499,8 @@ void migrate_multifd_send_threads_create(void)
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->init, 0);
         p->quit = false;
+        p->done = true;
+        p->address = 0;
         p->c = socket_send_channel_create();
         if (!p->c) {
             error_report("Error creating a send channel");
@@ -491,6 +513,28 @@ void migrate_multifd_send_threads_create(void)
     }
 }

+static int multifd_send_page(uint8_t *address)
+{
+    int i, thread_count;
+
+    thread_count = migrate_multifd_threads();
+    qemu_sem_wait(&multifd_send_sem);
+    qemu_mutex_lock(&multifd_send_mutex);
+    for (i = 0; i < thread_count; i++) {
+        if (multifd_send[i].done) {
+            multifd_send[i].done = false;
+            break;
+        }
+    }
+    qemu_mutex_unlock(&multifd_send_mutex);
+    qemu_mutex_lock(&multifd_send[i].mutex);
+    multifd_send[i].address = address;
+    qemu_mutex_unlock(&multifd_send[i].mutex);
+    qemu_sem_post(&multifd_send[i].sem);
+
+    return 0;
+}
+
 struct MultiFDRecvParams {
     QemuThread thread;
     QIOChannel *c;
@@ -1023,6 +1067,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
         *bytes_transferred +=
             save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
         qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
+        multifd_send_page(p);
         *bytes_transferred += TARGET_PAGE_SIZE;
         pages = 1;
         acct_info.norm_pages++;
-- 
2.7.4
