Received: from eggs.gnu.org ([2001:4830:134:3::10]:41792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVIlO-0006re-Ul
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVIlK-0002cB-PC
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:14:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Dec 2018 19:13:47 +0300
Message-Id: <20181207161351.4380-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181207161351.4380-1-vsementsov@virtuozzo.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/5] crypto/block-luks: fix memory leak in
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
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Free block->cipher and block->ivgen on error path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
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
