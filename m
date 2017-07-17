Received: from eggs.gnu.org ([2001:4830:134:3::10]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JL-0004j3-8e
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JK-0005b9-0v
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6JJ-0005ai-N2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3EC47F6A2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:43:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:37 +0200
Message-Id: <20170717134238.1966-17-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 16/17] migration: Transfer pages over new
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

We switch for sending the page number to send real pages.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Remove the HACK bit, now we have the function that calculates the size
of a page exported.
---
 migration/migration.c | 14 ++++++++----
 migration/ram.c       | 59 +++++++++++++++++----------------------------------
 2 files changed, 29 insertions(+), 44 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e122684..34a34b7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1882,13 +1882,14 @@ static void *migration_thread(void *opaque)
     /* Used by the bandwidth calcs, updated later */
     int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
-    int64_t initial_bytes = 0;
     /*
      * The final stage happens when the remaining data is smaller than
      * this threshold; it's calculated from the requested downtime and
      * measured bandwidth
      */
     int64_t threshold_size = 0;
+    int64_t qemu_file_bytes = 0;
+    int64_t multifd_pages = 0;
     int64_t start_time = initial_time;
     int64_t end_time;
     bool old_vm_running = false;
@@ -1976,9 +1977,13 @@ static void *migration_thread(void *opaque)
         }
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
-            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
-                                         initial_bytes;
             uint64_t time_spent = current_time - initial_time;
+            uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
+            uint64_t multifd_pages_now = ram_counters.multifd;
+            uint64_t transferred_bytes =
+                (qemu_file_bytes_now - qemu_file_bytes) +
+                (multifd_pages_now - multifd_pages) *
+                qemu_target_page_size();
             double bandwidth = (double)transferred_bytes / time_spent;
             threshold_size = bandwidth * s->parameters.downtime_limit;
 
@@ -1996,7 +2001,8 @@ static void *migration_thread(void *opaque)
 
             qemu_file_reset_rate_limit(s->to_dst_file);
             initial_time = current_time;
-            initial_bytes = qemu_ftell(s->to_dst_file);
+            qemu_file_bytes = qemu_file_bytes_now;
+            multifd_pages = multifd_pages_now;
         }
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
diff --git a/migration/ram.c b/migration/ram.c
index b55b243..c78b286 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -468,25 +468,21 @@ static void *multifd_send_thread(void *opaque)
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
@@ -654,7 +650,6 @@ void multifd_load_cleanup(void)
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
-    uint8_t *recv_address;
 
     qemu_sem_post(&p->ready);
     while (true) {
@@ -664,38 +659,21 @@ static void *multifd_recv_thread(void *opaque)
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
@@ -1262,8 +1240,10 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
                              offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
         fd_num = multifd_send_page(p, rs->migration_dirty_pages == 1);
         qemu_put_be16(rs->f, fd_num);
+        if (fd_num != UINT16_MAX) {
+            qemu_fflush(rs->f);
+        }
         ram_counters.transferred += 2; /* size of fd_num */
-        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
         ram_counters.transferred += TARGET_PAGE_SIZE;
         pages = 1;
         ram_counters.normal++;
@@ -3126,7 +3106,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
             fd_num = qemu_get_be16(f);
             multifd_recv_page(host, fd_num);
-            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
         case RAM_SAVE_FLAG_EOS:
-- 
2.9.4
