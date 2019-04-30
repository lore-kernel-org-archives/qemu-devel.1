Received: from eggs.gnu.org ([209.51.188.92]:48646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-0007y9-ET
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUum-00022c-KH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:26 +0200
Message-Id: <20190430154244.30083-10-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/27] qcow2: Avoid COW during metadata
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Limiting the allocation to INT_MAX bytes isn't particularly clever
because it means that the final cluster will be a partial cluster which
will be completed through a COW operation. This results in unnecessary
data read and write requests which lead to an unwanted non-sparse
filesystem block for metadata preallocation.

Align the maximum allocation size down to the cluster size to avoid this
situation.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3ace3b2209..dfac74c264 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2734,7 +2734,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
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
