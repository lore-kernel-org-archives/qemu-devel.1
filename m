Received: from eggs.gnu.org ([209.51.188.92]:51326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZO-0005oK-7e
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZN-00057T-Dc
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 31 Jan 2019 18:55:43 +0100
Message-Id: <20190131175549.11691-6-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 05/11] qcow2: Prepare
 count_contiguous_clusters() for external data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Offset 0 can be valid for normal (allocated) clusters now, so use
qcow2_get_cluster_type() instead.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 7c86e3f205..73ea0f99d6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -386,12 +386,12 @@ static int count_contiguous_clusters(BlockDriverSta=
te *bs, int nb_clusters,
     uint64_t first_entry =3D be64_to_cpu(l2_slice[0]);
     uint64_t offset =3D first_entry & mask;
=20
-    if (!offset) {
+    first_cluster_type =3D qcow2_get_cluster_type(bs, first_entry);
+    if (first_cluster_type =3D=3D QCOW2_CLUSTER_UNALLOCATED) {
         return 0;
     }
=20
     /* must be allocated */
-    first_cluster_type =3D qcow2_get_cluster_type(bs, first_entry);
     assert(first_cluster_type =3D=3D QCOW2_CLUSTER_NORMAL ||
            first_cluster_type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC);
=20
--=20
2.20.1
