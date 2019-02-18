Received: from eggs.gnu.org ([209.51.188.92]:33163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcb-0005Cn-T6
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcW-0007SR-89
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:10:13 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Feb 2019 17:09:20 +0300
Message-Id: <20190218140926.333779-12-vsementsov@virtuozzo.com>
In-Reply-To: <20190218140926.333779-1-vsementsov@virtuozzo.com>
References: <20190218140926.333779-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 11/17] block/vmdk: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/vmdk.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 096e8eb662..41048741cd 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1371,7 +1371,6 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
     VmdkGrainMarker *data = NULL;
     uLongf buf_len;
     QEMUIOVector local_qiov;
-    struct iovec iov;
     int64_t write_offset;
     int64_t write_end_sector;
 
@@ -1399,11 +1398,7 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
         data->size = cpu_to_le32(buf_len);
 
         n_bytes = buf_len + sizeof(VmdkGrainMarker);
-        iov = (struct iovec) {
-            .iov_base   = data,
-            .iov_len    = n_bytes,
-        };
-        qemu_iovec_init_external(&local_qiov, &iov, 1);
+        qemu_iovec_init_buf(&local_qiov, data, n_bytes);
 
         BLKDBG_EVENT(extent->file, BLKDBG_WRITE_COMPRESSED);
     } else {
-- 
2.18.0
