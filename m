Received: from eggs.gnu.org ([2001:4830:134:3::10]:51887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJuCK-0006qF-Rk
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJuCG-0001tn-54
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:37:40 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:62898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJuCE-0001sk-Oc
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:37:36 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 22 Dec 2016 11:37:03 +0800
Message-ID: <1482377823-20184-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] virtio-crypto: use the correct length for
 cipher operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Gonglei <arei.gonglei@huawei.com>

In some modes of cipher algorithms, the length of destination data
maybe larger then source data, such as ciphertext stealing (CTS).

For symmetric algorithms, the length of ciphertext is definitly
equal to the plaintext for each crypto operation. So we should
use the src_len instead of dst_len avoid to pass the incorrect
cryptographical results to the frontend driver.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 4f11fee..978bb98 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -355,7 +355,7 @@ virtio_crypto_sym_input_data_helper(VirtIODevice *vdev,
         return;
     }
 
-    len = sym_op_info->dst_len;
+    len = sym_op_info->src_len;
     /* Save the cipher result */
     s = iov_from_buf(req->in_iov, req->in_num, 0, sym_op_info->dst, len);
     if (s != len) {
-- 
1.8.3.1
