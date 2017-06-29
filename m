Received: from eggs.gnu.org ([2001:4830:134:3::10]:59368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQUS4-0004BG-Kl
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURz-0003Sl-QQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQURz-0003SL-HU
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Jun 2017 16:04:52 +0800
Message-Id: <20170629080452.26470-8-famz@redhat.com>
In-Reply-To: <20170629080452.26470-1-famz@redhat.com>
References: <20170629080452.26470-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/7] virtio-rng: Use DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/virtio/virtio-pci.c         |  2 --
 hw/virtio/virtio-rng.c         | 16 ++++------------
 include/hw/virtio/virtio-rng.h |  2 +-
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index eb03ba5..0938db4 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2459,8 +2459,6 @@ static void virtio_rng_initfn(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_RNG);
-    object_property_add_alias(obj, "rng", OBJECT(&dev->vdev), "rng",
-                              &error_abort);
 }
 
 static const TypeInfo virtio_rng_pci_info = {
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index a6ee501..218778b 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -199,7 +199,7 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
                                  "rng", NULL);
     }
 
-    vrng->rng = vrng->conf.rng;
+    vrng->rng = RNG_BACKEND(vrng->conf.rng);
     if (vrng->rng == NULL) {
         error_setg(errp, "'rng' parameter expects a valid object");
         return;
@@ -246,6 +246,9 @@ static Property virtio_rng_properties[] = {
      */
     DEFINE_PROP_UINT64("max-bytes", VirtIORNG, conf.max_bytes, INT64_MAX),
     DEFINE_PROP_UINT32("period", VirtIORNG, conf.period_ms, 1 << 16),
+    DEFINE_PROP_LINK("rng", VirtIORNG, conf.rng, TYPE_RNG_BACKEND,
+                     qdev_prop_allow_set_link_before_realize,
+                     OBJ_PROP_LINK_UNREF_ON_RELEASE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -262,21 +265,10 @@ static void virtio_rng_class_init(ObjectClass *klass, void *data)
     vdc->get_features = get_features;
 }
 
-static void virtio_rng_initfn(Object *obj)
-{
-    VirtIORNG *vrng = VIRTIO_RNG(obj);
-
-    object_property_add_link(obj, "rng", TYPE_RNG_BACKEND,
-                             (Object **)&vrng->conf.rng,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
-}
-
 static const TypeInfo virtio_rng_info = {
     .name = TYPE_VIRTIO_RNG,
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIORNG),
-    .instance_init = virtio_rng_initfn,
     .class_init = virtio_rng_class_init,
 };
 
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.h
index 922dce7..8d45597 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -23,7 +23,7 @@
         OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_RNG)
 
 struct VirtIORNGConf {
-    RngBackend *rng;
+    Object *rng;
     uint64_t max_bytes;
     uint32_t period_ms;
     RngRandom *default_backend;
-- 
2.9.4
