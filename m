Received: from eggs.gnu.org ([2001:4830:134:3::10]:40376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gaLK0-0000iC-8a
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gaLJx-00049u-D0
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:58:36 -0500
From: yuchenlin <npes87184@gmail.com>
Date: Fri, 21 Dec 2018 21:58:03 +0800
Message-Id: <20181221135803.9583-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, yuchenlin <npes87184@gmail.com>

There is a possible hang in original binary searsh implemtation. That is
if chunk1 = 4, chunk2 = 5, chunk3 = 4, and we go else case.

The chunk1 will be still 4, and so on.

Signed-off-by: yuchenlin <npes87184@gmail.com>
---
 block/dmg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 50e91aef6d..0e05702f5d 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -572,14 +572,14 @@ static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
 {
     /* binary search */
     uint32_t chunk1 = 0, chunk2 = s->n_chunks, chunk3;
-    while (chunk1 != chunk2) {
+    while (chunk1 <= chunk2) {
         chunk3 = (chunk1 + chunk2) / 2;
         if (s->sectors[chunk3] > sector_num) {
-            chunk2 = chunk3;
+            chunk2 = chunk3 - 1;
         } else if (s->sectors[chunk3] + s->sectorcounts[chunk3] > sector_num) {
             return chunk3;
         } else {
-            chunk1 = chunk3;
+            chunk1 = chunk3 + 1;
         }
     }
     return s->n_chunks; /* error */
-- 
2.17.1
