Received: from eggs.gnu.org ([2001:4830:134:3::10]:58318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejrot-0003vg-Fy
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejroq-00022m-2a
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:25:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Feb 2018 20:23:26 +0100
Message-Id: <20180208192328.16550-26-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-1-kwolf@redhat.com>
References: <20180208192328.16550-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 25/27] block: Fail bdrv_truncate() with
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
---
 block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block.c b/block.c
index 725c33e53f..59e74a5ebc 100644
--- a/block.c
+++ b/block.c
@@ -3681,6 +3681,11 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
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
