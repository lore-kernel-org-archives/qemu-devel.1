Received: from eggs.gnu.org ([2001:4830:134:3::10]:34411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dxV91-0001PY-GC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dxV8v-0008Vb-LI
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:30:11 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Thu, 28 Sep 2017 12:27:49 +0300
Message-Id: <20170928092750.24938-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170928092750.24938-1-pbutsykin@virtuozzo.com>
References: <20170928092750.24938-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/2] qcow2: fix return error code in
 qcow2_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbutsykin@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2174a84d1f..8a4311d338 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3166,7 +3166,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (old_file_size < 0) {
             error_setg_errno(errp, -old_file_size,
                              "Failed to inquire current file length");
-            return ret;
+            return old_file_size;
         }
 
         nb_new_data_clusters = DIV_ROUND_UP(offset - old_length,
@@ -3195,7 +3195,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (allocation_start < 0) {
             error_setg_errno(errp, -allocation_start,
                              "Failed to resize refcount structures");
-            return -allocation_start;
+            return allocation_start;
         }
 
         clusters_allocated = qcow2_alloc_clusters_at(bs, allocation_start,
-- 
2.14.1
