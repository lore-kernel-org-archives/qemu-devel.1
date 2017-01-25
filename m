Received: from eggs.gnu.org ([2001:4830:134:3::10]:38345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRGt-0004bH-GU
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRGn-0007BQ-4X
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:22:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cWRGm-0007BH-Vi
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:22:05 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58ED1624DB
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 17:22:04 +0000 (UTC)
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 25 Jan 2017 12:22:02 -0500
Message-Id: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] block: check full backing filename when
 searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

In bdrv_find_backing_image(), if we are searching an image for a backing
file that contains a protocol, we currently only compare unmodified
paths.

However, some management software will change the backing filename to be
a relative filename in a path.  QEMU is able to handle this fine,
because internally it will use path_combine to put together the full
protocol URI.

However, this can lead to an inability to match an image during a QAPI
command that needs to use bdrv_find_backing_image() to find the image,
when it is searched by the full URI.

When searching for a protocol filename, if the straight comparison
fails, this patch will also compare against the full backing filename to
see if that is a match.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block.c b/block.c
index 39ddea3..a173afc 100644
--- a/block.c
+++ b/block.c
@@ -3145,6 +3145,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     int is_protocol = 0;
     BlockDriverState *curr_bs = NULL;
     BlockDriverState *retval = NULL;
+    Error *local_error = NULL;
 
     if (!bs || !bs->drv || !backing_file) {
         return NULL;
@@ -3165,6 +3166,17 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
                 retval = curr_bs->backing->bs;
                 break;
             }
+            /* Also check against the full backing filename for the image */
+            bdrv_get_full_backing_filename(curr_bs, backing_file_full, PATH_MAX,
+                                           &local_error);
+            if (local_error == NULL) {
+                if (strcmp(backing_file, backing_file_full) == 0) {
+                    retval = curr_bs->backing->bs;
+                    break;
+                }
+            } else {
+                error_free(local_error);
+            }
         } else {
             /* If not an absolute filename path, make it relative to the current
              * image's filename path */
-- 
2.9.3
