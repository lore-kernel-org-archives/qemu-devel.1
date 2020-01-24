Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D924CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1482214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc9FEWhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1482214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvpK-0001xf-Oq
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iuvnE-0006Lb-GA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iuvnD-0006Yr-65
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iuvnC-0006YI-P1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579860142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvQ5GA+mBgNZIB4n151iIGtmYdm0/MUwPyFgTl16W54=;
 b=Nc9FEWhwBW0LEdywtgf85re5InHw8nSTUJ+SS4nlGUxr/bK8kmqaJMOEC+MmmUpD+ZVjXD
 sUc70XX0GWwckYNgiqRd0Ps+uZ9ShuDNNwjfJFcQ+TcwWcP6K9kigXmTBaE9Qy6FXH+xj1
 +DTQ+DscU5TCgdv6iXj1Y0XdktmXrE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-Qup9UDWPNqCqCKtvIJ_NxA-1; Fri, 24 Jan 2020 05:02:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 971DB1005510;
 Fri, 24 Jan 2020 10:02:17 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7322985784;
 Fri, 24 Jan 2020 10:02:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] virtio-blk: default num_queues to -smp N
Date: Fri, 24 Jan 2020 10:01:58 +0000
Message-Id: <20200124100159.736209-4-stefanha@redhat.com>
In-Reply-To: <20200124100159.736209-1-stefanha@redhat.com>
References: <20200124100159.736209-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Qup9UDWPNqCqCKtvIJ_NxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 hw/block/virtio-blk.c          | 6 +++++-
 hw/core/machine.c              | 1 +
 hw/virtio/virtio-blk-pci.c     | 9 ++++++++-
 include/hw/virtio/virtio-blk.h | 2 ++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9bee514c4e..d3ffaffc93 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1135,6 +1135,9 @@ static void virtio_blk_device_realize(DeviceState *de=
v, Error **errp)
         error_setg(errp, "Device needs media, but drive is empty");
         return;
     }
+    if (conf->num_queues =3D=3D VIRTIO_BLK_AUTO_NUM_QUEUES) {
+        conf->num_queues =3D 1;
+    }
     if (!conf->num_queues) {
         error_setg(errp, "num-queues property must be larger than 0");
         return;
@@ -1271,7 +1274,8 @@ static Property virtio_blk_properties[] =3D {
 #endif
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, =
0,
                     true),
-    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
+    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
+                       VIRTIO_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
     DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, t=
rue),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD=
,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d6e2370c77..de6ceaa97f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,6 +28,7 @@
 #include "hw/mem/nvdimm.h"
=20
 GlobalProperty hw_compat_4_2[] =3D {
+    { "virtio-blk-device", "num-queues", "1"},
     { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
     { "virtio-blk-device", "seg-max-adjust", "off"},
     { "virtio-scsi-device", "num_queues", "1"},
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index d9b69a5af3..7e6d863963 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-blk.h"
 #include "virtio-pci.h"
@@ -50,9 +51,15 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_=
dev, Error **errp)
 {
     VirtIOBlkPCI *dev =3D VIRTIO_BLK_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
+    VirtIOBlkConf *conf =3D &dev->vdev.conf;
+
+    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
+    if (conf->num_queues =3D=3D VIRTIO_BLK_AUTO_NUM_QUEUES) {
+        conf->num_queues =3D current_machine->smp.cpus;
+    }
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D dev->vdev.conf.num_queues + 1;
+        vpci_dev->nvectors =3D conf->num_queues + 1;
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.=
h
index 1e62f869b2..4e5e903f4a 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -30,6 +30,8 @@ struct virtio_blk_inhdr
     unsigned char status;
 };
=20
+#define VIRTIO_BLK_AUTO_NUM_QUEUES UINT16_MAX
+
 struct VirtIOBlkConf
 {
     BlockConf conf;
--=20
2.24.1


