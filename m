Received: from eggs.gnu.org ([2001:4830:134:3::10]:44355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gau0x-00050Z-I5
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 22:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gau0w-0005kp-KW
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 22:01:15 -0500
From: yuchenlin <npes87184@gmail.com>
Date: Sun, 23 Dec 2018 10:59:37 +0800
Message-Id: <20181223025939.15775-2-npes87184@gmail.com>
In-Reply-To: <20181223025939.15775-1-npes87184@gmail.com>
References: <20181223025939.15775-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/3] dmg: fix binary search
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

There is a possible hang in original binary search implementation. That is
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
