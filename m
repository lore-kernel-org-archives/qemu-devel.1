Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAC-0007YL-SP
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAB-0005dc-KS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:04 -0500
Received: from mail.kernel.org ([198.145.29.136]:47982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAB-0005d3-9E
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:03 -0500
Date: Tue, 10 Jan 2017 07:39:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-16-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/41] cryptodev: introduce a new is_used
 property
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

This property is used to Tag the cryptodev backend
is used by virtio-crypto or not. Making cryptodev
can't be hot unplugged when it's in use. Cleanup
resources when cryptodev is finalized.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/sysemu/cryptodev.h | 23 +++++++++++++++++++++++
 backends/cryptodev.c       | 19 +++++++++++++++++++
 hw/virtio/virtio-crypto.c  |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index 84526c0..461389d 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -202,6 +202,8 @@ struct CryptoDevBackend {
     Object parent_obj;
 
     bool ready;
+    /* Tag the cryptodev backend is used by virtio-crypto or not */
+    bool is_used;
     CryptoDevBackendConf conf;
 };
 
@@ -295,4 +297,25 @@ int cryptodev_backend_crypto_operation(
                  void *opaque,
                  uint32_t queue_index, Error **errp);
 
+/**
+ * cryptodev_backend_set_used:
+ * @backend: the cryptodev backend object
+ * @used: ture or false
+ *
+ * Set the cryptodev backend is used by virtio-crypto or not
+ */
+void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used);
+
+/**
+ * cryptodev_backend_is_used:
+ * @backend: the cryptodev backend object
+ *
+ * Return the status that the cryptodev backend is used
+ * by virtio-crypto or not
+ *
+ * Returns: true on used, or false on not used
+ */
+bool cryptodev_backend_is_used(CryptoDevBackend *backend);
+
+
 #endif /* CRYPTODEV_H */
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 4a49f97..6a66c27 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -197,6 +197,22 @@ out:
     error_propagate(errp, local_err);
 }
 
+void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used)
+{
+    backend->is_used = used;
+}
+
+bool cryptodev_backend_is_used(CryptoDevBackend *backend)
+{
+    return backend->is_used;
+}
+
+static bool
+cryptodev_backend_can_be_deleted(UserCreatable *uc, Error **errp)
+{
+    return !cryptodev_backend_is_used(CRYPTODEV_BACKEND(uc));
+}
+
 static void cryptodev_backend_instance_init(Object *obj)
 {
     object_property_add(obj, "queues", "int",
@@ -209,7 +225,9 @@ static void cryptodev_backend_instance_init(Object *obj)
 
 static void cryptodev_backend_finalize(Object *obj)
 {
+    CryptoDevBackend *backend = CRYPTODEV_BACKEND(obj);
 
+    cryptodev_backend_cleanup(backend, NULL);
 }
 
 static void
@@ -218,6 +236,7 @@ cryptodev_backend_class_init(ObjectClass *oc, void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = cryptodev_backend_complete;
+    ucc->can_be_deleted = cryptodev_backend_can_be_deleted;
 
     QTAILQ_INIT(&crypto_clients);
 }
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index f872c87..6318fcf 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -799,6 +799,7 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
     }
 
     virtio_crypto_init_config(vdev);
+    cryptodev_backend_set_used(vcrypto->cryptodev, true);
 }
 
 static void virtio_crypto_device_unrealize(DeviceState *dev, Error **errp)
@@ -818,6 +819,7 @@ static void virtio_crypto_device_unrealize(DeviceState *dev, Error **errp)
     g_free(vcrypto->vqs);
 
     virtio_cleanup(vdev);
+    cryptodev_backend_set_used(vcrypto->cryptodev, false);
 }
 
 static const VMStateDescription vmstate_virtio_crypto = {
-- 
MST
