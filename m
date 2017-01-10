Received: from eggs.gnu.org ([2001:4830:134:3::10]:33693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAO-0007nG-2c
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAN-0005jc-6t
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:16 -0500
Received: from mail.kernel.org ([198.145.29.136]:48112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAN-0005jH-0B
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:15 -0500
Date: Tue, 10 Jan 2017 07:40:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-21-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 20/41] virtio-crypto: zeroize the key material
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

From: Gonglei <arei.gonglei@huawei.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-crypto.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index fc30bc3..296472f 100644
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
MST
