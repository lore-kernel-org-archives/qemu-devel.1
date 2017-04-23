Received: from eggs.gnu.org ([2001:4830:134:3::10]:36275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2IZt-0007Jy-1w
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 10:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2IZp-0003Ir-UO
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 10:33:29 -0400
From: jemmy858585@gmail.com
Date: Sun, 23 Apr 2017 22:33:16 +0800
Message-Id: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-img: make sure contain the
 consecutive number of zero bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <lidongchen@tencent.com>

is_allocated_sectors_min don't guarantee to contain the
consecutive number of zero bytes. this patch fixes this bug.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 qemu-img.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..df6d165 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1060,9 +1060,9 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
 }
 
 /*
- * Like is_allocated_sectors, but if the buffer starts with a used sector,
- * up to 'min' consecutive sectors containing zeros are ignored. This avoids
- * breaking up write requests for only small sparse areas.
+ * Like is_allocated_sectors, but up to 'min' consecutive sectors
+ * containing zeros are ignored. This avoids breaking up write requests
+ * for only small sparse areas.
  */
 static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
     int min)
@@ -1071,11 +1071,12 @@ static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
     int num_checked, num_used;
 
     if (n < min) {
-        min = n;
+        *pnum = n;
+        return 1;
     }
 
     ret = is_allocated_sectors(buf, n, pnum);
-    if (!ret) {
+    if (!ret && *pnum >= min) {
         return ret;
     }
 
-- 
1.8.3.1
