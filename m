Received: from eggs.gnu.org ([2001:4830:134:3::10]:45124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cH-0007aT-Tu
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cH-0008VO-2a
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cG-0008V6-Sz
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEFE2342C73
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:45:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:44:55 +0100
Message-Id: <20170323204544.12015-3-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 02/51] ram: rename block_name to rbname
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

So all places are consisten on the nambing of a block name parameter.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 76f1fc4..21047c5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -743,14 +743,14 @@ static int save_zero_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset,
     return pages;
 }
 
-static void ram_release_pages(MigrationState *ms, const char *block_name,
+static void ram_release_pages(MigrationState *ms, const char *rbname,
                               uint64_t offset, int pages)
 {
     if (!migrate_release_ram() || !migration_in_postcopy(ms)) {
         return;
     }
 
-    ram_discard_range(NULL, block_name, offset, pages << TARGET_PAGE_BITS);
+    ram_discard_range(NULL, rbname, offset, pages << TARGET_PAGE_BITS);
 }
 
 /**
@@ -1942,25 +1942,24 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
  * Returns zero on success
  *
  * @mis: current migration incoming state
- * @block_name: Name of the RAMBLock of the request. NULL means the
- *              same that last one.
+ * @rbname: name of the RAMBLock of the request. NULL means the
+ *          same that last one.
  * @start: RAMBlock starting page
  * @length: RAMBlock size
  */
 int ram_discard_range(MigrationIncomingState *mis,
-                      const char *block_name,
+                      const char *rbname,
                       uint64_t start, size_t length)
 {
     int ret = -1;
 
-    trace_ram_discard_range(block_name, start, length);
+    trace_ram_discard_range(rbname, start, length);
 
     rcu_read_lock();
-    RAMBlock *rb = qemu_ram_block_by_name(block_name);
+    RAMBlock *rb = qemu_ram_block_by_name(rbname);
 
     if (!rb) {
-        error_report("ram_discard_range: Failed to find block '%s'",
-                     block_name);
+        error_report("ram_discard_range: Failed to find block '%s'", rbname);
         goto err;
     }
 
-- 
2.9.3
