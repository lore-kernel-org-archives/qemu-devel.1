Received: from eggs.gnu.org ([2001:4830:134:3::10]:36276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDJE-00072H-IK
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDJ9-0005d7-Qz
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:14:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDJ9-0005b6-5f
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:14:39 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:33 +0800
Message-ID: <1505092240-10864-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 1/8] virtio-crypto: add new definations for
 multiplexing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Adds the defination of the control/operation header for
multiplexing mode.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 include/standard-headers/linux/virtio_crypto.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 5ff0b4e..987fb1e 100755
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -38,6 +38,13 @@
 #define VIRTIO_CRYPTO_SERVICE_MAC    2
 #define VIRTIO_CRYPTO_SERVICE_AEAD   3
 
+/* The features for virtio crypto device */
+#define VIRTIO_CRYPTO_F_MUX_MODE	0
+#define VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE	1
+#define VIRTIO_CRYPTO_F_HASH_STATELESS_MODE	2
+#define VIRTIO_CRYPTO_F_MAC_STATELESS_MODE	3
+#define VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE	4
+
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
 struct virtio_crypto_ctrl_header {
@@ -234,7 +241,7 @@ struct virtio_crypto_destroy_session_req {
 	uint8_t padding[48];
 };
 
-/* The request of the control virtqueue's packet */
+/* The request of the control virtqueue's packet for non-MUX mode */
 struct virtio_crypto_op_ctrl_req {
 	struct virtio_crypto_ctrl_header header;
 
@@ -253,6 +260,11 @@ struct virtio_crypto_op_ctrl_req {
 	} u;
 };
 
+/* The request of the control virtqueue's packet for MUX mode */
+struct virtio_crypto_op_ctrl_req_mux {
+	struct virtio_crypto_ctrl_header header;
+};
+
 struct virtio_crypto_op_header {
 #define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
@@ -390,7 +402,7 @@ struct virtio_crypto_aead_data_req {
 	uint8_t padding[32];
 };
 
-/* The request of the data virtqueue's packet */
+/* The request of the data virtqueue's packet for non-MUX mode */
 struct virtio_crypto_op_data_req {
 	struct virtio_crypto_op_header header;
 
@@ -403,6 +415,11 @@ struct virtio_crypto_op_data_req {
 	} u;
 };
 
+/* The request of the data virtqueue's packet for MUX mode */
+struct virtio_crypto_op_data_req_mux {
+	struct virtio_crypto_op_header header;
+};
+
 #define VIRTIO_CRYPTO_OK        0
 #define VIRTIO_CRYPTO_ERR       1
 #define VIRTIO_CRYPTO_BADMSG    2
-- 
1.8.3.1
