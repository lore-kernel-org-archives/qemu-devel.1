Received: from eggs.gnu.org ([2001:4830:134:3::10]:60058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnm-0000ot-4T
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnl-0006cM-Aa
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 18:27:11 +0100
Message-Id: <20180309172713.26318-5-kwolf@redhat.com>
In-Reply-To: <20180309172713.26318-1-kwolf@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] luks: Turn invalid assertion into check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

The .bdrv_getlength implementation of the crypto block driver asserted
that the payload offset isn't after EOF. This is an invalid assertion to
make as the image file could be corrupted. Instead, check it and return
-EIO if the file is too small for the payload offset.

Zero length images are fine, so trigger -EIO only on offset > len, not
on offset >= len as the assertion did before.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index 2035f9ab13..4908d8627f 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -518,7 +518,10 @@ static int64_t block_crypto_getlength(BlockDriverState *bs)
 
     uint64_t offset = qcrypto_block_get_payload_offset(crypto->block);
     assert(offset < INT64_MAX);
-    assert(offset < len);
+
+    if (offset > len) {
+       return -EIO;
+    }
 
     len -= offset;
 
-- 
2.13.6
