Received: from eggs.gnu.org ([2001:4830:134:3::10]:56475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dddJ3-0003pf-GN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dddIo-0004nU-AN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:10:25 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  4 Aug 2017 15:08:26 +0100
Message-Id: <20170804140826.1351-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3] block: document semanatics of
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---

 - Clarify that @bytes matches @qiov total size (Kevin)

 include/block/block_int.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index d4f4ea7584..4f7f20e56b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -147,12 +147,43 @@ struct BlockDriver {
 
     int coroutine_fn (*bdrv_co_readv)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
+
+    /**
+     * @offset: position in bytes to read at
+     * @bytes: number of bytes to read
+     * @qiov: the buffers to fill with read data
+     * @flags: currently unused, always 0
+     *
+     * @offset and @bytes will be a multiple of 'request_alignment',
+     * but the length of individual @qiov elements does not have to
+     * be a multiple.
+     *
+     * @bytes will always equal the total size of @qiov, and will be
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
+     * @flags: zero or more of bits allowed by 'supported_write_flags'
+     *
+     * @offset and @bytes will be a multiple of 'request_alignment',
+     * but the length of individual @qiov elements does not have to
+     * be a multiple.
+     *
+     * @bytes will always equal the total size of @qiov, and will be
+     * no larger than 'max_transfer'.
+     *
+     * The buffer in @qiov may point directly to guest memory.
+     */
     int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
 
-- 
2.13.3
