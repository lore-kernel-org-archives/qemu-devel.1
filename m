Received: from eggs.gnu.org ([2001:4830:134:3::10]:35249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG5-0004HG-LJ
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG3-00046y-W1
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDG3-00045u-Ad
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:11:27 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:40 +0800
Message-ID: <1505092240-10864-9-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 8/8] virtio-crypto: add host feature bits support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com

From: Gonglei <arei.gonglei@huawei.com>

We enable all feature bits acquiescently.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto.c         | 15 +++++++++++++++
 include/hw/virtio/virtio-crypto.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index d58ffba..69c5ad5 100755
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1095,6 +1095,11 @@ static uint64_t virtio_crypto_get_features(VirtIODevice *vdev,
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
 
@@ -1210,6 +1215,16 @@ static const VMStateDescription vmstate_virtio_crypto = {
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
index 465ad20..30ea51d 100755
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
