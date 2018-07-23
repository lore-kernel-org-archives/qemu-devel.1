Received: from eggs.gnu.org ([2001:4830:134:3::10]:51029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxt-0002DN-Ii
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxs-0005Ab-GM
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 23 Jul 2018 18:45:26 +0200
Message-Id: <20180723164530.26599-4-kwolf@redhat.com>
In-Reply-To: <20180723164530.26599-1-kwolf@redhat.com>
References: <20180723164530.26599-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] qemu-img: avoid overflow of min_sparse
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Peter Lieven <pl@kamp.de>

the min_sparse convert parameter can overflow (e.g. -S 1024G)
in the conversion from int64_t to int resulting in a negative
min_sparse parameter. Avoid this by limiting the valid parameters
to sane values. In fact anything exceeding the convert buffer size
is also pointless. While at it also forbid values that are non
multiple of 512 to avoid undesired behaviour. For instance, values
between 1 and 511 were legal, but resulted in full allocation.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 4a7ce43dc9..9b7506b8ae 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2005,6 +2005,8 @@ static int convert_do_copy(ImgConvertState *s)
     return s->ret;
 }
 
+#define MAX_BUF_SECTORS 32768
+
 static int img_convert(int argc, char **argv)
 {
     int c, bs_i, flags, src_flags = 0;
@@ -2100,8 +2102,12 @@ static int img_convert(int argc, char **argv)
             int64_t sval;
 
             sval = cvtnum(optarg);
-            if (sval < 0) {
-                error_report("Invalid minimum zero buffer size for sparse output specified");
+            if (sval < 0 || sval & (BDRV_SECTOR_SIZE - 1) ||
+                sval / BDRV_SECTOR_SIZE > MAX_BUF_SECTORS) {
+                error_report("Invalid buffer size for sparse output specified. "
+                    "Valid sizes are multiples of %llu up to %llu. Select "
+                    "0 to disable sparse detection (fully allocates output).",
+                    BDRV_SECTOR_SIZE, MAX_BUF_SECTORS * BDRV_SECTOR_SIZE);
                 goto fail_getopt;
             }
 
@@ -2385,9 +2391,9 @@ static int img_convert(int argc, char **argv)
     }
 
     /* increase bufsectors from the default 4096 (2M) if opt_transfer
-     * or discard_alignment of the out_bs is greater. Limit to 32768 (16MB)
-     * as maximum. */
-    s.buf_sectors = MIN(32768,
+     * or discard_alignment of the out_bs is greater. Limit to
+     * MAX_BUF_SECTORS as maximum which is currently 32768 (16MB). */
+    s.buf_sectors = MIN(MAX_BUF_SECTORS,
                         MAX(s.buf_sectors,
                             MAX(out_bs->bl.opt_transfer >> BDRV_SECTOR_BITS,
                                 out_bs->bl.pdiscard_alignment >>
-- 
2.13.6
