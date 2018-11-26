Received: from eggs.gnu.org ([2001:4830:134:3::10]:53429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRF4H-0005X1-V2
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRF4H-0004uW-7V
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:28:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Nov 2018 12:28:27 +0100
Message-Id: <20181126112828.23047-2-kwolf@redhat.com>
In-Reply-To: <20181126112828.23047-1-kwolf@redhat.com>
References: <20181126112828.23047-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 1/2] block: Don't inactivate children
 before parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

bdrv_child_cb_inactivate() asserts that parents are already inactive
when children get inactivated. This precondition is necessary because
parents could still issue requests in their inactivation code.

When block nodes are created individually with -blockdev, all of them
are monitor owned and will be returned by bdrv_next() in an undefined
order (in practice, in the order of their creation, which is usually
children before parents), which obviously fails the assertion.

This patch fixes the ordering by skipping nodes with still active
parents in bdrv_inactivate_recurse() because we know that they will be
covered by recursion when the last active parent becomes inactive.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/block.c b/block.c
index 5ba3435f8f..0569275e31 100644
--- a/block.c
+++ b/block.c
@@ -4612,6 +4612,22 @@ void bdrv_invalidate_cache_all(Error **errp)
     }
 }
=20
+static bool bdrv_has_active_bds_parent(BlockDriverState *bs)
+{
+    BdrvChild *parent;
+
+    QLIST_FOREACH(parent, &bs->parents, next_parent) {
+        if (parent->role->parent_is_bds) {
+            BlockDriverState *parent_bs =3D parent->opaque;
+            if (!(parent_bs->open_flags & BDRV_O_INACTIVE)) {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
+
 static int bdrv_inactivate_recurse(BlockDriverState *bs,
                                    bool setting_flag)
 {
@@ -4622,6 +4638,12 @@ static int bdrv_inactivate_recurse(BlockDriverStat=
e *bs,
         return -ENOMEDIUM;
     }
=20
+    /* Make sure that we don't inactivate a child before its parent.
+     * It will be covered by recursion from the yet active parent. */
+    if (bdrv_has_active_bds_parent(bs)) {
+        return 0;
+    }
+
     if (!setting_flag && bs->drv->bdrv_inactivate) {
         ret =3D bs->drv->bdrv_inactivate(bs);
         if (ret < 0) {
--=20
2.19.1
