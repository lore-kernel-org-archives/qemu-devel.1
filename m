Received: from eggs.gnu.org ([2001:4830:134:3::10]:39119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UNb-0003d7-QF
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UNa-00062d-Ss
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:06:47 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42128)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UNa-00062B-LB
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:06:46 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:06:46 +0300
Message-ID: <20171031110646.5836.47129.stgit@pasha-VirtualBox>
In-Reply-To: <20171031110641.5836.43266.stgit@pasha-VirtualBox>
References: <20171031110641.5836.43266.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 01/26] block: implement bdrv_snapshot_goto
 for blkreplay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch enables making snapshots with blkreplay used in
block devices.
This function is required to make bdrv_snapshot_goto without
calling .bdrv_open which is not implemented.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 block/blkreplay.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index 61e44a1..82a88f8 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -127,6 +127,12 @@ static int coroutine_fn blkreplay_co_flush(BlockDriverState *bs)
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
@@ -143,6 +149,8 @@ static BlockDriver bdrv_blkreplay = {
     .bdrv_co_pwrite_zeroes  = blkreplay_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkreplay_co_pdiscard,
     .bdrv_co_flush          = blkreplay_co_flush,
+
+    .bdrv_snapshot_goto     = blkreplay_snapshot_goto,
 };
 
 static void bdrv_blkreplay_init(void)
