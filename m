Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE6C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 19:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD87207FF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 19:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD87207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG7Ba-0002WH-76
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 15:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iG6qu-0005Ri-F0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 15:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iG6qs-0004t6-8N
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 15:33:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iG6qo-0004n4-Dm; Thu, 03 Oct 2019 15:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A13F18CB8E0;
 Thu,  3 Oct 2019 19:33:21 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B43F31001B09;
 Thu,  3 Oct 2019 19:33:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 5/8] bootdevice: Gather LCHS from all relevant devices
Date: Thu,  3 Oct 2019 15:32:42 -0400
Message-Id: <20191003193245.8993-6-jsnow@redhat.com>
In-Reply-To: <20191003193245.8993-1-jsnow@redhat.com>
References: <20191003193245.8993-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 03 Oct 2019 19:33:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Arbel Moshe <arbel.moshe@oracle.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Sam Eiderman <shmuel.eiderman@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sam Eiderman <sameid@google.com>, Laszlo Ersek <lersek@redhat.com>,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Relevant devices are:
    * ide-hd (and ide-cd, ide-drive)
    * scsi-hd (and scsi-cd, scsi-disk, scsi-block)
    * virtio-blk-pci

We do not call del_boot_device_lchs() for ide-* since we don't need to -
IDE block devices do not support unplugging.

Signed-off-by: Sam Eiderman <sameid@google.com>
Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-id: 20190925110639.100699-6-sameid@google.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/block/virtio-blk.c |  6 ++++++
 hw/ide/qdev.c         |  5 +++++
 hw/scsi/scsi-disk.c   | 12 ++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 18851601cb..6d8ff34a16 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1186,6 +1186,11 @@ static void virtio_blk_device_realize(DeviceState =
*dev, Error **errp)
     blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);
=20
     blk_iostatus_enable(s->blk);
+
+    add_boot_device_lchs(dev, "/disk@0,0",
+                         conf->conf.lcyls,
+                         conf->conf.lheads,
+                         conf->conf.lsecs);
 }
=20
 static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
@@ -1193,6 +1198,7 @@ static void virtio_blk_device_unrealize(DeviceState=
 *dev, Error **errp)
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOBlock *s =3D VIRTIO_BLK(dev);
=20
+    del_boot_device_lchs(dev, "/disk@0,0");
     virtio_blk_data_plane_destroy(s->dataplane);
     s->dataplane =3D NULL;
     qemu_del_vm_change_state_handler(s->change);
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6dd219944f..2ffd387a73 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -220,6 +220,11 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveK=
ind kind, Error **errp)
=20
     add_boot_device_path(dev->conf.bootindex, &dev->qdev,
                          dev->unit ? "/disk@1" : "/disk@0");
+
+    add_boot_device_lchs(&dev->qdev, dev->unit ? "/disk@1" : "/disk@0",
+                         dev->conf.lcyls,
+                         dev->conf.lheads,
+                         dev->conf.lsecs);
 }
=20
 static void ide_dev_get_bootindex(Object *obj, Visitor *v, const char *n=
ame,
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 915641a0f1..d19896fe4d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -35,6 +35,7 @@
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/dma.h"
+#include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "trace.h"
=20
@@ -2402,6 +2403,16 @@ static void scsi_realize(SCSIDevice *dev, Error **=
errp)
     blk_set_guest_block_size(s->qdev.conf.blk, s->qdev.blocksize);
=20
     blk_iostatus_enable(s->qdev.conf.blk);
+
+    add_boot_device_lchs(&dev->qdev, NULL,
+                         dev->conf.lcyls,
+                         dev->conf.lheads,
+                         dev->conf.lsecs);
+}
+
+static void scsi_unrealize(SCSIDevice *dev, Error **errp)
+{
+    del_boot_device_lchs(&dev->qdev, NULL);
 }
=20
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
@@ -3006,6 +3017,7 @@ static void scsi_hd_class_initfn(ObjectClass *klass=
, void *data)
     SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(klass);
=20
     sc->realize      =3D scsi_hd_realize;
+    sc->unrealize    =3D scsi_unrealize;
     sc->alloc_req    =3D scsi_new_request;
     sc->unit_attention_reported =3D scsi_disk_unit_attention_reported;
     dc->desc =3D "virtual SCSI disk";
--=20
2.21.0


