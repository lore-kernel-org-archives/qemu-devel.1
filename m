Received: from eggs.gnu.org ([2001:4830:134:3::10]:51827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddaFW-0003tl-Oo
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddaES-0006R0-Hy
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:54:34 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  4 Aug 2017 11:50:59 +0100
Message-Id: <20170804105059.11941-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/block/block_int.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index d4f4ea7584..deb81a58bd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -147,12 +147,41 @@ struct BlockDriver {
 
     int coroutine_fn (*bdrv_co_readv)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
+
+    /**
+     * @offset: position in bytes to read at
+     * @bytes: number of bytes to read
+     * @qiov: the buffers to fill with read data
+     *
+     * @offset and @bytes will be a multiple of 'request_alignment',
+     * but the length of individual @qiov elements does not have to
+     * be a multiple.
+     *
+     * @bytes may be less than the total sizeof @iov, and will be
+     * no larger than 'max_transfer'.
+     *
+     * The buffer in @qiov may point directly to guest memory.
+     */
     int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
     int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
     int coroutine_fn (*bdrv_co_writev_flags)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flags);
+    /**
+     * @offset: position in bytes to write at
+     * @bytes: number of bytes to write
+     * @qiov: the buffers containing data to write
+     *
+     * @offset and @bytes will be a multiple of 'request_alignment',
+     * but the length of individual @qiov elements does not have to
+     * be a multiple.
+     *
+     * @bytes may be less than the total sizeof @iov, and will be
+     * no larger than 'max_transfer'.
+     *
+     * The buffer in @qiov may point directly to guest memory.
+     */
     int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
 
-- 
2.13.3
