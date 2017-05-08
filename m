Received: from eggs.gnu.org ([2001:4830:134:3::10]:50746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0X-0002ze-QU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0W-0004XX-Mp
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0V-0004WY-RJ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:16 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:16 +0800
Message-ID: <1494243504-127980-2-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 1/9] cryptodev: introduce stateless sym
 operation stuff
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

Because a stateless crypto request include all
information about one crypto operation, we should
introduce a wrapper for it, and add a new crypto
operation callback to do statless crypto operation.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c      | 10 ++++++++++
 backends/cryptodev.c              | 21 +++++++++++++++++++++
 include/hw/virtio/virtio-crypto.h |  1 +
 include/sysemu/cryptodev.h        | 19 +++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 657c0ba..1fa2cab 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -372,6 +372,15 @@ static void cryptodev_builtin_cleanup(
     cryptodev_backend_set_ready(backend, false);
 }
 
+static int
+cryptodev_builtin_sym_stateless_operation(
+                 CryptoDevBackend *backend,
+                 CryptoDevBackendSymStatelessInfo *op_info,
+                 uint32_t queue_index, Error **errp)
+{
+    return -VIRTIO_CRYPTO_ERR;
+}
+
 static void
 cryptodev_builtin_class_init(ObjectClass *oc, void *data)
 {
@@ -382,6 +391,7 @@ cryptodev_builtin_class_init(ObjectClass *oc, void *data)
     bc->create_session = cryptodev_builtin_sym_create_session;
     bc->close_session = cryptodev_builtin_sym_close_session;
     bc->do_sym_op = cryptodev_builtin_sym_operation;
+    bc->do_sym_stateless_op = cryptodev_builtin_sym_stateless_operation;
 }
 
 static const TypeInfo cryptodev_builtin_info = {
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 832f056..c6d7c5f 100644
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
index a9d0d1e..be507f7 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -58,6 +58,7 @@ typedef struct CryptoDevBackend CryptoDevBackend;
 
 enum CryptoDevBackendAlgType {
     CRYPTODEV_BACKEND_ALG_SYM,
+    CRYPTODEV_BACKEND_ALG_SYM_STATELESS,
     CRYPTODEV_BACKEND_ALG__MAX,
 };
 
@@ -146,6 +147,21 @@ typedef struct CryptoDevBackendSymOpInfo {
     uint8_t data[0];
 } CryptoDevBackendSymOpInfo;
 
+/**
+ * CryptoDevBackendSymStatelessInfo:
+ *
+ * @session_info: session information, see above
+ *   CryptoDevBackendSymSessionInfo
+ * @op_info: crypto operation information, see above
+ *   CryptoDevBackendSymOpInfo, @session_id is ignored
+ *
+ */
+typedef struct CryptoDevBackendSymStatelessInfo {
+    CryptoDevBackendSymSessionInfo session_info;
+    CryptoDevBackendSymOpInfo op_info;
+} CryptoDevBackendSymStatelessInfo;
+
+
 typedef struct CryptoDevBackendClass {
     ObjectClass parent_class;
 
@@ -161,6 +177,9 @@ typedef struct CryptoDevBackendClass {
     int (*do_sym_op)(CryptoDevBackend *backend,
                      CryptoDevBackendSymOpInfo *op_info,
                      uint32_t queue_index, Error **errp);
+    int (*do_sym_stateless_op)(CryptoDevBackend *backend,
+                     CryptoDevBackendSymStatelessInfo *op_info,
+                     uint32_t queue_index, Error **errp);
 } CryptoDevBackendClass;
 
 
-- 
1.8.3.1
