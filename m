Received: from eggs.gnu.org ([2001:4830:134:3::10]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAC-0007YK-SM
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA8-0005ci-VQ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:04 -0500
Received: from mail.kernel.org ([198.145.29.136]:47956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA8-0005cZ-Ow
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:00 -0500
Date: Tue, 10 Jan 2017 07:39:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-15-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/41] virtio-crypto: use the correct length for
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>

From: Gonglei <arei.gonglei@huawei.com>

In some modes of cipher algorithms, the length of destination data
maybe larger then source data, such as ciphertext stealing (CTS).

For symmetric algorithms, the length of ciphertext is definitly
equal to the plaintext for each crypto operation. So we should
use the src_len instead of dst_len avoid to pass the incorrect
cryptographical results to the frontend driver.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index c23e1ad..f872c87 100644
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
MST
