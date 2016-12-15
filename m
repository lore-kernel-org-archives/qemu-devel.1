Received: from eggs.gnu.org ([2001:4830:134:3::10]:60016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHLR2-0007OY-5H
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHLQw-0002gn-3j
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:06:16 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:17213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHLQT-0002aG-9m
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:06:10 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 15 Dec 2016 10:03:16 +0800
Message-ID: <1481767396-187748-2-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1481767396-187748-1-git-send-email-arei.gonglei@huawei.com>
References: <1481767396-187748-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
Cc: luonengjun@huawei.com, mst@redhat.com, stefanha@redhat.com, weidong.huang@huawei.com, wu.wubin@huawei.com, xin.zeng@intel.com, claudio.fontana@huawei.com, herbert@gondor.apana.org.au, pasic@linux.vnet.ibm.com, davem@davemloft.net, jianjay.zhou@huawei.com, hanweidong@huawei.com, arei.gonglei@hotmail.com, cornelia.huck@de.ibm.com, xuquan8@huawei.com, longpeng2@huawei.com, wanzongshun@huawei.com, Gonglei <arei.gonglei@huawei.com>

This patch introduces virtio-crypto driver for Linux Kernel.

The virtio crypto device is a virtual cryptography device
as well as a kind of virtual hardware accelerator for
virtual machines. The encryption anddecryption requests
are placed in the data queue and are ultimately handled by
thebackend crypto accelerators. The second queue is the
control queue used to create or destroy sessions for
symmetric algorithms and will control some advanced features
in the future. The virtio crypto device provides the following
cryptoservices: CIPHER, MAC, HASH, and AEAD.

For more information about virtio-crypto device, please see:
  http://qemu-project.org/Features/VirtioCrypto

CC: Michael S. Tsirkin <mst@redhat.com>
CC: Cornelia Huck <cornelia.huck@de.ibm.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: Halil Pasic <pasic@linux.vnet.ibm.com>
CC: David S. Miller <davem@davemloft.net>
CC: Zeng Xin <xin.zeng@intel.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 MAINTAINERS                                  |   9 +
 drivers/crypto/Kconfig                       |   2 +
 drivers/crypto/Makefile                      |   1 +
 drivers/crypto/virtio/Kconfig                |  10 +
 drivers/crypto/virtio/Makefile               |   5 +
 drivers/crypto/virtio/virtio_crypto_algs.c   | 540 +++++++++++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h | 128 +++++++
 drivers/crypto/virtio/virtio_crypto_core.c   | 476 +++++++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_mgr.c    | 264 +++++++++++++
 include/uapi/linux/Kbuild                    |   1 +
 include/uapi/linux/virtio_crypto.h           | 450 ++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h              |   1 +
 12 files changed, 1887 insertions(+)
 create mode 100644 drivers/crypto/virtio/Kconfig
 create mode 100644 drivers/crypto/virtio/Makefile
 create mode 100644 drivers/crypto/virtio/virtio_crypto_algs.c
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.h
 create mode 100644 drivers/crypto/virtio/virtio_crypto_core.c
 create mode 100644 drivers/crypto/virtio/virtio_crypto_mgr.c
 create mode 100644 include/uapi/linux/virtio_crypto.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1174508..b749f1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12967,6 +12967,7 @@ F:	drivers/net/virtio_net.c
 F:	drivers/block/virtio_blk.c
 F:	include/linux/virtio_*.h
 F:	include/uapi/linux/virtio_*.h
+F:	drivers/crypto/virtio/
 
 VIRTIO DRIVERS FOR S390
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
@@ -13003,6 +13004,14 @@ S:	Maintained
 F:	drivers/virtio/virtio_input.c
 F:	include/uapi/linux/virtio_input.h
 
+VIRTIO CRYPTO DRIVER
+M:  Gonglei <arei.gonglei@huawei.com>
+L:  virtualization@lists.linux-foundation.org
+L:  linux-crypto@vger.kernel.org
+S:  Maintained
+F:  drivers/crypto/virtio/
+F:  include/uapi/linux/virtio_crypto.h
+
 VIA RHINE NETWORK DRIVER
 S:	Orphan
 F:	drivers/net/ethernet/via/via-rhine.c
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 4d2b81f..7956478 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -555,4 +555,6 @@ config CRYPTO_DEV_ROCKCHIP
 
 source "drivers/crypto/chelsio/Kconfig"
 
+source "drivers/crypto/virtio/Kconfig"
+
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index ad7250f..bc53cb8 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
 obj-$(CONFIG_CRYPTO_DEV_SUN4I_SS) += sunxi-ss/
 obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rockchip/
 obj-$(CONFIG_CRYPTO_DEV_CHELSIO) += chelsio/
+obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio/
diff --git a/drivers/crypto/virtio/Kconfig b/drivers/crypto/virtio/Kconfig
new file mode 100644
index 0000000..d80f733
--- /dev/null
+++ b/drivers/crypto/virtio/Kconfig
@@ -0,0 +1,10 @@
+config CRYPTO_DEV_VIRTIO
+	tristate "VirtIO crypto driver"
+	depends on VIRTIO
+	select CRYPTO_AEAD
+	select CRYPTO_AUTHENC
+	select CRYPTO_BLKCIPHER
+	default m
+	help
+	  This driver provides support for virtio crypto device. If you
+	  choose 'M' here, this module will be called virtio_crypto.
diff --git a/drivers/crypto/virtio/Makefile b/drivers/crypto/virtio/Makefile
new file mode 100644
index 0000000..dd342c9
--- /dev/null
+++ b/drivers/crypto/virtio/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o
+virtio_crypto-objs := \
+	virtio_crypto_algs.o \
+	virtio_crypto_mgr.o \
+	virtio_crypto_core.o
diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
new file mode 100644
index 0000000..c2374df
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -0,0 +1,540 @@
+ /* Algorithms supported by virtio crypto device
+  *
+  * Authors: Gonglei <arei.gonglei@huawei.com>
+  *
+  * Copyright 2016 HUAWEI TECHNOLOGIES CO., LTD.
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  *
+  * You should have received a copy of the GNU General Public License
+  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+  */
+
+#include <linux/scatterlist.h>
+#include <crypto/algapi.h>
+#include <linux/err.h>
+#include <crypto/scatterwalk.h>
+#include <linux/atomic.h>
+
+#include <uapi/linux/virtio_crypto.h>
+#include "virtio_crypto_common.h"
+
+/*
+ * The algs_lock protects the below global virtio_crypto_active_devs
+ * and crypto algorithms registion.
+ */
+static DEFINE_MUTEX(algs_lock);
+static unsigned int virtio_crypto_active_devs;
+
+static u64 virtio_crypto_alg_sg_nents_length(struct scatterlist *sg)
+{
+	u64 total = 0;
+
+	for (total = 0; sg; sg = sg_next(sg))
+		total += sg->length;
+
+	return total;
+}
+
+static int
+virtio_crypto_alg_validate_key(int key_len, uint32_t *alg)
+{
+	switch (key_len) {
+	case AES_KEYSIZE_128:
+	case AES_KEYSIZE_192:
+	case AES_KEYSIZE_256:
+		*alg = VIRTIO_CRYPTO_CIPHER_AES_CBC;
+		break;
+	default:
+		pr_err("virtio_crypto: Unsupported key length: %d\n",
+			key_len);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int virtio_crypto_alg_ablkcipher_init_session(
+		struct virtio_crypto_ablkcipher_ctx *ctx,
+		uint32_t alg, const uint8_t *key,
+		unsigned int keylen,
+		int encrypt)
+{
+	struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
+	unsigned int tmp;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
+	int err;
+	unsigned int num_out = 0, num_in = 0;
+
+	/*
+	 * Avoid to do DMA from the stack, switch to using
+	 * dynamically-allocated for the key
+	 */
+	uint8_t *cipher_key = kmalloc(keylen, GFP_ATOMIC);
+
+	if (!cipher_key)
+		return -ENOMEM;
+
+	memcpy(cipher_key, key, keylen);
+
+	spin_lock(&vcrypto->ctrl_lock);
+	/* Pad ctrl header */
+	vcrypto->ctrl.header.opcode =
+		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
+	vcrypto->ctrl.header.algo = cpu_to_le32(alg);
+	/* Set the default dataqueue id to 0 */
+	vcrypto->ctrl.header.queue_id = 0;
+
+	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	/* Pad cipher's parameters */
+	vcrypto->ctrl.u.sym_create_session.op_type =
+		cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
+	vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
+		vcrypto->ctrl.header.algo;
+	vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
+		cpu_to_le32(keylen);
+	vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
+		cpu_to_le32(op);
+
+	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sgs[num_out++] = &outhdr;
+
+	/* Set key */
+	sg_init_one(&key_sg, cipher_key, keylen);
+	sgs[num_out++] = &key_sg;
+
+	/* Return status and session id back */
+	sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
+	sgs[num_out + num_in++] = &inhdr;
+
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
+				num_in, vcrypto, GFP_ATOMIC);
+	if (err < 0) {
+		spin_unlock(&vcrypto->ctrl_lock);
+		kzfree(cipher_key);
+		return err;
+	}
+	virtqueue_kick(vcrypto->ctrl_vq);
+
+	/*
+	 * Trapping into the hypervisor, so the request should be
+	 * handled immediately.
+	 */
+	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
+	       !virtqueue_is_broken(vcrypto->ctrl_vq))
+		cpu_relax();
+
+	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+		spin_unlock(&vcrypto->ctrl_lock);
+		pr_err("virtio_crypto: Create session failed status: %u\n",
+			le32_to_cpu(vcrypto->input.status));
+		kzfree(cipher_key);
+		return -EINVAL;
+	}
+
+	if (encrypt)
+		ctx->enc_sess_info.session_id =
+			le64_to_cpu(vcrypto->input.session_id);
+	else
+		ctx->dec_sess_info.session_id =
+			le64_to_cpu(vcrypto->input.session_id);
+
+	spin_unlock(&vcrypto->ctrl_lock);
+
+	kzfree(cipher_key);
+	return 0;
+}
+
+static int virtio_crypto_alg_ablkcipher_close_session(
+		struct virtio_crypto_ablkcipher_ctx *ctx,
+		int encrypt)
+{
+	struct scatterlist outhdr, status_sg, *sgs[2];
+	unsigned int tmp;
+	struct virtio_crypto_destroy_session_req *destroy_session;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	int err;
+	unsigned int num_out = 0, num_in = 0;
+
+	spin_lock(&vcrypto->ctrl_lock);
+	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	/* Pad ctrl header */
+	vcrypto->ctrl.header.opcode =
+		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
+	/* Set the default virtqueue id to 0 */
+	vcrypto->ctrl.header.queue_id = 0;
+
+	destroy_session = &vcrypto->ctrl.u.destroy_session;
+
+	if (encrypt)
+		destroy_session->session_id =
+			cpu_to_le64(ctx->enc_sess_info.session_id);
+	else
+		destroy_session->session_id =
+			cpu_to_le64(ctx->dec_sess_info.session_id);
+
+	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sgs[num_out++] = &outhdr;
+
+	/* Return status and session id back */
+	sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
+		sizeof(vcrypto->ctrl_status.status));
+	sgs[num_out + num_in++] = &status_sg;
+
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
+			num_in, vcrypto, GFP_ATOMIC);
+	if (err < 0) {
+		spin_unlock(&vcrypto->ctrl_lock);
+		return err;
+	}
+	virtqueue_kick(vcrypto->ctrl_vq);
+
+	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
+	       !virtqueue_is_broken(vcrypto->ctrl_vq))
+		cpu_relax();
+
+	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+		spin_unlock(&vcrypto->ctrl_lock);
+		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
+			vcrypto->ctrl_status.status,
+			destroy_session->session_id);
+
+		return -EINVAL;
+	}
+	spin_unlock(&vcrypto->ctrl_lock);
+
+	return 0;
+}
+
+static int virtio_crypto_alg_ablkcipher_init_sessions(
+		struct virtio_crypto_ablkcipher_ctx *ctx,
+		const uint8_t *key, unsigned int keylen)
+{
+	uint32_t alg;
+	int ret;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+
+	if (keylen > vcrypto->max_cipher_key_len) {
+		pr_err("virtio_crypto: the key is too long\n");
+		goto bad_key;
+	}
+
+	if (virtio_crypto_alg_validate_key(keylen, &alg))
+		goto bad_key;
+
+	/* Create encryption session */
+	ret = virtio_crypto_alg_ablkcipher_init_session(ctx,
+			alg, key, keylen, 1);
+	if (ret)
+		return ret;
+	/* Create decryption session */
+	ret = virtio_crypto_alg_ablkcipher_init_session(ctx,
+			alg, key, keylen, 0);
+	if (ret) {
+		virtio_crypto_alg_ablkcipher_close_session(ctx, 1);
+		return ret;
+	}
+	return 0;
+
+bad_key:
+	crypto_tfm_set_flags(ctx->tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+	return -EINVAL;
+}
+
+/* Note: kernel crypto API realization */
+static int virtio_crypto_ablkcipher_setkey(struct crypto_ablkcipher *tfm,
+					 const uint8_t *key,
+					 unsigned int keylen)
+{
+	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	int ret;
+
+	if (!ctx->vcrypto) {
+		/* New key */
+		int node = virtio_crypto_get_current_node();
+		struct virtio_crypto *vcrypto =
+				      virtcrypto_get_dev_node(node);
+		if (!vcrypto) {
+			pr_err("virtio_crypto: Could not find a virtio device in the system");
+			return -ENODEV;
+		}
+
+		ctx->vcrypto = vcrypto;
+	} else {
+		/* Rekeying, we should close the created sessions previously */
+		virtio_crypto_alg_ablkcipher_close_session(ctx, 1);
+		virtio_crypto_alg_ablkcipher_close_session(ctx, 0);
+	}
+
+	ret = virtio_crypto_alg_ablkcipher_init_sessions(ctx, key, keylen);
+	if (ret) {
+		virtcrypto_dev_put(ctx->vcrypto);
+		ctx->vcrypto = NULL;
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+__virtio_crypto_ablkcipher_do_req(struct virtio_crypto_request *vc_req,
+		struct ablkcipher_request *req,
+		struct data_queue *data_vq,
+		__u8 op)
+{
+	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
+	unsigned int ivsize = crypto_ablkcipher_ivsize(tfm);
+	struct virtio_crypto_ablkcipher_ctx *ctx = vc_req->ablkcipher_ctx;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	struct virtio_crypto_op_data_req *req_data;
+	int src_nents, dst_nents;
+	int err;
+	unsigned long flags;
+	struct scatterlist outhdr, iv_sg, status_sg, **sgs;
+	int i;
+	u64 dst_len;
+	unsigned int num_out = 0, num_in = 0;
+	int sg_total;
+	uint8_t *iv;
+
+	src_nents = sg_nents_for_len(req->src, req->nbytes);
+	dst_nents = sg_nents(req->dst);
+
+	pr_debug("virtio_crypto: Number of sgs (src_nents: %d, dst_nents: %d)\n",
+			src_nents, dst_nents);
+
+	/* Why 3?  outhdr + iv + inhdr */
+	sg_total = src_nents + dst_nents + 3;
+	sgs = kzalloc_node(sg_total * sizeof(*sgs), GFP_ATOMIC,
+				dev_to_node(&vcrypto->vdev->dev));
+	if (!sgs)
+		return -ENOMEM;
+
+	req_data = kzalloc_node(sizeof(*req_data), GFP_ATOMIC,
+				dev_to_node(&vcrypto->vdev->dev));
+	if (!req_data) {
+		kfree(sgs);
+		return -ENOMEM;
+	}
+
+	vc_req->req_data = req_data;
+	vc_req->type = VIRTIO_CRYPTO_SYM_OP_CIPHER;
+	/* Head of operation */
+	if (op) {
+		req_data->header.session_id =
+			cpu_to_le64(ctx->enc_sess_info.session_id);
+		req_data->header.opcode =
+			cpu_to_le32(VIRTIO_CRYPTO_CIPHER_ENCRYPT);
+	} else {
+		req_data->header.session_id =
+			cpu_to_le64(ctx->dec_sess_info.session_id);
+	    req_data->header.opcode =
+			cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DECRYPT);
+	}
+	req_data->u.sym_req.op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
+	req_data->u.sym_req.u.cipher.para.iv_len = cpu_to_le32(ivsize);
+	req_data->u.sym_req.u.cipher.para.src_data_len =
+			cpu_to_le32(req->nbytes);
+
+	dst_len = virtio_crypto_alg_sg_nents_length(req->dst);
+	if (unlikely(dst_len > U32_MAX)) {
+		pr_err("virtio_crypto: The dst_len is beyond U32_MAX\n");
+		err = -EINVAL;
+		goto free;
+	}
+
+	pr_debug("virtio_crypto: src_len: %u, dst_len: %llu\n",
+			req->nbytes, dst_len);
+
+	if (unlikely(req->nbytes + dst_len + ivsize +
+		sizeof(vc_req->status) > vcrypto->max_size)) {
+		pr_err("virtio_crypto: The length is too big\n");
+		err = -EINVAL;
+		goto free;
+	}
+
+	req_data->u.sym_req.u.cipher.para.dst_data_len =
+			cpu_to_le32((uint32_t)dst_len);
+
+	/* Outhdr */
+	sg_init_one(&outhdr, req_data, sizeof(*req_data));
+	sgs[num_out++] = &outhdr;
+
+	/* IV */
+
+	/*
+	 * Avoid to do DMA from the stack, switch to using
+	 * dynamically-allocated for the IV
+	 */
+	iv = kzalloc_node(ivsize, GFP_ATOMIC,
+				dev_to_node(&vcrypto->vdev->dev));
+	if (!iv) {
+		err = -ENOMEM;
+		goto free;
+	}
+	memcpy(iv, req->info, ivsize);
+	sg_init_one(&iv_sg, iv, ivsize);
+	sgs[num_out++] = &iv_sg;
+	vc_req->iv = iv;
+
+	/* Source data */
+	for (i = 0; i < src_nents; i++)
+		sgs[num_out++] = &req->src[i];
+
+	/* Destination data */
+	for (i = 0; i < dst_nents; i++)
+		sgs[num_out + num_in++] = &req->dst[i];
+
+	/* Status */
+	sg_init_one(&status_sg, &vc_req->status, sizeof(vc_req->status));
+	sgs[num_out + num_in++] = &status_sg;
+
+	vc_req->sgs = sgs;
+
+	spin_lock_irqsave(&data_vq->lock, flags);
+	err = virtqueue_add_sgs(data_vq->vq, sgs, num_out,
+				num_in, vc_req, GFP_ATOMIC);
+	virtqueue_kick(data_vq->vq);
+	spin_unlock_irqrestore(&data_vq->lock, flags);
+	if (unlikely(err < 0))
+		goto free_iv;
+
+	return 0;
+
+free_iv:
+	kzfree(iv);
+free:
+	kzfree(req_data);
+	kfree(sgs);
+	return err;
+}
+
+static int virtio_crypto_ablkcipher_encrypt(struct ablkcipher_request *req)
+{
+	struct crypto_ablkcipher *atfm = crypto_ablkcipher_reqtfm(req);
+	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_ablkcipher_ctx(atfm);
+	struct virtio_crypto_request *vc_req = ablkcipher_request_ctx(req);
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	int ret;
+	/* Use the first data virtqueue as default */
+	struct data_queue *data_vq = &vcrypto->data_vq[0];
+
+	vc_req->ablkcipher_ctx = ctx;
+	vc_req->ablkcipher_req = req;
+	ret = __virtio_crypto_ablkcipher_do_req(vc_req, req, data_vq, 1);
+	if (ret < 0) {
+		pr_err("virtio_crypto: Encryption failed!\n");
+		return ret;
+	}
+
+	return -EINPROGRESS;
+}
+
+static int virtio_crypto_ablkcipher_decrypt(struct ablkcipher_request *req)
+{
+	struct crypto_ablkcipher *atfm = crypto_ablkcipher_reqtfm(req);
+	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_ablkcipher_ctx(atfm);
+	struct virtio_crypto_request *vc_req = ablkcipher_request_ctx(req);
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	int ret;
+	/* Use the first data virtqueue as default */
+	struct data_queue *data_vq = &vcrypto->data_vq[0];
+
+	vc_req->ablkcipher_ctx = ctx;
+	vc_req->ablkcipher_req = req;
+
+	ret = __virtio_crypto_ablkcipher_do_req(vc_req, req, data_vq, 0);
+	if (ret < 0) {
+		pr_err("virtio_crypto: Decryption failed!\n");
+		return ret;
+	}
+
+	return -EINPROGRESS;
+}
+
+static int virtio_crypto_ablkcipher_init(struct crypto_tfm *tfm)
+{
+	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	tfm->crt_ablkcipher.reqsize = sizeof(struct virtio_crypto_request);
+	ctx->tfm = tfm;
+
+	return 0;
+}
+
+static void virtio_crypto_ablkcipher_exit(struct crypto_tfm *tfm)
+{
+	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (!ctx->vcrypto)
+		return;
+
+	virtio_crypto_alg_ablkcipher_close_session(ctx, 1);
+	virtio_crypto_alg_ablkcipher_close_session(ctx, 0);
+	virtcrypto_dev_put(ctx->vcrypto);
+	ctx->vcrypto = NULL;
+}
+
+static struct crypto_alg virtio_crypto_algs[] = { {
+	.cra_name = "cbc(aes)",
+	.cra_driver_name = "virtio_crypto_aes_cbc",
+	.cra_priority = 501,
+	.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
+	.cra_blocksize = AES_BLOCK_SIZE,
+	.cra_ctxsize  = sizeof(struct virtio_crypto_ablkcipher_ctx),
+	.cra_alignmask = 0,
+	.cra_module = THIS_MODULE,
+	.cra_type = &crypto_ablkcipher_type,
+	.cra_init = virtio_crypto_ablkcipher_init,
+	.cra_exit = virtio_crypto_ablkcipher_exit,
+	.cra_u = {
+	   .ablkcipher = {
+			.setkey = virtio_crypto_ablkcipher_setkey,
+			.decrypt = virtio_crypto_ablkcipher_decrypt,
+			.encrypt = virtio_crypto_ablkcipher_encrypt,
+			.min_keysize = AES_MIN_KEY_SIZE,
+			.max_keysize = AES_MAX_KEY_SIZE,
+			.ivsize = AES_BLOCK_SIZE,
+		},
+	},
+} };
+
+int virtio_crypto_algs_register(void)
+{
+	int ret = 0;
+
+	mutex_lock(&algs_lock);
+	if (++virtio_crypto_active_devs != 1)
+		goto unlock;
+
+	ret = crypto_register_algs(virtio_crypto_algs,
+			ARRAY_SIZE(virtio_crypto_algs));
+	if (ret)
+		virtio_crypto_active_devs--;
+
+unlock:
+	mutex_unlock(&algs_lock);
+	return ret;
+}
+
+void virtio_crypto_algs_unregister(void)
+{
+	mutex_lock(&algs_lock);
+	if (--virtio_crypto_active_devs != 0)
+		goto unlock;
+
+	crypto_unregister_algs(virtio_crypto_algs,
+			ARRAY_SIZE(virtio_crypto_algs));
+
+unlock:
+	mutex_unlock(&algs_lock);
+}
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
new file mode 100644
index 0000000..3d6566b
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -0,0 +1,128 @@
+/* Common header for Virtio crypto device.
+ *
+ * Copyright 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _VIRTIO_CRYPTO_COMMON_H
+#define _VIRTIO_CRYPTO_COMMON_H
+
+#include <linux/virtio.h>
+#include <linux/crypto.h>
+#include <linux/spinlock.h>
+#include <crypto/aead.h>
+#include <crypto/aes.h>
+#include <crypto/authenc.h>
+
+
+/* Internal representation of a data virtqueue */
+struct data_queue {
+	/* Virtqueue associated with this send _queue */
+	struct virtqueue *vq;
+
+	/* To protect the vq operations for the dataq */
+	spinlock_t lock;
+
+	/* Name of the tx queue: dataq.$index */
+	char name[32];
+};
+
+struct virtio_crypto {
+	struct virtio_device *vdev;
+	struct virtqueue *ctrl_vq;
+	struct data_queue *data_vq;
+
+	/* To protect the vq operations for the controlq */
+	spinlock_t ctrl_lock;
+
+	/* Maximum of data queues supported by the device */
+	u32 max_data_queues;
+
+	/* Number of queue currently used by the driver */
+	u32 curr_queue;
+
+	/* Maximum length of cipher key */
+	u32 max_cipher_key_len;
+	/* Maximum length of authenticated key */
+	u32 max_auth_key_len;
+	/* Maximum size of per request */
+	u64 max_size;
+
+	/* Control VQ buffers: protected by the ctrl_lock */
+	struct virtio_crypto_op_ctrl_req ctrl;
+	struct virtio_crypto_session_input input;
+	struct virtio_crypto_inhdr ctrl_status;
+
+	unsigned long status;
+	atomic_t ref_count;
+	struct list_head list;
+	struct module *owner;
+	uint8_t dev_id;
+
+	/* Does the affinity hint is set for virtqueues? */
+	bool affinity_hint_set;
+};
+
+struct virtio_crypto_sym_session_info {
+	/* Backend session id, which come from the host side */
+	__u64 session_id;
+};
+
+struct virtio_crypto_ablkcipher_ctx {
+	struct virtio_crypto *vcrypto;
+	struct crypto_tfm *tfm;
+
+	struct virtio_crypto_sym_session_info enc_sess_info;
+	struct virtio_crypto_sym_session_info dec_sess_info;
+};
+
+struct virtio_crypto_request {
+	/* Cipher or aead */
+	uint32_t type;
+	uint8_t status;
+	struct virtio_crypto_ablkcipher_ctx *ablkcipher_ctx;
+	struct ablkcipher_request *ablkcipher_req;
+	struct virtio_crypto_op_data_req *req_data;
+	struct scatterlist **sgs;
+	uint8_t *iv;
+};
+
+int virtcrypto_devmgr_add_dev(struct virtio_crypto *vcrypto_dev);
+struct list_head *virtcrypto_devmgr_get_head(void);
+void virtcrypto_devmgr_rm_dev(struct virtio_crypto *vcrypto_dev);
+struct virtio_crypto *virtcrypto_devmgr_get_first(void);
+int virtcrypto_dev_in_use(struct virtio_crypto *vcrypto_dev);
+int virtcrypto_dev_get(struct virtio_crypto *vcrypto_dev);
+void virtcrypto_dev_put(struct virtio_crypto *vcrypto_dev);
+int virtcrypto_dev_started(struct virtio_crypto *vcrypto_dev);
+struct virtio_crypto *virtcrypto_get_dev_node(int node);
+int virtcrypto_dev_start(struct virtio_crypto *vcrypto);
+void virtcrypto_dev_stop(struct virtio_crypto *vcrypto);
+
+static inline int virtio_crypto_get_current_node(void)
+{
+	int cpu, node;
+
+	cpu = get_cpu();
+	node = topology_physical_package_id(cpu);
+	put_cpu();
+
+	return node;
+}
+
+int virtio_crypto_algs_register(void);
+void virtio_crypto_algs_unregister(void);
+
+#endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
new file mode 100644
index 0000000..fe70ec8
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -0,0 +1,476 @@
+ /* Driver for Virtio crypto device.
+  *
+  * Copyright 2016 HUAWEI TECHNOLOGIES CO., LTD.
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  *
+  * You should have received a copy of the GNU General Public License
+  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+  */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/virtio_config.h>
+#include <linux/cpu.h>
+
+#include <uapi/linux/virtio_crypto.h>
+#include "virtio_crypto_common.h"
+
+
+static void
+virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
+{
+	if (vc_req) {
+		kzfree(vc_req->iv);
+		kzfree(vc_req->req_data);
+		kfree(vc_req->sgs);
+	}
+}
+
+static void virtcrypto_dataq_callback(struct virtqueue *vq)
+{
+	struct virtio_crypto *vcrypto = vq->vdev->priv;
+	struct virtio_crypto_request *vc_req;
+	unsigned long flags;
+	unsigned int len;
+	struct ablkcipher_request *ablk_req;
+	int error;
+	unsigned int qid = vq->index;
+
+	spin_lock_irqsave(&vcrypto->data_vq[qid].lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
+			if (vc_req->type == VIRTIO_CRYPTO_SYM_OP_CIPHER) {
+				switch (vc_req->status) {
+				case VIRTIO_CRYPTO_OK:
+					error = 0;
+					break;
+				case VIRTIO_CRYPTO_INVSESS:
+				case VIRTIO_CRYPTO_ERR:
+					error = -EINVAL;
+					break;
+				case VIRTIO_CRYPTO_BADMSG:
+					error = -EBADMSG;
+					break;
+				default:
+					error = -EIO;
+					break;
+				}
+				ablk_req = vc_req->ablkcipher_req;
+				virtcrypto_clear_request(vc_req);
+
+				spin_unlock_irqrestore(
+					&vcrypto->data_vq[qid].lock, flags);
+				/* Finish the encrypt or decrypt process */
+				ablk_req->base.complete(&ablk_req->base, error);
+				spin_lock_irqsave(
+					&vcrypto->data_vq[qid].lock, flags);
+			}
+		}
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vcrypto->data_vq[qid].lock, flags);
+}
+
+static int virtcrypto_find_vqs(struct virtio_crypto *vi)
+{
+	vq_callback_t **callbacks;
+	struct virtqueue **vqs;
+	int ret = -ENOMEM;
+	int i, total_vqs;
+	const char **names;
+
+	/*
+	 * We expect 1 data virtqueue, followed by
+	 * possible N-1 data queues used in multiqueue mode,
+	 * followed by control vq.
+	 */
+	total_vqs = vi->max_data_queues + 1;
+
+	/* Allocate space for find_vqs parameters */
+	vqs = kcalloc(total_vqs, sizeof(*vqs), GFP_KERNEL);
+	if (!vqs)
+		goto err_vq;
+	callbacks = kcalloc(total_vqs, sizeof(*callbacks), GFP_KERNEL);
+	if (!callbacks)
+		goto err_callback;
+	names = kcalloc(total_vqs, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		goto err_names;
+
+	/* Parameters for control virtqueue */
+	callbacks[total_vqs - 1] = NULL;
+	names[total_vqs - 1] = "controlq";
+
+	/* Allocate/initialize parameters for data virtqueues */
+	for (i = 0; i < vi->max_data_queues; i++) {
+		callbacks[i] = virtcrypto_dataq_callback;
+		snprintf(vi->data_vq[i].name, sizeof(vi->data_vq[i].name),
+				"dataq.%d", i);
+		names[i] = vi->data_vq[i].name;
+	}
+
+	ret = vi->vdev->config->find_vqs(vi->vdev, total_vqs, vqs, callbacks,
+					 names);
+	if (ret)
+		goto err_find;
+
+	vi->ctrl_vq = vqs[total_vqs - 1];
+
+	for (i = 0; i < vi->max_data_queues; i++) {
+		spin_lock_init(&vi->data_vq[i].lock);
+		vi->data_vq[i].vq = vqs[i];
+	}
+
+	kfree(names);
+	kfree(callbacks);
+	kfree(vqs);
+
+	return 0;
+
+err_find:
+	kfree(names);
+err_names:
+	kfree(callbacks);
+err_callback:
+	kfree(vqs);
+err_vq:
+	return ret;
+}
+
+static int virtcrypto_alloc_queues(struct virtio_crypto *vi)
+{
+	vi->data_vq = kcalloc(vi->max_data_queues, sizeof(*vi->data_vq),
+				GFP_KERNEL);
+	if (!vi->data_vq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void virtcrypto_clean_affinity(struct virtio_crypto *vi, long hcpu)
+{
+	int i;
+
+	if (vi->affinity_hint_set) {
+		for (i = 0; i < vi->max_data_queues; i++)
+			virtqueue_set_affinity(vi->data_vq[i].vq, -1);
+
+		vi->affinity_hint_set = false;
+	}
+}
+
+static void virtcrypto_set_affinity(struct virtio_crypto *vcrypto)
+{
+	int i = 0;
+	int cpu;
+
+	/*
+	 * In single queue mode, we don't set the cpu affinity.
+	 */
+	if (vcrypto->curr_queue == 1 || vcrypto->max_data_queues == 1) {
+		virtcrypto_clean_affinity(vcrypto, -1);
+		return;
+	}
+
+	/*
+	 * In multiqueue mode, we let the queue to be private to one cpu
+	 * by setting the affinity hint to eliminate the contention.
+	 *
+	 * TODO: adds cpu hotplug support by register cpu notifier.
+	 *
+	 */
+	for_each_online_cpu(cpu) {
+		virtqueue_set_affinity(vcrypto->data_vq[i].vq, cpu);
+		if (++i >= vcrypto->max_data_queues)
+			break;
+	}
+
+	vcrypto->affinity_hint_set = true;
+}
+
+static void virtcrypto_free_queues(struct virtio_crypto *vi)
+{
+	kfree(vi->data_vq);
+}
+
+static int virtcrypto_init_vqs(struct virtio_crypto *vi)
+{
+	int ret;
+
+	/* Allocate send & receive queues */
+	ret = virtcrypto_alloc_queues(vi);
+	if (ret)
+		goto err;
+
+	ret = virtcrypto_find_vqs(vi);
+	if (ret)
+		goto err_free;
+
+	get_online_cpus();
+	virtcrypto_set_affinity(vi);
+	put_online_cpus();
+
+	return 0;
+
+err_free:
+	virtcrypto_free_queues(vi);
+err:
+	return ret;
+}
+
+static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
+{
+	u32 status;
+	int err;
+
+	virtio_cread(vcrypto->vdev,
+	    struct virtio_crypto_config, status, &status);
+
+	/*
+	 * Unknown status bits would be a host error and the driver
+	 * should consider the device to be broken.
+	 */
+	if (status & (~VIRTIO_CRYPTO_S_HW_READY)) {
+		dev_warn(&vcrypto->vdev->dev,
+				"Unknown status bits: 0x%x\n", status);
+
+		virtio_break_device(vcrypto->vdev);
+		return -EPERM;
+	}
+
+	if (vcrypto->status == status)
+		return 0;
+
+	vcrypto->status = status;
+
+	if (vcrypto->status & VIRTIO_CRYPTO_S_HW_READY) {
+		err = virtcrypto_dev_start(vcrypto);
+		if (err) {
+			dev_err(&vcrypto->vdev->dev,
+				"Failed to start virtio crypto device.\n");
+
+			return -EPERM;
+		}
+		dev_info(&vcrypto->vdev->dev, "Accelerator is ready\n");
+	} else {
+		virtcrypto_dev_stop(vcrypto);
+		dev_info(&vcrypto->vdev->dev, "Accelerator is not ready\n");
+	}
+
+	return 0;
+}
+
+static void virtcrypto_del_vqs(struct virtio_crypto *vcrypto)
+{
+	struct virtio_device *vdev = vcrypto->vdev;
+
+	virtcrypto_clean_affinity(vcrypto, -1);
+
+	vdev->config->del_vqs(vdev);
+
+	virtcrypto_free_queues(vcrypto);
+}
+
+static int virtcrypto_probe(struct virtio_device *vdev)
+{
+	int err = -EFAULT;
+	struct virtio_crypto *vcrypto;
+	u32 max_data_queues = 0, max_cipher_key_len = 0;
+	u32 max_auth_key_len = 0;
+	u64 max_size = 0;
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		return -ENODEV;
+
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (num_possible_nodes() > 1 && dev_to_node(&vdev->dev) < 0) {
+		/*
+		 * If the accelerator is connected to a node with no memory
+		 * there is no point in using the accelerator since the remote
+		 * memory transaction will be very slow.
+		 */
+		dev_err(&vdev->dev, "Invalid NUMA configuration.\n");
+		return -EINVAL;
+	}
+
+	vcrypto = kzalloc_node(sizeof(*vcrypto), GFP_KERNEL,
+					dev_to_node(&vdev->dev));
+	if (!vcrypto)
+		return -ENOMEM;
+
+	virtio_cread(vdev, struct virtio_crypto_config,
+			max_dataqueues, &max_data_queues);
+	if (max_data_queues < 1)
+		max_data_queues = 1;
+
+	virtio_cread(vdev, struct virtio_crypto_config,
+		max_cipher_key_len, &max_cipher_key_len);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		max_auth_key_len, &max_auth_key_len);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		max_size, &max_size);
+
+	/* Add virtio crypto device to global table */
+	err = virtcrypto_devmgr_add_dev(vcrypto);
+	if (err) {
+		dev_err(&vdev->dev, "Failed to add new virtio crypto device.\n");
+		goto free;
+	}
+	vcrypto->owner = THIS_MODULE;
+	vcrypto = vdev->priv = vcrypto;
+	vcrypto->vdev = vdev;
+
+	spin_lock_init(&vcrypto->ctrl_lock);
+
+	/* Use single data queue as default */
+	vcrypto->curr_queue = 1;
+	vcrypto->max_data_queues = max_data_queues;
+	vcrypto->max_cipher_key_len = max_cipher_key_len;
+	vcrypto->max_auth_key_len = max_auth_key_len;
+	vcrypto->max_size = max_size;
+
+	dev_info(&vdev->dev,
+		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u, max_size 0x%llx\n",
+		vcrypto->max_data_queues,
+		vcrypto->max_cipher_key_len,
+		vcrypto->max_auth_key_len,
+		vcrypto->max_size);
+
+	err = virtcrypto_init_vqs(vcrypto);
+	if (err) {
+		dev_err(&vdev->dev, "Failed to initialize vqs.\n");
+		goto free_dev;
+	}
+	virtio_device_ready(vdev);
+
+	err = virtcrypto_update_status(vcrypto);
+	if (err)
+		goto free_vqs;
+
+	return 0;
+
+free_vqs:
+	vcrypto->vdev->config->reset(vdev);
+	virtcrypto_del_vqs(vcrypto);
+free_dev:
+	virtcrypto_devmgr_rm_dev(vcrypto);
+free:
+	kfree(vcrypto);
+	return err;
+}
+
+static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
+{
+	struct virtio_crypto_request *vc_req;
+	int i;
+	struct virtqueue *vq;
+
+	for (i = 0; i < vcrypto->max_data_queues; i++) {
+		vq = vcrypto->data_vq[i].vq;
+		while ((vc_req = virtqueue_detach_unused_buf(vq)) != NULL) {
+			kfree(vc_req->req_data);
+			kfree(vc_req->sgs);
+		}
+	}
+}
+
+static void virtcrypto_remove(struct virtio_device *vdev)
+{
+	struct virtio_crypto *vcrypto = vdev->priv;
+
+	dev_info(&vdev->dev, "Start virtcrypto_remove.\n");
+
+	if (virtcrypto_dev_started(vcrypto))
+		virtcrypto_dev_stop(vcrypto);
+	vdev->config->reset(vdev);
+	virtcrypto_free_unused_reqs(vcrypto);
+	virtcrypto_del_vqs(vcrypto);
+	virtcrypto_devmgr_rm_dev(vcrypto);
+	kfree(vcrypto);
+}
+
+static void virtcrypto_config_changed(struct virtio_device *vdev)
+{
+	struct virtio_crypto *vcrypto = vdev->priv;
+
+	virtcrypto_update_status(vcrypto);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int virtcrypto_freeze(struct virtio_device *vdev)
+{
+	struct virtio_crypto *vcrypto = vdev->priv;
+
+	vdev->config->reset(vdev);
+	virtcrypto_free_unused_reqs(vcrypto);
+	if (virtcrypto_dev_started(vcrypto))
+		virtcrypto_dev_stop(vcrypto);
+
+	virtcrypto_del_vqs(vcrypto);
+	return 0;
+}
+
+static int virtcrypto_restore(struct virtio_device *vdev)
+{
+	struct virtio_crypto *vcrypto = vdev->priv;
+	int err;
+
+	err = virtcrypto_init_vqs(vcrypto);
+	if (err)
+		return err;
+
+	virtio_device_ready(vdev);
+	err = virtcrypto_dev_start(vcrypto);
+	if (err) {
+		dev_err(&vdev->dev, "Failed to start virtio crypto device.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+#endif
+
+static unsigned int features[] = {
+	/* none */
+};
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_CRYPTO, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_crypto_driver = {
+	.driver.name         = KBUILD_MODNAME,
+	.driver.owner        = THIS_MODULE,
+	.feature_table       = features,
+	.feature_table_size  = ARRAY_SIZE(features),
+	.id_table            = id_table,
+	.probe               = virtcrypto_probe,
+	.remove              = virtcrypto_remove,
+	.config_changed = virtcrypto_config_changed,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtcrypto_freeze,
+	.restore = virtcrypto_restore,
+#endif
+};
+
+module_virtio_driver(virtio_crypto_driver);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("virtio crypto device driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gonglei <arei.gonglei@huawei.com>");
diff --git a/drivers/crypto/virtio/virtio_crypto_mgr.c b/drivers/crypto/virtio/virtio_crypto_mgr.c
new file mode 100644
index 0000000..a69ff71
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_crypto_mgr.c
@@ -0,0 +1,264 @@
+ /* Management for virtio crypto devices (refer to adf_dev_mgr.c)
+  *
+  * Copyright 2016 HUAWEI TECHNOLOGIES CO., LTD.
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  *
+  * You should have received a copy of the GNU General Public License
+  * along with this program; if not, see <http://www.gnu.org/licenses/>.
+  */
+
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/module.h>
+
+#include <uapi/linux/virtio_crypto.h>
+#include "virtio_crypto_common.h"
+
+static LIST_HEAD(virtio_crypto_table);
+static uint32_t num_devices;
+
+/* The table_lock protects the above global list and num_devices */
+static DEFINE_MUTEX(table_lock);
+
+#define VIRTIO_CRYPTO_MAX_DEVICES 32
+
+
+/*
+ * virtcrypto_devmgr_add_dev() - Add vcrypto_dev to the acceleration
+ * framework.
+ * @vcrypto_dev:  Pointer to virtio crypto device.
+ *
+ * Function adds virtio crypto device to the global list.
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: 0 on success, error code othewise.
+ */
+int virtcrypto_devmgr_add_dev(struct virtio_crypto *vcrypto_dev)
+{
+	struct list_head *itr;
+
+	mutex_lock(&table_lock);
+	if (num_devices == VIRTIO_CRYPTO_MAX_DEVICES) {
+		pr_info("virtio_crypto: only support up to %d devices\n",
+			    VIRTIO_CRYPTO_MAX_DEVICES);
+		mutex_unlock(&table_lock);
+		return -EFAULT;
+	}
+
+	list_for_each(itr, &virtio_crypto_table) {
+		struct virtio_crypto *ptr =
+				list_entry(itr, struct virtio_crypto, list);
+
+		if (ptr == vcrypto_dev) {
+			mutex_unlock(&table_lock);
+			return -EEXIST;
+		}
+	}
+	atomic_set(&vcrypto_dev->ref_count, 0);
+	list_add_tail(&vcrypto_dev->list, &virtio_crypto_table);
+	vcrypto_dev->dev_id = num_devices++;
+	mutex_unlock(&table_lock);
+	return 0;
+}
+
+struct list_head *virtcrypto_devmgr_get_head(void)
+{
+	return &virtio_crypto_table;
+}
+
+/*
+ * virtcrypto_devmgr_rm_dev() - Remove vcrypto_dev from the acceleration
+ * framework.
+ * @vcrypto_dev:  Pointer to virtio crypto device.
+ *
+ * Function removes virtio crypto device from the acceleration framework.
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: void
+ */
+void virtcrypto_devmgr_rm_dev(struct virtio_crypto *vcrypto_dev)
+{
+	mutex_lock(&table_lock);
+	list_del(&vcrypto_dev->list);
+	num_devices--;
+	mutex_unlock(&table_lock);
+}
+
+/*
+ * virtcrypto_devmgr_get_first()
+ *
+ * Function returns the first virtio crypto device from the acceleration
+ * framework.
+ *
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: pointer to vcrypto_dev or NULL if not found.
+ */
+struct virtio_crypto *virtcrypto_devmgr_get_first(void)
+{
+	struct virtio_crypto *dev = NULL;
+
+	mutex_lock(&table_lock);
+	if (!list_empty(&virtio_crypto_table))
+		dev = list_first_entry(&virtio_crypto_table,
+					struct virtio_crypto,
+				    list);
+	mutex_unlock(&table_lock);
+	return dev;
+}
+
+/*
+ * virtcrypto_dev_in_use() - Check whether vcrypto_dev is currently in use
+ * @vcrypto_dev: Pointer to virtio crypto device.
+ *
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: 1 when device is in use, 0 otherwise.
+ */
+int virtcrypto_dev_in_use(struct virtio_crypto *vcrypto_dev)
+{
+	return atomic_read(&vcrypto_dev->ref_count) != 0;
+}
+
+/*
+ * virtcrypto_dev_get() - Increment vcrypto_dev reference count
+ * @vcrypto_dev: Pointer to virtio crypto device.
+ *
+ * Increment the vcrypto_dev refcount and if this is the first time
+ * incrementing it during this period the vcrypto_dev is in use,
+ * increment the module refcount too.
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: 0 when successful, EFAULT when fail to bump module refcount
+ */
+int virtcrypto_dev_get(struct virtio_crypto *vcrypto_dev)
+{
+	if (atomic_add_return(1, &vcrypto_dev->ref_count) == 1)
+		if (!try_module_get(vcrypto_dev->owner))
+			return -EFAULT;
+	return 0;
+}
+
+/*
+ * virtcrypto_dev_put() - Decrement vcrypto_dev reference count
+ * @vcrypto_dev: Pointer to virtio crypto device.
+ *
+ * Decrement the vcrypto_dev refcount and if this is the last time
+ * decrementing it during this period the vcrypto_dev is in use,
+ * decrement the module refcount too.
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: void
+ */
+void virtcrypto_dev_put(struct virtio_crypto *vcrypto_dev)
+{
+	if (atomic_sub_return(1, &vcrypto_dev->ref_count) == 0)
+		module_put(vcrypto_dev->owner);
+}
+
+/*
+ * virtcrypto_dev_started() - Check whether device has started
+ * @vcrypto_dev: Pointer to virtio crypto device.
+ *
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: 1 when the device has started, 0 otherwise
+ */
+int virtcrypto_dev_started(struct virtio_crypto *vcrypto_dev)
+{
+	return (vcrypto_dev->status & VIRTIO_CRYPTO_S_HW_READY);
+}
+
+/*
+ * virtcrypto_get_dev_node() - Get vcrypto_dev on the node.
+ * @node:  Node id the driver works.
+ *
+ * Function returns the virtio crypto device used fewest on the node.
+ *
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: pointer to vcrypto_dev or NULL if not found.
+ */
+struct virtio_crypto *virtcrypto_get_dev_node(int node)
+{
+	struct virtio_crypto *vcrypto_dev = NULL, *tmp_dev;
+	unsigned long best = ~0;
+	unsigned long ctr;
+
+	mutex_lock(&table_lock);
+	list_for_each_entry(tmp_dev, virtcrypto_devmgr_get_head(), list) {
+
+		if ((node == dev_to_node(&tmp_dev->vdev->dev) ||
+		     dev_to_node(&tmp_dev->vdev->dev) < 0) &&
+		    virtcrypto_dev_started(tmp_dev)) {
+			ctr = atomic_read(&tmp_dev->ref_count);
+			if (best > ctr) {
+				vcrypto_dev = tmp_dev;
+				best = ctr;
+			}
+		}
+	}
+
+	if (!vcrypto_dev) {
+		pr_info("virtio_crypto: Could not find a device on node %d\n",
+				node);
+		/* Get any started device */
+		list_for_each_entry(tmp_dev,
+				virtcrypto_devmgr_get_head(), list) {
+			if (virtcrypto_dev_started(tmp_dev)) {
+				vcrypto_dev = tmp_dev;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&table_lock);
+	if (!vcrypto_dev)
+		return NULL;
+
+	virtcrypto_dev_get(vcrypto_dev);
+	return vcrypto_dev;
+}
+
+/*
+ * virtcrypto_dev_start() - Start virtio crypto device
+ * @vcrypto:    Pointer to virtio crypto device.
+ *
+ * Function notifies all the registered services that the virtio crypto device
+ * is ready to be used.
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: 0 on success, EFAULT when fail to register algorithms
+ */
+int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
+{
+	if (virtio_crypto_algs_register()) {
+		pr_err("virtio_crypto: Failed to register crypto algs\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * virtcrypto_dev_stop() - Stop virtio crypto device
+ * @vcrypto:    Pointer to virtio crypto device.
+ *
+ * Function notifies all the registered services that the virtio crypto device
+ * is ready to be used.
+ * To be used by virtio crypto device specific drivers.
+ *
+ * Return: void
+ */
+void virtcrypto_dev_stop(struct virtio_crypto *vcrypto)
+{
+	virtio_crypto_algs_unregister();
+}
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index bc2ef9f..a26c5c7 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -462,6 +462,7 @@ header-y += virtio_rng.h
 header-y += virtio_scsi.h
 header-y += virtio_types.h
 header-y += virtio_vsock.h
+header-y += virtio_crypto.h
 header-y += vm_sockets.h
 header-y += vt.h
 header-y += vtpm_proxy.h
diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
new file mode 100644
index 0000000..50cdc8a
--- /dev/null
+++ b/include/uapi/linux/virtio_crypto.h
@@ -0,0 +1,450 @@
+#ifndef _VIRTIO_CRYPTO_H
+#define _VIRTIO_CRYPTO_H
+/* This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+#include <linux/types.h>
+#include <linux/virtio_types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+
+
+#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
+#define VIRTIO_CRYPTO_SERVICE_HASH   1
+#define VIRTIO_CRYPTO_SERVICE_MAC    2
+#define VIRTIO_CRYPTO_SERVICE_AEAD   3
+
+#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
+
+struct virtio_crypto_ctrl_header {
+#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
+#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
+#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
+#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
+#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
+#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
+#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
+#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+	__le32 opcode;
+	__le32 algo;
+	__le32 flag;
+	/* data virtqueue id */
+	__le32 queue_id;
+};
+
+struct virtio_crypto_cipher_session_para {
+#define VIRTIO_CRYPTO_NO_CIPHER                 0
+#define VIRTIO_CRYPTO_CIPHER_ARC4               1
+#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
+#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
+#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
+#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
+#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
+#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
+#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
+#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
+#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
+#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
+#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
+#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
+#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
+	__le32 algo;
+	/* length of key */
+	__le32 keylen;
+
+#define VIRTIO_CRYPTO_OP_ENCRYPT  1
+#define VIRTIO_CRYPTO_OP_DECRYPT  2
+	/* encrypt or decrypt */
+	__le32 op;
+	__le32 padding;
+};
+
+struct virtio_crypto_session_input {
+	/* Device-writable part */
+	__le64 session_id;
+	__le32 status;
+	__le32 padding;
+};
+
+struct virtio_crypto_cipher_session_req {
+	struct virtio_crypto_cipher_session_para para;
+	__u8 padding[32];
+};
+
+struct virtio_crypto_hash_session_para {
+#define VIRTIO_CRYPTO_NO_HASH            0
+#define VIRTIO_CRYPTO_HASH_MD5           1
+#define VIRTIO_CRYPTO_HASH_SHA1          2
+#define VIRTIO_CRYPTO_HASH_SHA_224       3
+#define VIRTIO_CRYPTO_HASH_SHA_256       4
+#define VIRTIO_CRYPTO_HASH_SHA_384       5
+#define VIRTIO_CRYPTO_HASH_SHA_512       6
+#define VIRTIO_CRYPTO_HASH_SHA3_224      7
+#define VIRTIO_CRYPTO_HASH_SHA3_256      8
+#define VIRTIO_CRYPTO_HASH_SHA3_384      9
+#define VIRTIO_CRYPTO_HASH_SHA3_512      10
+#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
+#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
+	__le32 algo;
+	/* hash result length */
+	__le32 hash_result_len;
+	__u8 padding[8];
+};
+
+struct virtio_crypto_hash_create_session_req {
+	struct virtio_crypto_hash_session_para para;
+	__u8 padding[40];
+};
+
+struct virtio_crypto_mac_session_para {
+#define VIRTIO_CRYPTO_NO_MAC                       0
+#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
+#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
+#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
+#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
+#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
+#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
+#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
+#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
+#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
+#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
+	__le32 algo;
+	/* hash result length */
+	__le32 hash_result_len;
+	/* length of authenticated key */
+	__le32 auth_key_len;
+	__le32 padding;
+};
+
+struct virtio_crypto_mac_create_session_req {
+	struct virtio_crypto_mac_session_para para;
+	__u8 padding[40];
+};
+
+struct virtio_crypto_aead_session_para {
+#define VIRTIO_CRYPTO_NO_AEAD     0
+#define VIRTIO_CRYPTO_AEAD_GCM    1
+#define VIRTIO_CRYPTO_AEAD_CCM    2
+#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
+	__le32 algo;
+	/* length of key */
+	__le32 key_len;
+	/* hash result length */
+	__le32 hash_result_len;
+	/* length of the additional authenticated data (AAD) in bytes */
+	__le32 aad_len;
+	/* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
+	__le32 op;
+	__le32 padding;
+};
+
+struct virtio_crypto_aead_create_session_req {
+	struct virtio_crypto_aead_session_para para;
+	__u8 padding[32];
+};
+
+struct virtio_crypto_alg_chain_session_para {
+#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
+#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
+	__le32 alg_chain_order;
+/* Plain hash */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN    1
+/* Authenticated hash (mac) */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH     2
+/* Nested hash */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_NESTED   3
+	__le32 hash_mode;
+	struct virtio_crypto_cipher_session_para cipher_param;
+	union {
+		struct virtio_crypto_hash_session_para hash_param;
+		struct virtio_crypto_mac_session_para mac_param;
+		__u8 padding[16];
+	} u;
+	/* length of the additional authenticated data (AAD) in bytes */
+	__le32 aad_len;
+	__le32 padding;
+};
+
+struct virtio_crypto_alg_chain_session_req {
+	struct virtio_crypto_alg_chain_session_para para;
+};
+
+struct virtio_crypto_sym_create_session_req {
+	union {
+		struct virtio_crypto_cipher_session_req cipher;
+		struct virtio_crypto_alg_chain_session_req chain;
+		__u8 padding[48];
+	} u;
+
+	/* Device-readable part */
+
+/* No operation */
+#define VIRTIO_CRYPTO_SYM_OP_NONE  0
+/* Cipher only operation on the data */
+#define VIRTIO_CRYPTO_SYM_OP_CIPHER  1
+/*
+ * Chain any cipher with any hash or mac operation. The order
+ * depends on the value of alg_chain_order param
+ */
+#define VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING  2
+	__le32 op_type;
+	__le32 padding;
+};
+
+struct virtio_crypto_destroy_session_req {
+	/* Device-readable part */
+	__le64  session_id;
+	__u8 padding[48];
+};
+
+/* The request of the control virtqueue's packet */
+struct virtio_crypto_op_ctrl_req {
+	struct virtio_crypto_ctrl_header header;
+
+	union {
+		struct virtio_crypto_sym_create_session_req
+			sym_create_session;
+		struct virtio_crypto_hash_create_session_req
+			hash_create_session;
+		struct virtio_crypto_mac_create_session_req
+			mac_create_session;
+		struct virtio_crypto_aead_create_session_req
+			aead_create_session;
+		struct virtio_crypto_destroy_session_req
+			destroy_session;
+		__u8 padding[56];
+	} u;
+};
+
+struct virtio_crypto_op_header {
+#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
+#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
+#define VIRTIO_CRYPTO_HASH \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
+#define VIRTIO_CRYPTO_MAC \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
+#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
+#define VIRTIO_CRYPTO_AEAD_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+	__le32 opcode;
+	/* algo should be service-specific algorithms */
+	__le32 algo;
+	/* session_id should be service-specific algorithms */
+	__le64 session_id;
+	/* control flag to control the request */
+	__le32 flag;
+	__le32 padding;
+};
+
+struct virtio_crypto_cipher_para {
+	/*
+	 * Byte Length of valid IV/Counter
+	 *
+	 * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or for
+	 *   SNOW3G in UEA2 mode, this is the length of the IV (which
+	 *   must be the same as the block length of the cipher).
+	 * For block ciphers in CTR mode, this is the length of the counter
+	 *   (which must be the same as the block length of the cipher).
+	 * For AES-XTS, this is the 128bit tweak, i, from IEEE Std 1619-2007.
+	 *
+	 * The IV/Counter will be updated after every partial cryptographic
+	 * operation.
+	 */
+	__le32 iv_len;
+	/* length of source data */
+	__le32 src_data_len;
+	/* length of dst data */
+	__le32 dst_data_len;
+	__le32 padding;
+};
+
+struct virtio_crypto_hash_para {
+	/* length of source data */
+	__le32 src_data_len;
+	/* hash result length */
+	__le32 hash_result_len;
+};
+
+struct virtio_crypto_mac_para {
+	struct virtio_crypto_hash_para hash;
+};
+
+struct virtio_crypto_aead_para {
+	/*
+	 * Byte Length of valid IV data pointed to by the below iv_addr
+	 * parameter.
+	 *
+	 * For GCM mode, this is either 12 (for 96-bit IVs) or 16, in which
+	 *   case iv_addr points to J0.
+	 * For CCM mode, this is the length of the nonce, which can be in the
+	 *   range 7 to 13 inclusive.
+	 */
+	__le32 iv_len;
+	/* length of additional auth data */
+	__le32 aad_len;
+	/* length of source data */
+	__le32 src_data_len;
+	/* length of dst data */
+	__le32 dst_data_len;
+};
+
+struct virtio_crypto_cipher_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_cipher_para para;
+	__u8 padding[24];
+};
+
+struct virtio_crypto_hash_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_hash_para para;
+	__u8 padding[40];
+};
+
+struct virtio_crypto_mac_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_mac_para para;
+	__u8 padding[40];
+};
+
+struct virtio_crypto_alg_chain_data_para {
+	__le32 iv_len;
+	/* Length of source data */
+	__le32 src_data_len;
+	/* Length of destination data */
+	__le32 dst_data_len;
+	/* Starting point for cipher processing in source data */
+	__le32 cipher_start_src_offset;
+	/* Length of the source data that the cipher will be computed on */
+	__le32 len_to_cipher;
+	/* Starting point for hash processing in source data */
+	__le32 hash_start_src_offset;
+	/* Length of the source data that the hash will be computed on */
+	__le32 len_to_hash;
+	/* Length of the additional auth data */
+	__le32 aad_len;
+	/* Length of the hash result */
+	__le32 hash_result_len;
+	__le32 reserved;
+};
+
+struct virtio_crypto_alg_chain_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_alg_chain_data_para para;
+};
+
+struct virtio_crypto_sym_data_req {
+	union {
+		struct virtio_crypto_cipher_data_req cipher;
+		struct virtio_crypto_alg_chain_data_req chain;
+		__u8 padding[40];
+	} u;
+
+	/* See above VIRTIO_CRYPTO_SYM_OP_* */
+	__le32 op_type;
+	__le32 padding;
+};
+
+struct virtio_crypto_aead_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_aead_para para;
+	__u8 padding[32];
+};
+
+/* The request of the data virtqueue's packet */
+struct virtio_crypto_op_data_req {
+	struct virtio_crypto_op_header header;
+
+	union {
+		struct virtio_crypto_sym_data_req  sym_req;
+		struct virtio_crypto_hash_data_req hash_req;
+		struct virtio_crypto_mac_data_req mac_req;
+		struct virtio_crypto_aead_data_req aead_req;
+		__u8 padding[48];
+	} u;
+};
+
+#define VIRTIO_CRYPTO_OK        0
+#define VIRTIO_CRYPTO_ERR       1
+#define VIRTIO_CRYPTO_BADMSG    2
+#define VIRTIO_CRYPTO_NOTSUPP   3
+#define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+
+/* The accelerator hardware is ready */
+#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
+
+struct virtio_crypto_config {
+	/* See VIRTIO_CRYPTO_OP_* above */
+	__u32  status;
+
+	/*
+	 * Maximum number of data queue
+	 */
+	__u32  max_dataqueues;
+
+	/*
+	 * Specifies the services mask which the device support,
+	 * see VIRTIO_CRYPTO_SERVICE_* above
+	 */
+	__u32 crypto_services;
+
+	/* Detailed algorithms mask */
+	__u32 cipher_algo_l;
+	__u32 cipher_algo_h;
+	__u32 hash_algo;
+	__u32 mac_algo_l;
+	__u32 mac_algo_h;
+	__u32 aead_algo;
+	/* Maximum length of cipher key */
+	__u32 max_cipher_key_len;
+	/* Maximum length of authenticated key */
+	__u32 max_auth_key_len;
+	__u32 reserve;
+	/* Maximum size of each crypto request's content */
+	__u64 max_size;
+};
+
+struct virtio_crypto_inhdr {
+	/* See VIRTIO_CRYPTO_* above */
+	__u8 status;
+};
+#endif
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 3228d58..6d5c3b2 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -42,5 +42,6 @@
 #define VIRTIO_ID_GPU          16 /* virtio GPU */
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
+#define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
1.8.3.1
