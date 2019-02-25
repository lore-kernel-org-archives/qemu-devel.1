Received: from eggs.gnu.org ([209.51.188.92]:37544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI56-0000YL-1w
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI54-0001Be-Iu
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:11 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:07 +0100
Message-Id: <20190225152053.15976-26-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/71] qcow2: Assert that L2 table offsets fit
 in the L1 table
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

L1 table entries have a field to store the offset of an L2 table.
The rest of the bits of the entry are currently reserved except from
bit 63, which stores the COPIED flag.

The offset is always taken from the entry using L1E_OFFSET_MASK to
ensure that we only use the bits that belong to that field.

While that mask is used every time we read from the L1 table, it is
never used when we write to it. Due to the limits set elsewhere in the
code QEMU can never produce L2 table offsets that don't fit in that
field so any such offset when allocating an L2 table would indicate a
bug in QEMU.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 30eca26c47..179aa2c728 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -285,6 +285,9 @@ static int l2_allocate(BlockDriverState *bs, int l1_i=
ndex)
         goto fail;
     }
=20
+    /* The offset must fit in the offset field of the L1 table entry */
+    assert((l2_offset & L1E_OFFSET_MASK) =3D=3D l2_offset);
+
     /* If we're allocating the table at offset 0 then something is wrong=
 */
     if (l2_offset =3D=3D 0) {
         qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
--=20
2.20.1
