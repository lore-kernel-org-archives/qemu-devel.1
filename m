Received: from eggs.gnu.org ([2001:4830:134:3::10]:45927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d13Kj-0006CQ-2p
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d13Kf-0001Bj-PI
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:04:41 -0400
From: jemmy858585@gmail.com
Date: Thu, 20 Apr 2017 12:04:25 +0800
Message-Id: <1492661065-18510-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH] qemu-img: check bs_n when use old style option
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

When use old style option like -o backing_file, img_convert
continue run when bs_n > 1, this patch fix this bug.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 qemu-img.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..c673aef 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2225,6 +2225,13 @@ static int img_convert(int argc, char **argv)
         out_baseimg = out_baseimg_param;
     }
 
+    if (bs_n > 1 && out_baseimg) {
+        error_report("-B makes no sense when concatenating multiple input "
+                     "images");
+        ret = -1;
+        goto out;
+    }
+
     /* Check if compression is supported */
     if (compress) {
         bool encryption =
-- 
1.8.3.1
