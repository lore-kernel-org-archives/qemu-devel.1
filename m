Received: from eggs.gnu.org ([2001:4830:134:3::10]:46754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH6rK-0002ji-Bs
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH6rH-0003GV-5U
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:14 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 11 May 2018 20:08:16 +0800
Message-Id: <20180511120823.7892-4-famz@redhat.com>
In-Reply-To: <20180511120823.7892-1-famz@redhat.com>
References: <20180511120823.7892-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 03/10] raw: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

Just pass down to ->file.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/raw-format.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index 803083f1a1..71ca9c627d 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -495,6 +495,36 @@ static int raw_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
     return bdrv_probe_geometry(bs->file->bs, geo);
 }
 
+static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
+                                               BdrvChild *src, uint64_t src_offset,
+                                               BdrvChild *dst, uint64_t dst_offset,
+                                               uint64_t bytes, BdrvRequestFlags flags)
+{
+    int ret;
+
+    ret = raw_adjust_offset(bs, &src_offset, bytes);
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
+    ret = raw_adjust_offset(bs, &dst_offset, bytes);
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
@@ -511,6 +541,8 @@ BlockDriver bdrv_raw = {
     .bdrv_co_pwrite_zeroes = &raw_co_pwrite_zeroes,
     .bdrv_co_pdiscard     = &raw_co_pdiscard,
     .bdrv_co_block_status = &raw_co_block_status,
+    .bdrv_co_copy_range_from = &raw_co_copy_range_from,
+    .bdrv_co_copy_range_to  = &raw_co_copy_range_to,
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
-- 
2.14.3
