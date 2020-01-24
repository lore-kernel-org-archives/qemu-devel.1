Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA9FC32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F72E208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7+nafv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F72E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvqk-0004IF-MX
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iuvnI-0006UN-S6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iuvnH-0006cK-I4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iuvnH-0006c3-Dk
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579860147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zapCsf3yIAWy9YVSk9S/kiNcaPecTeVpB4Pj1Kno3O8=;
 b=K7+nafv0Q7dQ3XDPiUbrC25XC2/2+83ubNEjvkhyl7SYf6k2H3GqmXoito3d30F0HrkhjM
 6+HuiVMdGr2zz9ZoBBrE8KN2dPjL2O1M4ZNZP8/2teYaEABmUxGwPLKu2jH/g2HAKupKva
 wrdzRBnexcytHBIP3LB8uj4yuEEr/Jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-raErzDmaMa-J_zpET0Ha8A-1; Fri, 24 Jan 2020 05:02:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BF71477;
 Fri, 24 Jan 2020 10:02:24 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0456219C69;
 Fri, 24 Jan 2020 10:02:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] vhost-user-blk: default num_queues to -smp N
Date: Fri, 24 Jan 2020 10:01:59 +0000
Message-Id: <20200124100159.736209-5-stefanha@redhat.com>
In-Reply-To: <20200124100159.736209-1-stefanha@redhat.com>
References: <20200124100159.736209-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: raErzDmaMa-J_zpET0Ha8A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
 hw/block/vhost-user-blk.c          | 6 +++++-
 hw/core/machine.c                  | 1 +
 hw/virtio/vhost-user-blk-pci.c     | 6 ++++++
 include/hw/virtio/vhost-user-blk.h | 2 ++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 98b383f90e..2ee26a434c 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -403,6 +403,9 @@ static void vhost_user_blk_device_realize(DeviceState *=
dev, Error **errp)
         return;
     }
=20
+    if (s->num_queues =3D=3D VHOST_USER_BLK_AUTO_NUM_QUEUES) {
+        s->num_queues =3D 1;
+    }
     if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "vhost-user-blk: invalid number of IO queues");
         return;
@@ -500,7 +503,8 @@ static const VMStateDescription vmstate_vhost_user_blk =
=3D {
=20
 static Property vhost_user_blk_properties[] =3D {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
-    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
+    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
+                       VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
     DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/core/machine.c b/hw/core/machine.c
index de6ceaa97f..d4c67f4d6e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,6 +35,7 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-scsi-device", "seg_max_adjust", "off"},
     { "vhost-blk-device", "seg_max_adjust", "off"},
     { "vhost-scsi", "num_queues", "1"},
+    { "vhost-user-blk", "num-queues", "1"},
     { "vhost-user-scsi", "num_queues", "1"},
     { "usb-host", "suppress-remote-wake", "off" },
     { "usb-redir", "suppress-remote-wake", "off" },
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.=
c
index 1dc834a3ff..cf72b21c16 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
=20
 #include "standard-headers/linux/virtio_pci.h"
+#include "hw/boards.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost-user-blk.h"
 #include "hw/pci/pci.h"
@@ -54,6 +55,11 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
     VHostUserBlkPCI *dev =3D VHOST_USER_BLK_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
=20
+    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
+    if (dev->vdev.num_queues =3D=3D VHOST_USER_BLK_AUTO_NUM_QUEUES) {
+        dev->vdev.num_queues =3D current_machine->smp.cpus;
+    }
+
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
         vpci_dev->nvectors =3D dev->vdev.num_queues + 1;
     }
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-u=
ser-blk.h
index 108bfadeeb..5a353dc1c6 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -25,6 +25,8 @@
 #define VHOST_USER_BLK(obj) \
         OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
=20
+#define VHOST_USER_BLK_AUTO_NUM_QUEUES UINT16_MAX
+
 typedef struct VHostUserBlk {
     VirtIODevice parent_obj;
     CharBackend chardev;
--=20
2.24.1


