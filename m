Received: from eggs.gnu.org ([2001:4830:134:3::10]:52519)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1fQuPg-0007Gj-Dg
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1fQuPd-0003hZ-BC
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:53:12 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:54224 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1fQuPd-0003gH-1c
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:53:09 -0400
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 7 Jun 2018 14:46:20 +0200
From: Peter Lieven <pl@kamp.de>
Date: Thu,  7 Jun 2018 14:46:21 +0200
Message-Id: <1528375581-29538-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH] qemu-img: align is_allocated_sectors to 4k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, Peter Lieven <pl@kamp.de>

We currently don't enforce that the sparse segments we detect during convert are
aligned. This leads to unnecessary and costly read-modify-write cycles either
internally in Qemu or in the background on the storage device as nearly all
modern filesystems or hardware has a 4k alignment internally.

As we per default set the min_sparse size to 4k it makes perfectly sense to ensure
that these sparse holes in the file are placed at 4k boundaries.

The number of RMW cycles when converting an example image [1] to a raw device that
has 4k sector size is about 4600 4k read requests to perform a total of about 15000
write requests. With this path the 4600 additional read requests are eliminated.

[1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.vmdk

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 qemu-img.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 75f1610..68eefba 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1096,24 +1096,33 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
  *
  * 'pnum' is set to the number of sectors (including and immediately following
  * the first one) that are known to be in the same allocated/unallocated state.
+ * The function will try to align 'pnum' to 8 sectors (4k) to avoid unnecassary
+ * RMW cycles on modern hardware.
  */
 static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
 {
     bool is_zero;
-    int i;
+    int i, alignment = 1;
 
     if (n <= 0) {
         *pnum = 0;
         return 0;
     }
-    is_zero = buffer_is_zero(buf, 512);
-    for(i = 1; i < n; i++) {
-        buf += 512;
-        if (is_zero != buffer_is_zero(buf, 512)) {
+
+    if (!(n & 7)) {
+        /* the buffer size is dividable by 4k */
+        alignment = 8;
+        n /= 8;
+    }
+
+    is_zero = buffer_is_zero(buf, BDRV_SECTOR_SIZE * alignment);
+    for (i = 1; i < n; i++) {
+        buf += BDRV_SECTOR_SIZE * alignment;
+        if (is_zero != buffer_is_zero(buf, BDRV_SECTOR_SIZE * alignment)) {
             break;
         }
     }
-    *pnum = i;
+    *pnum = i * alignment;
     return !is_zero;
 }
 
-- 
2.7.4
