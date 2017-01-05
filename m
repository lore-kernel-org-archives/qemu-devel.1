Received: from eggs.gnu.org ([2001:4830:134:3::10]:60077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOwGF-00024v-4C
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOwGD-0008Ng-5e
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:50:31 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:41924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOwGC-0008KF-H4
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:50:29 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Thu, 5 Jan 2017 08:49:40 +0800
Message-ID: <1483577381-38088-6-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1483577381-38088-1-git-send-email-longpeng2@huawei.com>
References: <1483577381-38088-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND 5/6] crypto: implement other common
 funcs for AEAD algorithms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

If currently gcrypt/nettle doesn't support AEAD alg, then
we should implement some no-op funcs.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/aead.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index 47639b7..effe45e 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -16,18 +16,58 @@
 #include "qapi/error.h"
 #include "crypto/aead.h"
 
+#if defined(CONFIG_NETTLE_AEAD) || defined(CONFIG_GCRYPT_AEAD)
+
+static size_t alg_key_len[QCRYPTO_AEAD_ALG__MAX] = {
+    [QCRYPTO_CIPHER_ALG_AES_128] = 16,
+    [QCRYPTO_CIPHER_ALG_AES_192] = 24,
+    [QCRYPTO_CIPHER_ALG_AES_256] = 32,
+};
+
 bool qcrypto_aead_supports(QCryptoCipherAlgorithm alg,
                            QCryptoCipherMode mode)
 {
+    switch (alg) {
+    case QCRYPTO_CIPHER_ALG_AES_128:
+    case QCRYPTO_CIPHER_ALG_AES_192:
+    case QCRYPTO_CIPHER_ALG_AES_256:
+        break;
+    default:
+        return false;
+    }
+
+    switch (mode) {
+    case QCRYPTO_CIPHER_MODE_CCM:
+    case QCRYPTO_CIPHER_MODE_GCM:
+        return true;
+    default:
+        break;
+    }
+
     return false;
 }
 
 size_t qcrypto_aead_get_key_len(QCryptoCipherAlgorithm alg)
 {
-    return -1;
+    if (alg > G_N_ELEMENTS(alg_key_len)) {
+        return 0;
+    }
+
+    return alg_key_len[alg];
 }
 
-#if !defined(CONFIG_NETTLE_AEAD) && !defined(CONFIG_GCRYPT_AEAD)
+#else
+
+bool qcrypto_aead_supports(QCryptoCipherAlgorithm alg,
+                           QCryptoCipherMode mode)
+{
+    return false;
+}
+
+size_t qcrypto_aead_get_key_len(QCryptoCipherAlgorithm alg)
+{
+    return -1;
+}
 
 QCryptoAead *qcrypto_aead_new(QCryptoCipherAlgorithm alg,
                               QCryptoCipherMode mode,
-- 
1.8.3.1
