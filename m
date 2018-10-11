Received: from eggs.gnu.org ([2001:4830:134:3::10]:47865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gAYfw-0008Hk-DU
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gAYfs-0007I4-EN
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:58:40 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 11 Oct 2018 13:58:02 +0300
Message-Id: <20181011105802.22665-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Get the request alignment for encrypted
 images from QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This doesn't have any practical effect at the moment because the
values of BDRV_SECTOR_SIZE, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE and
QCRYPTO_BLOCK_QCOW_SECTOR_SIZE are all the same (512 bytes), but
future encryption methods could have different requirements.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7277feda13..010a1b3924 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1627,7 +1627,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
 
     if (bs->encrypted) {
         /* Encryption works on a sector granularity */
-        bs->bl.request_alignment = BDRV_SECTOR_SIZE;
+        bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
     bs->bl.pwrite_zeroes_alignment = s->cluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
-- 
2.11.0
