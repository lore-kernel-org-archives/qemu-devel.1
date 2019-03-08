Received: from eggs.gnu.org ([209.51.188.92]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5v-0000AT-U5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5t-0008Dg-RN
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:10 +0100
Message-Id: <20190308125823.32535-21-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/33] qcow2: Prepare qcow2_co_block_status()
 for data file
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

Offset 0 cannot be assumed to mean an unallocated cluster any more.
Instead, the cluster type needs to be checked.

*file must refer to the data file instead of the image file if a valid
offset is returned from qcow2_co_block_status().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index eaccd1c11a..8d1f667e91 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1829,11 +1829,11 @@ static int coroutine_fn qcow2_co_block_status(Blo=
ckDriverState *bs,
=20
     *pnum =3D bytes;
=20
-    if (cluster_offset !=3D 0 && ret !=3D QCOW2_CLUSTER_COMPRESSED &&
+    if ((ret =3D=3D QCOW2_CLUSTER_NORMAL || ret =3D=3D QCOW2_CLUSTER_ZER=
O_ALLOC) &&
         !s->crypto) {
         index_in_cluster =3D offset & (s->cluster_size - 1);
         *map =3D cluster_offset | index_in_cluster;
-        *file =3D bs->file->bs;
+        *file =3D s->data_file->bs;
         status |=3D BDRV_BLOCK_OFFSET_VALID;
     }
     if (ret =3D=3D QCOW2_CLUSTER_ZERO_PLAIN || ret =3D=3D QCOW2_CLUSTER_=
ZERO_ALLOC) {
--=20
2.20.1
