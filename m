Received: from eggs.gnu.org ([208.118.235.92]:53055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gf1TK-0000Um-Ux
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gf1TK-0003SN-CS
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:47:34 -0500
From: yuchenlin <npes87184@gmail.com>
Date: Thu,  3 Jan 2019 19:46:58 +0800
Message-Id: <20190103114700.9686-2-npes87184@gmail.com>
In-Reply-To: <20190103114700.9686-1-npes87184@gmail.com>
References: <20190103114700.9686-1-npes87184@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/3] dmg: fix binary search
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
 block/dmg.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 50e91aef6d..65a0140487 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -572,16 +572,20 @@ static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
 {
     /* binary search */
     uint32_t chunk1 = 0, chunk2 = s->n_chunks, chunk3;
-    while (chunk1 != chunk2) {
+    while (chunk1 <= chunk2) {
         chunk3 = (chunk1 + chunk2) / 2;
         if (s->sectors[chunk3] > sector_num) {
-            chunk2 = chunk3;
+            if (chunk3 == 0) {
+                goto err;
+            }
+            chunk2 = chunk3 - 1;
         } else if (s->sectors[chunk3] + s->sectorcounts[chunk3] > sector_num) {
             return chunk3;
         } else {
-            chunk1 = chunk3;
+            chunk1 = chunk3 + 1;
         }
     }
+err:
     return s->n_chunks; /* error */
 }
 
-- 
2.17.1
