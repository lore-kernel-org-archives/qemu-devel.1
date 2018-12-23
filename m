Received: from eggs.gnu.org ([2001:4830:134:3::10]:44324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gau0w-0004zb-Jb
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 22:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gau0u-0005ij-Jv
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 22:01:14 -0500
From: yuchenlin <npes87184@gmail.com>
Date: Sun, 23 Dec 2018 10:59:38 +0800
Message-Id: <20181223025939.15775-3-npes87184@gmail.com>
In-Reply-To: <20181223025939.15775-1-npes87184@gmail.com>
References: <20181223025939.15775-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/3] dmg: use enumeration type instead of
 hard coding number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, yuchenlin <npes87184@gmail.com>

Signed-off-by: yuchenlin <npes87184@gmail.com>
---
 block/dmg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 0e05702f5d..6b0a057bf8 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -267,7 +267,7 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
 
         /* all-zeroes sector (type 2) does not need to be "uncompressed" and can
          * therefore be unbounded. */
-        if (s->types[i] != 2 && s->sectorcounts[i] > DMG_SECTORCOUNTS_MAX) {
+        if (s->types[i] != UDIG && s->sectorcounts[i] > DMG_SECTORCOUNTS_MAX) {
             error_report("sector count %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
                          s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
@@ -706,7 +706,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         /* Special case: current chunk is all zeroes. Do not perform a memcpy as
          * s->uncompressed_chunk may be too small to cover the large all-zeroes
          * section. dmg_read_chunk is called to find s->current_chunk */
-        if (s->types[s->current_chunk] == 2) { /* all zeroes block entry */
+        if (s->types[s->current_chunk] == UDIG) { /* all zeroes block entry */
             qemu_iovec_memset(qiov, i * 512, 0, 512);
             continue;
         }
-- 
2.17.1
