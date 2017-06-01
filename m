Received: from eggs.gnu.org ([2001:4830:134:3::10]:47560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYGX-00077C-3M
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYGW-0002Cf-30
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGYGV-0002Bx-Sz
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5A04C0587C8
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 22:08:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  2 Jun 2017 00:08:09 +0200
Message-Id: <20170601220813.30535-2-quintela@redhat.com>
In-Reply-To: <20170601220813.30535-1-quintela@redhat.com>
References: <20170601220813.30535-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] ram: Call migration_page_queue_free() at
 ram_migration_cleanup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We shouldn't be using memory later than that.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 --
 migration/ram.c       | 5 +++--
 migration/ram.h       | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index af4c2cc..ea3d41c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -814,8 +814,6 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_bh_delete(s->cleanup_bh);
     s->cleanup_bh = NULL;
 
-    migration_page_queue_free();
-
     if (s->to_dst_file) {
         trace_migrate_fd_cleanup();
         qemu_mutex_unlock_iothread();
diff --git a/migration/ram.c b/migration/ram.c
index db7f4b0..e503277 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1181,10 +1181,9 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
  * be some left.  in case that there is any page left, we drop it.
  *
  */
-void migration_page_queue_free(void)
+static void migration_page_queue_free(RAMState *rs)
 {
     struct RAMSrcPageRequest *mspr, *next_mspr;
-    RAMState *rs = &ram_state;
     /* This queue generally should be empty - but in the case of a failed
      * migration might have some droppings in.
      */
@@ -1434,6 +1433,7 @@ void free_xbzrle_decoded_buf(void)
 
 static void ram_migration_cleanup(void *opaque)
 {
+    RAMState *rs = opaque;
     RAMBlock *block;
 
     /* caller have hold iothread lock or is in a bh, so there is
@@ -1459,6 +1459,7 @@ static void ram_migration_cleanup(void *opaque)
         XBZRLE.current_buf = NULL;
     }
     XBZRLE_cache_unlock();
+    migration_page_queue_free(rs);
 }
 
 static void ram_state_reset(RAMState *rs)
diff --git a/migration/ram.h b/migration/ram.h
index c9563d1..d4da419 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -53,7 +53,6 @@ void migrate_decompress_threads_create(void);
 void migrate_decompress_threads_join(void);
 
 uint64_t ram_pagesize_summary(void);
-void migration_page_queue_free(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
 void free_xbzrle_decoded_buf(void);
-- 
2.9.4
