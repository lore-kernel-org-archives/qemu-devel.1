Received: from eggs.gnu.org ([2001:4830:134:3::10]:46930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZE-0001Te-4v
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZ9-00079r-VY
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 19 Nov 2018 15:29:42 +0100
Message-Id: <20181119142944.29061-8-kwolf@redhat.com>
In-Reply-To: <20181119142944.29061-1-kwolf@redhat.com>
References: <20181119142944.29061-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] block: Always abort reopen after prepare
 succeeded
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

From: Max Reitz <mreitz@redhat.com>

bdrv_reopen_multiple() does not invoke bdrv_reopen_abort() for the
element of the reopen queue for which bdrv_reopen_prepare() failed,
because it assumes that the prepare function will have rolled back all
changes already.

However, bdrv_reopen_prepare() does not do this in every case: It may
notice an error after BlockDriver.bdrv_reopen_prepare() succeeded, and
it will not invoke BlockDriver.bdrv_reopen_abort() then; and neither
will bdrv_reopen_multiple(), as explained above.

This is wrong because we must always call .bdrv_reopen_commit() or
.bdrv_reopen_abort() after .bdrv_reopen_prepare() has succeeded.
Otherwise, the block driver has no chance to undo what it has done in
its implementation of .bdrv_reopen_prepare().

To fix this, bdrv_reopen_prepare() has to call .bdrv_reopen_abort() if
it wants to return an error after .bdrv_reopen_prepare() has succeeded.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block.c b/block.c
index fd67e14dfa..3feac08535 100644
--- a/block.c
+++ b/block.c
@@ -3201,6 +3201,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_sta=
te, BlockReopenQueue *queue,
     QDict *orig_reopen_opts;
     char *discard =3D NULL;
     bool read_only;
+    bool drv_prepared =3D false;
=20
     assert(reopen_state !=3D NULL);
     assert(reopen_state->bs->drv !=3D NULL);
@@ -3285,6 +3286,8 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_sta=
te, BlockReopenQueue *queue,
         goto error;
     }
=20
+    drv_prepared =3D true;
+
     /* Options that are not handled are only okay if they are unchanged
      * compared to the old state. It is expected that some options are o=
nly
      * used for the initial open, but not reopen (e.g. filename) */
@@ -3350,6 +3353,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_st=
ate, BlockReopenQueue *queue,
     reopen_state->options =3D qobject_ref(orig_reopen_opts);
=20
 error:
+    if (ret < 0 && drv_prepared) {
+        /* drv->bdrv_reopen_prepare() has succeeded, so we need to
+         * call drv->bdrv_reopen_abort() before signaling an error
+         * (bdrv_reopen_multiple() will not call bdrv_reopen_abort()
+         * when the respective bdrv_reopen_prepare() has failed) */
+        if (drv->bdrv_reopen_abort) {
+            drv->bdrv_reopen_abort(reopen_state);
+        }
+    }
     qemu_opts_del(opts);
     qobject_unref(orig_reopen_opts);
     g_free(discard);
--=20
2.19.1
