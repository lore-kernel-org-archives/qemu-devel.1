Received: from eggs.gnu.org ([2001:4830:134:3::10]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtok-00064S-NS
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtoh-000089-JN
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:18 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:54336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtog-00005G-US
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:15 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 22 Dec 2016 11:12:41 +0800
Message-ID: <1482376362-13804-5-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
References: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND 4/5] virtio-crypto: avoid one cryptodev
 device is used by multiple virtio crypto devices
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

Add the check condition for cryptodev device in order
to avoid one cryptodev device is used by multiple
virtio crypto devices.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index ffaac9d..4f11fee 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -877,6 +877,20 @@ static void virtio_crypto_class_init(ObjectClass *klass, void *data)
     vdc->reset = virtio_crypto_reset;
 }
 
+static void
+virtio_crypto_check_cryptodev_is_used(Object *obj, const char *name,
+                                      Object *val, Error **errp)
+{
+    if (cryptodev_backend_is_used(CRYPTODEV_BACKEND(val))) {
+        char *path = object_get_canonical_path_component(val);
+        error_setg(errp,
+            "can't use already used cryptodev backend: %s", path);
+        g_free(path);
+    } else {
+        qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
+    }
+}
+
 static void virtio_crypto_instance_init(Object *obj)
 {
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(obj);
@@ -890,7 +904,7 @@ static void virtio_crypto_instance_init(Object *obj)
     object_property_add_link(obj, "cryptodev",
                              TYPE_CRYPTODEV_BACKEND,
                              (Object **)&vcrypto->conf.cryptodev,
-                             qdev_prop_allow_set_link_before_realize,
+                             virtio_crypto_check_cryptodev_is_used,
                              OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
 }
 
-- 
1.8.3.1
