Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D57CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0902E2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8uLPOS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0902E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQD3V-0005ep-Ft
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iQCr9-0007R9-5D
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iQCr7-0000qi-Et
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:59:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iQCr7-0000px-Bp
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572537565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=507E8locfzYS/XdJbIJy4ZRsi9XumUYC/TA/C4dmmd0=;
 b=f8uLPOS5f77uAbpv66XB7pli2fSHZPHy62BZ2ns4Ki/VAYjJXdzJeG2HadPqhZYJmCuCU1
 kc5lsteA60Es3MXZfayuXANphMpMdk61v92oBkBnG2OsWm1nfzJJPimLMZ8PxMRRsZtROc
 l9yuS1fd6pup4l2RGg5hqBeKQYfOZYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-40ndKEb-PqWNvR1mqW7RSA-1; Thu, 31 Oct 2019 11:59:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 900B22EDC;
 Thu, 31 Oct 2019 15:59:18 +0000 (UTC)
Received: from probe.redhat.com (ovpn-126-19.rdu2.redhat.com [10.10.126.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CB24600CD;
 Thu, 31 Oct 2019 15:58:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 6/9] bootdevice: Gather LCHS from all relevant devices
Date: Thu, 31 Oct 2019 11:56:33 -0400
Message-Id: <20191031155636.18589-7-jsnow@redhat.com>
In-Reply-To: <20191031155636.18589-1-jsnow@redhat.com>
References: <20191031155636.18589-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 40ndKEb-PqWNvR1mqW7RSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Arbel Moshe <arbel.moshe@oracle.com>, Laszlo Ersek <lersek@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Sam Eiderman <shmuel.eiderman@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sam Eiderman <sameid@google.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
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

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Sam Eiderman <sameid@google.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/block/virtio-blk.c |  6 ++++++
 hw/ide/qdev.c         |  5 +++++
 hw/scsi/scsi-disk.c   | 12 ++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9fa2eaf890..4c357d2928 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1200,6 +1200,11 @@ static void virtio_blk_device_realize(DeviceState *d=
ev, Error **errp)
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
@@ -1210,6 +1215,7 @@ static void virtio_blk_device_unrealize(DeviceState *=
dev, Error **errp)
     unsigned i;
=20
     blk_drain(s->blk);
+    del_boot_device_lchs(dev, "/disk@0,0");
     virtio_blk_data_plane_destroy(s->dataplane);
     s->dataplane =3D NULL;
     for (i =3D 0; i < conf->num_queues; i++) {
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 85cca6ec38..374a791a45 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -220,6 +220,11 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKin=
d kind, Error **errp)
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
 static void ide_dev_get_bootindex(Object *obj, Visitor *v, const char *nam=
e,
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 68b1675fd9..07fb5ebdf1 100644
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
@@ -2414,6 +2415,16 @@ static void scsi_realize(SCSIDevice *dev, Error **er=
rp)
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
@@ -3018,6 +3029,7 @@ static void scsi_hd_class_initfn(ObjectClass *klass, =
void *data)
     SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(klass);
=20
     sc->realize      =3D scsi_hd_realize;
+    sc->unrealize    =3D scsi_unrealize;
     sc->alloc_req    =3D scsi_new_request;
     sc->unit_attention_reported =3D scsi_disk_unit_attention_reported;
     dc->desc =3D "virtual SCSI disk";
--=20
2.21.0


