Received: from eggs.gnu.org ([2001:4830:134:3::10]:42535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52S-0000MV-9P
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52N-0002EP-I3
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:33 +0200
Message-Id: <20170808135838.11525-14-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/18] block: Fix order in bdrv_replace_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

Commit 8ee03995 refactored the code incorrectly and broke the release of
permissions on the old BDS. Instead of changing the permissions to the
new required values after removing the old BDS from the list of
children, it only re-obtains the permissions it already had.

Change the order of operations so that the old BDS is removed again
before calculating the new required permissions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index ce9cce7b3c..ab908cdc50 100644
--- a/block.c
+++ b/block.c
@@ -1933,6 +1933,8 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
     BlockDriverState *old_bs = child->bs;
     uint64_t perm, shared_perm;
 
+    bdrv_replace_child_noperm(child, new_bs);
+
     if (old_bs) {
         /* Update permissions for old node. This is guaranteed to succeed
          * because we're just taking a parent away, so we're loosening
@@ -1942,8 +1944,6 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
         bdrv_set_perm(old_bs, perm, shared_perm);
     }
 
-    bdrv_replace_child_noperm(child, new_bs);
-
     if (new_bs) {
         bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
         bdrv_set_perm(new_bs, perm, shared_perm);
-- 
2.13.4
