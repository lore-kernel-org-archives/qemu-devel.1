Received: from eggs.gnu.org ([2001:4830:134:3::10]:33295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9g-00078c-PZ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9f-0005NG-Dj
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:32 -0500
Date: Tue, 10 Jan 2017 07:39:24 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-4-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 03/41] virtio-crypto: fix possible integer and
 heap overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>, qemu-stable@nongnu.org, Li Qiang <liqiang6-s@360.cn>

From: Gonglei <arei.gonglei@huawei.com>

Because the 'size_t' type is 4 bytes in 32-bit platform, which
is the same with 'int'. It's easy to make 'max_len' to zero when
integer overflow and then cause heap overflow if 'max_len' is zero.

Using uint_64 instead of size_t to avoid the integer overflow.

Cc: qemu-stable@nongnu.org
Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Tested-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 2f2467e..c23e1ad 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -416,7 +416,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
     uint32_t hash_start_src_offset = 0, len_to_hash = 0;
     uint32_t cipher_start_src_offset = 0, len_to_cipher = 0;
 
-    size_t max_len, curr_size = 0;
+    uint64_t max_len, curr_size = 0;
     size_t s;
 
     /* Plain cipher */
@@ -441,7 +441,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
         return NULL;
     }
 
-    max_len = iv_len + aad_len + src_len + dst_len + hash_result_len;
+    max_len = (uint64_t)iv_len + aad_len + src_len + dst_len + hash_result_len;
     if (unlikely(max_len > vcrypto->conf.max_size)) {
         virtio_error(vdev, "virtio-crypto too big length");
         return NULL;
-- 
MST
