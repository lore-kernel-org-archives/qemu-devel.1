Received: from eggs.gnu.org ([2001:4830:134:3::10]:46091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dP-0000Ei-5b
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dM-0000kY-8m
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9dM-0000jw-0q
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:47:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F37F67AE9A
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:42 +0100
Message-Id: <20170323204544.12015-50-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 49/51] ram: rename last_ram_offset()
 last_ram_pages()
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

We always use it as pages anyways.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 exec.c                  |  6 +++---
 include/exec/ram_addr.h |  2 +-
 migration/ram.c         | 11 +++++------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/exec.c b/exec.c
index 9a4c385..2cae288 100644
--- a/exec.c
+++ b/exec.c
@@ -1528,7 +1528,7 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
     return offset;
 }
 
-ram_addr_t last_ram_offset(void)
+unsigned long last_ram_page(void)
 {
     RAMBlock *block;
     ram_addr_t last = 0;
@@ -1538,7 +1538,7 @@ ram_addr_t last_ram_offset(void)
         last = MAX(last, block->offset + block->max_length);
     }
     rcu_read_unlock();
-    return last;
+    return last >> TARGET_PAGE_BITS;
 }
 
 static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
@@ -1727,7 +1727,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     ram_addr_t old_ram_size, new_ram_size;
     Error *err = NULL;
 
-    old_ram_size = last_ram_offset() >> TARGET_PAGE_BITS;
+    old_ram_size = last_ram_page();
 
     qemu_mutex_lock_ramlist();
     new_block->offset = find_ram_offset(new_block->max_length);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index d50c970..bbbfc7d 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -53,7 +53,7 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
 }
 
 long qemu_getrampagesize(void);
-ram_addr_t last_ram_offset(void);
+unsigned long last_ram_page(void);
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    bool share, const char *mem_path,
                                    Error **errp);
diff --git a/migration/ram.c b/migration/ram.c
index 3f283ba..1be9a6b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1535,7 +1535,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
  */
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
 {
-    int64_t ram_pages = last_ram_offset() >> TARGET_PAGE_BITS;
+    unsigned long ram_pages = last_ram_page();
     RAMState *rs = &ram_state;
     int64_t cur;
     int64_t linelen = 128;
@@ -1902,8 +1902,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
      * Update the unsentmap to be unsentmap = unsentmap | dirty
      */
     bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-    bitmap_or(unsentmap, unsentmap, bitmap,
-               last_ram_offset() >> TARGET_PAGE_BITS);
+    bitmap_or(unsentmap, unsentmap, bitmap, last_ram_page());
 
 
     trace_ram_postcopy_send_discard_bitmap();
@@ -1951,7 +1950,7 @@ err:
 
 static int ram_state_init(RAMState *rs)
 {
-    int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
+    unsigned long ram_bitmap_pages;
 
     memset(rs, 0, sizeof(*rs));
     qemu_mutex_init(&rs->bitmap_mutex);
@@ -1997,7 +1996,7 @@ static int ram_state_init(RAMState *rs)
     rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
-        ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
+        ram_bitmap_pages = last_ram_page();
         rs->ram_bitmap->bmap = bitmap_new(ram_bitmap_pages);
         bitmap_set(rs->ram_bitmap->bmap, 0, ram_bitmap_pages);
 
@@ -2458,7 +2457,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
  */
 int ram_postcopy_incoming_init(MigrationIncomingState *mis)
 {
-    size_t ram_pages = last_ram_offset() >> TARGET_PAGE_BITS;
+    unsigned long ram_pages = last_ram_page();
 
     return postcopy_ram_incoming_init(mis, ram_pages);
 }
-- 
2.9.3
