Received: from eggs.gnu.org ([2001:4830:134:3::10]:38100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJy-0006RI-6M
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJx-0001cK-CY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:50 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 22:21:00 +0200
Message-Id: <20170613202107.10125-10-mreitz@redhat.com>
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
References: <20170613202107.10125-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/16] block/qcow2: Generalize preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This patch adds two new parameters to the preallocate() function so we
will be able to use it not just for preallocating a new image but also
for preallocated image growth.

The offset parameter allows the caller to specify a virtual offset from
which to start preallocating. For newly created images this is always 0,
but for preallocating growth this will be the old image length.

The new_length parameter specifies the supposed new length of the image
(basically the "end offset" for preallocation). During image truncation,
bdrv_getlength() will return the old image length so we cannot rely on
its return value then.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6371c32..7d201bb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2035,17 +2035,24 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
     return qcow2_update_header(bs);
 }
 
-static int preallocate(BlockDriverState *bs)
+/**
+ * Preallocates metadata structures for data clusters between @offset (in the
+ * guest disk) and @new_length (which is thus generally the new guest disk
+ * size).
+ *
+ * Returns: 0 on success, -errno on failure.
+ */
+static int preallocate(BlockDriverState *bs,
+                       uint64_t offset, uint64_t new_length)
 {
     uint64_t bytes;
-    uint64_t offset;
     uint64_t host_offset = 0;
     unsigned int cur_bytes;
     int ret;
     QCowL2Meta *meta;
 
-    bytes = bdrv_getlength(bs);
-    offset = 0;
+    assert(offset <= new_length);
+    bytes = new_length - offset;
 
     while (bytes) {
         cur_bytes = MIN(bytes, INT_MAX);
@@ -2384,7 +2391,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     if (prealloc != PREALLOC_MODE_OFF) {
         BDRVQcow2State *s = blk_bs(blk)->opaque;
         qemu_co_mutex_lock(&s->lock);
-        ret = preallocate(blk_bs(blk));
+        ret = preallocate(blk_bs(blk), 0, total_size);
         qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not preallocate metadata");
-- 
2.9.4
