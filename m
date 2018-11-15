Received: from eggs.gnu.org ([2001:4830:134:3::10]:53685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70p-0002N1-Lf
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70n-0005iy-Pf
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:07 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:29 -0600
Message-Id: <20181115020334.1189829-9-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/13] crypto: Audit for read/write 64-bit
 cleanness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

The crypto read/write functions do their own fragmentation (because
everything has to go through a bounce buffer); while we could
advertise BLOCK_CRYPTO_MAX_IO_SIZE as our max_transfer (and let the
block layer do our fragmentation for us), I'm instead choosing to
document that this driver is 64-bit clean.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/crypto.c b/block/crypto.c
index 33ee01bebd9..259ef2649e1 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -453,6 +453,7 @@ static void block_crypto_refresh_limits(BlockDriverState *bs, Error **errp)
     BlockCrypto *crypto = bs->opaque;
     uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
     bs->bl.request_alignment = sector_size; /* No sub-sector I/O */
+    bs->bl.max_transfer = INT64_MAX;
 }


-- 
2.17.2
