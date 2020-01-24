Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9680BC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EBB2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnFKJZ1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EBB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvoG-0008B8-ES
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iuvn8-0006GQ-Oq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iuvn6-0006Rs-Pt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51147
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iuvn6-0006Pr-Ib
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579860134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQxVhFjVOtXTswwkqeSbsQS/+HjZ0EegRuzS2Ji1B60=;
 b=bnFKJZ1joN3tt/xVdlJYSlW9lfVwg0gNkRDBHFkdvRGVusfadqjhNeF3CrRpyykBLr7/Xy
 0enuD0BrHQA5zPGngOPQ/AoM65PM8w5mA+6eGi7H+RpmV8mkF9rKBrkPcNg75lMyFiv47A
 jgwkqA1KGPPzdTEQ0yOMlUql8AXwUSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-qBO7CEEPPvakh24HXfb3kw-1; Fri, 24 Jan 2020 05:02:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2943C107ACC5;
 Fri, 24 Jan 2020 10:02:11 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE1C119C69;
 Fri, 24 Jan 2020 10:02:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Date: Fri, 24 Jan 2020 10:01:57 +0000
Message-Id: <20200124100159.736209-3-stefanha@redhat.com>
In-Reply-To: <20200124100159.736209-1-stefanha@redhat.com>
References: <20200124100159.736209-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qBO7CEEPPvakh24HXfb3kw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Automatically size the number of request virtqueues to match the number
of vCPUs.  This ensures that completion interrupts are handled on the
same vCPU that submitted the request.  No IPI is necessary to complete
an I/O request and performance is improved.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/core/machine.c               |  3 +++
 hw/scsi/vhost-scsi.c            |  3 ++-
 hw/scsi/vhost-user-scsi.c       |  3 ++-
 hw/scsi/virtio-scsi.c           |  6 +++++-
 hw/virtio/vhost-scsi-pci.c      | 10 ++++++++--
 hw/virtio/vhost-user-scsi-pci.c | 10 ++++++++--
 hw/virtio/virtio-scsi-pci.c     | 10 ++++++++--
 include/hw/virtio/virtio-scsi.h |  2 ++
 8 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bfceb..d6e2370c77 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,8 +30,11 @@
 GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
     { "virtio-blk-device", "seg-max-adjust", "off"},
+    { "virtio-scsi-device", "num_queues", "1"},
     { "virtio-scsi-device", "seg_max_adjust", "off"},
     { "vhost-blk-device", "seg_max_adjust", "off"},
+    { "vhost-scsi", "num_queues", "1"},
+    { "vhost-user-scsi", "num_queues", "1"},
     { "usb-host", "suppress-remote-wake", "off" },
     { "usb-redir", "suppress-remote-wake", "off" },
 };
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 26f710d3ec..80fe5d999a 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -272,7 +272,8 @@ static Property vhost_scsi_properties[] =3D {
     DEFINE_PROP_STRING("vhostfd", VirtIOSCSICommon, conf.vhostfd),
     DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
-    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1)=
,
+    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
+                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_=
size,
                        128),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adju=
st,
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index eb37733bd0..655d300875 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -163,7 +163,8 @@ static void vhost_user_scsi_unrealize(DeviceState *dev,=
 Error **errp)
 static Property vhost_user_scsi_properties[] =3D {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
-    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1)=
,
+    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
+                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_=
size,
                        128),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 224a290498..c9342004ef 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -891,6 +891,9 @@ void virtio_scsi_common_realize(DeviceState *dev,
     virtio_init(vdev, "virtio-scsi", VIRTIO_ID_SCSI,
                 sizeof(VirtIOSCSIConfig));
=20
+    if (s->conf.num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
+        s->conf.num_queues =3D 1;
+    }
     if (s->conf.num_queues =3D=3D 0 ||
             s->conf.num_queues > VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIX=
ED) {
         error_setg(errp, "Invalid number of queues (=3D %" PRIu32 "), "
@@ -964,7 +967,8 @@ static void virtio_scsi_device_unrealize(DeviceState *d=
ev, Error **errp)
 }
=20
 static Property virtio_scsi_properties[] =3D {
-    DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queue=
s, 1),
+    DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queue=
s,
+                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
                                          parent_obj.conf.virtqueue_size, 1=
28),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index e8dfbfc60f..38a8f0c3ef 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
=20
 #include "standard-headers/linux/virtio_pci.h"
+#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-scsi.h"
 #include "qapi/error.h"
@@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci=
_dev, Error **errp)
 {
     VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
+    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf;
+
+    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
+    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
+        conf->num_queues =3D current_machine->smp.cpus;
+    }
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
+        vpci_dev->nvectors =3D conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED=
 + 1;
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pc=
i.c
index ff13af7030..0cad29eb67 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
=20
 #include "standard-headers/linux/virtio_pci.h"
+#include "hw/boards.h"
 #include "hw/virtio/vhost-user-scsi.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-scsi.h"
@@ -53,10 +54,15 @@ static void vhost_user_scsi_pci_realize(VirtIOPCIProxy =
*vpci_dev, Error **errp)
 {
     VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
+    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf;
+
+    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
+    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
+        conf->num_queues =3D current_machine->smp.cpus;
+    }
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
+        vpci_dev->nvectors =3D conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED=
 + 1;
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index 3c55dc19a1..b22c8b79e2 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "qemu/module.h"
@@ -46,12 +47,17 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpc=
i_dev, Error **errp)
 {
     VirtIOSCSIPCI *dev =3D VIRTIO_SCSI_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
     DeviceState *proxy =3D DEVICE(vpci_dev);
+    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.conf;
     char *bus_name;
=20
+    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
+    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
+        conf->num_queues =3D current_machine->smp.cpus;
+    }
+
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
+        vpci_dev->nvectors =3D conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED=
 + 1;
     }
=20
     /*
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scs=
i.h
index 9f293bcb80..c0b8e4dd7e 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -39,6 +39,8 @@
 /* Number of virtqueues that are always present */
 #define VIRTIO_SCSI_VQ_NUM_FIXED    2
=20
+#define VIRTIO_SCSI_AUTO_NUM_QUEUES UINT32_MAX
+
 typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
 typedef struct virtio_scsi_cmd_resp VirtIOSCSICmdResp;
 typedef struct virtio_scsi_ctrl_tmf_req VirtIOSCSICtrlTMFReq;
--=20
2.24.1


