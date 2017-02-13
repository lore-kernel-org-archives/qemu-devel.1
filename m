Received: from eggs.gnu.org ([2001:4830:134:3::10]:57900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIT-0008Ad-CB
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIR-00052I-Sg
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIR-000520-Ks
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:15 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0A2A64A70
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:47 +0100
Message-Id: <1487006388-7966-12-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 11/12] migration: Send the fd number which we
 are going to use for this page
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

We are still sending the page through the main channel, that would
change later in the series

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8d85c49..38789c8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -527,7 +527,8 @@ void migrate_multifd_send_threads_create(void)
     }
 }

-static int multifd_send_page(uint8_t *address)
+
+static uint16_t multifd_send_page(uint8_t *address, bool last_page)
 {
     int i, j, thread_count;
     static MultiFDPages pages;
@@ -541,8 +542,10 @@ static int multifd_send_page(uint8_t *address)
     pages.address[pages.num] = address;
     pages.num++;

-    if (pages.num < (pages.size - 1)) {
-        return UINT16_MAX;
+    if (!last_page) {
+        if (pages.num < (pages.size - 1)) {
+            return UINT16_MAX;
+        }
     }

     thread_count = migrate_multifd_threads();
@@ -564,16 +567,21 @@ static int multifd_send_page(uint8_t *address)
     qemu_mutex_unlock(&multifd_send[i].mutex);
     qemu_sem_post(&multifd_send[i].sem);

-    return 0;
+    return i;
 }

 struct MultiFDRecvParams {
+    /* not changed */
     QemuThread thread;
     QIOChannel *c;
     QemuSemaphore init;
+    QemuSemaphore ready;
     QemuSemaphore sem;
     QemuMutex mutex;
+    /* proteced by param mutex */
     bool quit;
+    MultiFDPages pages;
+    bool done;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;

@@ -586,6 +594,7 @@ static void *multifd_recv_thread(void *opaque)

     qio_channel_read(params->c, &start, 1, &error_abort);
     qemu_sem_post(&params->init);
+    qemu_sem_post(&params->ready);

     while (true) {
         qemu_mutex_lock(&params->mutex);
@@ -593,6 +602,13 @@ static void *multifd_recv_thread(void *opaque)
             qemu_mutex_unlock(&params->mutex);
             break;
         }
+        if (params->pages.num) {
+            params->pages.num = 0;
+            params->done = true;
+            qemu_mutex_unlock(&params->mutex);
+            qemu_sem_post(&params->ready);
+            continue;
+        }
         qemu_mutex_unlock(&params->mutex);
         qemu_sem_wait(&params->sem);
     }
@@ -652,7 +668,10 @@ void migrate_multifd_recv_threads_create(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->init, 0);
+        qemu_sem_init(&p->ready, 0);
         p->quit = false;
+        p->done = false;
+        multifd_init_group(&p->pages);
         p->c = socket_recv_channel_create();

         if (!p->c) {
@@ -666,6 +685,42 @@ void migrate_multifd_recv_threads_create(void)
     socket_recv_channel_close_listening();
 }

+static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
+{
+    int i, thread_count;
+    MultiFDRecvParams *params;
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
+    if (fd_num == UINT16_MAX) {
+        return;
+    }
+
+    thread_count = migrate_multifd_threads();
+    assert(fd_num < thread_count);
+    params = &multifd_recv[fd_num];
+
+    qemu_sem_wait(&params->ready);
+
+    qemu_mutex_lock(&params->mutex);
+    params->done = false;
+    for (i = 0; i < pages.num; i++) {
+        params->pages.address[i] = pages.address[i];
+    }
+    params->pages.num = pages.num;
+    pages.num = 0;
+    qemu_mutex_unlock(&params->mutex);
+    qemu_sem_post(&params->sem);
+}
+
 /**
  * save_page_header: Write page header to wire
  *
@@ -1085,6 +1140,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
                             bool last_stage, uint64_t *bytes_transferred)
 {
     int pages;
+    uint16_t fd_num;
     uint8_t *p;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->offset;
@@ -1098,8 +1154,10 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
     if (pages == -1) {
         *bytes_transferred +=
             save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
+        fd_num = multifd_send_page(p, migration_dirty_pages == 1);
+        qemu_put_be16(f, fd_num);
+        *bytes_transferred += 2; /* size of fd_num */
         qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
-        multifd_send_page(p);
         *bytes_transferred += TARGET_PAGE_SIZE;
         pages = 1;
         acct_info.norm_pages++;
@@ -2813,6 +2871,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
         void *host = NULL;
+        uint16_t fd_num;
         uint8_t ch;

         addr = qemu_get_be64(f);
@@ -2910,6 +2969,8 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;

         case RAM_SAVE_FLAG_MULTIFD_PAGE:
+            fd_num = qemu_get_be16(f);
+            multifd_recv_page(host, fd_num);
             qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;

-- 
2.7.4
