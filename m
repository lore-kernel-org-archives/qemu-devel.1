Received: from eggs.gnu.org ([2001:4830:134:3::10]:56195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6K02-0008Fr-C7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6K01-0003xZ-Eq
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  4 May 2017 18:52:41 +0200
Message-Id: <1493916761-32319-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] file-posix: Remove
 .bdrv_inactivate/invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Now that the block layer takes care to request a lot less permissions
for inactive nodes, the special-casing in file-posix isn't necessary any
more.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index f1f924b..90a5f53 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2190,35 +2190,6 @@ static void raw_abort_perm_update(BlockDriverState *bs)
     raw_handle_perm_lock(bs, RAW_PL_ABORT, 0, 0, NULL);
 }
 
-static int raw_inactivate(BlockDriverState *bs)
-{
-    int ret;
-    uint64_t perm = 0;
-    uint64_t shared = BLK_PERM_ALL;
-
-    ret = raw_handle_perm_lock(bs, RAW_PL_PREPARE, perm, shared, NULL);
-    if (ret) {
-        return ret;
-    }
-    raw_handle_perm_lock(bs, RAW_PL_COMMIT, perm, shared, NULL);
-    return 0;
-}
-
-
-static void raw_invalidate_cache(BlockDriverState *bs, Error **errp)
-{
-    BDRVRawState *s = bs->opaque;
-    int ret;
-
-    assert(!(bdrv_get_flags(bs) & BDRV_O_INACTIVE));
-    ret = raw_handle_perm_lock(bs, RAW_PL_PREPARE, s->perm, s->shared_perm,
-                               errp);
-    if (ret) {
-        return;
-    }
-    raw_handle_perm_lock(bs, RAW_PL_COMMIT, s->perm, s->shared_perm, NULL);
-}
-
 BlockDriver bdrv_file = {
     .format_name = "file",
     .protocol_name = "file",
@@ -2249,8 +2220,6 @@ BlockDriver bdrv_file = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
-    .bdrv_inactivate = raw_inactivate,
-    .bdrv_invalidate_cache = raw_invalidate_cache,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
@@ -2712,8 +2681,6 @@ static BlockDriver bdrv_host_device = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
-    .bdrv_inactivate = raw_inactivate,
-    .bdrv_invalidate_cache = raw_invalidate_cache,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
-- 
1.8.3.1
