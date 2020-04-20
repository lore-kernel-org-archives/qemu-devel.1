Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE00C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3C4205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG1/sM4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3C4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTyl-0003Q2-Rk
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58058 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jQTtU-0005bN-U1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:43:17 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jQTtT-0005uz-Rf
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:43:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jQTtT-0005ty-EI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587379394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tqx3wFTMlCAc0U6blYHQ1wRWTexIJf86d7f9RhPApfI=;
 b=DG1/sM4GDmhKRlq4rKChzEJgGMcHyaGyFZ45WGeuPnBBc3adpZDe9f1upkpqvEYmc7uCGh
 Ipggz72y7FcCDeotejNAr9pCTLgnA5vfCbRxGabwBwy0IwAIV79ZjlICbK4nA9RKKyyJE2
 OjAhDffcXA3mAxaO6F/OnUJcEKpFYUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-wTFSYCOyOg6Hpd4TUGYfbg-1; Mon, 20 Apr 2020 06:43:11 -0400
X-MC-Unique: wTFSYCOyOg6Hpd4TUGYfbg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7A84107ACCC;
 Mon, 20 Apr 2020 10:43:09 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-114-254.ams2.redhat.com
 [10.36.114.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFF2D5DDA8;
 Mon, 20 Apr 2020 10:42:48 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC v2 3/6] qmp: decode feature bits in virtio-status
Date: Mon, 20 Apr 2020 12:41:42 +0200
Message-Id: <20200420104145.205297-4-lvivier@redhat.com>
In-Reply-To: <20200420104145.205297-1-lvivier@redhat.com>
References: <20200420104145.205297-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Amit Shah <amit@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Display feature names instead of a features bitmap for host, guest
and backend.

Decode features according device type, transport features are
on the first line. Undecoded bits (if any) are stored in a separate
field.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2: new patch

 hw/block/virtio-blk.c        |  23 +++++
 hw/char/virtio-serial-bus.c  |  11 +++
 hw/display/virtio-gpu-base.c |  10 ++
 hw/net/virtio-net.c          |  35 +++++++
 hw/scsi/virtio-scsi.c        |  12 +++
 hw/virtio/virtio-balloon.c   |  13 +++
 hw/virtio/virtio-iommu.c     |  14 +++
 hw/virtio/virtio.c           | 114 ++++++++++++++++++++-
 include/hw/virtio/virtio.h   |  13 +++
 qapi/virtio.json             | 186 +++++++++++++++++++++++++++++++++--
 10 files changed, 418 insertions(+), 13 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 97ba8a218727..5bb3f70cbd1b 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
@@ -48,6 +49,28 @@ static VirtIOFeature feature_sizes[] =3D {
     {}
 };
=20
+qmp_virtio_feature_map_t blk_map[] =3D {
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_BLK_F_##name, VIRTIO_BLK_FEATURE_##name }
+    FEATURE_ENTRY(SIZE_MAX),
+    FEATURE_ENTRY(SEG_MAX),
+    FEATURE_ENTRY(GEOMETRY),
+    FEATURE_ENTRY(RO),
+    FEATURE_ENTRY(BLK_SIZE),
+    FEATURE_ENTRY(TOPOLOGY),
+    FEATURE_ENTRY(MQ),
+    FEATURE_ENTRY(DISCARD),
+    FEATURE_ENTRY(WRITE_ZEROES),
+#ifndef VIRTIO_BLK_NO_LEGACY
+    FEATURE_ENTRY(BARRIER),
+    FEATURE_ENTRY(SCSI),
+    FEATURE_ENTRY(FLUSH),
+    FEATURE_ENTRY(CONFIG_WCE),
+#endif
+#undef FEATURE_ENTRY
+    { -1, -1 }
+};
+
 static void virtio_blk_set_config_size(VirtIOBlock *s, uint64_t host_featu=
res)
 {
     s->config_size =3D MAX(VIRTIO_BLK_CFG_SIZE,
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 99a65bab7fff..872ba2ccf49f 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -33,6 +34,16 @@
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-access.h"
=20
+qmp_virtio_feature_map_t serial_map[] =3D {
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_CONSOLE_F_##name, VIRTIO_SERIAL_FEATURE_##name }
+    FEATURE_ENTRY(SIZE),
+    FEATURE_ENTRY(MULTIPORT),
+    FEATURE_ENTRY(EMERG_WRITE),
+#undef FEATURE_ENTRY
+    { -1, -1 }
+};
+
 static struct VirtIOSerialDevices {
     QLIST_HEAD(, VirtIOSerial) devices;
 } vserdevices;
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 55e07995feec..da66325452df 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -16,9 +16,19 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "qemu/error-report.h"
 #include "trace.h"
=20
+qmp_virtio_feature_map_t gpu_map[] =3D {
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_GPU_F_##name, VIRTIO_GPU_FEATURE_##name }
+    FEATURE_ENTRY(VIRGL),
+    FEATURE_ENTRY(EDID),
+#undef FEATURE_ENTRY
+    { -1, -1 }
+};
+
 void
 virtio_gpu_base_reset(VirtIOGPUBase *g)
 {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a46e3b37a7cd..24e87674c0c0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-events-migration.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
@@ -83,6 +84,40 @@
 #define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
 #define VIRTIO_NET_F_RSC_EXT       61
=20
+qmp_virtio_feature_map_t net_map[] =3D {
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_NET_F_##name, VIRTIO_NET_FEATURE_##name }
+    FEATURE_ENTRY(CSUM),
+    FEATURE_ENTRY(GUEST_CSUM),
+    FEATURE_ENTRY(CTRL_GUEST_OFFLOADS),
+    FEATURE_ENTRY(MTU),
+    FEATURE_ENTRY(MAC),
+    FEATURE_ENTRY(GUEST_TSO4),
+    FEATURE_ENTRY(GUEST_TSO6),
+    FEATURE_ENTRY(GUEST_ECN),
+    FEATURE_ENTRY(GUEST_UFO),
+    FEATURE_ENTRY(HOST_TSO4),
+    FEATURE_ENTRY(HOST_TSO6),
+    FEATURE_ENTRY(HOST_ECN),
+    FEATURE_ENTRY(HOST_UFO),
+    FEATURE_ENTRY(MRG_RXBUF),
+    FEATURE_ENTRY(STATUS),
+    FEATURE_ENTRY(CTRL_VQ),
+    FEATURE_ENTRY(CTRL_RX),
+    FEATURE_ENTRY(CTRL_VLAN),
+    FEATURE_ENTRY(CTRL_RX_EXTRA),
+    FEATURE_ENTRY(GUEST_ANNOUNCE),
+    FEATURE_ENTRY(MQ),
+    FEATURE_ENTRY(CTRL_MAC_ADDR),
+    FEATURE_ENTRY(STANDBY),
+    FEATURE_ENTRY(SPEED_DUPLEX),
+#ifndef VIRTIO_NET_NO_LEGACY
+    FEATURE_ENTRY(GSO),
+#endif /* VIRTIO_NET_NO_LEGACY */
+#undef FEATURE_ENTRY
+    { -1, -1 }
+};
+
 static inline __virtio16 *virtio_net_rsc_ext_num_packets(
     struct virtio_net_hdr *hdr)
 {
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 472bbd233bf3..7f027fbacf56 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "migration/qemu-file-types.h"
@@ -28,6 +29,17 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
=20
+qmp_virtio_feature_map_t scsi_map[] =3D {
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_SCSI_F_##name, VIRTIO_SCSI_FEATURE_##name }
+    FEATURE_ENTRY(INOUT),
+    FEATURE_ENTRY(HOTPLUG),
+    FEATURE_ENTRY(CHANGE),
+    FEATURE_ENTRY(T10_PI),
+#undef FEATURE_ENTRY
+    { -1, -1 }
+};
+
 static inline int virtio_scsi_get_lun(uint8_t *lun)
 {
     return ((lun[2] << 8) | lun[3]) & 0x3FFF;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc930..3cd9b319e77a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
 #include "qapi/visitor.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "migration/misc.h"
@@ -33,6 +34,18 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
=20
+qmp_virtio_feature_map_t balloon_map[] =3D {
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_BALLOON_F_##name, VIRTIO_BALLOON_FEATURE_##name }
+    FEATURE_ENTRY(MUST_TELL_HOST),
+    FEATURE_ENTRY(STATS_VQ),
+    FEATURE_ENTRY(DEFLATE_ON_OOM),
+    FEATURE_ENTRY(FREE_PAGE_HINT),
+    FEATURE_ENTRY(PAGE_POISON),
+#undef FEATURE_ENTRY
+    { -1, -1 }
+};
+
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
=20
 typedef struct PartiallyBalloonedPage {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 22ba8848c2fe..89858321ef87 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -25,6 +25,7 @@
 #include "hw/virtio/virtio.h"
 #include "sysemu/kvm.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "qemu/error-report.h"
 #include "trace.h"
=20
@@ -36,6 +37,19 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci.h"
=20
+qmp_virtio_feature_map_t iommu_map[] =3D {
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_IOMMU_F_##name, VIRTIO_IOMMU_FEATURE_##name }
+    FEATURE_ENTRY(INPUT_RANGE),
+    FEATURE_ENTRY(DOMAIN_RANGE),
+    FEATURE_ENTRY(MAP_UNMAP),
+    FEATURE_ENTRY(BYPASS),
+    FEATURE_ENTRY(PROBE),
+    FEATURE_ENTRY(MMIO),
+#undef FEATURE_ENTRY
+    { -1, -1 }
+};
+
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
=20
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 539dc47e9952..6c484822f97b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -29,9 +29,30 @@
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
+#include "config-devices.h"
=20
 static QTAILQ_HEAD(, VirtIODevice) virtio_list;
=20
+static qmp_virtio_feature_map_t transport_map[] =3D {
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_F_##name, VIRTIO_TRANSPORT_FEATURE_##name }
+    FEATURE_ENTRY(NOTIFY_ON_EMPTY),
+    FEATURE_ENTRY(ANY_LAYOUT),
+    FEATURE_ENTRY(VERSION_1),
+    FEATURE_ENTRY(IOMMU_PLATFORM),
+    FEATURE_ENTRY(RING_PACKED),
+    FEATURE_ENTRY(ORDER_PLATFORM),
+    FEATURE_ENTRY(SR_IOV),
+    FEATURE_ENTRY(BAD_FEATURE),
+#undef FEATURE_ENTRY
+#define FEATURE_ENTRY(name) \
+    { VIRTIO_RING_F_##name, VIRTIO_TRANSPORT_FEATURE_##name }
+    FEATURE_ENTRY(INDIRECT_DESC),
+    FEATURE_ENTRY(EVENT_IDX),
+#undef FEATURE_ENTRY
+    { -1, -1 }
+};
+
 /*
  * The alignment to use between consumer and producer parts of vring.
  * x86 pagesize again. This is the default, used by transports like PCI
@@ -3856,6 +3877,90 @@ static VirtIODevice *virtio_device_find(const char *=
path)
     return NULL;
 }
=20
+#define CONVERT_FEATURES(type, map)                \
+    ({                                           \
+        type *list =3D NULL;                         \
+        type *node;                                \
+        for (i =3D 0; map[i].virtio_bit !=3D -1; i++) {\
+            bit =3D 1ULL << map[i].virtio_bit;       \
+            if ((bitmap & bit) =3D=3D 0) {             \
+                continue;                          \
+            }                                      \
+            node =3D g_new0(type, 1);                \
+            node->value =3D map[i].qapi_virtio_enum; \
+            node->next =3D list;                     \
+            list =3D node;                           \
+            bitmap ^=3D bit;                         \
+        }                                          \
+        list;                                      \
+    })
+
+static VirtioStatusFeatures *qmp_decode_features(const char *name,
+                                                 uint64_t bitmap)
+{
+    VirtioStatusFeatures *features;
+    uint64_t bit;
+    int i;
+
+    features =3D g_new0(VirtioStatusFeatures, 1);
+
+    /* transport features */
+    features->transport =3D CONVERT_FEATURES(VirtioTransportFeatureList, \
+                                           transport_map);
+
+    /* device features */
+    features->device =3D g_new0(VirtioDeviceFeatures, 1);
+    features->device->type =3D qapi_enum_parse(&VirtioDeviceFeaturesKind_l=
ookup,
+                                             name, -1, NULL);
+    switch (features->device->type) {
+    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_SERIAL:
+        features->device->u.virtio_serial.data =3D
+                          CONVERT_FEATURES(VirtioSerialFeatureList, serial=
_map);
+        break;
+#ifdef CONFIG_VIRTIO_BLK
+    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_BLK:
+        features->device->u.virtio_blk.data =3D
+                                CONVERT_FEATURES(VirtioBlkFeatureList, blk=
_map);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_GPU
+    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_GPU:
+        features->device->u.virtio_gpu.data =3D
+                                CONVERT_FEATURES(VirtioGpuFeatureList, gpu=
_map);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_NET
+    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_NET:
+        features->device->u.virtio_net.data =3D
+                                CONVERT_FEATURES(VirtioNetFeatureList, net=
_map);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_SCSI
+    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_SCSI:
+        features->device->u.virtio_scsi.data =3D
+                              CONVERT_FEATURES(VirtioScsiFeatureList, scsi=
_map);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_BALLOON
+    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_BALLOON:
+        features->device->u.virtio_balloon.data =3D
+                        CONVERT_FEATURES(VirtioBalloonFeatureList, balloon=
_map);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_IOMMU
+    case VIRTIO_DEVICE_FEATURES_KIND_VIRTIO_IOMMU:
+        features->device->u.virtio_iommu.data =3D
+                            CONVERT_FEATURES(VirtioIommuFeatureList, iommu=
_map);
+        break;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+    features->unknown =3D bitmap;
+
+    return features;
+}
+
 VirtioStatus *qmp_virtio_status(const char* path, Error **errp)
 {
     VirtIODevice *vdev;
@@ -3868,9 +3973,12 @@ VirtioStatus *qmp_virtio_status(const char* path, Er=
ror **errp)
     }
=20
     status =3D g_new0(VirtioStatus, 1);
-    status->guest_features =3D vdev->guest_features;
-    status->host_features =3D vdev->host_features;
-    status->backend_features =3D vdev->backend_features;
+    status->guest_features =3D qmp_decode_features(vdev->name,
+                                                 vdev->guest_features);
+    status->host_features =3D qmp_decode_features(vdev->name,
+                                                vdev->host_features);
+    status->backend_features =3D qmp_decode_features(vdev->name,
+                                                   vdev->backend_features)=
;
     status->device_id =3D vdev->device_id;
=20
     switch (vdev->device_endian) {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 65adce680188..f10c3365e367 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -166,6 +166,19 @@ typedef struct VirtioDeviceClass {
     bool (*primary_unplug_pending)(void *opaque);
 } VirtioDeviceClass;
=20
+typedef struct {
+    int virtio_bit;
+    int qapi_virtio_enum;
+} qmp_virtio_feature_map_t;
+
+extern qmp_virtio_feature_map_t serial_map[];
+extern qmp_virtio_feature_map_t blk_map[];
+extern qmp_virtio_feature_map_t gpu_map[];
+extern qmp_virtio_feature_map_t net_map[];
+extern qmp_virtio_feature_map_t scsi_map[];
+extern qmp_virtio_feature_map_t balloon_map[];
+extern qmp_virtio_feature_map_t iommu_map[];
+
 void virtio_instance_init_common(Object *proxy_obj, void *data,
                                  size_t vdev_size, const char *vdev_name);
=20
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 504b235d7628..e72237cc1a68 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -78,6 +78,150 @@
   'data': [ 'unknown', 'little', 'big' ]
 }
=20
+##
+# @VirtioTransportFeature:
+#
+# An enumeration of Virtio device transport features, including virtio-rin=
g
+#
+# Since: 5.1
+##
+
+{ 'enum': 'VirtioTransportFeature',
+  'data': [ 'notify-on-empty', 'any-layout', 'version-1', 'iommu-platform'=
,
+            'ring-packed', 'order-platform', 'sr-iov', 'indirect-desc',
+            'event-idx', 'bad-feature' ]
+}
+
+##
+# @VirtioSerialFeature:
+#
+# An enumeration of Virtio serial features
+#
+# Since: 5.1
+##
+
+{ 'enum': 'VirtioSerialFeature',
+  'data': [ 'size', 'multiport', 'emerg-write' ]
+}
+
+##
+# @VirtioBlkFeature:
+#
+# An enumeration of Virtio block features
+#
+# Since: 5.1
+##
+
+{ 'enum': 'VirtioBlkFeature',
+  'data': [ 'size-max', 'seg-max', 'geometry', 'ro', 'blk-size', 'topology=
',              'mq', 'discard', 'write-zeroes', 'barrier', 'scsi', 'flush'=
,
+            'config-wce' ]
+}
+
+##
+# @VirtioGpuFeature:
+#
+# An enumeration of Virtio gpu features
+#
+# Since: 5.1
+##
+
+{ 'enum': 'VirtioGpuFeature',
+  'data': [ 'virgl', 'edid' ]
+}
+
+##
+# @VirtioNetFeature:
+#
+# An enumeration of Virtio net features
+#
+# Since: 5.1
+##
+
+{ 'enum': 'VirtioNetFeature',
+  'data': [ 'csum', 'guest-csum', 'ctrl-guest-offloads', 'mtu', 'mac',
+            'guest-tso4', 'guest-tso6', 'guest-ecn', 'guest-ufo',
+            'host-tso4', 'host-tso6', 'host-ecn', 'host-ufo', 'mrg-rxbuf',
+            'status', 'ctrl-vq', 'ctrl-rx', 'ctrl-vlan', 'ctrl-rx-extra',
+            'guest-announce', 'mq', 'ctrl-mac-addr', 'standby',
+            'speed-duplex', 'gso' ]
+}
+
+##
+# @VirtioScsiFeature:
+#
+# An enumeration of Virtio scsi features
+#
+# Since: 5.1
+##
+
+{ 'enum': 'VirtioScsiFeature',
+  'data': [ 'inout', 'hotplug', 'change', 't10-pi' ]
+}
+
+##
+# @VirtioBalloonFeature:
+#
+# An enumeration of Virtio balloon features
+#
+# Since: 5.1
+##
+
+{ 'enum': 'VirtioBalloonFeature',
+  'data': [ 'must-tell-host', 'stats-vq', 'deflate-on-oom', 'free-page-hin=
t',
+            'page-poison' ]
+}
+
+##
+# @VirtioIommuFeature:
+#
+# An enumeration of Virtio iommu features
+#
+# Since: 5.1
+##
+
+{ 'enum': 'VirtioIommuFeature',
+  'data': [ 'input-range', 'domain-range', 'map-unmap', 'bypass', 'probe',
+            'mmio' ]
+}
+
+##
+# @VirtioDeviceFeatures:
+#
+# An union to define the list of features for a virtio device
+#
+# Since: 5.1
+##
+
+{ 'union': 'VirtioDeviceFeatures',
+  'data': {
+    'virtio-serial': [ 'VirtioSerialFeature' ],
+    'virtio-blk': [ 'VirtioBlkFeature' ],
+    'virtio-gpu': [ 'VirtioGpuFeature' ],
+    'virtio-net': [ 'VirtioNetFeature' ],
+    'virtio-scsi': [ 'VirtioScsiFeature' ],
+    'virtio-balloon': [ 'VirtioBalloonFeature' ],
+    'virtio-iommu': [ 'VirtioIommuFeature' ]
+  }
+}
+
+##
+# @VirtioStatusFeatures:
+#
+# @transport: the list of transport features of the virtio device
+#
+# @device: the list of the virtio device specific features
+#
+# @unknown: virtio bitmap of the undecoded features
+#
+# Since: 5.1
+##
+
+{ 'struct': 'VirtioStatusFeatures',
+  'data': { 'transport': [ 'VirtioTransportFeature' ],
+            'device': 'VirtioDeviceFeatures',
+            'unknown': 'uint64' }
+}
+
 ##
 # @VirtioStatus:
 #
@@ -101,9 +245,9 @@
   'data': {
     'device-id': 'int',
     'device-endian': 'VirtioStatusEndianness',
-    'guest-features': 'uint64',
-    'host-features': 'uint64',
-    'backend-features': 'uint64',
+    'guest-features': 'VirtioStatusFeatures',
+    'host-features': 'VirtioStatusFeatures',
+    'backend-features': 'VirtioStatusFeatures',
     'num-vqs': 'uint16'
   }
 }
@@ -123,18 +267,40 @@
 #
 # -> { "execute": "virtio-status",
 #      "arguments": {
-#          "path": "/machine/peripheral-anon/device[3]/virtio-backend"
+#          "path": "/machine/peripheral-anon/device[1]/virtio-backend"
 #      }
 #   }
 # <- { "return": {
-#          "backend-features": 0,
-#          "guest-features": 5111807911,
-#          "num-vqs": 3,
-#          "host-features": 6337593319,
 #          "device-endian": "little",
-#          "device-id": 1
+#          "device-id": 3,
+#          "backend-features": {
+#              "device": {
+#                  "type": "virtio-serial",
+#                  "data": []
+#              },
+#              "unknown": 0,
+#              "transport": []
+#          },
+#          "num-vqs": 64,
+#          "guest-features": {
+#              "device": {
+#                  "type": "virtio-serial",
+#                  "data": [ "multiport" ]
+#              },
+#              "unknown": 0,
+#              "transport": [ "event-idx", "indirect-desc", "version-1" ]
+#          },
+#          "host-features": {
+#              "device": {
+#                  "type": "virtio-serial",
+#                  "data": [ "emerg-write", "multiport" ]
+#              },
+#              "unknown": 0,
+#              "transport": [ "event-idx", "indirect-desc", "bad-feature",
+#                             "version-1", "any-layout", "notify-on-empty"=
 ]
+#          }
 #      }
-#    }
+#  }
 #
 ##
=20
--=20
2.25.2


