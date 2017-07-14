Received: from eggs.gnu.org ([2001:4830:134:3::10]:42501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYg-0000Nn-Ps
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYc-000530-L4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:50 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYc-00052R-Dq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:46 -0400
Received: by mail-wr0-x241.google.com with SMTP id y28so6807458wrd.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:22 +0200
Message-Id: <1500027028-4127-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 49/55] virtio-rng: Convert to DEFINE_PROP_LINK
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

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-9-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/s390x/virtio-ccw.c  |  2 --
 hw/virtio/virtio-pci.c |  2 --
 hw/virtio/virtio-rng.c | 12 +-----------
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index c5e0606..a492d0f 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1548,8 +1548,6 @@ static void virtio_ccw_rng_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_RNG);
-    object_property_add_alias(obj, "rng", OBJECT(&dev->vdev),
-                              "rng", &error_abort);
 }
 
 static Property virtio_ccw_rng_properties[] = {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cc69fe3..5d14bd6 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2463,8 +2463,6 @@ static void virtio_rng_initfn(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_RNG);
-    object_property_add_alias(obj, "rng", OBJECT(&dev->vdev), "rng",
-                              &error_abort);
 }
 
 static const TypeInfo virtio_rng_pci_info = {
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index a6ee501..289bbca 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -246,6 +246,7 @@ static Property virtio_rng_properties[] = {
      */
     DEFINE_PROP_UINT64("max-bytes", VirtIORNG, conf.max_bytes, INT64_MAX),
     DEFINE_PROP_UINT32("period", VirtIORNG, conf.period_ms, 1 << 16),
+    DEFINE_PROP_LINK("rng", VirtIORNG, conf.rng, TYPE_RNG_BACKEND, RngBackend *),
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
 
-- 
1.8.3.1
