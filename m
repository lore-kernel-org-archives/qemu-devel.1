Received: from eggs.gnu.org ([2001:4830:134:3::10]:56794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKS-0003Fb-Na
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKR-0006Cd-OI
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:40 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42246)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKR-0006BP-Gm
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:39 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 04 May 2017 11:41:42 +0300
Message-ID: <20170504084142.7488.77770.stgit@PASHA-ISP>
In-Reply-To: <20170504084135.7488.24715.stgit@PASHA-ISP>
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v9 01/10] block: implement bdrv_snapshot_goto
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch enables making snapshots with blkreplay used in
block devices.
This function is required to make bdrv_snapshot_goto without
calling .bdrv_open which is not implemented.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 block/blkreplay.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index e1102119fb..d13a98d691 100644
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
@@ -146,6 +152,8 @@ static BlockDriver bdrv_blkreplay = {
     .bdrv_co_pwrite_zeroes  = blkreplay_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkreplay_co_pdiscard,
     .bdrv_co_flush          = blkreplay_co_flush,
+
+    .bdrv_snapshot_goto     = blkreplay_snapshot_goto,
 };
 
 static void bdrv_blkreplay_init(void)
