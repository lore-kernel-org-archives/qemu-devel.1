Received: from eggs.gnu.org ([2001:4830:134:3::10]:37595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA3-0007Va-CH
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA2-0003R3-Ji
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:02:31 -0600
Message-Id: <20171107030236.23633-4-eblake@redhat.com>
In-Reply-To: <20171107030236.23633-1-eblake@redhat.com>
References: <20171107030236.23633-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 3/8] raw: Reflect read-only protocol layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

We forbid operations like a zero-length write zero or a discard
at the protocol layer when it is marked read-only, but those
same operations were succeeding at the format layer because the
raw format was not reflecting the underlying read-only status
to the block layer, which then took short circuit paths on
zero-length operations.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/raw-format.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index 830243a8e4..717b8eff65 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -418,6 +418,12 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
         bs->file->bs->supported_write_flags;
     bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
         bs->file->bs->supported_zero_flags;
+    if (bdrv_is_read_only(bs->file->bs)) {
+        ret = bdrv_set_read_only(bs, true, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }

     if (bs->probed && !bdrv_is_read_only(bs)) {
         fprintf(stderr,
-- 
2.13.6
