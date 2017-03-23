Received: from eggs.gnu.org ([2001:4830:134:3::10]:56385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzEX-00026H-1v
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzET-0003sC-Uo
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:41 -0400
Received: from [45.249.212.187] (port=3009 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzET-0003bF-5s
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:37 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 23 Mar 2017 17:39:10 +0800
Message-ID: <1490261951-21352-2-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1490261951-21352-1-git-send-email-arei.gonglei@huawei.com>
References: <1490261951-21352-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL for-2.9 1/2] cryptodev: setiv only when really
 need
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Longpeng(Mike)" <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

ECB mode cipher doesn't need IV, if we setiv for it then qemu
crypto API would report "Expected IV size 0 not **", so we should
setiv only when the cipher algos really need.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 82a068e..b24a299 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -320,10 +320,12 @@ static int cryptodev_builtin_sym_operation(
 
     sess = builtin->sessions[op_info->session_id];
 
-    ret = qcrypto_cipher_setiv(sess->cipher, op_info->iv,
-                               op_info->iv_len, errp);
-    if (ret < 0) {
-        return -VIRTIO_CRYPTO_ERR;
+    if (op_info->iv_len > 0) {
+        ret = qcrypto_cipher_setiv(sess->cipher, op_info->iv,
+                                   op_info->iv_len, errp);
+        if (ret < 0) {
+            return -VIRTIO_CRYPTO_ERR;
+        }
     }
 
     if (sess->direction == VIRTIO_CRYPTO_OP_ENCRYPT) {
-- 
1.7.12.4
