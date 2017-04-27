Received: from eggs.gnu.org ([2001:4830:134:3::10]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YVx-0007RE-7Q
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YVw-00042G-Ay
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 20:46:10 -0500
Message-Id: <20170427014626.11553-2-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-1-eblake@redhat.com>
References: <20170427014626.11553-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v10 01/17] block: Update comments on
 BDRV_BLOCK_* meanings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

We had some conflicting documentation: a nice 8-way table that
described all possible combinations of DATA, ZERO, and
OFFSET_VALID, couple with text that implied that OFFSET_VALID
always meant raw data could be read directly.  As the 8-way
table is the intended semantics, simplify the rest of the text
to get rid of the confusion.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v10: new patch
---
 include/block/block.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 862eb56..04fcbd0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,21 +121,22 @@ typedef struct HDGeometry {

 /*
  * Allocation status flags
- * BDRV_BLOCK_DATA: data is read from a file returned by bdrv_get_block_status.
+ * BDRV_BLOCK_DATA: data is read from a file returned by bdrv_get_block_status
  * BDRV_BLOCK_ZERO: sectors read as zero
- * BDRV_BLOCK_OFFSET_VALID: sector stored as raw data in a file returned by
- *                          bdrv_get_block_status.
+ * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing raw data
  * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
  *                       layer (as opposed to the backing file)
  * BDRV_BLOCK_RAW: used internally to indicate that the request
  *                 was answered by the raw driver and that one
  *                 should look in bs->file directly.
  *
- * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 represent the offset in
- * bs->file where sector data can be read from as raw data.
- *
  * DATA == 0 && ZERO == 0 means that data is read from backing_hd if present.
  *
+ * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 represent the offset
+ * in bs->file that is allocated for the corresponding raw data;
+ * however, whether that offset actually contains data also depends on
+ * BDRV_BLOCK_DATA, as follows:
+ *
  * DATA ZERO OFFSET_VALID
  *  t    t        t       sectors read as zero, bs->file is zero at offset
  *  t    f        t       sectors read as valid from bs->file at offset
-- 
2.9.3
