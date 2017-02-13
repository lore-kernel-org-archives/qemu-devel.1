Received: from eggs.gnu.org ([2001:4830:134:3::10]:59141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLj-0002y3-Tk
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLi-0005va-TG
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:33 +0100
Message-Id: <1487006583-24350-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 11/41] vvfat: Implement .bdrv_child_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

vvfat is the last remaining driver that can have children, but doesn't
implement .bdrv_child_perm() yet. The default handlers aren't suitable
here, so let's implement a very simple driver-specific one that protects
the internal child from being used by other users as good as our
permissions permit.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/vvfat.c b/block/vvfat.c
index c6bf67e..7246432 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3052,6 +3052,18 @@ err:
     return ret;
 }
 
+static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
+                             const BdrvChildRole *role,
+                             uint64_t perm, uint64_t shared,
+                             uint64_t *nperm, uint64_t *nshared)
+{
+    assert(role == &child_vvfat_qcow);
+
+    /* This is a private node, nobody should try to attach to it */
+    *nperm = BLK_PERM_WRITE;
+    *nshared = 0;
+}
+
 static void vvfat_close(BlockDriverState *bs)
 {
     BDRVVVFATState *s = bs->opaque;
@@ -3077,6 +3089,7 @@ static BlockDriver bdrv_vvfat = {
     .bdrv_file_open         = vvfat_open,
     .bdrv_refresh_limits    = vvfat_refresh_limits,
     .bdrv_close             = vvfat_close,
+    .bdrv_child_perm        = vvfat_child_perm,
 
     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
-- 
1.8.3.1
