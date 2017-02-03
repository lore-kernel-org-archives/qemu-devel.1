Received: from eggs.gnu.org ([2001:4830:134:3::10]:41883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZgO5-0007T4-5Z
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZgO3-0007Sn-7n
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:07:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZgO2-0007SQ-Vk
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:06:59 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 280B23B731
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 16:06:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  3 Feb 2017 16:06:51 +0000
Message-Id: <20170203160651.19917-5-dgilbert@redhat.com>
In-Reply-To: <20170203160651.19917-1-dgilbert@redhat.com>
References: <20170203160651.19917-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] virtio/migration: Migrate virtio-net to
 VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/virtio-net.c            | 316 +++++++++++++++++++++++++++--------------
 include/hw/virtio/virtio-net.h |   4 +-
 2 files changed, 213 insertions(+), 107 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7b3ad4a..41723a4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1557,119 +1557,22 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     virtio_net_set_queues(n);
 }
 
-static void virtio_net_save_device(VirtIODevice *vdev, QEMUFile *f)
+static int virtio_net_post_load_device(void *opaque, int version_id)
 {
-    VirtIONet *n = VIRTIO_NET(vdev);
-    int i;
-
-    qemu_put_buffer(f, n->mac, ETH_ALEN);
-    qemu_put_be32(f, n->vqs[0].tx_waiting);
-    qemu_put_be32(f, n->mergeable_rx_bufs);
-    qemu_put_be16(f, n->status);
-    qemu_put_byte(f, n->promisc);
-    qemu_put_byte(f, n->allmulti);
-    qemu_put_be32(f, n->mac_table.in_use);
-    qemu_put_buffer(f, n->mac_table.macs, n->mac_table.in_use * ETH_ALEN);
-    qemu_put_buffer(f, (uint8_t *)n->vlans, MAX_VLAN >> 3);
-    qemu_put_be32(f, n->has_vnet_hdr);
-    qemu_put_byte(f, n->mac_table.multi_overflow);
-    qemu_put_byte(f, n->mac_table.uni_overflow);
-    qemu_put_byte(f, n->alluni);
-    qemu_put_byte(f, n->nomulti);
-    qemu_put_byte(f, n->nouni);
-    qemu_put_byte(f, n->nobcast);
-    qemu_put_byte(f, n->has_ufo);
-    if (n->max_queues > 1) {
-        qemu_put_be16(f, n->max_queues);
-        qemu_put_be16(f, n->curr_queues);
-        for (i = 1; i < n->curr_queues; i++) {
-            qemu_put_be32(f, n->vqs[i].tx_waiting);
-        }
-    }
-
-    if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
-        qemu_put_be64(f, n->curr_guest_offloads);
-    }
-}
-
-static int virtio_net_load_device(VirtIODevice *vdev, QEMUFile *f,
-                                  int version_id)
-{
-    VirtIONet *n = VIRTIO_NET(vdev);
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int i, link_down;
 
-    qemu_get_buffer(f, n->mac, ETH_ALEN);
-    n->vqs[0].tx_waiting = qemu_get_be32(f);
-
-    virtio_net_set_mrg_rx_bufs(n, qemu_get_be32(f),
+    virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
                                virtio_vdev_has_feature(vdev,
                                                        VIRTIO_F_VERSION_1));
 
-    n->status = qemu_get_be16(f);
-
-    n->promisc = qemu_get_byte(f);
-    n->allmulti = qemu_get_byte(f);
-
-    n->mac_table.in_use = qemu_get_be32(f);
     /* MAC_TABLE_ENTRIES may be different from the saved image */
-    if (n->mac_table.in_use <= MAC_TABLE_ENTRIES) {
-        qemu_get_buffer(f, n->mac_table.macs,
-                        n->mac_table.in_use * ETH_ALEN);
-    } else {
-        int64_t i;
-
-        /* Overflow detected - can happen if source has a larger MAC table.
-         * We simply set overflow flag so there's no need to maintain the
-         * table of addresses, discard them all.
-         * Note: 64 bit math to avoid integer overflow.
-         */
-        for (i = 0; i < (int64_t)n->mac_table.in_use * ETH_ALEN; ++i) {
-            qemu_get_byte(f);
-        }
-        n->mac_table.multi_overflow = n->mac_table.uni_overflow = 1;
+    if (n->mac_table.in_use > MAC_TABLE_ENTRIES) {
         n->mac_table.in_use = 0;
     }
- 
-    qemu_get_buffer(f, (uint8_t *)n->vlans, MAX_VLAN >> 3);
-
-    if (qemu_get_be32(f) && !peer_has_vnet_hdr(n)) {
-        error_report("virtio-net: saved image requires vnet_hdr=on");
-        return -1;
-    }
-
-    n->mac_table.multi_overflow = qemu_get_byte(f);
-    n->mac_table.uni_overflow = qemu_get_byte(f);
-
-    n->alluni = qemu_get_byte(f);
-    n->nomulti = qemu_get_byte(f);
-    n->nouni = qemu_get_byte(f);
-    n->nobcast = qemu_get_byte(f);
-
-    if (qemu_get_byte(f) && !peer_has_ufo(n)) {
-        error_report("virtio-net: saved image requires TUN_F_UFO support");
-        return -1;
-    }
 
-    if (n->max_queues > 1) {
-        if (n->max_queues != qemu_get_be16(f)) {
-            error_report("virtio-net: different max_queues ");
-            return -1;
-        }
-
-        n->curr_queues = qemu_get_be16(f);
-        if (n->curr_queues > n->max_queues) {
-            error_report("virtio-net: curr_queues %x > max_queues %x",
-                         n->curr_queues, n->max_queues);
-            return -1;
-        }
-        for (i = 1; i < n->curr_queues; i++) {
-            n->vqs[i].tx_waiting = qemu_get_be32(f);
-        }
-    }
-
-    if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
-        n->curr_guest_offloads = qemu_get_be64(f);
-    } else {
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
         n->curr_guest_offloads = virtio_net_supported_guest_offloads(n);
     }
 
@@ -1703,6 +1606,210 @@ static int virtio_net_load_device(VirtIODevice *vdev, QEMUFile *f,
     return 0;
 }
 
+/* tx_waiting field of a VirtIONetQueue */
+static const VMStateDescription vmstate_virtio_net_queue_tx_waiting = {
+    .name = "virtio-net-queue-tx_waiting",
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(tx_waiting, VirtIONetQueue),
+        VMSTATE_END_OF_LIST()
+   },
+};
+
+static bool max_queues_gt_1(void *opaque, int version_id)
+{
+    return VIRTIO_NET(opaque)->max_queues > 1;
+}
+
+static bool has_ctrl_guest_offloads(void *opaque, int version_id)
+{
+    return virtio_vdev_has_feature(VIRTIO_DEVICE(opaque),
+                                   VIRTIO_NET_F_CTRL_GUEST_OFFLOADS);
+}
+
+static bool mac_table_fits(void *opaque, int version_id)
+{
+    return VIRTIO_NET(opaque)->mac_table.in_use <= MAC_TABLE_ENTRIES;
+}
+
+static bool mac_table_doesnt_fit(void *opaque, int version_id)
+{
+    return !mac_table_fits(opaque, version_id);
+}
+
+/* This temporary type is shared by all the WITH_TMP methods
+ * although only some fields are used by each.
+ */
+struct VirtIONetMigTmp {
+    VirtIONet      *parent;
+    VirtIONetQueue *vqs_1;
+    uint16_t        curr_queues_1;
+    uint8_t         has_ufo;
+    uint32_t        has_vnet_hdr;
+};
+
+/* The 2nd and subsequent tx_waiting flags are loaded later than
+ * the 1st entry in the queues and only if there's more than one
+ * entry.  We use the tmp mechanism to calculate a temporary
+ * pointer and count and also validate the count.
+ */
+
+static void virtio_net_tx_waiting_pre_save(void *opaque)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+
+    tmp->vqs_1 = tmp->parent->vqs + 1;
+    tmp->curr_queues_1 = tmp->parent->curr_queues - 1;
+    if (tmp->parent->curr_queues == 0) {
+        tmp->curr_queues_1 = 0;
+    }
+}
+
+static int virtio_net_tx_waiting_pre_load(void *opaque)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+
+    /* Reuse the pointer setup from save */
+    virtio_net_tx_waiting_pre_save(opaque);
+
+    if (tmp->parent->curr_queues > tmp->parent->max_queues) {
+        error_report("virtio-net: curr_queues %x > max_queues %x",
+            tmp->parent->curr_queues, tmp->parent->max_queues);
+
+        return -EINVAL;
+    }
+
+    return 0; /* all good */
+}
+
+static const VMStateDescription vmstate_virtio_net_tx_waiting = {
+    .name      = "virtio-net-tx_waiting",
+    .pre_load  = virtio_net_tx_waiting_pre_load,
+    .pre_save  = virtio_net_tx_waiting_pre_save,
+    .fields    = (VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT16(vqs_1, struct VirtIONetMigTmp,
+                                     curr_queues_1,
+                                     vmstate_virtio_net_queue_tx_waiting,
+                                     struct VirtIONetQueue),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+/* the 'has_ufo' flag is just tested; if the incoming stream has the
+ * flag set we need to check that we have it
+ */
+static int virtio_net_ufo_post_load(void *opaque, int version_id)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+
+    if (tmp->has_ufo && !peer_has_ufo(tmp->parent)) {
+        error_report("virtio-net: saved image requires TUN_F_UFO support");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static void virtio_net_ufo_pre_save(void *opaque)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+
+    tmp->has_ufo = tmp->parent->has_ufo;
+}
+
+static const VMStateDescription vmstate_virtio_net_has_ufo = {
+    .name      = "virtio-net-ufo",
+    .post_load = virtio_net_ufo_post_load,
+    .pre_save  = virtio_net_ufo_pre_save,
+    .fields    = (VMStateField[]) {
+        VMSTATE_UINT8(has_ufo, struct VirtIONetMigTmp),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+/* the 'has_vnet_hdr' flag is just tested; if the incoming stream has the
+ * flag set we need to check that we have it
+ */
+static int virtio_net_vnet_post_load(void *opaque, int version_id)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+
+    if (tmp->has_vnet_hdr && !peer_has_vnet_hdr(tmp->parent)) {
+        error_report("virtio-net: saved image requires vnet_hdr=on");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static void virtio_net_vnet_pre_save(void *opaque)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+
+    tmp->has_vnet_hdr = tmp->parent->has_vnet_hdr;
+}
+
+static const VMStateDescription vmstate_virtio_net_has_vnet = {
+    .name      = "virtio-net-vnet",
+    .post_load = virtio_net_vnet_post_load,
+    .pre_save  = virtio_net_vnet_pre_save,
+    .fields    = (VMStateField[]) {
+        VMSTATE_UINT32(has_vnet_hdr, struct VirtIONetMigTmp),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_virtio_net_device = {
+    .name = "virtio-net-device",
+    .version_id = VIRTIO_NET_VM_VERSION,
+    .minimum_version_id = VIRTIO_NET_VM_VERSION,
+    .post_load = virtio_net_post_load_device,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(mac, VirtIONet, ETH_ALEN),
+        VMSTATE_STRUCT_POINTER(vqs, VirtIONet,
+                               vmstate_virtio_net_queue_tx_waiting,
+                               VirtIONetQueue),
+        VMSTATE_UINT32(mergeable_rx_bufs, VirtIONet),
+        VMSTATE_UINT16(status, VirtIONet),
+        VMSTATE_UINT8(promisc, VirtIONet),
+        VMSTATE_UINT8(allmulti, VirtIONet),
+        VMSTATE_UINT32(mac_table.in_use, VirtIONet),
+
+        /* Guarded pair: If it fits we load it, else we throw it away
+         * - can happen if source has a larger MAC table.; post-load
+         *  sets flags in this case.
+         */
+        VMSTATE_VBUFFER_MULTIPLY(mac_table.macs, VirtIONet,
+                                0, mac_table_fits, 0, mac_table.in_use,
+                                 ETH_ALEN),
+        VMSTATE_UNUSED_VARRAY_UINT32(VirtIONet, mac_table_doesnt_fit, 0,
+                                     mac_table.in_use, ETH_ALEN),
+
+        /* Note: This is an array of uint32's that's always been saved as a
+         * buffer; hold onto your endiannesses; it's actually used as a bitmap
+         * but based on the uint.
+         */
+        VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
+        VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
+                         vmstate_virtio_net_has_vnet),
+        VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
+        VMSTATE_UINT8(mac_table.uni_overflow, VirtIONet),
+        VMSTATE_UINT8(alluni, VirtIONet),
+        VMSTATE_UINT8(nomulti, VirtIONet),
+        VMSTATE_UINT8(nouni, VirtIONet),
+        VMSTATE_UINT8(nobcast, VirtIONet),
+        VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
+                         vmstate_virtio_net_has_ufo),
+        VMSTATE_SINGLE_TEST(max_queues, VirtIONet, max_queues_gt_1, 0,
+                            vmstate_info_uint16_equal, uint16_t),
+        VMSTATE_UINT16_TEST(curr_queues, VirtIONet, max_queues_gt_1),
+        VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
+                         vmstate_virtio_net_tx_waiting),
+        VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
+                            has_ctrl_guest_offloads),
+        VMSTATE_END_OF_LIST()
+   },
+};
+
 static NetClientInfo net_virtio_info = {
     .type = NET_CLIENT_DRIVER_NIC,
     .size = sizeof(NICState),
@@ -1989,9 +2096,8 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->set_status = virtio_net_set_status;
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
     vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
-    vdc->load = virtio_net_load_device;
-    vdc->save = virtio_net_save_device;
     vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
+    vdc->vmsd = &vmstate_virtio_net_device;
 }
 
 static const TypeInfo virtio_net_info = {
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 8ea56a8..1eec9a2 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -47,7 +47,7 @@ typedef struct VirtIONetQueue {
     VirtQueue *tx_vq;
     QEMUTimer *tx_timer;
     QEMUBH *tx_bh;
-    int tx_waiting;
+    uint32_t tx_waiting;
     struct {
         VirtQueueElement *elem;
     } async_tx;
@@ -68,7 +68,7 @@ typedef struct VirtIONet {
     size_t guest_hdr_len;
     uint32_t host_features;
     uint8_t has_ufo;
-    int mergeable_rx_bufs;
+    uint32_t mergeable_rx_bufs;
     uint8_t promisc;
     uint8_t allmulti;
     uint8_t alluni;
-- 
2.9.3
