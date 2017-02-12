Received: from eggs.gnu.org ([2001:4830:134:3::10]:47015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6R-0005LU-8s
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6Q-00077D-Bq
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:23 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:36:50 +0100
Message-Id: <20170212013704.6378-5-mreitz@redhat.com>
In-Reply-To: <20170212013704.6378-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
	<20170212013704.6378-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 07/21] block: check full backing filename when
 searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Jeff Cody <jcody@redhat.com>

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
Message-id: c2d025adca8a2b665189e6f4cf080f44126d0b6b.1485392617.git.jcody@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block.c b/block.c
index 1dbc060c3f..b8bc2a1c68 100644
--- a/block.c
+++ b/block.c
@@ -3145,6 +3145,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     int is_protocol = 0;
     BlockDriverState *curr_bs = NULL;
     BlockDriverState *retval = NULL;
+    Error *local_error = NULL;
 
     if (!bs || !bs->drv || !backing_file) {
         return NULL;
@@ -3165,6 +3166,18 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
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
+                local_error = NULL;
+            }
         } else {
             /* If not an absolute filename path, make it relative to the current
              * image's filename path */
-- 
2.11.0
