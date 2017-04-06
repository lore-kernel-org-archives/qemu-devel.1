Received: from eggs.gnu.org ([2001:4830:134:3::10]:50903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7BS-0006iq-2r
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7BQ-0000Ds-UN
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7BQ-0000DU-Fq
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E5E6C04BD4C
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:10:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:09:12 +0200
Message-Id: <20170406130913.2232-54-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 53/54] ram: Use RAMBitmap type for coherence
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 3675dad..92d6ff7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1451,7 +1451,7 @@ void free_xbzrle_decoded_buf(void)
     xbzrle_decoded_buf = NULL;
 }
 
-static void migration_bitmap_free(struct RAMBitmap *bmap)
+static void migration_bitmap_free(RAMBitmap *bmap)
 {
     g_free(bmap->bmap);
     g_free(bmap->unsentmap);
@@ -1465,7 +1465,7 @@ static void ram_migration_cleanup(void *opaque)
     /* caller have hold iothread lock or is in a bh, so there is
      * no writing race against this migration_bitmap
      */
-    struct RAMBitmap *bitmap = rs->ram_bitmap;
+    RAMBitmap *bitmap = rs->ram_bitmap;
     atomic_rcu_set(&rs->ram_bitmap, NULL);
     if (bitmap) {
         memory_global_dirty_log_stop();
@@ -1504,8 +1504,8 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
      * no writing race against this migration_bitmap
      */
     if (rs->ram_bitmap) {
-        struct RAMBitmap *old_bitmap = rs->ram_bitmap, *bitmap;
-        bitmap = g_new(struct RAMBitmap, 1);
+        RAMBitmap *old_bitmap = rs->ram_bitmap, *bitmap;
+        bitmap = g_new(RAMBitmap, 1);
         bitmap->bmap = bitmap_new(new);
 
         /* prevent migration_bitmap content from being set bit
@@ -1995,7 +1995,7 @@ static int ram_state_init(RAMState *rs)
     rcu_read_lock();
     ram_state_reset(rs);
 
-    rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
+    rs->ram_bitmap = g_new0(RAMBitmap, 1);
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
         ram_bitmap_pages = last_ram_page();
-- 
2.9.3
