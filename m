Received: from eggs.gnu.org ([2001:4830:134:3::10]:60318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdl-00024m-TQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdf-00053v-Uq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:19:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:18:02 +0100
Message-Id: <20180313161803.1814-41-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 40/41] vpc: Require aligned size in
 .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Perform the rounding to match a CHS geometry only in the legacy code
path in .bdrv_co_create_opts. QMP now requires that the user already
passes a CHS aligned image size, unless force-size=true is given.

CHS alignment is required to make the image compatible with Virtual PC,
but not for use with newer Microsoft hypervisors.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/vpc.c | 113 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 31 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 8824211713..28ffa0d2f8 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -902,6 +902,62 @@ static int create_fixed_disk(BlockBackend *blk, uint8_t *buf,
     return ret;
 }
 
+static int calculate_rounded_image_size(BlockdevCreateOptionsVpc *vpc_opts,
+                                        uint16_t *out_cyls,
+                                        uint8_t *out_heads,
+                                        uint8_t *out_secs_per_cyl,
+                                        int64_t *out_total_sectors,
+                                        Error **errp)
+{
+    int64_t total_size = vpc_opts->size;
+    uint16_t cyls = 0;
+    uint8_t heads = 0;
+    uint8_t secs_per_cyl = 0;
+    int64_t total_sectors;
+    int i;
+
+    /*
+     * Calculate matching total_size and geometry. Increase the number of
+     * sectors requested until we get enough (or fail). This ensures that
+     * qemu-img convert doesn't truncate images, but rather rounds up.
+     *
+     * If the image size can't be represented by a spec conformant CHS geometry,
+     * we set the geometry to 65535 x 16 x 255 (CxHxS) sectors and use
+     * the image size from the VHD footer to calculate total_sectors.
+     */
+    if (vpc_opts->force_size) {
+        /* This will force the use of total_size for sector count, below */
+        cyls         = VHD_CHS_MAX_C;
+        heads        = VHD_CHS_MAX_H;
+        secs_per_cyl = VHD_CHS_MAX_S;
+    } else {
+        total_sectors = MIN(VHD_MAX_GEOMETRY, total_size / BDRV_SECTOR_SIZE);
+        for (i = 0; total_sectors > (int64_t)cyls * heads * secs_per_cyl; i++) {
+            calculate_geometry(total_sectors + i, &cyls, &heads, &secs_per_cyl);
+        }
+    }
+
+    if ((int64_t)cyls * heads * secs_per_cyl == VHD_MAX_GEOMETRY) {
+        total_sectors = total_size / BDRV_SECTOR_SIZE;
+        /* Allow a maximum disk size of 2040 GiB */
+        if (total_sectors > VHD_MAX_SECTORS) {
+            error_setg(errp, "Disk size is too large, max size is 2040 GiB");
+            return -EFBIG;
+        }
+    } else {
+        total_sectors = (int64_t) cyls * heads * secs_per_cyl;
+    }
+
+    *out_total_sectors = total_sectors;
+    if (out_cyls) {
+        *out_cyls = cyls;
+        *out_heads = heads;
+        *out_secs_per_cyl = secs_per_cyl;
+    }
+
+    return 0;
+}
+
 static int coroutine_fn vpc_co_create(BlockdevCreateOptions *opts,
                                       Error **errp)
 {
@@ -911,7 +967,6 @@ static int coroutine_fn vpc_co_create(BlockdevCreateOptions *opts,
 
     uint8_t buf[1024];
     VHDFooter *footer = (VHDFooter *) buf;
-    int i;
     uint16_t cyls = 0;
     uint8_t heads = 0;
     uint8_t secs_per_cyl = 0;
@@ -953,38 +1008,22 @@ static int coroutine_fn vpc_co_create(BlockdevCreateOptions *opts,
     }
     blk_set_allow_write_beyond_eof(blk, true);
 
-    /*
-     * Calculate matching total_size and geometry. Increase the number of
-     * sectors requested until we get enough (or fail). This ensures that
-     * qemu-img convert doesn't truncate images, but rather rounds up.
-     *
-     * If the image size can't be represented by a spec conformant CHS geometry,
-     * we set the geometry to 65535 x 16 x 255 (CxHxS) sectors and use
-     * the image size from the VHD footer to calculate total_sectors.
-     */
-    if (vpc_opts->force_size) {
-        /* This will force the use of total_size for sector count, below */
-        cyls         = VHD_CHS_MAX_C;
-        heads        = VHD_CHS_MAX_H;
-        secs_per_cyl = VHD_CHS_MAX_S;
-    } else {
-        total_sectors = MIN(VHD_MAX_GEOMETRY, total_size / BDRV_SECTOR_SIZE);
-        for (i = 0; total_sectors > (int64_t)cyls * heads * secs_per_cyl; i++) {
-            calculate_geometry(total_sectors + i, &cyls, &heads, &secs_per_cyl);
-        }
+    /* Get geometry and check that it matches the image size*/
+    ret = calculate_rounded_image_size(vpc_opts, &cyls, &heads, &secs_per_cyl,
+                                       &total_sectors, errp);
+    if (ret < 0) {
+        goto out;
     }
 
-    if ((int64_t)cyls * heads * secs_per_cyl == VHD_MAX_GEOMETRY) {
-        total_sectors = total_size / BDRV_SECTOR_SIZE;
-        /* Allow a maximum disk size of 2040 GiB */
-        if (total_sectors > VHD_MAX_SECTORS) {
-            error_setg(errp, "Disk size is too large, max size is 2040 GiB");
-            ret = -EFBIG;
-            goto out;
-        }
-    } else {
-        total_sectors = (int64_t)cyls * heads * secs_per_cyl;
-        total_size = total_sectors * BDRV_SECTOR_SIZE;
+    if (total_size != total_sectors * BDRV_SECTOR_SIZE) {
+        error_setg(errp, "The requested image size cannot be represented in "
+                         "CHS geometry");
+        error_append_hint(errp, "Try size=%llu or force-size=on (the "
+                                "latter makes the image incompatible with "
+                                "Virtual PC)",
+                          total_sectors * BDRV_SECTOR_SIZE);
+        ret = -EINVAL;
+        goto out;
     }
 
     /* Prepare the Hard Disk Footer */
@@ -1102,6 +1141,18 @@ static int coroutine_fn vpc_co_create_opts(const char *filename,
     create_options->u.vpc.size =
         ROUND_UP(create_options->u.vpc.size, BDRV_SECTOR_SIZE);
 
+    if (!create_options->u.vpc.force_size) {
+        int64_t total_sectors;
+        ret = calculate_rounded_image_size(&create_options->u.vpc, NULL, NULL,
+                                           NULL, &total_sectors, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        create_options->u.vpc.size = total_sectors * BDRV_SECTOR_SIZE;
+    }
+
+
     /* Create the vpc image (format layer) */
     ret = vpc_co_create(create_options, errp);
 
-- 
2.13.6
