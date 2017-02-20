Received: from eggs.gnu.org ([2001:4830:134:3::10]:60137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cfm3n-0008Ek-SJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cfm3m-0005pJ-S7
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:23:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cfm3m-0005p3-M6
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:23:14 -0500
From: P J P <ppandit@redhat.com>
Date: Mon, 20 Feb 2017 16:53:07 +0530
Message-Id: <20170220112307.31695-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] crypto: assert cipher algorithm is always valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Crypto routines 'qcrypto_cipher_get_block_len' and
'qcrypto_cipher_get_key_len' return non-zero cipher block and key
lengths from static arrays 'alg_block_len[]' and 'alg_key_len[]'
respectively. Returning 'zero(0)' value from either of them would
likely lead to an error condition.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 crypto/cipher.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 9ecaff7..5a96489 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -63,18 +63,14 @@ static bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] = {
 
 size_t qcrypto_cipher_get_block_len(QCryptoCipherAlgorithm alg)
 {
-    if (alg >= G_N_ELEMENTS(alg_key_len)) {
-        return 0;
-    }
+    assert(alg < G_N_ELEMENTS(alg_key_len));
     return alg_block_len[alg];
 }
 
 
 size_t qcrypto_cipher_get_key_len(QCryptoCipherAlgorithm alg)
 {
-    if (alg >= G_N_ELEMENTS(alg_key_len)) {
-        return 0;
-    }
+    assert(alg < G_N_ELEMENTS(alg_key_len));
     return alg_key_len[alg];
 }
 
-- 
2.9.3
