Received: from eggs.gnu.org ([2001:4830:134:3::10]:56639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLX-0004eF-MK
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLR-00060N-Lh
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:45:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLR-0005zy-DD
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:45:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8649C1556C
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:45:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:33 +0100
Message-Id: <20170313124434.1043-16-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 15/16] migration: Transfer pages over new
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

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Remove the HACK bit, now we have the function that calculates the size
of a page exported.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 14 ++++++++----
 migration/ram.c       | 59 +++++++++++++++++----------------------------------
 2 files changed, 29 insertions(+), 44 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a32e4ad..18d6955 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1967,7 +1967,8 @@ static void *migration_thread(void *opaque)
     /* Used by the bandwidth calcs, updated later */
     int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
-    int64_t initial_bytes = 0;
+    int64_t qemu_file_bytes = 0;
+    int64_t multifd_pages = 0;
     int64_t max_size = 0;
     int64_t start_time = initial_time;
     int64_t end_time;
@@ -2051,9 +2052,13 @@ static void *migration_thread(void *opaque)
         }
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
-            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
-                                         initial_bytes;
             uint64_t time_spent = current_time - initial_time;
+            uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
+            uint64_t multifd_pages_now = multifd_mig_pages_transferred();
+            uint64_t transferred_bytes =
+                (qemu_file_bytes_now - qemu_file_bytes) +
+                (multifd_pages_now - multifd_pages) *
+                (1ul << qemu_target_page_bits());
             double bandwidth = (double)transferred_bytes / time_spent;
             max_size = bandwidth * s->parameters.downtime_limit;
 
@@ -2070,7 +2075,8 @@ static void *migration_thread(void *opaque)
 
             qemu_file_reset_rate_limit(s->to_dst_file);
             initial_time = current_time;
-            initial_bytes = qemu_ftell(s->to_dst_file);
+            qemu_file_bytes = qemu_file_bytes_now;
+            multifd_pages = multifd_pages_now;
         }
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
diff --git a/migration/ram.c b/migration/ram.c
index 32cc678..e213a49 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -476,25 +476,21 @@ static void *multifd_send_thread(void *opaque)
             break;
         }
         if (p->pages.num) {
-            int i;
             int num;
 
             num = p->pages.num;
             p->pages.num = 0;
             qemu_mutex_unlock(&p->mutex);
 
-            for (i = 0; i < num; i++) {
-                if (qio_channel_write(p->c,
-                                      (const char *)&p->pages.iov[i].iov_base,
-                                      sizeof(uint8_t *), &error_abort)
-                    != sizeof(uint8_t *)) {
-                    MigrationState *s = migrate_get_current();
+            if (qio_channel_writev_all(p->c, p->pages.iov,
+                                       num, &error_abort)
+                != num * TARGET_PAGE_SIZE) {
+                MigrationState *s = migrate_get_current();
 
-                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                                      MIGRATION_STATUS_FAILED);
-                    terminate_multifd_send_threads();
-                    return NULL;
-                }
+                migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                                  MIGRATION_STATUS_FAILED);
+                terminate_multifd_send_threads();
+                return NULL;
             }
             qemu_mutex_lock(&multifd_send_state->mutex);
             p->done = true;
@@ -663,7 +659,6 @@ void migrate_multifd_recv_threads_join(void)
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
-    uint8_t *recv_address;
     char start;
 
     qio_channel_read(p->c, &start, 1, &error_abort);
@@ -677,38 +672,21 @@ static void *multifd_recv_thread(void *opaque)
             break;
         }
         if (p->pages.num) {
-            int i;
             int num;
 
             num = p->pages.num;
             p->pages.num = 0;
 
-            for (i = 0; i < num; i++) {
-                if (qio_channel_read(p->c,
-                                     (char *)&recv_address,
-                                     sizeof(uint8_t *), &error_abort)
-                    != sizeof(uint8_t *)) {
-                    MigrationState *s = migrate_get_current();
+            if (qio_channel_readv_all(p->c, p->pages.iov,
+                                      num, &error_abort)
+                != num * TARGET_PAGE_SIZE) {
+                MigrationState *s = migrate_get_current();
 
-                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                                      MIGRATION_STATUS_FAILED);
-                    terminate_multifd_recv_threads();
-                    return NULL;
-                }
-                if (recv_address != p->pages.iov[i].iov_base) {
-                    MigrationState *s = migrate_get_current();
-
-                    printf("We received %p what we were expecting %p (%d)\n",
-                           recv_address,
-                           p->pages.iov[i].iov_base, i);
-
-                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                                      MIGRATION_STATUS_FAILED);
-                    terminate_multifd_recv_threads();
-                    return NULL;
-                }
+                migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                                  MIGRATION_STATUS_FAILED);
+                terminate_multifd_recv_threads();
+                return NULL;
             }
-
             p->done = true;
             qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->ready);
@@ -1260,8 +1238,10 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
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
@@ -3118,7 +3098,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
             fd_num = qemu_get_be16(f);
             multifd_recv_page(host, fd_num);
-            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
         case RAM_SAVE_FLAG_EOS:
-- 
2.9.3
