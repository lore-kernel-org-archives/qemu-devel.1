Received: from eggs.gnu.org ([2001:4830:134:3::10]:45879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XCx-0003NG-KV
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XCw-0007r2-3v
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XCv-0007qv-RY
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 973EBC59C7
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:33 +0200
Message-Id: <20170421115646.15544-53-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 52/65] ram: rename last_ram_offset()
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                  |  6 +++---
 include/exec/ram_addr.h |  2 +-
 migration/ram.c         | 11 +++++------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/exec.c b/exec.c
index 7a640c7..de843f4 100644
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
index 8a1372c..a8411c7 100644
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
index 932a96e..f972882 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1537,7 +1537,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
  */
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
 {
-    int64_t ram_pages = last_ram_offset() >> TARGET_PAGE_BITS;
+    unsigned long ram_pages = last_ram_page();
     RAMState *rs = &ram_state;
     int64_t cur;
     int64_t linelen = 128;
@@ -1904,8 +1904,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
      * Update the unsentmap to be unsentmap = unsentmap | dirty
      */
     bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
-    bitmap_or(unsentmap, unsentmap, bitmap,
-               last_ram_offset() >> TARGET_PAGE_BITS);
+    bitmap_or(unsentmap, unsentmap, bitmap, last_ram_page());
 
 
     trace_ram_postcopy_send_discard_bitmap();
@@ -1953,7 +1952,7 @@ err:
 
 static int ram_state_init(RAMState *rs)
 {
-    int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
+    unsigned long ram_bitmap_pages;
 
     memset(rs, 0, sizeof(*rs));
     qemu_mutex_init(&rs->bitmap_mutex);
@@ -1999,7 +1998,7 @@ static int ram_state_init(RAMState *rs)
     rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
-        ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
+        ram_bitmap_pages = last_ram_page();
         rs->ram_bitmap->bmap = bitmap_new(ram_bitmap_pages);
         bitmap_set(rs->ram_bitmap->bmap, 0, ram_bitmap_pages);
 
@@ -2460,7 +2459,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
  */
 int ram_postcopy_incoming_init(MigrationIncomingState *mis)
 {
-    size_t ram_pages = last_ram_offset() >> TARGET_PAGE_BITS;
+    unsigned long ram_pages = last_ram_page();
 
     return postcopy_ram_incoming_init(mis, ram_pages);
 }
-- 
2.9.3
