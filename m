Received: from eggs.gnu.org ([2001:4830:134:3::10]:56189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cZbEO-0001Nj-QU
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cZbEM-0002mv-7s
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:36:40 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cZbEM-0002lr-0P
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:36:38 -0500
Received: by mail-pg0-x241.google.com with SMTP id 204so1688662pge.2
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 02:36:37 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Fri,  3 Feb 2017 16:06:38 +0530
Message-Id: <1486118198-8965-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2] migrate: Introduce zero RAM checks to skip
 RAM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: quintela@redhat.com, dgilbert@redhat.com, amit.shah@redhat.com, berrange@redhat.com, pbonzini@redhat.com, groug@kaod.org, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Migration of a "none" machine with no RAM crashes abruptly as
bitmap_new() fails and thus aborts. Instead place zero RAM checks at
appropriate places to skip migration of RAM in this case and complete
migration successfully for devices only.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
Changes in v2:
- try to migrate successfully by skipping RAM (Paolo, Greg)
- drop the idea of erroring out and failing nicely
 migration/ram.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ef8fadf..2f19566 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1325,6 +1325,11 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
     ram_addr_t dirty_ram_abs; /* Address of the start of the dirty page in
                                  ram_addr_t space */
 
+    /* No dirty page as there is zero RAM */
+    if (!ram_bytes_total()) {
+        return pages;
+    }
+
     pss.block = last_seen_block;
     pss.offset = last_offset;
     pss.complete_round = false;
@@ -1912,14 +1917,17 @@ static int ram_save_init_globals(void)
     bytes_transferred = 0;
     reset_ram_globals();
 
-    ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
-    migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
-    migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
-    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
+    /* Skip setting bitmap if there is no RAM */
+    if (ram_bytes_total()) {
+        ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
+        migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
+        migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
+        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
 
-    if (migrate_postcopy_ram()) {
-        migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
-        bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
+        if (migrate_postcopy_ram()) {
+            migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
+            bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
+        }
     }
 
     /*
-- 
2.6.2
