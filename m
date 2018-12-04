Received: from eggs.gnu.org ([2001:4830:134:3::10]:50439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUFiv-00041N-Fc
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUFiq-0001E8-34
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:47:08 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  4 Dec 2018 21:46:53 +0300
Message-Id: <20181204184657.78028-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181204184657.78028-1-vsementsov@virtuozzo.com>
References: <20181204184657.78028-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH for-3.1? 1/5] crypto/block-luks: fix memory
 leak in qcrypto_block_luks_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Free block->cipher and block->ivgen on error path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 crypto/block-luks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 5738124773..51e24d23ca 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1341,6 +1341,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     qcrypto_ivgen_free(ivgen);
     qcrypto_cipher_free(cipher);
 
+    qcrypto_cipher_free(block->cipher);
+    qcrypto_ivgen_free(block->ivgen);
+
     g_free(luks);
     return -1;
 }
-- 
2.18.0
