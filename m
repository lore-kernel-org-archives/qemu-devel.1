Received: from eggs.gnu.org ([2001:4830:134:3::10]:48235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtpF-0006Lc-ND
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtpE-0000O0-Dh
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:49 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:48739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtp4-0000F1-27
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:48 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 22 Dec 2016 11:12:39 +0800
Message-ID: <1482376362-13804-3-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
References: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND 2/5] cryptodev: wrap the ready flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Gonglei <arei.gonglei@huawei.com>

The ready flag should be set by the children of
cryptodev backend interface. Warp the setter/getter
functions for it.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c |  4 ++++
 backends/cryptodev.c         | 15 +++++++++++----
 hw/virtio/virtio-crypto.c    |  4 ++--
 include/sysemu/cryptodev.h   | 19 +++++++++++++++++++
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index eda954b..7b90586 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -94,6 +94,8 @@ static void cryptodev_builtin_init(
     backend->conf.max_size = LONG_MAX - sizeof(CryptoDevBackendSymOpInfo);
     backend->conf.max_cipher_key_len = CRYPTODEV_BUITLIN_MAX_CIPHER_KEY_LEN;
     backend->conf.max_auth_key_len = CRYPTODEV_BUITLIN_MAX_AUTH_KEY_LEN;
+
+    cryptodev_backend_set_ready(backend, true);
 }
 
 static int
@@ -331,6 +333,8 @@ static void cryptodev_builtin_cleanup(
             backend->conf.peers.ccs[i] = NULL;
         }
     }
+
+    cryptodev_backend_set_ready(backend, false);
 }
 
 static void
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 6a66c27..832f056 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -73,8 +73,6 @@ void cryptodev_backend_cleanup(
     if (bc->cleanup) {
         bc->cleanup(backend, errp);
     }
-
-    backend->ready = false;
 }
 
 int64_t cryptodev_backend_sym_create_session(
@@ -189,11 +187,10 @@ cryptodev_backend_complete(UserCreatable *uc, Error **errp)
             goto out;
         }
     }
-    backend->ready = true;
+
     return;
 
 out:
-    backend->ready = false;
     error_propagate(errp, local_err);
 }
 
@@ -207,6 +204,16 @@ bool cryptodev_backend_is_used(CryptoDevBackend *backend)
     return backend->is_used;
 }
 
+void cryptodev_backend_set_ready(CryptoDevBackend *backend, bool ready)
+{
+    backend->ready = ready;
+}
+
+bool cryptodev_backend_is_ready(CryptoDevBackend *backend)
+{
+    return backend->ready;
+}
+
 static bool
 cryptodev_backend_can_be_deleted(UserCreatable *uc, Error **errp)
 {
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 117f55a..ffaac9d 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -732,7 +732,7 @@ static void virtio_crypto_reset(VirtIODevice *vdev)
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
     /* multiqueue is disabled by default */
     vcrypto->curr_queues = 1;
-    if (!vcrypto->cryptodev->ready) {
+    if (!cryptodev_backend_is_ready(vcrypto->cryptodev)) {
         vcrypto->status &= ~VIRTIO_CRYPTO_S_HW_READY;
     } else {
         vcrypto->status |= VIRTIO_CRYPTO_S_HW_READY;
@@ -792,7 +792,7 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
     }
 
     vcrypto->ctrl_vq = virtio_add_queue(vdev, 64, virtio_crypto_handle_ctrl);
-    if (!vcrypto->cryptodev->ready) {
+    if (!cryptodev_backend_is_ready(vcrypto->cryptodev)) {
         vcrypto->status &= ~VIRTIO_CRYPTO_S_HW_READY;
     } else {
         vcrypto->status |= VIRTIO_CRYPTO_S_HW_READY;
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index 461389d..a9d0d1e 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -317,5 +317,24 @@ void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used);
  */
 bool cryptodev_backend_is_used(CryptoDevBackend *backend);
 
+/**
+ * cryptodev_backend_set_ready:
+ * @backend: the cryptodev backend object
+ * @ready: ture or false
+ *
+ * Set the cryptodev backend is ready or not, which is called
+ * by the children of the cryptodev banckend interface.
+ */
+void cryptodev_backend_set_ready(CryptoDevBackend *backend, bool ready);
+
+/**
+ * cryptodev_backend_is_ready:
+ * @backend: the cryptodev backend object
+ *
+ * Return the status that the cryptodev backend is ready or not
+ *
+ * Returns: true on ready, or false on not ready
+ */
+bool cryptodev_backend_is_ready(CryptoDevBackend *backend);
 
 #endif /* CRYPTODEV_H */
-- 
1.8.3.1
