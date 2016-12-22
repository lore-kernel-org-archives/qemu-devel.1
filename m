Received: from eggs.gnu.org ([2001:4830:134:3::10]:46215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJte1-0000la-6q
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtdw-00059p-Gx
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:02:13 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:20465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtdw-00058F-4O
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:02:08 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 22 Dec 2016 11:01:28 +0800
Message-ID: <1482375688-20872-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] virtio-crypto: zeroize the key material
 before free
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

Common practice with sensitive information (key material, passwords,
etc). Prevents sensitive information from being exposed by accident later in
coredumps, memory disclosure bugs when heap memory is reused, etc.

Sensitive information is sometimes also held in mlocked pages to prevent
it being swapped to disk but that's not being done here.

Let's zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
for key material security.

[Thanks to Stefan for help with crafting the commit message]

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 v3:
 - rework the commit message [Eric]
 - add Eric's R-by tag.

 hw/virtio/virtio-crypto.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 4f11fee..48288e8 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -337,7 +337,18 @@ static void virtio_crypto_free_request(VirtIOCryptoReq *req)
 {
     if (req) {
         if (req->flags == CRYPTODEV_BACKEND_ALG_SYM) {
-            g_free(req->u.sym_op_info);
+            size_t max_len;
+            CryptoDevBackendSymOpInfo *op_info = req->u.sym_op_info;
+
+            max_len = op_info->iv_len +
+                      op_info->aad_len +
+                      op_info->src_len +
+                      op_info->dst_len +
+                      op_info->digest_result_len;
+
+            /* Zeroize and free request data structure */
+            memset(op_info, 0, sizeof(*op_info) + max_len);
+            g_free(op_info);
         }
         g_free(req);
     }
-- 
1.8.3.1
