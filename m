Received: from eggs.gnu.org ([2001:4830:134:3::10]:33870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEL-0002NH-Bo
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEJ-0003CI-Qd
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmEJ-0003C2-I3
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABAA1C0567A3
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:18 +0100
Message-Id: <1485207141-1941-15-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 14/17] migration: Create thread infrastructure
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
 migration/ram.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ca94704..4e530ea 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -523,7 +523,7 @@ void migrate_multifd_send_threads_create(void)
     }
 }

-static int multifd_send_page(uint8_t *address)
+static uint16_t multifd_send_page(uint8_t *address, bool last_page)
 {
     int i, j, thread_count;
     bool found = false;
@@ -538,8 +538,10 @@ static int multifd_send_page(uint8_t *address)
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
@@ -570,17 +572,25 @@ static int multifd_send_page(uint8_t *address)
 }

 struct MultiFDRecvParams {
+    /* not changed */
     QemuThread thread;
     QIOChannel *c;
     QemuCond cond;
     QemuMutex mutex;
+    /* proteced by param mutex */
     bool quit;
     bool started;
+    multifd_pages_t pages;
+    /* proteced by multifd mutex */
+    bool done;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;

 static MultiFDRecvParams *multifd_recv;

+QemuMutex multifd_recv_mutex;
+QemuCond  multifd_recv_cond;
+
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *params = opaque;
@@ -594,7 +604,17 @@ static void *multifd_recv_thread(void *opaque)

     qemu_mutex_lock(&params->mutex);
     while (!params->quit){
-        qemu_cond_wait(&params->cond, &params->mutex);
+        if (params->pages.num) {
+            params->pages.num = 0;
+            qemu_mutex_unlock(&params->mutex);
+            qemu_mutex_lock(&multifd_recv_mutex);
+            params->done = true;
+            qemu_cond_signal(&multifd_recv_cond);
+            qemu_mutex_unlock(&multifd_recv_mutex);
+            qemu_mutex_lock(&params->mutex);
+        } else {
+            qemu_cond_wait(&params->cond, &params->mutex);
+        }
     }
     qemu_mutex_unlock(&params->mutex);

@@ -647,8 +667,9 @@ void migrate_multifd_recv_threads_create(void)
         qemu_cond_init(&multifd_recv[i].cond);
         multifd_recv[i].quit = false;
         multifd_recv[i].started = false;
+        multifd_recv[i].done = true;
+        multifd_init_group(&multifd_recv[i].pages);
         multifd_recv[i].c = socket_recv_channel_create();
-
         if(!multifd_recv[i].c) {
             error_report("Error creating a recv channel");
             exit(0);
@@ -664,6 +685,45 @@ void migrate_multifd_recv_threads_create(void)
     }
 }

+static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
+{
+    int i, thread_count;
+    MultiFDRecvParams *params;
+    static multifd_pages_t pages;
+    static bool once = false;
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
+    qemu_mutex_lock(&multifd_recv_mutex);
+    while (!params->done) {
+        qemu_cond_wait(&multifd_recv_cond, &multifd_recv_mutex);
+    }
+    params->done = false;
+    qemu_mutex_unlock(&multifd_recv_mutex);
+    qemu_mutex_lock(&params->mutex);
+    for(i = 0; i < pages.num; i++) {
+        params->pages.address[i] = pages.address[i];
+    }
+    params->pages.num = pages.num;
+    pages.num = 0;
+    qemu_cond_signal(&params->cond);
+    qemu_mutex_unlock(&params->mutex);
+}
+
 /**
  * save_page_header: Write page header to wire
  *
@@ -1097,7 +1157,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
     if (pages == -1) {
         *bytes_transferred +=
             save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
-        fd_num = multifd_send_page(p);
+        fd_num = multifd_send_page(p, migration_dirty_pages == 1);
         qemu_put_be16(f, fd_num);
         *bytes_transferred += 2; /* size of fd_num */
         qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
@@ -2920,10 +2980,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)

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
