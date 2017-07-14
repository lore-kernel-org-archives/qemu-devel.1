Received: from eggs.gnu.org ([2001:4830:134:3::10]:42504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYg-0000Nv-Qq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYe-00053T-2i
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:50 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYd-00053B-OA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:48 -0400
Received: by mail-wm0-x242.google.com with SMTP id p204so9958224wmg.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:23 +0200
Message-Id: <1500027028-4127-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 50/55] virtio-crypto: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Unlike other object_property_add_link() occurrences in virtio devices,
virtio-crypto checks the "in use" state of the linked backend object in
addition to qdev_prop_allow_set_link_before_realize. To convert it
without needing to specialize DEFINE_PROP_LINK which always uses the
qdev callback, move the "in use" check to device realize time.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-10-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/s390x/virtio-ccw.c         |  3 ---
 hw/virtio/virtio-crypto-pci.c |  2 --
 hw/virtio/virtio-crypto.c     | 27 +++++++--------------------
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a492d0f..c07ddb1 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1594,9 +1594,6 @@ static void virtio_ccw_crypto_instance_init(Object *obj)
     ccw_dev->force_revision_1 = true;
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_CRYPTO);
-
-    object_property_add_alias(obj, "cryptodev", OBJECT(&dev->vdev),
-                              "cryptodev", &error_abort);
 }
 
 static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 422aca3..bf64996 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -62,8 +62,6 @@ static void virtio_crypto_initfn(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_CRYPTO);
-    object_property_add_alias(obj, "cryptodev", OBJECT(&dev->vdev),
-                              "cryptodev", &error_abort);
 }
 
 static const TypeInfo virtio_crypto_pci_info = {
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 2590893..19c82e0 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -781,6 +781,11 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
     if (vcrypto->cryptodev == NULL) {
         error_setg(errp, "'cryptodev' parameter expects a valid object");
         return;
+    } else if (cryptodev_backend_is_used(vcrypto->cryptodev)) {
+        char *path = object_get_canonical_path_component(OBJECT(vcrypto->conf.cryptodev));
+        error_setg(errp, "can't use already used cryptodev backend: %s", path);
+        g_free(path);
+        return;
     }
 
     vcrypto->max_queues = MAX(vcrypto->cryptodev->conf.peers.queues, 1);
@@ -845,6 +850,8 @@ static const VMStateDescription vmstate_virtio_crypto = {
 };
 
 static Property virtio_crypto_properties[] = {
+    DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
+                     TYPE_CRYPTODEV_BACKEND, CryptoDevBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -888,20 +895,6 @@ static void virtio_crypto_class_init(ObjectClass *klass, void *data)
     vdc->reset = virtio_crypto_reset;
 }
 
-static void
-virtio_crypto_check_cryptodev_is_used(const Object *obj, const char *name,
-                                      Object *val, Error **errp)
-{
-    if (cryptodev_backend_is_used(CRYPTODEV_BACKEND(val))) {
-        char *path = object_get_canonical_path_component(val);
-        error_setg(errp,
-            "can't use already used cryptodev backend: %s", path);
-        g_free(path);
-    } else {
-        qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
-    }
-}
-
 static void virtio_crypto_instance_init(Object *obj)
 {
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(obj);
@@ -911,12 +904,6 @@ static void virtio_crypto_instance_init(Object *obj)
      * Can be overriden with virtio_crypto_set_config_size.
      */
     vcrypto->config_size = sizeof(struct virtio_crypto_config);
-
-    object_property_add_link(obj, "cryptodev",
-                             TYPE_CRYPTODEV_BACKEND,
-                             (Object **)&vcrypto->conf.cryptodev,
-                             virtio_crypto_check_cryptodev_is_used,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
 }
 
 static const TypeInfo virtio_crypto_info = {
-- 
1.8.3.1
