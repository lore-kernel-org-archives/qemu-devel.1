Received: from eggs.gnu.org ([2001:4830:134:3::10]:41698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZG-00044d-1h
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZE-00033a-Pg
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZE-00033L-Fw
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69DEF7F6A2
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:11 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:36 +0800
Message-Id: <20170704064347.7022-10-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/20] virtio-crypto: Convert to
 DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Unlike other object_property_add_link() occurrences in virtio devices,
virtio-crypto checks the "in use" state of the linked backend object in
addition to qdev_prop_allow_set_link_before_realize. To convert it
without needing to specialize DEFINE_PROP_LINK which always uses the
qdev callback, move the "in use" check to device realize time.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/s390x/virtio-ccw.c             |  3 ---
 hw/virtio/virtio-crypto-pci.c     |  2 --
 hw/virtio/virtio-crypto.c         | 56 +++++++++++++--------------------------
 include/hw/virtio/virtio-crypto.h |  3 ++-
 4 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index bd4a9ea..dfc55ba 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1592,9 +1592,6 @@ static void virtio_ccw_crypto_instance_init(Object *obj)
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
index 2590893..0c44fe1 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -753,22 +753,18 @@ static void virtio_crypto_reset(VirtIODevice *vdev)
 static void virtio_crypto_init_config(VirtIODevice *vdev)
 {
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
+    CryptoDevBackend *cryptodev = CRYPTODEV_BACKEND(vcrypto->conf.cryptodev);
 
-    vcrypto->conf.crypto_services =
-                     vcrypto->conf.cryptodev->conf.crypto_services;
-    vcrypto->conf.cipher_algo_l =
-                     vcrypto->conf.cryptodev->conf.cipher_algo_l;
-    vcrypto->conf.cipher_algo_h =
-                     vcrypto->conf.cryptodev->conf.cipher_algo_h;
-    vcrypto->conf.hash_algo = vcrypto->conf.cryptodev->conf.hash_algo;
-    vcrypto->conf.mac_algo_l = vcrypto->conf.cryptodev->conf.mac_algo_l;
-    vcrypto->conf.mac_algo_h = vcrypto->conf.cryptodev->conf.mac_algo_h;
-    vcrypto->conf.aead_algo = vcrypto->conf.cryptodev->conf.aead_algo;
-    vcrypto->conf.max_cipher_key_len =
-                  vcrypto->conf.cryptodev->conf.max_cipher_key_len;
-    vcrypto->conf.max_auth_key_len =
-                  vcrypto->conf.cryptodev->conf.max_auth_key_len;
-    vcrypto->conf.max_size = vcrypto->conf.cryptodev->conf.max_size;
+    vcrypto->conf.crypto_services = cryptodev->conf.crypto_services;
+    vcrypto->conf.cipher_algo_l = cryptodev->conf.cipher_algo_l;
+    vcrypto->conf.cipher_algo_h = cryptodev->conf.cipher_algo_h;
+    vcrypto->conf.hash_algo = cryptodev->conf.hash_algo;
+    vcrypto->conf.mac_algo_l = cryptodev->conf.mac_algo_l;
+    vcrypto->conf.mac_algo_h = cryptodev->conf.mac_algo_h;
+    vcrypto->conf.aead_algo = cryptodev->conf.aead_algo;
+    vcrypto->conf.max_cipher_key_len = cryptodev->conf.max_cipher_key_len;
+    vcrypto->conf.max_auth_key_len = cryptodev->conf.max_auth_key_len;
+    vcrypto->conf.max_size = cryptodev->conf.max_size;
 }
 
 static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
@@ -776,11 +772,15 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
     int i;
-
-    vcrypto->cryptodev = vcrypto->conf.cryptodev;
+    vcrypto->cryptodev = CRYPTODEV_BACKEND(vcrypto->conf.cryptodev);
     if (vcrypto->cryptodev == NULL) {
         error_setg(errp, "'cryptodev' parameter expects a valid object");
         return;
+    } else if (cryptodev_backend_is_used(vcrypto->cryptodev)) {
+        char *path = object_get_canonical_path_component(vcrypto->conf.cryptodev);
+        error_setg(errp, "can't use already used cryptodev backend: %s", path);
+        g_free(path);
+        return;
     }
 
     vcrypto->max_queues = MAX(vcrypto->cryptodev->conf.peers.queues, 1);
@@ -845,6 +845,8 @@ static const VMStateDescription vmstate_virtio_crypto = {
 };
 
 static Property virtio_crypto_properties[] = {
+    DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
+                     TYPE_CRYPTODEV_BACKEND),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -888,20 +890,6 @@ static void virtio_crypto_class_init(ObjectClass *klass, void *data)
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
@@ -911,12 +899,6 @@ static void virtio_crypto_instance_init(Object *obj)
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
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
index a00a0bf..d3db159 100644
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -38,7 +38,8 @@ do { \
 
 
 typedef struct VirtIOCryptoConf {
-    CryptoDevBackend *cryptodev;
+    /* CryptoDevBackend pointer to be filled by link property */
+    Object *cryptodev;
 
     /* Supported service mask */
     uint32_t crypto_services;
-- 
2.9.4
