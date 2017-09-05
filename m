Received: from eggs.gnu.org ([2001:4830:134:3::10]:51352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpDv9-0000xb-9y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpDv4-00040w-Ll
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dpDv4-00040L-EY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Sep 2017 14:29:08 +0100
Message-Id: <20170905132908.30931-5-stefanha@redhat.com>
In-Reply-To: <20170905132908.30931-1-stefanha@redhat.com>
References: <20170905132908.30931-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] block: document semantics of
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170831105456.9558-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7571c0aaaf..7816b43a27 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -146,12 +146,43 @@ struct BlockDriver {
 
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
+     * @flags: zero or more bits allowed by 'supported_write_flags'
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
2.13.5
