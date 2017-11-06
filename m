Received: from eggs.gnu.org ([2001:4830:134:3::10]:41819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBams-0000bu-Cx
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBamn-0002uF-LZ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:21:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBamn-0002fk-8t
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:21:29 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:21:11 +0800
Message-ID: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] crypto: afalg: fix a NULL pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, pbonzini@redhat.com, arei.gonglei@huawei.com
Cc: longpeng2@huawei.com, qemu-devel@nongnu.org

Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
errp=NULL, this will cause a NULL poniter deference if afalg_driver
doesn't support requested algos:
    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
                                                result, resultlen,
                                                errp);
    if (ret == 0) {
        return ret;
    }

    error_free(*errp);  // <--- here

So we must check 'errp & *errp' before dereference.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hash.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index ac59c63..c464c78 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -60,7 +60,9 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
      * TODO:
      * Maybe we should treat some afalg errors as fatal
      */
-    error_free(*errp);
+    if (errp && *errp) {
+        error_free(*errp);
+    }
 #endif
 
     return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
-- 
1.8.3.1
