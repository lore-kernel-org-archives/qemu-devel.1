Received: from eggs.gnu.org ([2001:4830:134:3::10]:50684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0T-0002x9-Dz
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0O-0004Ub-JS
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0N-0004TF-Vy
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:08 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:23 +0800
Message-ID: <1494243504-127980-9-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 8/9] virtio-crypto: add host feature bits
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, pasic@linux.vnet.ibm.com, stefanha@redhat.com, luonengjun@huawei.com, cornelia.huck@de.ibm.com, linqiangmin@huawei.com, xin.zeng@intel.com, wu.wubin@huawei.com, Gonglei <arei.gonglei@huawei.com>

We enable all feature bits acquiescently.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto.c         | 15 +++++++++++++++
 include/hw/virtio/virtio-crypto.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 5422f25..3dc0ff2 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1034,6 +1034,11 @@ static uint64_t virtio_crypto_get_features(VirtIODevice *vdev,
                                            uint64_t features,
                                            Error **errp)
 {
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
+
+    /* Firstly sync all virtio-crypto possible supported features */
+    features |= vcrypto->host_features;
+
     return features;
 }
 
@@ -1144,6 +1149,16 @@ static const VMStateDescription vmstate_virtio_crypto = {
 };
 
 static Property virtio_crypto_properties[] = {
+    DEFINE_PROP_BIT("mux_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_MUX_MODE, true),
+    DEFINE_PROP_BIT("cipher_stateless_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE, true),
+    DEFINE_PROP_BIT("hash_stateless_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_HASH_STATELESS_MODE, true),
+    DEFINE_PROP_BIT("mac_stateless_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_MAC_STATELESS_MODE, true),
+    DEFINE_PROP_BIT("aead_stateless_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
index 465ad20..30ea51d 100644
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -97,6 +97,7 @@ typedef struct VirtIOCrypto {
     int multiqueue;
     uint32_t curr_queues;
     size_t config_size;
+    uint32_t host_features;
 } VirtIOCrypto;
 
 #endif /* _QEMU_VIRTIO_CRYPTO_H */
-- 
1.8.3.1
