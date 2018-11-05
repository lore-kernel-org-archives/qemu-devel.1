Received: from eggs.gnu.org ([2001:4830:134:3::10]:50883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhur-0000Gl-DN
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhul-0007Kq-SG
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:39:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:23 +0100
Message-Id: <20181105163744.25139-16-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/36] quorum: Return an error if the blkverify
 mode has invalid settings
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

The blkverify mode of Quorum can only be enabled if the number of
children is exactly two and the value of vote-threshold is also two.

If the user tries to enable it but the other settings are incorrect
then QEMU simply prints an error message to stderr and carries on
disabling the blkverify setting.

This patch makes quorum_open() fail and return an error in this case.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/quorum.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index b1b777baef..6188ff6666 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -912,13 +912,12 @@ static int quorum_open(BlockDriverState *bs, QDict =
*options, int flags,
     s->read_pattern =3D ret;
=20
     if (s->read_pattern =3D=3D QUORUM_READ_PATTERN_QUORUM) {
-        /* is the driver in blkverify mode */
-        if (qemu_opt_get_bool(opts, QUORUM_OPT_BLKVERIFY, false) &&
-            s->num_children =3D=3D 2 && s->threshold =3D=3D 2) {
-            s->is_blkverify =3D true;
-        } else if (qemu_opt_get_bool(opts, QUORUM_OPT_BLKVERIFY, false))=
 {
-            fprintf(stderr, "blkverify mode is set by setting blkverify=3D=
on "
-                    "and using two files with vote_threshold=3D2\n");
+        s->is_blkverify =3D qemu_opt_get_bool(opts, QUORUM_OPT_BLKVERIFY=
, false);
+        if (s->is_blkverify && (s->num_children !=3D 2 || s->threshold !=
=3D 2)) {
+            error_setg(&local_err, "blkverify=3Don can only be set if th=
ere are "
+                       "exactly two files and vote-threshold is 2");
+            ret =3D -EINVAL;
+            goto exit;
         }
=20
         s->rewrite_corrupted =3D qemu_opt_get_bool(opts, QUORUM_OPT_REWR=
ITE,
--=20
2.19.1
