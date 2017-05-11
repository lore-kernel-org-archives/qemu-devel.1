Received: from eggs.gnu.org ([2001:4830:134:3::10]:41932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d8qMU-0005rr-HW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d8qMR-0007B1-Uo
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d8qMR-0007AY-L5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73BF5796FE
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 15:50:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 11 May 2017 17:50:28 +0200
Message-Id: <20170511155028.6543-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH] ram: Rename RAM_SAVE_FLAG_COMPRESS to
 RAM_SAVE_FLAG_ZERO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Reflects better what it does now, and avoid confussions with
RAM_SAVE_FLAG_COMPRESS_PAGE.

Signed-off-by: Juan Quintela <quintela@redhat.com>

---

Hi

I always forgot the diffe9rent between COMPRESS and COMPRESS_PAGE.
This patch makes it clean which is which.

Please, comment.

Later, Juan.


---
 migration/ram.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 995d1fc..76c118c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -48,8 +48,14 @@
 /***********************************************************/
 /* ram save/restore */
 
+/* RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
+ * worked for pages that where filled with the same char.  We switched
+ * it to only search for the zero value.  And to avoid confusion with
+ * RAM_SSAVE_FLAG_COMPRESS_PAGE just rename it.
+ */
+
 #define RAM_SAVE_FLAG_FULL     0x01 /* Obsolete, not used anymore */
-#define RAM_SAVE_FLAG_COMPRESS 0x02
+#define RAM_SAVE_FLAG_ZERO     0x02
 #define RAM_SAVE_FLAG_MEM_SIZE 0x04
 #define RAM_SAVE_FLAG_PAGE     0x08
 #define RAM_SAVE_FLAG_EOS      0x10
@@ -746,7 +752,7 @@ static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
         rs->zero_pages++;
         rs->bytes_transferred +=
-            save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_COMPRESS);
+            save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_ZERO);
         qemu_put_byte(rs->f, 0);
         rs->bytes_transferred += 1;
         pages = 1;
@@ -2406,7 +2412,7 @@ static int ram_load_postcopy(QEMUFile *f)
 
         trace_ram_load_postcopy_loop((uint64_t)addr, flags);
         place_needed = false;
-        if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE)) {
+        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE)) {
             block = ram_block_from_stream(f, flags);
 
             host = host_from_ram_block_offset(block, addr);
@@ -2453,7 +2459,7 @@ static int ram_load_postcopy(QEMUFile *f)
         last_host = host;
 
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
-        case RAM_SAVE_FLAG_COMPRESS:
+        case RAM_SAVE_FLAG_ZERO:
             ch = qemu_get_byte(f);
             memset(page_buffer, ch, TARGET_PAGE_SIZE);
             if (ch) {
@@ -2542,7 +2548,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         flags = addr & ~TARGET_PAGE_MASK;
         addr &= TARGET_PAGE_MASK;
 
-        if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE |
+        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);
 
@@ -2604,7 +2610,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             }
             break;
 
-        case RAM_SAVE_FLAG_COMPRESS:
+        case RAM_SAVE_FLAG_ZERO:
             ch = qemu_get_byte(f);
             ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
             break;
-- 
2.9.3
