Received: from eggs.gnu.org ([2001:4830:134:3::10]:60029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfq-0000lr-MW
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfp-0007JU-Md
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:06:03 +0100
Message-Id: <20181112170603.23986-15-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/14] qcow2: Read outside array bounds in
 qcow2_pre_write_overlap_check()
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

From: Liam Merwick <Liam.Merwick@oracle.com>

The commit for 0e4e4318eaa5 increments QCOW2_OL_MAX_BITNR but does not
add an array entry for QCOW2_OL_BITMAP_DIRECTORY_BITNR to metadata_ol_nam=
es[].
As a result, an array dereference of metadata_ol_names[8] in
qcow2_pre_write_overlap_check() could result in a read outside of the arr=
ay bounds.

Fixes: 0e4e4318eaa5 ('qcow2: add overlap check for bitmap directory')

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 1541453919-25973-6-git-send-email-Liam.Merwick@oracle.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3c539f02e5..46082aeac1 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2719,15 +2719,17 @@ int qcow2_check_metadata_overlap(BlockDriverState=
 *bs, int ign, int64_t offset,
 }
=20
 static const char *metadata_ol_names[] =3D {
-    [QCOW2_OL_MAIN_HEADER_BITNR]    =3D "qcow2_header",
-    [QCOW2_OL_ACTIVE_L1_BITNR]      =3D "active L1 table",
-    [QCOW2_OL_ACTIVE_L2_BITNR]      =3D "active L2 table",
-    [QCOW2_OL_REFCOUNT_TABLE_BITNR] =3D "refcount table",
-    [QCOW2_OL_REFCOUNT_BLOCK_BITNR] =3D "refcount block",
-    [QCOW2_OL_SNAPSHOT_TABLE_BITNR] =3D "snapshot table",
-    [QCOW2_OL_INACTIVE_L1_BITNR]    =3D "inactive L1 table",
-    [QCOW2_OL_INACTIVE_L2_BITNR]    =3D "inactive L2 table",
+    [QCOW2_OL_MAIN_HEADER_BITNR]        =3D "qcow2_header",
+    [QCOW2_OL_ACTIVE_L1_BITNR]          =3D "active L1 table",
+    [QCOW2_OL_ACTIVE_L2_BITNR]          =3D "active L2 table",
+    [QCOW2_OL_REFCOUNT_TABLE_BITNR]     =3D "refcount table",
+    [QCOW2_OL_REFCOUNT_BLOCK_BITNR]     =3D "refcount block",
+    [QCOW2_OL_SNAPSHOT_TABLE_BITNR]     =3D "snapshot table",
+    [QCOW2_OL_INACTIVE_L1_BITNR]        =3D "inactive L1 table",
+    [QCOW2_OL_INACTIVE_L2_BITNR]        =3D "inactive L2 table",
+    [QCOW2_OL_BITMAP_DIRECTORY_BITNR]   =3D "bitmap directory",
 };
+QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR !=3D ARRAY_SIZE(metadata_ol_names))=
;
=20
 /*
  * First performs a check for metadata overlaps (through
--=20
2.19.1
