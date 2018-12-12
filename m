Received: from eggs.gnu.org ([2001:4830:134:3::10]:46896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZM-0003bu-MV
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZK-0001ro-Dx
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:56 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:31 +0100
Message-Id: <20181212132735.16080-38-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/41] block: Remove flags parameter from
 bdrv_reopen_queue()
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

Now that all callers are passing all flag changes as QDict options,
the flags parameter is no longer necessary, so we can get rid of it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 3 +--
 block.c               | 5 +++--
 block/replication.c   | 6 ++----
 qemu-io-cmds.c        | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index de72c7a093..f70a843b72 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -299,8 +299,7 @@ BlockDriverState *bdrv_open(const char *filename, con=
st char *reference,
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *nod=
e_name,
                                        int flags, Error **errp);
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
-                                    BlockDriverState *bs,
-                                    QDict *options, int flags);
+                                    BlockDriverState *bs, QDict *options=
);
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Er=
ror **errp);
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp);
diff --git a/block.c b/block.c
index 071465ee3a..800c341244 100644
--- a/block.c
+++ b/block.c
@@ -3060,8 +3060,9 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bl=
ockReopenQueue *bs_queue,
=20
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
-                                    QDict *options, int flags)
+                                    QDict *options)
 {
+    int flags =3D bdrv_get_flags(bs);
     return bdrv_reopen_queue_child(bs_queue, bs, options, flags,
                                    NULL, NULL, 0);
 }
@@ -3135,7 +3136,7 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs,=
 bool read_only,
     qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
=20
     bdrv_subtree_drained_begin(bs);
-    queue =3D bdrv_reopen_queue(NULL, bs, opts, bdrv_get_flags(bs));
+    queue =3D bdrv_reopen_queue(NULL, bs, opts);
     ret =3D bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, errp);
     bdrv_subtree_drained_end(bs);
=20
diff --git a/block/replication.c b/block/replication.c
index af9dba8696..e70dd95001 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -371,19 +371,17 @@ static void reopen_backing_file(BlockDriverState *b=
s, bool writable,
     bdrv_subtree_drained_begin(s->secondary_disk->bs);
=20
     if (s->orig_hidden_read_only) {
-        int flags =3D bdrv_get_flags(s->hidden_disk->bs);
         QDict *opts =3D qdict_new();
         qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
         reopen_queue =3D bdrv_reopen_queue(reopen_queue, s->hidden_disk-=
>bs,
-                                         opts, flags);
+                                         opts);
     }
=20
     if (s->orig_secondary_read_only) {
-        int flags =3D bdrv_get_flags(s->secondary_disk->bs);
         QDict *opts =3D qdict_new();
         qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
         reopen_queue =3D bdrv_reopen_queue(reopen_queue, s->secondary_di=
sk->bs,
-                                         opts, flags);
+                                         opts);
     }
=20
     if (reopen_queue) {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index c9ae09d574..2c39124036 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2075,7 +2075,7 @@ static int reopen_f(BlockBackend *blk, int argc, ch=
ar **argv)
     }
=20
     bdrv_subtree_drained_begin(bs);
-    brq =3D bdrv_reopen_queue(NULL, bs, opts, flags);
+    brq =3D bdrv_reopen_queue(NULL, bs, opts);
     bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
     bdrv_subtree_drained_end(bs);
=20
--=20
2.19.2
