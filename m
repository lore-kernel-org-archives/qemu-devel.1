Received: from eggs.gnu.org ([2001:4830:134:3::10]:51606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBr-0000FE-IX
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBq-0000TK-RY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:25 +0100
Message-Id: <20180320173632.25480-6-kwolf@redhat.com>
In-Reply-To: <20180320173632.25480-1-kwolf@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 05/12] luks: Turn another invalid
 assertion into check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Commit e39e959e fixed an invalid assertion in the .bdrv_length
implementation, but left a similar assertion in place for
.bdrv_truncate. Instead of crashing when the user requests a too large
image size, fail gracefully.

A file size of exactly INT64_MAX caused failure before, but is actually
legal.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index e0b8856f74..bc6c7e3795 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -357,7 +357,11 @@ static int block_crypto_truncate(BlockDriverState *bs, int64_t offset,
     BlockCrypto *crypto = bs->opaque;
     uint64_t payload_offset =
         qcrypto_block_get_payload_offset(crypto->block);
-    assert(payload_offset < (INT64_MAX - offset));
+
+    if (payload_offset > INT64_MAX - offset) {
+        error_setg(errp, "The requested file size is too large");
+        return -EFBIG;
+    }
 
     offset += payload_offset;
 
-- 
2.13.6
