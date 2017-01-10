Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAM-0007lf-BE
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAI-0005im-DX
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:14 -0500
Received: from mail.kernel.org ([198.145.29.136]:48060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAI-0005iF-6y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:10 -0500
Date: Tue, 10 Jan 2017 07:40:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-19-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 18/41] virtio-crypto: avoid one cryptodev device
 is used by multiple virtio crypto devices
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

Add the check condition for cryptodev device in order
to avoid one cryptodev device is used by multiple
virtio crypto devices.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-crypto.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 9213258..fc30bc3 100644
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
MST
