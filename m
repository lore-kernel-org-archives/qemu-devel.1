Received: from eggs.gnu.org ([2001:4830:134:3::10]:46541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z4-0003G1-6a
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z3-0001bm-9t
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:20 +0100
Message-Id: <20181212132735.16080-27-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/41] block: Add bdrv_reopen_set_read_only()
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

Most callers of bdrv_reopen() only use it to switch a BlockDriverState
between read-only and read-write, so this patch adds a new function
that does just that.

We also want to get rid of the flags parameter in the bdrv_reopen()
API, so this function sets the "read-only" option and passes the
original flags (which will then be updated in bdrv_reopen_prepare()).

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  2 ++
 block.c               | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 7f5453b45b..382e6643fc 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -303,6 +303,8 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue =
*bs_queue,
                                     QDict *options, int flags);
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Er=
ror **errp);
 int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp);
+int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
+                              Error **errp);
 int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                         BlockReopenQueue *queue, Error **errp);
 void bdrv_reopen_commit(BDRVReopenState *reopen_state);
diff --git a/block.c b/block.c
index 811239ca23..7178872560 100644
--- a/block.c
+++ b/block.c
@@ -3146,6 +3146,23 @@ int bdrv_reopen(BlockDriverState *bs, int bdrv_fla=
gs, Error **errp)
     return ret;
 }
=20
+int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
+                              Error **errp)
+{
+    int ret;
+    BlockReopenQueue *queue;
+    QDict *opts =3D qdict_new();
+
+    qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
+
+    bdrv_subtree_drained_begin(bs);
+    queue =3D bdrv_reopen_queue(NULL, bs, opts, bdrv_get_flags(bs));
+    ret =3D bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, errp);
+    bdrv_subtree_drained_end(bs);
+
+    return ret;
+}
+
 static BlockReopenQueueEntry *find_parent_in_reopen_queue(BlockReopenQue=
ue *q,
                                                           BdrvChild *c)
 {
--=20
2.19.2
