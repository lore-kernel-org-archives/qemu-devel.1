Received: from eggs.gnu.org ([2001:4830:134:3::10]:60783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRQ-0001nM-MT
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRP-0003IE-NO
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:10:00 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Mar 2018 19:09:12 +0800
Message-Id: <20180329110914.20888-7-famz@redhat.com>
In-Reply-To: <20180329110914.20888-1-famz@redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 6/8] raw: Implement raw_co_map_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

Because raw can be seen as a "passthrough" format, its implementation of
bdrv_co_map_range is exactly the same as bdrv_co_block_status. The
BDRV_REQ_ALLOCATE flag can be ignored because no metadata update is
necessary.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/raw-format.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index a378547c99..95e81af22d 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -263,6 +263,14 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
     return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
 }
 
+static int coroutine_fn raw_co_map_range(BlockDriverState *bs, int64_t offset,
+                                         int64_t bytes, int64_t *pnum, int64_t *map,
+                                         BlockDriverState **file,
+                                         int flags)
+{
+    return raw_co_block_status(bs, true, offset, bytes, pnum, map, file);
+}
+
 static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
                                              int64_t offset, int bytes,
                                              BdrvRequestFlags flags)
@@ -498,6 +506,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_pwrite_zeroes = &raw_co_pwrite_zeroes,
     .bdrv_co_pdiscard     = &raw_co_pdiscard,
     .bdrv_co_block_status = &raw_co_block_status,
+    .bdrv_co_map_range    = &raw_co_map_range,
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
-- 
2.14.3
