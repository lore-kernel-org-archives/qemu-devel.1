Received: from eggs.gnu.org ([2001:4830:134:3::10]:56885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uym-0001bY-Pe
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uyi-0004a6-TO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:56:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:20 +0200
Message-Id: <20171006155422.10135-53-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 52/54] qcow2: fix return error code in
 qcow2_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170929121613.25997-2-pbutsykin@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 33597394b5..960b3ab977 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3167,7 +3167,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (old_file_size < 0) {
             error_setg_errno(errp, -old_file_size,
                              "Failed to inquire current file length");
-            return ret;
+            return old_file_size;
         }
 
         nb_new_data_clusters = DIV_ROUND_UP(offset - old_length,
@@ -3196,7 +3196,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (allocation_start < 0) {
             error_setg_errno(errp, -allocation_start,
                              "Failed to resize refcount structures");
-            return -allocation_start;
+            return allocation_start;
         }
 
         clusters_allocated = qcow2_alloc_clusters_at(bs, allocation_start,
-- 
2.13.6
