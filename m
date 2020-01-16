Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE5C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6396420730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyXgj8Fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6396420730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2w3-0002aN-7f
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is2s2-00064j-G1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is2ry-00004s-Hd
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is2ry-0008W4-DD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579172362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1EJUAyINaXAVU17lKziI/hzu+/NjWM5FzY/Y9KFvO6g=;
 b=gyXgj8Fe7hIu3DT31G033Q/bPlbfe21Za9qNn9mAoKlplniLdTxuG6QSDVBLepZcTo1ctH
 zhVxkdR8+aGJMZoo34p+mmWGJ6PHwCqSuA8nlzqDqu4/wf4lDd8QwKgvm5z3w9wSK3Ra5w
 y8YZYFskWyjM814B+quJlEdwp0YMS0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ldWcLZtmNiyCgIbDYhJ2jQ-1; Thu, 16 Jan 2020 05:59:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C6C107ACC9;
 Thu, 16 Jan 2020 10:59:18 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 112A419C5B;
 Thu, 16 Jan 2020 10:59:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] vhost-user-blk: default num_queues to -smp N
Date: Thu, 16 Jan 2020 10:58:42 +0000
Message-Id: <20200116105842.271179-6-stefanha@redhat.com>
In-Reply-To: <20200116105842.271179-1-stefanha@redhat.com>
References: <20200116105842.271179-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ldWcLZtmNiyCgIbDYhJ2jQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

This patch duplicates the .get_num_virtqueues() function because
vhost-user-blk defines its own qdev property fields and does not share
VirtIOBlkConf.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/vhost-user-blk.c          | 15 +++++++++++++++
 hw/core/machine.c                  |  1 +
 hw/virtio/vhost-user-blk-pci.c     |  3 ++-
 include/hw/virtio/vhost-user-blk.h |  1 +
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 98b383f90e..ac61ce9835 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "qom/object.h"
+#include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost.h"
@@ -391,6 +392,17 @@ static void vhost_user_blk_event(void *opaque, QEMUChr=
Event event)
     }
 }
=20
+static uint32_t vhost_user_blk_get_num_virtqueues(VirtIODevice *vdev)
+{
+    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
+
+    if (s->num_queues =3D=3D 1 && s->auto_num_queues) {
+        return current_machine->smp.cpus;
+    }
+
+    return s->num_queues;
+}
+
 static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
@@ -403,6 +415,7 @@ static void vhost_user_blk_device_realize(DeviceState *=
dev, Error **errp)
         return;
     }
=20
+    s->num_queues =3D vhost_user_blk_get_num_virtqueues(vdev);
     if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "vhost-user-blk: invalid number of IO queues");
         return;
@@ -501,6 +514,7 @@ static const VMStateDescription vmstate_vhost_user_blk =
=3D {
 static Property vhost_user_blk_properties[] =3D {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
+    DEFINE_PROP_BOOL("auto-num-queues", VHostUserBlk, auto_num_queues, tru=
e),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
     DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
     DEFINE_PROP_END_OF_LIST(),
@@ -514,6 +528,7 @@ static void vhost_user_blk_class_init(ObjectClass *klas=
s, void *data)
     dc->props =3D vhost_user_blk_properties;
     dc->vmsd =3D &vmstate_vhost_user_blk;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    vdc->get_num_virtqueues =3D vhost_user_blk_get_num_virtqueues;
     vdc->realize =3D vhost_user_blk_device_realize;
     vdc->unrealize =3D vhost_user_blk_device_unrealize;
     vdc->get_config =3D vhost_user_blk_update_config;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index a33d1e93b1..0d4142c3c8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,6 +35,7 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-scsi-device", "seg_max_adjust", "off"},
     { "vhost-blk-device", "seg_max_adjust", "off"},
     { "vhost-scsi", "auto_num_queues", "off"},
+    { "vhost-user-blk", "auto-num-queues", "off"},
     { "vhost-user-scsi", "auto_num_queues", "off"},
     { "usb-host", "suppress-remote-wake", "off" },
     { "usb-redir", "suppress-remote-wake", "off" },
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.=
c
index 1dc834a3ff..328c6a4066 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -53,9 +53,10 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
 {
     VHostUserBlkPCI *dev =3D VHOST_USER_BLK_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D dev->vdev.num_queues + 1;
+        vpci_dev->nvectors =3D vdc->get_num_virtqueues(VIRTIO_DEVICE(vdev)=
) + 1;
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-u=
ser-blk.h
index 108bfadeeb..09d1fdf722 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -31,6 +31,7 @@ typedef struct VHostUserBlk {
     int32_t bootindex;
     struct virtio_blk_config blkcfg;
     uint16_t num_queues;
+    bool auto_num_queues;
     uint32_t queue_size;
     uint32_t config_wce;
     struct vhost_dev dev;
--=20
2.24.1


