Received: from eggs.gnu.org ([2001:4830:134:3::10]:50716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0U-0002xO-Ql
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0T-0004Wq-Ri
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0T-0004Vj-7I
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:13 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:18 +0800
Message-ID: <1494243504-127980-4-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 3/9] cryptodev: add missing op_code for
 symmertric crypto
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

We need the op_code to identify which of crypto
operations for stateless crypto operation.

Let's add it.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 7 +++++++
 include/sysemu/cryptodev.h   | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index abc2655..1e72985 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -334,6 +334,13 @@ static int cryptodev_builtin_sym_operation(
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
+    if (op_info->op_code != VIRTIO_CRYPTO_CIPHER_ENCRYPT &&
+        op_info->op_code != VIRTIO_CRYPTO_CIPHER_DECRYPT) {
+        error_setg(errp,
+               "Unsupported op code: %u", op_info->op_code);
+        return -VIRTIO_CRYPTO_NOTSUPP;
+    }
+
     sess = builtin->sessions[op_info->session_id];
 
     if (op_info->iv_len > 0) {
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index be507f7..d75f2e7 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -103,6 +103,7 @@ typedef struct CryptoDevBackendSymSessionInfo {
  *
  * @session_id: session index which was previously
  *              created by cryptodev_backend_sym_create_session()
+ * @op_code: operation code (refer to virtio_crypto.h)
  * @aad_len: byte length of additional authenticated data
  * @iv_len: byte length of initialization vector or counter
  * @src_len: byte length of source data
@@ -129,6 +130,8 @@ typedef struct CryptoDevBackendSymSessionInfo {
  */
 typedef struct CryptoDevBackendSymOpInfo {
     uint64_t session_id;
+    /* corresponding with virtio crypto spec */
+    uint32_t op_code;
     uint32_t aad_len;
     uint32_t iv_len;
     uint32_t src_len;
-- 
1.8.3.1
