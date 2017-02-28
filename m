Received: from eggs.gnu.org ([2001:4830:134:3::10]:42891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cifRK-0005A2-8v
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cifRJ-0006aA-FV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:55:30 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 28 Feb 2017 13:55:27 +0300
Message-ID: <20170228105527.1284.44425.stgit@PASHA-ISP>
In-Reply-To: <20170228105521.1284.11059.stgit@PASHA-ISP>
References: <20170228105521.1284.11059.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/3] block: implement bdrv_snapshot_goto for
 blkreplay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, dovgaluk@ispras.ru, qemu-block@nongnu.org, mreitz@redhat.com

This patch enables making snapshots with blkreplay used in
block devices.
This function is required to make bdrv_snapshot_goto without
calling .bdrv_open which is not implemented.

v2: updated commit message

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 block/blkreplay.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index cfc8c5b..ddcf344 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -130,6 +130,12 @@ static int coroutine_fn blkreplay_co_flush(BlockDriverState *bs)
     return ret;
 }
 
+static int blkreplay_snapshot_goto(BlockDriverState *bs,
+                                   const char *snapshot_id)
+{
+    return bdrv_snapshot_goto(bs->file->bs, snapshot_id);
+}
+
 static BlockDriver bdrv_blkreplay = {
     .format_name            = "blkreplay",
     .protocol_name          = "blkreplay",
@@ -145,6 +151,8 @@ static BlockDriver bdrv_blkreplay = {
     .bdrv_co_pwrite_zeroes  = blkreplay_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkreplay_co_pdiscard,
     .bdrv_co_flush          = blkreplay_co_flush,
+
+    .bdrv_snapshot_goto     = blkreplay_snapshot_goto,
 };
 
 static void bdrv_blkreplay_init(void)
