Received: from eggs.gnu.org ([2001:4830:134:3::10]:40781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuay-00037p-Nf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuax-0003MZ-Tb
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcuax-0003Lz-N9
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57DAF77889
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:06 +0100
Message-Id: <20180710153016.131258-6-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] migration: simplify check to use qemu
 file buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

Firstly, renaming the old matching_page_sizes variable to
matches_target_page_size, which suites more to what it did (it only
checks against target page size rather than multiple page sizes).
Meanwhile, simplify the check logic a bit, and enhance the comments.
Should have no functional change.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180710091902.28780-2-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 23cea47090..49068e86d3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3580,7 +3580,7 @@ static int ram_load_postcopy(QEMUFile *f)
 {
     int flags = 0, ret = 0;
     bool place_needed = false;
-    bool matching_page_sizes = false;
+    bool matches_target_page_size = false;
     MigrationIncomingState *mis = migration_incoming_get_current();
     /* Temporary page that is later 'placed' */
     void *postcopy_host_page = postcopy_get_tmp_page(mis);
@@ -3620,7 +3620,7 @@ static int ram_load_postcopy(QEMUFile *f)
                 ret = -EINVAL;
                 break;
             }
-            matching_page_sizes = block->page_size == TARGET_PAGE_SIZE;
+            matches_target_page_size = block->page_size == TARGET_PAGE_SIZE;
             /*
              * Postcopy requires that we place whole host pages atomically;
              * these may be huge pages for RAMBlocks that are backed by
@@ -3668,12 +3668,17 @@ static int ram_load_postcopy(QEMUFile *f)
 
         case RAM_SAVE_FLAG_PAGE:
             all_zero = false;
-            if (!place_needed || !matching_page_sizes) {
+            if (!matches_target_page_size) {
+                /* For huge pages, we always use temporary buffer */
                 qemu_get_buffer(f, page_buffer, TARGET_PAGE_SIZE);
             } else {
-                /* Avoids the qemu_file copy during postcopy, which is
-                 * going to do a copy later; can only do it when we
-                 * do this read in one go (matching page sizes)
+                /*
+                 * For small pages that matches target page size, we
+                 * avoid the qemu_file copy.  Instead we directly use
+                 * the buffer of QEMUFile to place the page.  Note: we
+                 * cannot do any QEMUFile operation before using that
+                 * buffer to make sure the buffer is valid when
+                 * placing the page.
                  */
                 qemu_get_buffer_in_place(f, (uint8_t **)&place_source,
                                          TARGET_PAGE_SIZE);
-- 
2.17.1
