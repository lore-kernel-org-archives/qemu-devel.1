Received: from eggs.gnu.org ([209.51.188.92]:59537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqy-0002Ib-Ew
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqx-00032U-Cg
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:49:03 +0200
Message-Id: <20190402124907.24421-6-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
References: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] block/file-posix: do not fail on unlock
 bytes
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

bdrv_replace_child() calls bdrv_check_perm() with error_abort on
loosening permissions. However file-locking operations may fail even
in this case, for example on NFS. And this leads to Qemu crash.

Let's avoid such errors. Note, that we ignore such things anyway on
permission update commit and abort.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index db4cccbe51..1cf4ee49eb 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -815,6 +815,18 @@ static int raw_handle_perm_lock(BlockDriverState *bs=
,
=20
     switch (op) {
     case RAW_PL_PREPARE:
+        if ((s->perm | new_perm) =3D=3D s->perm &&
+            (s->shared_perm & new_shared) =3D=3D s->shared_perm)
+        {
+            /*
+             * We are going to unlock bytes, it should not fail. If it f=
ail due
+             * to some fs-dependent permission-unrelated reasons (which =
occurs
+             * sometimes on NFS and leads to abort in bdrv_replace_child=
) we
+             * can't prevent such errors by any check here. And we ignor=
e them
+             * anyway in ABORT and COMMIT.
+             */
+            return 0;
+        }
         ret =3D raw_apply_lock_bytes(s, s->fd, s->perm | new_perm,
                                    ~s->shared_perm | ~new_shared,
                                    false, errp);
--=20
2.20.1
