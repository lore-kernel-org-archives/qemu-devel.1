Received: from eggs.gnu.org ([2001:4830:134:3::10]:53059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEopG-0007MT-Pa
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEopC-0007Yu-3Y
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:52:50 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:21222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEopB-0007Tv-Nf
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:52:46 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Thu, 8 Dec 2016 10:52:26 +0800
Message-ID: <1481165546-203200-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9] cryptodev: add 3des-ede support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arei.gonglei@huawei.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

This patch add 3des-ede support for cryptodev. However this is effective
only when backend using libgcrypt/nettle, because cipher-builtin doesn't
support 3des-ede yet.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
Changes since v1:
    - split the original pathset. [Gonglei]

---
 backends/cryptodev-builtin.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 5fb2836..486b4a6 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -205,6 +205,18 @@ static int cryptodev_builtin_create_cipher_session(
             return -1;
         }
         break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_ECB:
+        mode = QCRYPTO_CIPHER_MODE_ECB;
+        algo = QCRYPTO_CIPHER_ALG_3DES;
+        break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_CBC:
+        mode = QCRYPTO_CIPHER_MODE_CBC;
+        algo = QCRYPTO_CIPHER_ALG_3DES;
+        break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_CTR:
+        mode = QCRYPTO_CIPHER_MODE_CTR;
+        algo = QCRYPTO_CIPHER_ALG_3DES;
+        break;
     default:
         error_setg(errp, "Unsupported cipher alg :%u",
                    sess_info->cipher_alg);
-- 
1.8.3.1
