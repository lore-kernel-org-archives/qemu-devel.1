Received: from eggs.gnu.org ([2001:4830:134:3::10]:46782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZI-0003Wz-VQ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZE-0001ma-UA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:52 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:28 +0100
Message-Id: <20181212132735.16080-35-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/41] block: Drop bdrv_reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

No one is using this function anymore, so we can safely remove it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  1 -
 block.c               | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 382e6643fc..de72c7a093 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -302,7 +302,6 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue =
*bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, int flags);
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Er=
ror **errp);
-int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp);
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp);
 int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
diff --git a/block.c b/block.c
index d7b94794f4..071465ee3a 100644
--- a/block.c
+++ b/block.c
@@ -3125,27 +3125,6 @@ cleanup:
     return ret;
 }
=20
-
-/* Reopen a single BlockDriverState with the specified flags. */
-int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp)
-{
-    int ret =3D -1;
-    Error *local_err =3D NULL;
-    BlockReopenQueue *queue;
-
-    bdrv_subtree_drained_begin(bs);
-
-    queue =3D bdrv_reopen_queue(NULL, bs, NULL, bdrv_flags);
-    ret =3D bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, &local=
_err);
-    if (local_err !=3D NULL) {
-        error_propagate(errp, local_err);
-    }
-
-    bdrv_subtree_drained_end(bs);
-
-    return ret;
-}
-
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp)
 {
--=20
2.19.2
