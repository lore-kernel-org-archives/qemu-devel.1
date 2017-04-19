Received: from eggs.gnu.org ([2001:4830:134:3::10]:44481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wid-0004ln-Ah
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wia-0007NM-SL
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wia-0007Mz-KM
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A9367D0C3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:59:17 +0200
Message-Id: <20170419205923.8808-54-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 53/59] ram: Use RAMBitmap type for coherence
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
index f972882..2af8080 100644
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
