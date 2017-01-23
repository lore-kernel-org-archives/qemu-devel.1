Received: from eggs.gnu.org ([2001:4830:134:3::10]:33904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEO-0002OQ-5M
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEM-0003DJ-Ny
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmEM-0003Cx-Er
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:50 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F4F32E604C
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:20 +0100
Message-Id: <1485207141-1941-17-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 16/17] migration: [HACK]Transfer pages over new
 channels
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

We switch for sending the page number to send real pages.

[HACK]
How we calculate the bandwidth is beyond repair, there is a hack there
that would work for x86 and archs that have 4kb pages.

If you are having a nice day just go to migration/ram.c and look at
acct_update_position().  Now you are depressed, right?

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 15 +++++++++++----
 migration/ram.c       | 25 +++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1d62b91..cbbf2a3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1839,7 +1839,8 @@ static void *migration_thread(void *opaque)
     /* Used by the bandwidth calcs, updated later */
     int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
-    int64_t initial_bytes = 0;
+    int64_t qemu_file_bytes = 0;
+    int64_t multifd_pages = 0;
     int64_t max_size = 0;
     int64_t start_time = initial_time;
     int64_t end_time;
@@ -1923,9 +1924,14 @@ static void *migration_thread(void *opaque)
         }
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
-            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
-                                         initial_bytes;
             uint64_t time_spent = current_time - initial_time;
+            uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
+            uint64_t multifd_pages_now = multifd_mig_pages_transferred();
+            /* Hack ahead.  Why the hell we don't have a function to now the
+               target_page_size.  Hard coding it to 4096 */
+            uint64_t transferred_bytes =
+                (qemu_file_bytes_now - qemu_file_bytes) +
+                (multifd_pages_now - multifd_pages) * 4096;
             double bandwidth = (double)transferred_bytes / time_spent;
             max_size = bandwidth * s->parameters.downtime_limit;

@@ -1942,7 +1948,8 @@ static void *migration_thread(void *opaque)

             qemu_file_reset_rate_limit(s->to_dst_file);
             initial_time = current_time;
-            initial_bytes = qemu_ftell(s->to_dst_file);
+            qemu_file_bytes = qemu_file_bytes_now;
+            multifd_pages = multifd_pages_now;
         }
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
diff --git a/migration/ram.c b/migration/ram.c
index 95af694..28d099f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -441,9 +441,9 @@ static void *multifd_send_thread(void *opaque)

             for(i=0; i < num; i++) {
                 if (qio_channel_write(params->c,
-                                      (const char *)&params->pages.address[i],
-                                      sizeof(uint8_t *), &error_abort)
-                    != sizeof(uint8_t*)) {
+                                      (const char *)params->pages.address[i],
+                                      TARGET_PAGE_SIZE, &error_abort)
+                    != TARGET_PAGE_SIZE) {
                     /* Shuoudn't ever happen */
                     exit(-1);
                 }
@@ -608,7 +608,6 @@ QemuCond  multifd_recv_cond;
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *params = opaque;
-    uint8_t *recv_address;
     char start;

     qio_channel_read(params->c, &start, 1, &error_abort);
@@ -629,20 +628,13 @@ static void *multifd_recv_thread(void *opaque)

             for(i = 0; i < num; i++) {
                 if (qio_channel_read(params->c,
-                                     (char *)&recv_address,
-                                     sizeof(uint8_t*), &error_abort)
-                    != sizeof(uint8_t *)) {
+                                     (char *)params->pages.address[i],
+                                     TARGET_PAGE_SIZE, &error_abort)
+                    != TARGET_PAGE_SIZE) {
                     /* shouldn't ever happen */
                     exit(-1);
                 }
-                if (recv_address != params->pages.address[i]) {
-                    printf("We received %p what we were expecting %p (%d)\n",
-                           recv_address,
-                           params->pages.address[i], i);
-                    exit(-1);
-                }
             }
-
             qemu_mutex_lock(&multifd_recv_mutex);
             params->done = true;
             qemu_cond_signal(&multifd_recv_cond);
@@ -1195,8 +1187,10 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
             save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
         fd_num = multifd_send_page(p, migration_dirty_pages == 1);
         qemu_put_be16(f, fd_num);
+        if (fd_num != UINT16_MAX) {
+            qemu_fflush(f);
+        }
         *bytes_transferred += 2; /* size of fd_num */
-        qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
         *bytes_transferred += TARGET_PAGE_SIZE;
         pages = 1;
         acct_info.norm_pages++;
@@ -3017,7 +3011,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
             fd_num = qemu_get_be16(f);
             multifd_recv_page(host, fd_num);
-            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;

         case RAM_SAVE_FLAG_EOS:
-- 
2.9.3
