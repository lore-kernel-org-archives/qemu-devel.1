Received: from eggs.gnu.org ([2001:4830:134:3::10]:56541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLP-0004Tt-LZ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLO-0005ym-Ip
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLO-0005yN-AB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:58 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DA4761BB9
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:31 +0100
Message-Id: <20170313124434.1043-14-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 13/16] migration: Create thread infrastructure
 for multifd recv side
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
are still receiving things through the main thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6f5ca50..3b1a2dc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -44,6 +44,7 @@
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
+#include "qemu/iov.h"
 
 static int dirty_rate_high_cnt;
 
@@ -536,7 +537,7 @@ int migrate_multifd_send_threads_create(void)
     return 0;
 }
 
-static int multifd_send_page(uint8_t *address)
+static uint16_t multifd_send_page(uint8_t *address, bool last_page)
 {
     int i, j;
     MultiFDSendParams *p = NULL; /* make happy gcc */
@@ -552,8 +553,10 @@ static int multifd_send_page(uint8_t *address)
     pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
     pages.num++;
 
-    if (pages.num < (pages.size - 1)) {
-        return UINT16_MAX;
+    if (!last_page) {
+        if (pages.num < (pages.size - 1)) {
+            return UINT16_MAX;
+        }
     }
 
     qemu_sem_wait(&multifd_send_state->sem);
@@ -581,13 +584,18 @@ static int multifd_send_page(uint8_t *address)
 }
 
 struct MultiFDRecvParams {
+    /* not changed */
     int id;
     QemuThread thread;
     QIOChannel *c;
     QemuSemaphore init;
+    QemuSemaphore ready;
     QemuSemaphore sem;
     QemuMutex mutex;
+    /* proteced by param mutex */
     bool quit;
+    multifd_pages_t pages;
+    bool done;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
 
@@ -641,6 +649,7 @@ static void *multifd_recv_thread(void *opaque)
 
     qio_channel_read(p->c, &start, 1, &error_abort);
     qemu_sem_post(&p->init);
+    qemu_sem_post(&p->ready);
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -648,6 +657,13 @@ static void *multifd_recv_thread(void *opaque)
             qemu_mutex_unlock(&p->mutex);
             break;
         }
+        if (p->pages.num) {
+            p->pages.num = 0;
+            p->done = true;
+            qemu_mutex_unlock(&p->mutex);
+            qemu_sem_post(&p->ready);
+            continue;
+        }
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_wait(&p->sem);
     }
@@ -672,8 +688,11 @@ int migrate_multifd_recv_threads_create(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->init, 0);
+        qemu_sem_init(&p->ready, 0);
         p->quit = false;
         p->id = i;
+        p->done = false;
+        multifd_init_group(&p->pages);
         p->c = socket_recv_channel_create();
 
         if (!p->c) {
@@ -690,6 +709,42 @@ int migrate_multifd_recv_threads_create(void)
     return 0;
 }
 
+static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
+{
+    int thread_count;
+    MultiFDRecvParams *p;
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
+    if (fd_num == UINT16_MAX) {
+        return;
+    }
+
+    thread_count = migrate_multifd_threads();
+    assert(fd_num < thread_count);
+    p = &multifd_recv_state->params[fd_num];
+
+    qemu_sem_wait(&p->ready);
+
+    qemu_mutex_lock(&p->mutex);
+    p->done = false;
+    iov_copy(p->pages.iov, pages.num, pages.iov, pages.num, 0,
+             iov_size(pages.iov, pages.num));
+    p->pages.num = pages.num;
+    pages.num = 0;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+}
+
 /**
  * save_page_header: Write page header to wire
  *
@@ -1153,7 +1208,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
     if (pages == -1) {
         *bytes_transferred +=
             save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
-        fd_num = multifd_send_page(p);
+        fd_num = multifd_send_page(p, migration_dirty_pages == 1);
         qemu_put_be16(f, fd_num);
         *bytes_transferred += 2; /* size of fd_num */
         qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
@@ -3012,10 +3067,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
             fd_num = qemu_get_be16(f);
-            if (fd_num != 0) {
-                /* this is yet an unused variable, changed later */
-                fd_num = fd_num;
-            }
+            multifd_recv_page(host, fd_num);
             qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
-- 
2.9.3
