Received: from eggs.gnu.org ([2001:4830:134:3::10]:35422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cSHpc-0006BF-Mw
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 01:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cSHpX-0006fJ-Uj
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 01:28:52 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:57143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cSHpX-0006e1-FX
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 01:28:47 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Sat, 14 Jan 2017 14:28:21 +0800
Message-ID: <1484375301-159804-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] cryptodev: setiv only when really need
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

ECB mode cipher doesn't need IV, if we setiv for it then qemu
crypto API would report "Expected IV size 0 not **", so we should
setiv only when the cipher algos really need.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
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
1.8.3.1
