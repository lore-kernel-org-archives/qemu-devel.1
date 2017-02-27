Received: from eggs.gnu.org ([2001:4830:134:3::10]:52304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLWc-00077D-N0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLWb-0000Sj-Nz
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLWb-0000SW-HU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:37 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 27 Feb 2017 13:39:27 +0000
Message-Id: <20170227133927.759-3-berrange@redhat.com>
In-Reply-To: <20170227133927.759-1-berrange@redhat.com>
References: <20170227133927.759-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 2/2] crypto: assert cipher algorithm is
 always valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, "Daniel P . Berrange" <berrange@redhat.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

Crypto routines 'qcrypto_cipher_get_block_len' and
'qcrypto_cipher_get_key_len' return non-zero cipher block and key
lengths from static arrays 'alg_block_len[]' and 'alg_key_len[]'
respectively. Returning 'zero(0)' value from either of them would
likely lead to an error condition.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
