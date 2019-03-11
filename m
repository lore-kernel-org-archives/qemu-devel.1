Received: from eggs.gnu.org ([209.51.188.92]:59233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O9Q-00037v-BU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O8L-0007iE-KU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:50:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 11 Mar 2019 17:50:14 +0100
Message-Id: <20190311165017.32247-8-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-1-kwolf@redhat.com>
References: <20190311165017.32247-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/10] file-posix: Store
 BDRVRawState.reopen_state during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

We'll want to access the file descriptor in the reopen_state while
processing permission changes in the context of the repoen.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index ae57ba1fc6..6aaee1df16 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -144,6 +144,8 @@ typedef struct BDRVRawState {
     uint64_t locked_perm;
     uint64_t locked_shared_perm;
=20
+    BDRVReopenState *reopen_state;
+
 #ifdef CONFIG_XFS
     bool is_xfs:1;
 #endif
@@ -952,6 +954,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
         }
     }
=20
+    s->reopen_state =3D state;
 out:
     qemu_opts_del(opts);
     return ret;
@@ -978,12 +981,16 @@ static void raw_reopen_commit(BDRVReopenState *stat=
e)
=20
     g_free(state->opaque);
     state->opaque =3D NULL;
+
+    assert(s->reopen_state =3D=3D state);
+    s->reopen_state =3D NULL;
 }
=20
=20
 static void raw_reopen_abort(BDRVReopenState *state)
 {
     BDRVRawReopenState *rs =3D state->opaque;
+    BDRVRawState *s =3D state->bs->opaque;
=20
      /* nothing to do if NULL, we didn't get far enough */
     if (rs =3D=3D NULL) {
@@ -996,6 +1003,9 @@ static void raw_reopen_abort(BDRVReopenState *state)
     }
     g_free(state->opaque);
     state->opaque =3D NULL;
+
+    assert(s->reopen_state =3D=3D state);
+    s->reopen_state =3D NULL;
 }
=20
 static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
--=20
2.20.1
