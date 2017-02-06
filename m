Received: from eggs.gnu.org ([2001:4830:134:3::10]:45300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canA8-0003sU-Lf
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canA6-0006O5-RF
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canA6-0006Nt-IE
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:10 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4A7CC0016A4
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:32:51 +0000
Message-Id: <20170206173306.20603-2-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/16] postcopy: Transmit ram size summary
 word
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Replace the host page-size in the 'advise' command by a pagesize
summary bitmap; if the VM is just using normal RAM then
this will be exactly the same as before, however if they're using
huge pages they'll be different, and thus:
   a) Migration from/to old qemu's that don't understand huge pages
      will fail early.
   b) Migrations with different size RAMBlocks will also fail early.

This catches it very early; earlier than the detailed per-block
check in the next patch.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h |  1 +
 migration/ram.c               | 17 +++++++++++++++++
 migration/savevm.c            | 32 +++++++++++++++++++++-----------
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index af9135f..96c9d6e 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -366,6 +366,7 @@ void global_state_store_running(void);
 void flush_page_queue(MigrationState *ms);
 int ram_save_queue_pages(MigrationState *ms, const char *rbname,
                          ram_addr_t start, ram_addr_t len);
+uint64_t ram_pagesize_summary(void);
 
 PostcopyState postcopy_state_get(void);
 /* Set the state and return the old state */
diff --git a/migration/ram.c b/migration/ram.c
index ef8fadf..b405e4a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -600,6 +600,23 @@ static void migration_bitmap_sync_init(void)
     iterations_prev = 0;
 }
 
+/* Returns a summary bitmap of the page sizes of all RAMBlocks;
+ * for VMs with just normal pages this is equivalent to the
+ * host page size.  If it's got some huge pages then it's the OR
+ * of all the different page sizes.
+ */
+uint64_t ram_pagesize_summary(void)
+{
+    RAMBlock *block;
+    uint64_t summary = 0;
+
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        summary |= block->page_size;
+    }
+
+    return summary;
+}
+
 static void migration_bitmap_sync(void)
 {
     RAMBlock *block;
diff --git a/migration/savevm.c b/migration/savevm.c
index de86db0..e83d01a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -869,7 +869,7 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
 void qemu_savevm_send_postcopy_advise(QEMUFile *f)
 {
     uint64_t tmp[2];
-    tmp[0] = cpu_to_be64(getpagesize());
+    tmp[0] = cpu_to_be64(ram_pagesize_summary());
     tmp[1] = cpu_to_be64(1ul << qemu_target_page_bits());
 
     trace_qemu_savevm_send_postcopy_advise();
@@ -1346,7 +1346,7 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
-    uint64_t remote_hps, remote_tps;
+    uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
 
     trace_loadvm_postcopy_handle_advise();
     if (ps != POSTCOPY_INCOMING_NONE) {
@@ -1359,17 +1359,27 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
         return -1;
     }
 
-    remote_hps = qemu_get_be64(mis->from_src_file);
-    if (remote_hps != getpagesize())  {
+    remote_pagesize_summary = qemu_get_be64(mis->from_src_file);
+    local_pagesize_summary = ram_pagesize_summary();
+
+    if (remote_pagesize_summary != local_pagesize_summary)  {
         /*
-         * Some combinations of mismatch are probably possible but it gets
-         * a bit more complicated.  In particular we need to place whole
-         * host pages on the dest at once, and we need to ensure that we
-         * handle dirtying to make sure we never end up sending part of
-         * a hostpage on it's own.
+         * This detects two potential causes of mismatch:
+         *   a) A mismatch in host page sizes
+         *      Some combinations of mismatch are probably possible but it gets
+         *      a bit more complicated.  In particular we need to place whole
+         *      host pages on the dest at once, and we need to ensure that we
+         *      handle dirtying to make sure we never end up sending part of
+         *      a hostpage on it's own.
+         *   b) The use of different huge page sizes on source/destination
+         *      a more fine grain test is performed during RAM block migration
+         *      but this test here causes a nice early clear failure, and
+         *      also fails when passed to an older qemu that doesn't
+         *      do huge pages.
          */
-        error_report("Postcopy needs matching host page sizes (s=%d d=%d)",
-                     (int)remote_hps, getpagesize());
+        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
+                                                             " d=%" PRIx64 ")",
+                     remote_pagesize_summary, local_pagesize_summary);
         return -1;
     }
 
-- 
2.9.3
