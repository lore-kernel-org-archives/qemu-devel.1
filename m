Received: from eggs.gnu.org ([2001:4830:134:3::10]:50691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0T-0002xE-Nq
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0P-0004V6-MM
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0O-0004U6-Q1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:09 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:20 +0800
Message-ID: <1494243504-127980-6-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 5/9] virtio-crypto: update header file
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

Update the header based on the newset virtio
crypto spec, so that the virtio crypto can
support both session and stateless based
crypto services and keep compatibility with
the pre-existing code by introducing five feature bits.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 include/standard-headers/linux/virtio_crypto.h | 210 ++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 2 deletions(-)

diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 5ff0b4e..c447829 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -33,11 +33,20 @@
 #include "standard-headers/linux/virtio_config.h"
 
 
+/* The crypto service for virtio crypto */
 #define VIRTIO_CRYPTO_SERVICE_CIPHER 0
 #define VIRTIO_CRYPTO_SERVICE_HASH   1
 #define VIRTIO_CRYPTO_SERVICE_MAC    2
 #define VIRTIO_CRYPTO_SERVICE_AEAD   3
 
+/* The feature bitmap for virtio crypto */
+#define VIRTIO_CRYPTO_F_MUX_MODE 0  /* Multiplexing mode is available */
+#define VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE 1
+#define VIRTIO_CRYPTO_F_HASH_STATELESS_MODE 2
+#define VIRTIO_CRYPTO_F_MAC_STATELESS_MODE	3
+#define VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE	4
+
+
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
 struct virtio_crypto_ctrl_header {
@@ -166,8 +175,8 @@ struct virtio_crypto_aead_session_para {
 	uint32_t algo;
 	/* length of key */
 	uint32_t key_len;
-	/* hash result length */
-	uint32_t hash_result_len;
+	/* Authentication tag length */
+	uint32_t tag_len;
 	/* length of the additional authenticated data (AAD) in bytes */
 	uint32_t aad_len;
 	/* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
@@ -271,6 +280,8 @@ struct virtio_crypto_op_header {
 	uint32_t algo;
 	/* session_id should be service-specific algorithms */
 	uint64_t session_id;
+#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
+#define VIRTIO_CRYPTO_FLAG_STATELESS_MODE 2
 	/* control flag to control the request */
 	uint32_t flag;
 	uint32_t padding;
@@ -403,6 +414,201 @@ struct virtio_crypto_op_data_req {
 	} u;
 };
 
+struct virtio_crypto_cipher_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_CIPHER* above */
+		uint32_t algo;
+		/* length of key */
+		uint32_t keylen;
+
+		/* See VIRTIO_CRYPTO_OP_* above */
+		uint32_t op;
+	} sess_para;
+
+	/*
+	 * Byte Length of valid IV/Counter
+	 */
+	uint32_t iv_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* length of dst data */
+	uint32_t dst_data_len;
+};
+
+struct virtio_crypto_alg_chain_data_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_* above */
+		uint32_t alg_chain_order;
+		/* length of the additional authenticated data in bytes */
+		uint32_t aad_len;
+
+		struct {
+			/* See VIRTIO_CRYPTO_CIPHER* above */
+			uint32_t algo;
+			/* length of key */
+			uint32_t keylen;
+			/* See VIRTIO_CRYPTO_OP_* above */
+			uint32_t op;
+		} cipher;
+
+		struct {
+			/* See VIRTIO_CRYPTO_HASH_* or _MAC_* above */
+			uint32_t algo;
+			/* length of authenticated key */
+			uint32_t auth_key_len;
+			/* See VIRTIO_CRYPTO_SYM_HASH_MODE_* above */
+			uint32_t hash_mode;
+		} hash;
+	} sess_para;
+
+	uint32_t iv_len;
+	/* Length of source data */
+	uint32_t src_data_len;
+	/* Length of destination data */
+	uint32_t dst_data_len;
+	/* Starting point for cipher processing in source data */
+	uint32_t cipher_start_src_offset;
+	/* Length of the source data that the cipher will be computed on */
+	uint32_t len_to_cipher;
+	/* Starting point for hash processing in source data */
+	uint32_t hash_start_src_offset;
+	/* Length of the source data that the hash will be computed on */
+	uint32_t len_to_hash;
+	/* Length of the additional auth data */
+	uint32_t aad_len;
+	/* Length of the hash result */
+	uint32_t hash_result_len;
+	uint32_t reserved;
+};
+
+struct virtio_crypto_hash_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_HASH_* above */
+		uint32_t algo;
+	} sess_para;
+
+	/* length of source data */
+	uint32_t src_data_len;
+	/* hash result length */
+	uint32_t hash_result_len;
+	uint32_t reserved;
+};
+
+struct virtio_crypto_mac_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_MAC_* above */
+		uint32_t algo;
+		/* length of authenticated key */
+		uint32_t auth_key_len;
+	} sess_para;
+
+	/* length of source data */
+	uint32_t src_data_len;
+	/* hash result length */
+	uint32_t hash_result_len;
+};
+
+struct virtio_crypto_aead_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_AEAD_* above */
+		uint32_t algo;
+		/* length of key */
+		uint32_t key_len;
+		/* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
+		uint32_t op;
+	} sess_para;
+
+	/*
+	 * Byte Length of valid IV data pointed to by the below iv_addr
+	 * parameter.
+	 */
+	uint32_t iv_len;
+	/* Authentication tag length */
+	uint32_t tag_len;
+	/* length of the additional authenticated data (AAD) in bytes */
+	uint32_t aad_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* length of dst data, it should be at least src_data_len + tag_len */
+	uint32_t dst_data_len;
+};
+
+struct virtio_crypto_cipher_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_cipher_para_stateless para;
+	uint8_t padding[48];
+};
+
+struct virtio_crypto_hash_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_hash_para_stateless para;
+	uint8_t padding[64];
+};
+
+struct virtio_crypto_mac_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_mac_para_stateless para;
+	uint8_t padding[64];
+};
+
+struct virtio_crypto_alg_chain_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_alg_chain_data_para_stateless para;
+};
+
+struct virtio_crypto_sym_data_req_stateless {
+	union {
+		struct virtio_crypto_cipher_data_req_stateless cipher;
+		struct virtio_crypto_alg_chain_data_req_stateless chain;
+		uint8_t padding[72];
+	} u;
+
+	/* See above VIRTIO_CRYPTO_SYM_OP_* */
+	uint32_t op_type;
+	uint32_t padding;
+};
+
+struct virtio_crypto_aead_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_aead_para_stateless para;
+	uint8_t padding[48];
+};
+
+/* The request of the data virtqueue's packet */
+struct virtio_crypto_op_data_req_mux {
+    /* The size is 24 byte */
+	struct virtio_crypto_op_header header;
+
+	union {
+		struct {
+			struct virtio_crypto_sym_data_req  data;
+			uint8_t padding[56];
+		} sym_req;
+		struct {
+			struct virtio_crypto_hash_data_req data;
+			uint8_t padding[56];
+		} hash_req;
+		struct {
+			struct virtio_crypto_mac_data_req data;
+			uint8_t padding[56];
+		} mac_req;
+		struct {
+			struct virtio_crypto_aead_data_req data;
+			uint8_t padding[56];
+		} aead_req;
+
+		struct virtio_crypto_sym_data_req_stateless  sym_stateless_req;
+		struct virtio_crypto_hash_data_req_stateless hash_stateless_req;
+		struct virtio_crypto_mac_data_req_stateless mac_stateless_req;
+		struct virtio_crypto_aead_data_req_stateless aead_stateless_req;
+		/*
+		 * Making the request's total size is equal to 128 byte, and
+		 * reserving 24 byte for future extension.
+		 */
+		uint8_t padding[104];
+	} u;
+};
+
 #define VIRTIO_CRYPTO_OK        0
 #define VIRTIO_CRYPTO_ERR       1
 #define VIRTIO_CRYPTO_BADMSG    2
-- 
1.8.3.1
