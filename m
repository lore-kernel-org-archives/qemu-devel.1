Received: from eggs.gnu.org ([2001:4830:134:3::10]:33922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEP-0002PH-Ks
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEO-0003Dk-7s
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmEN-0003DW-VZ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:52 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 276D33B3D2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:21 +0100
Message-Id: <1485207141-1941-18-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 17/17] migration: flush receive queue
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

Each time that we sync the bitmap, it is a possiblity that we receive
a page that is being processed by a different thread.  We fix this
problem just making sure that we wait for all receiving threads to
finish its work before we procedeed with the next stage.

We are low on page flags, so we use a combination that is not valid to
emit that message:  MULTIFD_PAGE and COMPRESSED.

I tried to make a migration command for it, but it don't work because
we sync the bitmap sometimes when we have already sent the beggining
of the section, so I just added a new page flag.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  1 +
 migration/ram.c               | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index b3e4f31..1bd6bc0 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -259,6 +259,7 @@ void migrate_multifd_send_threads_create(void);
 void migrate_multifd_send_threads_join(void);
 void migrate_multifd_recv_threads_create(void);
 void migrate_multifd_recv_threads_join(void);
+void qemu_savevm_send_multifd_flush(QEMUFile *f);

 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
diff --git a/migration/ram.c b/migration/ram.c
index 28d099f..3baead8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -63,6 +63,13 @@ static uint64_t bitmap_sync_count;
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
 #define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200

+/* We are getting low on pages flags, so we start using combinations 
+   When we need to flush a page, we sent it as
+   RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_COMPRESS_PAGE
+   We don't allow that combination
+*/
+
+
 static uint8_t *ZERO_TARGET_PAGE;

 static inline bool is_zero_range(uint8_t *p, uint64_t size)
@@ -391,6 +398,9 @@ void migrate_compress_threads_create(void)

 /* Multiple fd's */

+/* Indicates if we have synced the bitmap and we need to assure that
+   target has processeed all previous pages */
+bool multifd_needs_flush = false;

 typedef struct {
     int num;
@@ -752,6 +762,25 @@ static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
     qemu_mutex_unlock(&params->mutex);
 }

+
+static int multifd_flush(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count = migrate_multifd_threads();
+    qemu_mutex_lock(&multifd_recv_mutex);
+    for (i = 0; i < thread_count; i++) {
+        while(!multifd_recv[i].done) {
+            qemu_cond_wait(&multifd_recv_cond, &multifd_recv_mutex);
+        }
+    }
+    qemu_mutex_unlock(&multifd_recv_mutex);
+    return 0;
+}
+
 /**
  * save_page_header: Write page header to wire
  *
@@ -768,6 +797,12 @@ static size_t save_page_header(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
 {
     size_t size, len;

+    if (multifd_needs_flush &&
+        (offset & RAM_SAVE_FLAG_MULTIFD_PAGE)) {
+        offset |= RAM_SAVE_FLAG_COMPRESS;
+        multifd_needs_flush = false;
+    }
+
     qemu_put_be64(f, offset);
     size = 8;

@@ -2450,6 +2485,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)

     if (!migration_in_postcopy(migrate_get_current())) {
         migration_bitmap_sync();
+        if (migrate_use_multifd()) {
+            multifd_needs_flush = true;
+        }
     }

     ram_control_before_iterate(f, RAM_CONTROL_FINISH);
@@ -2491,6 +2529,9 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
         qemu_mutex_lock_iothread();
         rcu_read_lock();
         migration_bitmap_sync();
+        if (migrate_use_multifd()) {
+            multifd_needs_flush = true;
+        }
         rcu_read_unlock();
         qemu_mutex_unlock_iothread();
         remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
@@ -2930,6 +2971,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
         }

+        if ((flags & (RAM_SAVE_FLAG_MULTIFD_PAGE|RAM_SAVE_FLAG_COMPRESS))
+                  == (RAM_SAVE_FLAG_MULTIFD_PAGE|RAM_SAVE_FLAG_COMPRESS)) {
+            multifd_flush();
+            flags = flags & ~RAM_SAVE_FLAG_COMPRESS;
+        }
         if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
                      RAM_SAVE_FLAG_MULTIFD_PAGE)) {
-- 
2.9.3
