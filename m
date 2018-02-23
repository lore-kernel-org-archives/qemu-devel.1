Received: from eggs.gnu.org ([2001:4830:134:3::10]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIzo-0001SP-Fz
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIzn-0005Tj-PO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:27:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Feb 2018 20:25:47 +0100
Message-Id: <20180223192549.26666-35-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-1-kwolf@redhat.com>
References: <20180223192549.26666-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 34/36] block: Fail bdrv_truncate() with
 negative size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Most callers have their own checks, but something like this should also
be checked centrally. As it happens, x-blockdev-create can pass negative
image sizes to format drivers (because there is no QAPI type that would
reject negative numbers) and triggers the check added by this patch.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block.c b/block.c
index 4a7e448226..5c874aefa1 100644
--- a/block.c
+++ b/block.c
@@ -3684,6 +3684,11 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
         error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
     }
+    if (offset < 0) {
+        error_setg(errp, "Image size cannot be negative");
+        return -EINVAL;
+    }
+
     if (!drv->bdrv_truncate) {
         if (bs->file && drv->is_filter) {
             return bdrv_truncate(bs->file, offset, prealloc, errp);
-- 
2.13.6
