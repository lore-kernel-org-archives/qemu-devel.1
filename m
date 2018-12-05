Received: from eggs.gnu.org ([2001:4830:134:3::10]:45037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUYSI-0000o9-Q4
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUYSG-0003o3-9U
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:47:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  5 Dec 2018 17:46:56 +0300
Message-Id: <20181205144700.26563-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181205144700.26563-1-vsementsov@virtuozzo.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/5] crypto/block-luks: fix memory leak in
 qcrypto_block_luks_create
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
