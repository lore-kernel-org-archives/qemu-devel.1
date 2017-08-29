Received: from eggs.gnu.org ([2001:4830:134:3::10]:48723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCm-0001dx-Pk
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCj-000603-IX
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35078
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCj-0005zQ-DQ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8qJ017779
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:29 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2ww78-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:28 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:28 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:40 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-6-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 05/79] qemu-img/convert: Move bs_n > 1 && -B
 check down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

It does not make much sense to use a backing image for the target when
you concatenate multiple images (because then there is no correspondence
between the source images' backing files and the target's); but it was
still possible to give one by using -o backing_file=X instead of -B X.

Fix this by moving the check.

(Also, change the error message because -B is not the only way to
 specify the backing file, evidently.)

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
* applied patch from v1 of series as suggested by author
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c                 | 14 +++++++-------
 tests/qemu-iotests/122.out |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index cfc3bc3..4b2d59a 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2113,13 +2113,6 @@ static int img_convert(int argc, char **argv)
     }
 
 
-    if (bs_n > 1 && out_baseimg) {
-        error_report("-B makes no sense when concatenating multiple input "
-                     "images");
-        ret = -1;
-        goto out;
-    }
-
     src_flags = 0;
     ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
     if (ret < 0) {
@@ -2229,6 +2222,13 @@ static int img_convert(int argc, char **argv)
         out_baseimg = out_baseimg_param;
     }
 
+    if (bs_n > 1 && out_baseimg) {
+        error_report("Having a backing file for the target makes no sense when "
+                     "concatenating multiple input images");
+        ret = -1;
+        goto out;
+    }
+
     /* Check if compression is supported */
     if (compress) {
         bool encryption =
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 98814de..9317d80 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -61,8 +61,8 @@ read 65536/65536 bytes at offset 4194304
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 8388608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: -B makes no sense when concatenating multiple input images
-qemu-img: -B makes no sense when concatenating multiple input images
+qemu-img: Having a backing file for the target makes no sense when concatenating multiple input images
+qemu-img: Having a backing file for the target makes no sense when concatenating multiple input images
 
 === Compression with misaligned allocations and image sizes ===
 
-- 
2.7.4
