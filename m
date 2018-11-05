Received: from eggs.gnu.org ([2001:4830:134:3::10]:53933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhzy-0000gM-DS
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhzx-000215-Nf
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:45:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:25 +0100
Message-Id: <20181105163744.25139-18-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/36] quorum: Forbid adding children in
 blkverify mode
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

The blkverify mode of Quorum only works when the number of children is
exactly two, so any attempt to add a new one must return an error.

quorum_del_child() on the other hand doesn't need any additional check
because decreasing the number of children would make it go under the
vote threshold.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/quorum.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index 6188ff6666..16b3c8067c 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -992,6 +992,11 @@ static void quorum_add_child(BlockDriverState *bs, B=
lockDriverState *child_bs,
     char indexstr[32];
     int ret;
=20
+    if (s->is_blkverify) {
+        error_setg(errp, "Cannot add a child to a quorum in blkverify mo=
de");
+        return;
+    }
+
     assert(s->num_children <=3D INT_MAX / sizeof(BdrvChild *));
     if (s->num_children =3D=3D INT_MAX / sizeof(BdrvChild *) ||
         s->next_child_index =3D=3D UINT_MAX) {
@@ -1046,6 +1051,9 @@ static void quorum_del_child(BlockDriverState *bs, =
BdrvChild *child,
         return;
     }
=20
+    /* We know now that num_children > threshold, so blkverify must be f=
alse */
+    assert(!s->is_blkverify);
+
     bdrv_drained_begin(bs);
=20
     /* We can safely remove this child now */
--=20
2.19.1
