Received: from eggs.gnu.org ([2001:4830:134:3::10]:56616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <karl.beldan@gmail.com>) id 1fAinK-0002aB-Ti
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 17:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <karl.beldan@gmail.com>) id 1fAinK-0007Ml-0h
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 17:14:42 -0400
From: Karl Beldan <karl.beldan@gmail.com>
Date: Mon, 23 Apr 2018 21:14:20 +0000
Message-Id: <20180423211420.6917-1-karl.beldan+oss@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/block/nand: Fix bad offset in nand_blk_load
 for on-drive OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

The logic wants 512-byte aligned blk ops.
To switch to byte-based block accesses, the fixed commit changed the
blk read offset,
	PAGE_START(addr) >> 9
with
	PAGE_START(addr)
which min alignment, for on-drive OOB, is the min OOB size.
Consequently the reads are offset by PAGE_START(addr) & 0x1ff.

Fixes: 9fc0d361cc41 ("nand: Switch to byte-based block access")
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Karl Beldan <karl.beldan+oss@gmail.com>
---
 hw/block/nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index 919cb9b803..ed587f60f0 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -788,7 +788,7 @@ static void glue(nand_blk_load_, PAGE_SIZE)(NANDFlashState *s,
                             OOB_SIZE);
             s->ioaddr = s->io + SECTOR_OFFSET(s->addr) + offset;
         } else {
-            if (blk_pread(s->blk, PAGE_START(addr), s->io,
+            if (blk_pread(s->blk, PAGE_START(addr) & ~0x1ff, s->io,
                           (PAGE_SECTORS + 2) << BDRV_SECTOR_BITS) < 0) {
                 printf("%s: read error in sector %" PRIu64 "\n",
                                 __func__, PAGE_START(addr) >> 9);
-- 
2.16.1.72.g5be1f00
