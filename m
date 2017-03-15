Received: from eggs.gnu.org ([2001:4830:134:3::10]:53926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KU-0007cm-2Z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KT-0003rO-1D
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9KS-0003pu-Sd
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:04 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCC764E4CA
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:51:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:16 +0100
Message-Id: <20170315135021.6978-27-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 26/31] ram: Remove ram_save_remaining
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

Just unfold it.  Move ram_bytes_remaining() with the rest of exported
functions.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9c9533d..e7db39c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -237,16 +237,16 @@ uint64_t xbzrle_mig_pages_overflow(void)
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
@@ -1398,11 +1398,6 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
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
@@ -2109,7 +2104,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
     RAMState *rs = opaque;
     uint64_t remaining_size;
 
-    remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
+    remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
 
     if (!migration_in_postcopy(migrate_get_current()) &&
         remaining_size < max_size) {
@@ -2118,7 +2113,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
         migration_bitmap_sync(rs);
         rcu_read_unlock();
         qemu_mutex_unlock_iothread();
-        remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
+        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
     }
 
     /* We can do postcopy, and all the data is postcopiable */
-- 
2.9.3
