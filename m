Received: from eggs.gnu.org ([2001:4830:134:3::10]:49779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLa-0006Gj-6y
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLV-0008F3-Ii
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLV-00088Z-0B
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:21 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:57:02 +0800
Message-ID: <1509951422-20060-11-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
References: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 10/10] virtio-crypto: add host feature bits
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, qemu-devel@nongnu.org

From: Gonglei <arei.gonglei@huawei.com>

We enable all feature bits acquiescently.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto.c         | 15 +++++++++++++++
 include/hw/virtio/virtio-crypto.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index e46c4a3..8f27a86 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1069,6 +1069,11 @@ static uint64_t virtio_crypto_get_features(VirtIODevice *vdev,
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
 
@@ -1184,6 +1189,16 @@ static const VMStateDescription vmstate_virtio_crypto = {
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
     DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
                      TYPE_CRYPTODEV_BACKEND, CryptoDevBackend *),
     DEFINE_PROP_END_OF_LIST(),
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
