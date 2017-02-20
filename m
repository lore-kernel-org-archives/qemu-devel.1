Received: from eggs.gnu.org ([2001:4830:134:3::10]:39374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj9-0003rO-Qb
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj5-0005cU-QC
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53145
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkj5-0005c6-JE
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:47 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9raRE100152
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:46 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qsdd3c1c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:46 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:44 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:27 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-6-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 05/12] virtio-ccw: add virtio-crypto-ccw device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Wire up virtio-crypto for the CCW based VIRTIO.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h | 12 ++++++++++
 2 files changed, 73 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 32c414f23d..613d8c6615 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -894,6 +894,24 @@ static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
                              NULL);
 }
 
+static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    Error *err = NULL;
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_link(OBJECT(vdev),
+                             OBJECT(dev->vdev.conf.cryptodev), "cryptodev",
+                             NULL);
+}
+
 /* DeviceState to VirtioCcwDevice. Note: used on datapath,
  * be careful and test performance if you change this.
  */
@@ -1534,6 +1552,48 @@ static const TypeInfo virtio_ccw_rng = {
     .class_init    = virtio_ccw_rng_class_init,
 };
 
+static Property virtio_ccw_crypto_properties[] = {
+    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_crypto_instance_init(Object *obj)
+{
+    VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_CRYPTO);
+
+    object_property_add_alias(obj, "cryptodev", OBJECT(&dev->vdev),
+                              "cryptodev", &error_abort);
+}
+
+static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_crypto_realize;
+    k->exit = virtio_ccw_exit;
+    dc->reset = virtio_ccw_reset;
+    dc->props = virtio_ccw_crypto_properties;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_crypto = {
+    .name          = TYPE_VIRTIO_CRYPTO_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOCryptoCcw),
+    .instance_init = virtio_ccw_crypto_instance_init,
+    .class_init    = virtio_ccw_crypto_class_init,
+};
+
 static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
@@ -1736,6 +1796,7 @@ static void virtio_ccw_register(void)
 #ifdef CONFIG_VHOST_VSOCK
     type_register_static(&vhost_vsock_ccw_info);
 #endif
+    type_register_static(&virtio_ccw_crypto);
 }
 
 type_init(virtio_ccw_register)
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 6a04e94f66..41d4010378 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -22,6 +22,7 @@
 #endif
 #include "hw/virtio/virtio-balloon.h"
 #include "hw/virtio/virtio-rng.h"
+#include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/virtio-bus.h"
 #ifdef CONFIG_VHOST_VSOCK
 #include "hw/virtio/vhost-vsock.h"
@@ -183,6 +184,17 @@ typedef struct VirtIORNGCcw {
     VirtIORNG vdev;
 } VirtIORNGCcw;
 
+/* virtio-crypto-ccw */
+
+#define TYPE_VIRTIO_CRYPTO_CCW "virtio-crypto-ccw"
+#define VIRTIO_CRYPTO_CCW(obj) \
+        OBJECT_CHECK(VirtIOCryptoCcw, (obj), TYPE_VIRTIO_CRYPTO_CCW)
+
+typedef struct VirtIOCryptoCcw {
+    VirtioCcwDevice parent_obj;
+    VirtIOCrypto vdev;
+} VirtIOCryptoCcw;
+
 VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch);
 
 #ifdef CONFIG_VIRTFS
-- 
2.11.0
