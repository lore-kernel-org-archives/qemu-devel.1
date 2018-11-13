Received: from eggs.gnu.org ([2001:4830:134:3::10]:57087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMbpS-0005oK-Jn
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMbpL-0007Jm-8a
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:46:16 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 13 Nov 2018 18:45:44 +0200
Message-Id: <20181113164544.9906-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Assert that refcount block offsets fit
 in the refcount table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

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
---
 block/qcow2-refcount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 46082aeac1..31a2e1f845 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -367,6 +367,9 @@ static int alloc_refcount_block(BlockDriverState *bs,
         return new_block;
     }
 
+    /* The offset must fit in the offset field of the refcount table entry */
+    assert((new_block & REFT_OFFSET_MASK) == new_block);
+
     /* If we're allocating the block at offset 0 then something is wrong */
     if (new_block == 0) {
         qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
-- 
2.11.0
