Received: from eggs.gnu.org ([2001:4830:134:3::10]:59120)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cUFgX-0005O5-NG
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cUFgW-00054o-Kp
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:35:37 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:46601 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cUFgW-000541-Bj
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:35:36 -0500
From: Peter Lieven <pl@kamp.de>
Date: Thu, 19 Jan 2017 17:35:30 +0100
Message-Id: <1484843730-23848-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2] qemu-img: optimize is_allocated_sectors_min
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>

the current implementation always splits requests if a buffer
begins or ends with zeroes independent of the length of the
zero area. Change this to really only split off zero areas
that have at least a length of 'min' bytes.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 qemu-img.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5df66fe..8e7357d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1010,45 +1010,29 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
 }
 
 /*
- * Like is_allocated_sectors, but if the buffer starts with a used sector,
- * up to 'min' consecutive sectors containing zeros are ignored. This avoids
- * breaking up write requests for only small sparse areas.
+ * Like is_allocated_sectors, but only at least 'min' consecutive sectors
+ * containing zeros are considered unallocated. This avoids breaking up write
+ * requests for only small sparse areas.
  */
 static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
-    int min)
+                                    int min)
 {
-    int ret;
-    int num_checked, num_used;
-
-    if (n < min) {
-        min = n;
-    }
-
-    ret = is_allocated_sectors(buf, n, pnum);
-    if (!ret) {
-        return ret;
-    }
-
-    num_used = *pnum;
-    buf += BDRV_SECTOR_SIZE * *pnum;
-    n -= *pnum;
-    num_checked = num_used;
+    int num_used = 0;
 
     while (n > 0) {
-        ret = is_allocated_sectors(buf, n, pnum);
-
-        buf += BDRV_SECTOR_SIZE * *pnum;
-        n -= *pnum;
-        num_checked += *pnum;
-        if (ret) {
-            num_used = num_checked;
-        } else if (*pnum >= min) {
+        if (!is_allocated_sectors(buf, n, pnum) && *pnum >= min) {
             break;
         }
+        num_used += *pnum;
+        buf += BDRV_SECTOR_SIZE * *pnum;
+        n -= *pnum;
     }
 
-    *pnum = num_used;
-    return 1;
+    if (num_used) {
+        *pnum = num_used;
+    }
+
+    return !!num_used;
 }
 
 /*
-- 
1.9.1
