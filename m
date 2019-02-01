Received: from eggs.gnu.org ([209.51.188.92]:39186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbo7-0007nq-Rl
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbo5-00006p-O3
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:47 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:34:54 +0100
Message-Id: <20190201163518.31157-4-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/27] qcow2: Assert that refcount block offsets
 fit in the refcount table
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

Refcount table entries have a field to store the offset of the
refcount block. The rest of the bits of the entry are currently
reserved.

The offset is always taken from the entry using REFT_OFFSET_MASK to
ensure that we only use the bits that belong to that field.

While that mask is used every time we read from the refcount table, it
is never used when we write to it. Due to the other constraints of the
qcow2 format QEMU can never produce refcount block offsets that don't
fit in that field so any such offset when allocating a refcount block
would indicate a bug in QEMU.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-refcount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 1c63ac244a..6f13d470d3 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -368,6 +368,9 @@ static int alloc_refcount_block(BlockDriverState *bs,
         return new_block;
     }
=20
+    /* The offset must fit in the offset field of the refcount table ent=
ry */
+    assert((new_block & REFT_OFFSET_MASK) =3D=3D new_block);
+
     /* If we're allocating the block at offset 0 then something is wrong=
 */
     if (new_block =3D=3D 0) {
         qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
--=20
2.20.1
