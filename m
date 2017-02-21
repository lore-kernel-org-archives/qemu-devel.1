Received: from eggs.gnu.org ([2001:4830:134:3::10]:43061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuk-0000Uk-C3
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuf-0007yo-Qu
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:18 +0100
Message-Id: <1487689130-30373-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 22/54] block: Request real permissions in
 bdrv_attach_child()
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

Now that all block drivers with children tell us what permissions they
need from each of their children, bdrv_attach_child() can use this
information and make the right requirements while trying to attach new
children.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 1c5f211..054e6f0 100644
--- a/block.c
+++ b/block.c
@@ -1659,10 +1659,14 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              Error **errp)
 {
     BdrvChild *child;
+    uint64_t perm, shared_perm;
+
+    assert(parent_bs->drv);
+    parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
+                                    0, BLK_PERM_ALL, &perm, &shared_perm);
 
-    /* FIXME Use real permissions */
     child = bdrv_root_attach_child(child_bs, child_name, child_role,
-                                   0, BLK_PERM_ALL, parent_bs, errp);
+                                   perm, shared_perm, parent_bs, errp);
     if (child == NULL) {
         return NULL;
     }
-- 
1.8.3.1
