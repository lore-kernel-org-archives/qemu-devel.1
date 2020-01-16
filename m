Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C0DC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB58E20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEHw5zbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB58E20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2w0-0002Pf-Mt
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is2s8-0006DR-Ds
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is2s3-0000Al-On
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50670
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is2s3-0000AQ-Jk
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579172367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3H4WA4qyYoNmCPE+S/ug1ggpeMg8EU8QXjs712xrC4=;
 b=WEHw5zbQzwb9gxVZ19guFXyuLYgoh24r5okGz9OSpvQKF6GYQ0UMB0m9jY0rzWb8f+CbfF
 7p8T09e0m7qEbDhA5KA7IB1mF4UTox1/qOq4I1W+tP0TlYjk/HtyyLtyb9tehHFE7CzFyb
 3VQRJaayyla2+/cIBNpdkoljcdSGvDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-3Uve9H2zOlObarlMh2QW4A-1; Thu, 16 Jan 2020 05:59:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF50010120A1;
 Thu, 16 Jan 2020 10:59:09 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40950619DB;
 Thu, 16 Jan 2020 10:59:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] virtio-scsi: default num_queues to -smp N
Date: Thu, 16 Jan 2020 10:58:40 +0000
Message-Id: <20200116105842.271179-4-stefanha@redhat.com>
In-Reply-To: <20200116105842.271179-1-stefanha@redhat.com>
References: <20200116105842.271179-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3Uve9H2zOlObarlMh2QW4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Automatically size the number of request virtqueues to match the number
of vCPUs.  This ensures that completion interrupts are handled on the
same vCPU that submitted the request.  No IPI is necessary to complete
an I/O request and performance is improved.

Remember that virtqueue numbering assumptions are being removed from the
virtio-pci proxy object, so the Control and Event virtqueues are counted
by ->get_num_virtqueues() and we only add 1 for the Configuration Change
interrupt:

     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
+        vpci_dev->nvectors =3D vdc->get_num_virtqueues(VIRTIO_DEVICE(vdev)=
) + 1;
     }

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/core/machine.c               |  3 +++
 hw/scsi/vhost-scsi.c            |  2 ++
 hw/scsi/vhost-user-scsi.c       |  2 ++
 hw/scsi/virtio-scsi.c           | 18 ++++++++++++++++++
 hw/virtio/vhost-scsi-pci.c      |  4 ++--
 hw/virtio/vhost-user-scsi-pci.c |  4 ++--
 hw/virtio/virtio-scsi-pci.c     |  4 ++--
 include/hw/virtio/virtio-scsi.h |  1 +
 8 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bfceb..41da19d85b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,8 +30,11 @@
 GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
     { "virtio-blk-device", "seg-max-adjust", "off"},
+    { "virtio-scsi-device", "auto_num_queues", "off"},
     { "virtio-scsi-device", "seg_max_adjust", "off"},
     { "vhost-blk-device", "seg_max_adjust", "off"},
+    { "vhost-scsi", "auto_num_queues", "off"},
+    { "vhost-user-scsi", "auto_num_queues", "off"},
     { "usb-host", "suppress-remote-wake", "off" },
     { "usb-redir", "suppress-remote-wake", "off" },
 };
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 26f710d3ec..1dfc269a29 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -273,6 +273,8 @@ static Property vhost_scsi_properties[] =3D {
     DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1)=
,
+    DEFINE_PROP_BOOL("auto_num_queues", VirtIOSCSICommon,
+                     conf.auto_num_queues, true),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_=
size,
                        128),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adju=
st,
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index eb37733bd0..92dbdf1042 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -164,6 +164,8 @@ static Property vhost_user_scsi_properties[] =3D {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1)=
,
+    DEFINE_PROP_BOOL("auto_num_queues", VirtIOSCSICommon,
+                     conf.auto_num_queues, true),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_=
size,
                        128),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 5622dd54e5..73c6030b22 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "standard-headers/linux/virtio_ids.h"
+#include "hw/boards.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "migration/qemu-file-types.h"
 #include "qemu/error-report.h"
@@ -878,6 +879,18 @@ static struct SCSIBusInfo virtio_scsi_scsi_info =3D {
     .load_request =3D virtio_scsi_load_request,
 };
=20
+static uint32_t virtio_scsi_get_num_virtqueues(VirtIODevice *vdev)
+{
+    VirtIOSCSICommon *s =3D VIRTIO_SCSI_COMMON(vdev);
+    uint32_t request_queues =3D s->conf.num_queues;
+
+    if (s->conf.num_queues =3D=3D 1 && s->conf.auto_num_queues) {
+        request_queues =3D current_machine->smp.cpus;
+    }
+
+    return VIRTIO_SCSI_VQ_NUM_FIXED + request_queues;
+}
+
 void virtio_scsi_common_realize(DeviceState *dev,
                                 VirtIOHandleOutput ctrl,
                                 VirtIOHandleOutput evt,
@@ -905,6 +918,8 @@ void virtio_scsi_common_realize(DeviceState *dev,
                    "must be > 2", s->conf.virtqueue_size);
         return;
     }
+    s->conf.num_queues =3D virtio_scsi_get_num_virtqueues(vdev) -
+                         VIRTIO_SCSI_VQ_NUM_FIXED;
     s->cmd_vqs =3D g_new0(VirtQueue *, s->conf.num_queues);
     s->sense_size =3D VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
     s->cdb_size =3D VIRTIO_SCSI_CDB_DEFAULT_SIZE;
@@ -959,6 +974,8 @@ static void virtio_scsi_device_unrealize(DeviceState *d=
ev, Error **errp)
=20
 static Property virtio_scsi_properties[] =3D {
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queue=
s, 1),
+    DEFINE_PROP_BOOL("auto_num_queues", VirtIOSCSI,
+                     parent_obj.conf.auto_num_queues, true),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
                                          parent_obj.conf.virtqueue_size, 1=
28),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
@@ -1011,6 +1028,7 @@ static void virtio_scsi_class_init(ObjectClass *klass=
, void *data)
     vdc->reset =3D virtio_scsi_reset;
     vdc->start_ioeventfd =3D virtio_scsi_dataplane_start;
     vdc->stop_ioeventfd =3D virtio_scsi_dataplane_stop;
+    vdc->get_num_virtqueues =3D virtio_scsi_get_num_virtqueues;
     hc->pre_plug =3D virtio_scsi_pre_hotplug;
     hc->plug =3D virtio_scsi_hotplug;
     hc->unplug =3D virtio_scsi_hotunplug;
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index e8dfbfc60f..94f64afde4 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -47,10 +47,10 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci=
_dev, Error **errp)
 {
     VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
+        vpci_dev->nvectors =3D vdc->get_num_virtqueues(VIRTIO_DEVICE(vdev)=
) + 1;
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pc=
i.c
index ff13af7030..6b518e6d72 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -53,10 +53,10 @@ static void vhost_user_scsi_pci_realize(VirtIOPCIProxy =
*vpci_dev, Error **errp)
 {
     VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
+        vpci_dev->nvectors =3D vdc->get_num_virtqueues(VIRTIO_DEVICE(vdev)=
) + 1;
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index 3c55dc19a1..447344869d 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -46,12 +46,12 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpc=
i_dev, Error **errp)
 {
     VirtIOSCSIPCI *dev =3D VIRTIO_SCSI_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
     DeviceState *proxy =3D DEVICE(vpci_dev);
     char *bus_name;
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
+        vpci_dev->nvectors =3D vdc->get_num_virtqueues(VIRTIO_DEVICE(vdev)=
) + 1;
     }
=20
     /*
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scs=
i.h
index 9f293bcb80..672e703bd2 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -50,6 +50,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
=20
 struct VirtIOSCSIConf {
     uint32_t num_queues;
+    bool auto_num_queues;
     uint32_t virtqueue_size;
     bool seg_max_adjust;
     uint32_t max_sectors;
--=20
2.24.1


