Received: from eggs.gnu.org ([2001:4830:134:3::10]:48321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwVsu-0005Wp-TC
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwVss-0000XM-Vz
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dwVss-0000Wu-NR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:05:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0D567E429
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:05:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 25 Sep 2017 17:05:17 +0100
Message-Id: <20170925160517.681-2-dgilbert@redhat.com>
In-Reply-To: <20170925160517.681-1-dgilbert@redhat.com>
References: <20170925160517.681-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio/pci/migration: Convert to VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Convert the 'modern_state' part of virtio-pci to modern migration
macros.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/virtio-pci.c | 108 +++++++++++++------------------------------------
 1 file changed, 27 insertions(+), 81 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8b0d6b69cd..f825a68a84 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -88,77 +88,19 @@ static void virtio_pci_save_config(DeviceState *d, QEMUFile *f)
         qemu_put_be16(f, vdev->config_vector);
 }
 
-static void virtio_pci_load_modern_queue_state(VirtIOPCIQueue *vq,
-                                               QEMUFile *f)
-{
-    vq->num = qemu_get_be16(f);
-    vq->enabled = qemu_get_be16(f);
-    vq->desc[0] = qemu_get_be32(f);
-    vq->desc[1] = qemu_get_be32(f);
-    vq->avail[0] = qemu_get_be32(f);
-    vq->avail[1] = qemu_get_be32(f);
-    vq->used[0] = qemu_get_be32(f);
-    vq->used[1] = qemu_get_be32(f);
-}
-
-static bool virtio_pci_has_extra_state(DeviceState *d)
-{
-    VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-
-    return proxy->flags & VIRTIO_PCI_FLAG_MIGRATE_EXTRA;
-}
-
-static int get_virtio_pci_modern_state(QEMUFile *f, void *pv, size_t size,
-                                       VMStateField *field)
-{
-    VirtIOPCIProxy *proxy = pv;
-    int i;
-
-    proxy->dfselect = qemu_get_be32(f);
-    proxy->gfselect = qemu_get_be32(f);
-    proxy->guest_features[0] = qemu_get_be32(f);
-    proxy->guest_features[1] = qemu_get_be32(f);
-    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-        virtio_pci_load_modern_queue_state(&proxy->vqs[i], f);
-    }
-
-    return 0;
-}
-
-static void virtio_pci_save_modern_queue_state(VirtIOPCIQueue *vq,
-                                               QEMUFile *f)
-{
-    qemu_put_be16(f, vq->num);
-    qemu_put_be16(f, vq->enabled);
-    qemu_put_be32(f, vq->desc[0]);
-    qemu_put_be32(f, vq->desc[1]);
-    qemu_put_be32(f, vq->avail[0]);
-    qemu_put_be32(f, vq->avail[1]);
-    qemu_put_be32(f, vq->used[0]);
-    qemu_put_be32(f, vq->used[1]);
-}
-
-static int put_virtio_pci_modern_state(QEMUFile *f, void *pv, size_t size,
-                                       VMStateField *field, QJSON *vmdesc)
-{
-    VirtIOPCIProxy *proxy = pv;
-    int i;
-
-    qemu_put_be32(f, proxy->dfselect);
-    qemu_put_be32(f, proxy->gfselect);
-    qemu_put_be32(f, proxy->guest_features[0]);
-    qemu_put_be32(f, proxy->guest_features[1]);
-    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-        virtio_pci_save_modern_queue_state(&proxy->vqs[i], f);
+static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
+    .name = "virtio_pci/modern_queue_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(num, VirtIOPCIQueue),
+        VMSTATE_UNUSED(1), /* enabled was stored as be16 */
+        VMSTATE_BOOL(enabled, VirtIOPCIQueue),
+        VMSTATE_UINT32_ARRAY(desc, VirtIOPCIQueue, 2),
+        VMSTATE_UINT32_ARRAY(avail, VirtIOPCIQueue, 2),
+        VMSTATE_UINT32_ARRAY(used, VirtIOPCIQueue, 2),
+        VMSTATE_END_OF_LIST()
     }
-
-    return 0;
-}
-
-static const VMStateInfo vmstate_info_virtio_pci_modern_state = {
-    .name = "virtqueue_state",
-    .get = get_virtio_pci_modern_state,
-    .put = put_virtio_pci_modern_state,
 };
 
 static bool virtio_pci_modern_state_needed(void *opaque)
@@ -168,21 +110,18 @@ static bool virtio_pci_modern_state_needed(void *opaque)
     return virtio_pci_modern(proxy);
 }
 
-static const VMStateDescription vmstate_virtio_pci_modern_state = {
+static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
     .name = "virtio_pci/modern_state",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_pci_modern_state_needed,
     .fields = (VMStateField[]) {
-        {
-            .name         = "modern_state",
-            .version_id   = 0,
-            .field_exists = NULL,
-            .size         = 0,
-            .info         = &vmstate_info_virtio_pci_modern_state,
-            .flags        = VMS_SINGLE,
-            .offset       = 0,
-        },
+        VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
+        VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
+        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
+        VMSTATE_STRUCT_ARRAY(vqs, VirtIOPCIProxy, VIRTIO_QUEUE_MAX, 0,
+                             vmstate_virtio_pci_modern_queue_state,
+                             VirtIOPCIQueue),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -196,11 +135,18 @@ static const VMStateDescription vmstate_virtio_pci = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription*[]) {
-        &vmstate_virtio_pci_modern_state,
+        &vmstate_virtio_pci_modern_state_sub,
         NULL
     }
 };
 
+static bool virtio_pci_has_extra_state(DeviceState *d)
+{
+    VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
+
+    return proxy->flags & VIRTIO_PCI_FLAG_MIGRATE_EXTRA;
+}
+
 static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-- 
2.13.5
