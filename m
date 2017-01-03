Received: from eggs.gnu.org ([2001:4830:134:3::10]:57022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cOIvn-0004fn-US
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 01:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cOIvk-0001DC-1k
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 01:50:48 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Tue, 3 Jan 2017 14:50:03 +0800
Message-ID: <1483426203-16196-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] virtio-crypto: fix possible integer and heap
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, liqiang6-s@360.cn, Gonglei <arei.gonglei@huawei.com>, qemu-stable@nongnu.org

Because the 'size_t' type is 4 bytes in 32-bit platform, which
is the same with 'int'. It's easy to make 'max_len' to zero when
integer overflow and then cause heap overflow if 'max_len' is zero.

Using uint_64 instead of size_t to avoid the integer overflow.

Cc: qemu-stable@nongnu.org
Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Tested-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/virtio/virtio-crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 978bb98..fc30bc3 100644
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
1.8.3.1
