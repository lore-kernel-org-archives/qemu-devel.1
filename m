Received: from eggs.gnu.org ([2001:4830:134:3::10]:37696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dxuE3-0008Hd-Ib
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dxuE2-0008Tz-Iz
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:17:03 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 29 Sep 2017 15:16:12 +0300
Message-Id: <20170929121613.25997-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170929121613.25997-1-pbutsykin@virtuozzo.com>
References: <20170929121613.25997-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/2] qcow2: fix return error code in
 qcow2_truncate()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbutsykin@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org
List-ID: <qemu-devel.nongnu.org>

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
