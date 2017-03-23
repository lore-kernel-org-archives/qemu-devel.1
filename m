Received: from eggs.gnu.org ([2001:4830:134:3::10]:46092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dP-0000Ej-5Z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dN-0000l0-Pf
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9dN-0000kq-Ip
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 861233DBC9
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:47:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:43 +0100
Message-Id: <20170323204544.12015-51-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 50/51] ram: Use RAMBitmap type for coherence
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
---
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1be9a6b..4d62788 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1449,7 +1449,7 @@ void free_xbzrle_decoded_buf(void)
     xbzrle_decoded_buf = NULL;
 }
 
-static void migration_bitmap_free(struct RAMBitmap *bmap)
+static void migration_bitmap_free(RAMBitmap *bmap)
 {
     g_free(bmap->bmap);
     g_free(bmap->unsentmap);
@@ -1463,7 +1463,7 @@ static void ram_migration_cleanup(void *opaque)
     /* caller have hold iothread lock or is in a bh, so there is
      * no writing race against this migration_bitmap
      */
-    struct RAMBitmap *bitmap = rs->ram_bitmap;
+    RAMBitmap *bitmap = rs->ram_bitmap;
     atomic_rcu_set(&rs->ram_bitmap, NULL);
     if (bitmap) {
         memory_global_dirty_log_stop();
@@ -1502,8 +1502,8 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
      * no writing race against this migration_bitmap
      */
     if (rs->ram_bitmap) {
-        struct RAMBitmap *old_bitmap = rs->ram_bitmap, *bitmap;
-        bitmap = g_new(struct RAMBitmap, 1);
+        RAMBitmap *old_bitmap = rs->ram_bitmap, *bitmap;
+        bitmap = g_new(RAMBitmap, 1);
         bitmap->bmap = bitmap_new(new);
 
         /* prevent migration_bitmap content from being set bit
@@ -1993,7 +1993,7 @@ static int ram_state_init(RAMState *rs)
     rcu_read_lock();
     ram_state_reset(rs);
 
-    rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
+    rs->ram_bitmap = g_new0(RAMBitmap, 1);
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
         ram_bitmap_pages = last_ram_page();
-- 
2.9.3
