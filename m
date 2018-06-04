Received: from eggs.gnu.org ([2001:4830:134:3::10]:36598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnXg-0007pi-Ag
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fPnXf-0001QW-FZ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:20:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  4 Jun 2018 12:20:28 +0100
Message-Id: <20180604112036.2715-4-stefanha@redhat.com>
In-Reply-To: <20180604112036.2715-1-stefanha@redhat.com>
References: <20180604112036.2715-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 03/11] raw: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fam Zheng <famz@redhat.com>

Just pass down to ->file.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180601092648.24614-4-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/raw-format.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index b69a0674b3..f2e468df6f 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -497,6 +497,36 @@ static int raw_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
     return bdrv_probe_geometry(bs->file->bs, geo);
 }
 
+static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
+                                               BdrvChild *src, uint64_t src_offset,
+                                               BdrvChild *dst, uint64_t dst_offset,
+                                               uint64_t bytes, BdrvRequestFlags flags)
+{
+    int ret;
+
+    ret = raw_adjust_offset(bs, &src_offset, bytes, false);
+    if (ret) {
+        return ret;
+    }
+    return bdrv_co_copy_range_from(bs->file, src_offset, dst, dst_offset,
+                                   bytes, flags);
+}
+
+static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
+                                             BdrvChild *src, uint64_t src_offset,
+                                             BdrvChild *dst, uint64_t dst_offset,
+                                             uint64_t bytes, BdrvRequestFlags flags)
+{
+    int ret;
+
+    ret = raw_adjust_offset(bs, &dst_offset, bytes, true);
+    if (ret) {
+        return ret;
+    }
+    return bdrv_co_copy_range_to(src, src_offset, bs->file, dst_offset, bytes,
+                                 flags);
+}
+
 BlockDriver bdrv_raw = {
     .format_name          = "raw",
     .instance_size        = sizeof(BDRVRawState),
@@ -513,6 +543,8 @@ BlockDriver bdrv_raw = {
     .bdrv_co_pwrite_zeroes = &raw_co_pwrite_zeroes,
     .bdrv_co_pdiscard     = &raw_co_pdiscard,
     .bdrv_co_block_status = &raw_co_block_status,
+    .bdrv_co_copy_range_from = &raw_co_copy_range_from,
+    .bdrv_co_copy_range_to  = &raw_co_copy_range_to,
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
-- 
2.17.1
