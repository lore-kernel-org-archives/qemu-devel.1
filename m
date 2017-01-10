Received: from eggs.gnu.org ([2001:4830:134:3::10]:33624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAF-0007au-7s
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAE-0005eO-7H
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:07 -0500
Received: from mail.kernel.org ([198.145.29.136]:48012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAD-0005e1-To
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:06 -0500
Date: Tue, 10 Jan 2017 07:40:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-17-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 16/41] cryptodev: wrap the ready flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>

From: Gonglei <arei.gonglei@huawei.com>

The ready flag should be set by the children of
cryptodev backend interface. Warp the setter/getter
functions for it.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/sysemu/cryptodev.h   | 19 +++++++++++++++++++
 backends/cryptodev-builtin.c |  4 ++++
 backends/cryptodev.c         | 15 +++++++++++----
 hw/virtio/virtio-crypto.c    |  4 ++--
 4 files changed, 36 insertions(+), 6 deletions(-)

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
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 486b4a6..82a068e 100644
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
@@ -366,6 +368,8 @@ static void cryptodev_builtin_cleanup(
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
index 6318fcf..9213258 100644
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
-- 
MST
