Received: from eggs.gnu.org ([2001:4830:134:3::10]:41681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZD-000429-Jz
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZC-00032W-IC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZC-000327-8u
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31DFA315D44
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:09 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:35 +0800
Message-Id: <20170704064347.7022-9-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/20] virtio-rng: Convert to
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/s390x/virtio-ccw.c          |  2 --
 hw/virtio/virtio-pci.c         |  2 --
 hw/virtio/virtio-rng.c         | 14 ++------------
 include/hw/virtio/virtio-rng.h |  3 ++-
 4 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 9386893..bd4a9ea 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1546,8 +1546,6 @@ static void virtio_ccw_rng_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_RNG);
-    object_property_add_alias(obj, "rng", OBJECT(&dev->vdev),
-                              "rng", &error_abort);
 }
 
 static Property virtio_ccw_rng_properties[] = {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1eb61be..c76f3e5 100644
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
index a6ee501..4bfe9c5 100644
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
@@ -246,6 +246,7 @@ static Property virtio_rng_properties[] = {
      */
     DEFINE_PROP_UINT64("max-bytes", VirtIORNG, conf.max_bytes, INT64_MAX),
     DEFINE_PROP_UINT32("period", VirtIORNG, conf.period_ms, 1 << 16),
+    DEFINE_PROP_LINK("rng", VirtIORNG, conf.rng, TYPE_RNG_BACKEND),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -262,21 +263,10 @@ static void virtio_rng_class_init(ObjectClass *klass, void *data)
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
index 922dce7..f2f106b 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -23,7 +23,8 @@
         OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_RNG)
 
 struct VirtIORNGConf {
-    RngBackend *rng;
+    /* RngBackend pointer to be filled by link property */
+    Object *rng;
     uint64_t max_bytes;
     uint32_t period_ms;
     RngRandom *default_backend;
-- 
2.9.4
