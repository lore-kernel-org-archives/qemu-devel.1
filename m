Received: from eggs.gnu.org ([2001:4830:134:3::10]:44137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wi5-0004FF-SY
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wi1-0007Ad-25
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wi0-00079I-SY
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB2B38FD1B
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:58:55 +0200
Message-Id: <20170419205923.8808-32-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 31/59] ram: Remove ram_save_remaining
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Just unfold it.  Move ram_bytes_remaining() with the rest of exported
functions.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index cd7226e..2f5cbd1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -244,16 +244,16 @@ uint64_t xbzrle_mig_pages_overflow(void)
     return ram_state.xbzrle_overflows;
 }
 
-static ram_addr_t ram_save_remaining(void)
-{
-    return ram_state.migration_dirty_pages;
-}
-
 uint64_t ram_bytes_transferred(void)
 {
     return ram_state.bytes_transferred;
 }
 
+uint64_t ram_bytes_remaining(void)
+{
+    return ram_state.migration_dirty_pages * TARGET_PAGE_SIZE;
+}
+
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* Current block being searched */
@@ -1440,11 +1440,6 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
     }
 }
 
-uint64_t ram_bytes_remaining(void)
-{
-    return ram_save_remaining() * TARGET_PAGE_SIZE;
-}
-
 uint64_t ram_bytes_total(void)
 {
     RAMBlock *block;
@@ -2212,7 +2207,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
     RAMState *rs = opaque;
     uint64_t remaining_size;
 
-    remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
+    remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
 
     if (!migration_in_postcopy(migrate_get_current()) &&
         remaining_size < max_size) {
@@ -2221,7 +2216,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
         migration_bitmap_sync(rs);
         rcu_read_unlock();
         qemu_mutex_unlock_iothread();
-        remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
+        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
     }
 
     /* We can do postcopy, and all the data is postcopiable */
-- 
2.9.3
