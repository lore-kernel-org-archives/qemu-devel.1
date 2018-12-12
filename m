Received: from eggs.gnu.org ([2001:4830:134:3::10]:46960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZW-0003kl-2X
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZU-0001zQ-7u
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:29:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:34 +0100
Message-Id: <20181212132735.16080-41-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/41] block: Assert that flags are up-to-date
 in bdrv_reopen_prepare()
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

Towards the end of bdrv_reopen_queue_child(), before starting to
process the children, the update_flags_from_options() function is
called in order to have BDRVReopenState.flags in sync with the options
from the QDict.

This is necessary because during the reopen process flags must be
updated for all nodes in the queue so bdrv_is_writable_after_reopen()
and the permission checks work correctly.

Because of that, calling update_flags_from_options() again in
bdrv_reopen_prepare() doesn't really change the flags (they are
already up-to-date). But we need to call it in order to remove those
options from QemuOpts and that way indicate that they have been
processed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block.c b/block.c
index c6d4564bcf..4f5ff2cc12 100644
--- a/block.c
+++ b/block.c
@@ -3197,6 +3197,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_sta=
te, BlockReopenQueue *queue,
                         Error **errp)
 {
     int ret =3D -1;
+    int old_flags;
     Error *local_err =3D NULL;
     BlockDriver *drv;
     QemuOpts *opts;
@@ -3223,7 +3224,12 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_st=
ate, BlockReopenQueue *queue,
         goto error;
     }
=20
+    /* This was already called in bdrv_reopen_queue_child() so the flags
+     * are up-to-date. This time we simply want to remove the options fr=
om
+     * QemuOpts in order to indicate that they have been processed. */
+    old_flags =3D reopen_state->flags;
     update_flags_from_options(&reopen_state->flags, opts);
+    assert(old_flags =3D=3D reopen_state->flags);
=20
     discard =3D qemu_opt_get_del(opts, BDRV_OPT_DISCARD);
     if (discard !=3D NULL) {
--=20
2.19.2
