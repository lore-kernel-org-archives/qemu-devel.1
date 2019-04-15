Received: from eggs.gnu.org ([209.51.188.92]:47647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3x1-0007bi-4l
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3wz-0003Qf-5p
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 15 Apr 2019 17:54:49 +0200
Message-Id: <20190415155452.5115-2-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-1-kwolf@redhat.com>
References: <20190415155452.5115-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] qcow2: Avoid COW during metadata
 preallocation
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

Limiting the allocation to INT_MAX bytes isn't particularly clever
because it means that the final cluster will be a partial cluster which
will be completed through a COW operation. This results in unnecessary
data read and write requests which lead to an unwanted non-sparse
filesystem block for metadata preallocation.

Align the maximum allocation size down to the cluster size to avoid this
situation.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d507ee0686..c8400e9712 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2723,6 +2723,7 @@ static int qcow2_set_up_encryption(BlockDriverState=
 *bs,
 static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t of=
fset,
                                        uint64_t new_length)
 {
+    BDRVQcow2State *s =3D bs->opaque;
     uint64_t bytes;
     uint64_t host_offset =3D 0;
     unsigned int cur_bytes;
@@ -2733,7 +2734,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
tate *bs, uint64_t offset,
     bytes =3D new_length - offset;
=20
     while (bytes) {
-        cur_bytes =3D MIN(bytes, INT_MAX);
+        cur_bytes =3D MIN(bytes, QEMU_ALIGN_DOWN(INT_MAX, s->cluster_siz=
e));
         ret =3D qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &host_offset, &meta);
         if (ret < 0) {
--=20
2.20.1
