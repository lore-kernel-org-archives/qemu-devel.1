Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F16BC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9BF206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBk24Cql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9BF206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWiV-0005v9-Gf
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43940 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQSp4-0003i3-6x
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:34:38 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQSp3-0003x4-FS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:34:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43624
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jQSp3-0003wi-1b
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587375276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvyWz9oNluUgLDVfQHYTG0prGOLJNzfYk5AQKmhXsR8=;
 b=aBk24CqlopDt7P9J23CgmKbgKT0QHF8GtIcosYbKdDbm9XD5+9baAbKB8ibmaaZIL1e88G
 SwHvajK+QZ/q+Lao4yhYcDemsY9ix31fMOHxV4pGDz9dyAQnQLHVVoc0PAkU7tPMqVq10d
 YVVMgEFfkQ5PDbmW++DsmMR0P/Mmc/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-43VqRM5FO0Oq8yZga9pcvw-1; Mon, 20 Apr 2020 05:34:34 -0400
X-MC-Unique: 43VqRM5FO0Oq8yZga9pcvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4878800D53;
 Mon, 20 Apr 2020 09:34:31 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-243.pek2.redhat.com [10.72.12.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF3FB92FA2;
 Mon, 20 Apr 2020 09:34:14 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v1 4/4] vhost: introduce vhost_set_vring_ready method
Date: Mon, 20 Apr 2020 17:32:41 +0800
Message-Id: <20200420093241.4238-5-lulu@redhat.com>
In-Reply-To: <20200420093241.4238-1-lulu@redhat.com>
References: <20200420093241.4238-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
X-Mailman-Approved-At: Mon, 20 Apr 2020 09:36:04 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

Vhost-vdpa introduces VHOST_VDPA_SET_VRING_ENABLE which complies the
semantic of queue_enable defined in virtio spec. This method can be
used for preventing device from executing request for a specific
virtqueue. This patch introduces the vhost_ops for this.

Note that, we've already had vhost_set_vring_enable which has different
semantic which allows to enable or disable a specific virtqueue for
some kinds of vhost backends. E.g vhost-user use this to changes the
number of active queue pairs.

Author: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vhost_net-stub.c           |  5 +++++
 hw/net/vhost_net.c                | 16 ++++++++++++++++
 hw/virtio/vhost-vdpa.c            |  9 +++------
 hw/virtio/virtio-pci.c            | 13 +++++++++++++
 hw/virtio/virtio.c                |  6 ++++++
 include/hw/virtio/vhost-backend.h |  2 ++
 include/hw/virtio/virtio-bus.h    |  4 ++++
 include/net/vhost_net.h           |  1 +
 8 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index aac0e98228..f5ef1e3055 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -86,6 +86,11 @@ int vhost_set_vring_enable(NetClientState *nc, int enabl=
e)
     return 0;
 }
=20
+int vhost_set_vring_ready(NetClientState *nc)
+{
+    return 0;
+}
+
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 {
     return 0;
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 0d13fda2fc..463e333531 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -380,6 +380,10 @@ int vhost_net_start(VirtIODevice *dev, NetClientState =
*ncs,
                 goto err_start;
             }
         }
+
+        if (virtio_queue_enabled(dev, i)) {
+            vhost_set_vring_ready(peer);
+        }
     }
=20
     return 0;
@@ -487,6 +491,18 @@ int vhost_set_vring_enable(NetClientState *nc, int ena=
ble)
     return 0;
 }
=20
+int vhost_set_vring_ready(NetClientState *nc)
+{
+    VHostNetState *net =3D get_vhost_net(nc);
+    const VhostOps *vhost_ops =3D net->dev.vhost_ops;
+
+    if (vhost_ops && vhost_ops->vhost_set_vring_ready) {
+        return vhost_ops->vhost_set_vring_ready(&net->dev);
+    }
+
+    return 0;
+}
+
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 {
     const VhostOps *vhost_ops =3D net->dev.vhost_ops;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 213b327600..49224ef9f8 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -325,18 +325,15 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *=
dev, int idx)
     return idx - dev->vq_index;
 }
=20
-static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
+static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
 {
     int i;
=20
     for (i =3D 0; i < dev->nvqs; ++i) {
         struct vhost_vring_state state =3D {
             .index =3D dev->vq_index + i,
-            .num   =3D enable,
+            .num =3D 1,
         };
-
-        state.num =3D 1;
-
         vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
     }
=20
@@ -368,7 +365,7 @@ const VhostOps vdpa_ops =3D {
         .vhost_set_owner =3D vhost_vdpa_set_owner,
         .vhost_reset_device =3D vhost_vdpa_reset_device,
         .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
-        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
+        .vhost_set_vring_ready =3D vhost_vdpa_set_vring_ready,
         .vhost_requires_shm_log =3D NULL,
         .vhost_migration_done =3D NULL,
         .vhost_backend_can_merge =3D NULL,
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c6b47a9c73..4aaf5d953e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1103,6 +1103,18 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceSta=
te *d)
     return pci_get_address_space(dev);
 }
=20
+static bool virtio_pci_queue_enabled(DeviceState *d, int n)
+{
+    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(d);
+    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        return proxy->vqs[vdev->queue_sel].enabled;
+    }
+
+    return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
+}
+
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
                                    struct virtio_pci_cap *cap)
 {
@@ -2053,6 +2065,7 @@ static void virtio_pci_bus_class_init(ObjectClass *kl=
ass, void *data)
     k->ioeventfd_enabled =3D virtio_pci_ioeventfd_enabled;
     k->ioeventfd_assign =3D virtio_pci_ioeventfd_assign;
     k->get_dma_as =3D virtio_pci_get_dma_as;
+    k->queue_enabled =3D virtio_pci_queue_enabled;
 }
=20
 static const TypeInfo virtio_pci_bus_info =3D {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5f6c..09732a8836 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3169,6 +3169,12 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev=
, int n)
=20
 bool virtio_queue_enabled(VirtIODevice *vdev, int n)
 {
+    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
+    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
+
+    if (k->queue_enabled)
+        return k->queue_enabled(qbus->parent, n);
+
     return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
 }
=20
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-ba=
ckend.h
index d81bd9885f..ce8de6d308 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -78,6 +78,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *de=
v);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
                                          int enable);
+typedef int (*vhost_set_vring_ready_op)(struct vhost_dev *dev);
 typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
 typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
                                        char *mac_addr);
@@ -140,6 +141,7 @@ typedef struct VhostOps {
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
+    vhost_set_vring_ready_op vhost_set_vring_ready;
     vhost_requires_shm_log_op vhost_requires_shm_log;
     vhost_migration_done_op vhost_migration_done;
     vhost_backend_can_merge_op vhost_backend_can_merge;
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.=
h
index 38c9399cd4..0f6f215925 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -83,6 +83,10 @@ typedef struct VirtioBusClass {
      */
     int (*ioeventfd_assign)(DeviceState *d, EventNotifier *notifier,
                             int n, bool assign);
+    /*
+     * Whether queue number n is enabled.
+     */
+    bool (*queue_enabled)(DeviceState *d, int n);
     /*
      * Does the transport have variable vring alignment?
      * (ie can it ever call virtio_queue_set_align()?)
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 6f3a624cf7..db473ff4d2 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -35,6 +35,7 @@ int vhost_net_notify_migration_done(VHostNetState *net, c=
har* mac_addr);
 VHostNetState *get_vhost_net(NetClientState *nc);
=20
 int vhost_set_vring_enable(NetClientState * nc, int enable);
+int vhost_set_vring_ready(NetClientState * nc);
=20
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
=20
--=20
2.21.1


