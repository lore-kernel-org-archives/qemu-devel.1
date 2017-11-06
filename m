Received: from eggs.gnu.org ([2001:4830:134:3::10]:49781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLa-0006Gk-Dy
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLV-0008Fb-Te
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbLV-00088u-AS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:57:21 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:56:58 +0800
Message-ID: <1509951422-20060-7-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
References: <1509951422-20060-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 06/10] cryptodev: add stateless mode cipher
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
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Adds stateless mode cipher support.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 backends/cryptodev.c              | 21 +++++++++++++++++++++
 include/hw/virtio/virtio-crypto.h |  1 +
 include/sysemu/cryptodev.h        | 18 ++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 67edfa5..e06ab12 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -120,6 +120,21 @@ static int cryptodev_backend_sym_operation(
     return -VIRTIO_CRYPTO_ERR;
 }
 
+static int cryptodev_backend_sym_stateless_operation(
+                 CryptoDevBackend *backend,
+                 CryptoDevBackendSymStatelessInfo *op_info,
+                 uint32_t queue_index, Error **errp)
+{
+    CryptoDevBackendClass *bc =
+                      CRYPTODEV_BACKEND_GET_CLASS(backend);
+
+    if (bc->do_sym_stateless_op) {
+        return bc->do_sym_stateless_op(backend, op_info, queue_index, errp);
+    }
+
+    return -VIRTIO_CRYPTO_ERR;
+}
+
 int cryptodev_backend_crypto_operation(
                  CryptoDevBackend *backend,
                  void *opaque,
@@ -133,6 +148,12 @@ int cryptodev_backend_crypto_operation(
 
         return cryptodev_backend_sym_operation(backend,
                          op_info, queue_index, errp);
+    } else if (req->flags == CRYPTODEV_BACKEND_ALG_SYM_STATELESS) {
+        CryptoDevBackendSymStatelessInfo *op_info;
+        op_info = req->u.sym_stateless_info;
+
+        return cryptodev_backend_sym_stateless_operation(backend,
+                         op_info, queue_index, errp);
     } else {
         error_setg(errp, "Unsupported cryptodev alg type: %" PRIu32 "",
                    req->flags);
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
index a00a0bf..465ad20 100644
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -73,6 +73,7 @@ typedef struct VirtIOCryptoReq {
     struct VirtIOCrypto *vcrypto;
     union {
         CryptoDevBackendSymOpInfo *sym_op_info;
+        CryptoDevBackendSymStatelessInfo *sym_stateless_info;
     } u;
 } VirtIOCryptoReq;
 
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index a9d0d1e..aa2fcd8 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -58,6 +58,7 @@ typedef struct CryptoDevBackend CryptoDevBackend;
 
 enum CryptoDevBackendAlgType {
     CRYPTODEV_BACKEND_ALG_SYM,
+    CRYPTODEV_BACKEND_ALG_SYM_STATELESS,
     CRYPTODEV_BACKEND_ALG__MAX,
 };
 
@@ -146,6 +147,20 @@ typedef struct CryptoDevBackendSymOpInfo {
     uint8_t data[0];
 } CryptoDevBackendSymOpInfo;
 
+/**
+ * CryptoDevBackendSymStatelessInfo:
+ *
+ * @session_info: session information, see above
+ *  CryptoDevBackendSymSessionInfo
+ * @op_info: crypto operation information, see above
+ *  CryptoDevBackendSymOpInfo, @session_id is ignored
+ *
+ **/
+typedef struct CryptoDevBackendSymStatelessInfo {
+    CryptoDevBackendSymSessionInfo session_info;
+    CryptoDevBackendSymOpInfo op_info;
+} CryptoDevBackendSymStatelessInfo;
+
 typedef struct CryptoDevBackendClass {
     ObjectClass parent_class;
 
@@ -161,6 +176,9 @@ typedef struct CryptoDevBackendClass {
     int (*do_sym_op)(CryptoDevBackend *backend,
                      CryptoDevBackendSymOpInfo *op_info,
                      uint32_t queue_index, Error **errp);
+    int (*do_sym_stateless_op)(CryptoDevBackend *backend,
+                     CryptoDevBackendSymStatelessInfo *op_info,
+                     uint32_t queue_index, Error **errp);
 } CryptoDevBackendClass;
 
 
-- 
1.8.3.1
