Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB7FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4430C21835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHgoxQo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4430C21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmYw-0005oj-EL
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36195)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3a0inXQYKCow8q2uytw44w1u.s426u2A-tuBu1343w3A.47w@flex--sameid.bounces.google.com>)
 id 1iKmNS-0004G3-MK
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3a0inXQYKCow8q2uytw44w1u.s426u2A-tuBu1343w3A.47w@flex--sameid.bounces.google.com>)
 id 1iKmNR-0006Gf-DD
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:22 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449]:44629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3a0inXQYKCow8q2uytw44w1u.s426u2A-tuBu1343w3A.47w@flex--sameid.bounces.google.com>)
 id 1iKmNR-0006GD-6e
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:21 -0400
Received: by mail-wr1-x449.google.com with SMTP id n18so11968366wro.11
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jJrGsmisejq5BsmJhJyozl1VGOARUm605lXC7WQlSTg=;
 b=aHgoxQo67NIvAoSPLJkyoj+01YpH2YXalQ4j0UhVjNZahodZomhJ/keI6DhLY4qFwD
 Jvg2RmqryBx7dyzjgkpSqupqneWhrzQIGess1aTTh92aGpHzkrpKWHf7lmpu3GzCyrnV
 BkJSYNa4EKX3TWYntRA8T0gOZ3FaOTJp7m/J5cbOqBZKv1nSrbA9c9Pf7OGb0abZ1bo3
 cw9+SzRw7eypvXl2W4rUjGVlVDd6RTF+0R890XAWTd1h1Ns8yAeRRbbOx6FoHpqMEykN
 GWGeTorSj2XZmFsJOEQvpsurkFwFAWD70u165hMqbizTEl3OiDEOJcBWXmg91v/sQESj
 NPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jJrGsmisejq5BsmJhJyozl1VGOARUm605lXC7WQlSTg=;
 b=gDbjurDRZtI2sL+ccCnA+XSH3OIhQ97ikPrRdPDzWtEbREFZb5jaqBiBi90h85G1Km
 XtrDeKjyhuIyJ1JONdGsHlE60EGDa1eM480WnTE/sY3ro9SdCBmeMOP4BKYS8EgqZa+G
 3UkLNrxu73eH9X45ewBe+TymmWdabKeRRQFZAbgdC0LIp3ybpgGHALI02C1VfOKwx2vv
 JQ694kfFwQ6yoOoXYYuC+OtVauUIp7yfs7NfqSd1CJJMvnCfUgqfZqEywQnAoVgSh8nN
 6y4OLsTwV0bVCKBMyOf4jJr9zbLBAt+Az2suj1d4svttdBD9MZrRs5zCBqOEIjc5hhQO
 T3wA==
X-Gm-Message-State: APjAAAUrhQe+LnO9YLdIAn43hhK0+wkKnH3H7lVh/i60U2mzUxlEiwtI
 SbWG/p4RKdUnaeOzKfJv98UfLf77xHQMma7huNOzmTRRm3R2nTlwkQPFTjH/VlaDehXwUvjZzWW
 0fgImD7K3I7pzCewSzT6r42nGbIdk/CroV4FtUoj8br87CSxTUBSFfLc14lQr
X-Google-Smtp-Source: APXvYqwkPk5TVkSLUX7xLsbZdrT7MnLsYXIq2aWqw8O3FzmohrA54NQSI9AF2ixkTUOWttMkSZgWPu9Fg1Y=
X-Received: by 2002:adf:fcd2:: with SMTP id f18mr3847264wrs.388.1571244139969; 
 Wed, 16 Oct 2019 09:42:19 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:41:42 +0300
In-Reply-To: <20191016164145.115898-1-sameid@google.com>
Message-Id: <20191016164145.115898-7-sameid@google.com>
Mime-Version: 1.0
References: <20191016164145.115898-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v8 5/8] bootdevice: Gather LCHS from all relevant devices
From: Sam Eiderman <sameid@google.com>
To: qemu-devel@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, kevin@koconnor.net, 
 kraxel@redhat.com, kwolf@redhat.com, liran.alon@oracle.com, 
 qemu-block@nongnu.org, sameid@google.com, seabios@seabios.org, 
 lersek@redhat.com, philmd@redhat.com, jsnow@redhat.com, 
 Sam Eiderman <shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::449
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
---
 hw/block/virtio-blk.c |  6 ++++++
 hw/ide/qdev.c         |  5 +++++
 hw/scsi/scsi-disk.c   | 12 ++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ed2ddebd2b..c56e905f80 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1200,6 +1200,11 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);
 
     blk_iostatus_enable(s->blk);
+
+    add_boot_device_lchs(dev, "/disk@0,0",
+                         conf->conf.lcyls,
+                         conf->conf.lheads,
+                         conf->conf.lsecs);
 }
 
 static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
@@ -1207,6 +1212,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
 
+    del_boot_device_lchs(dev, "/disk@0,0");
     virtio_blk_data_plane_destroy(s->dataplane);
     s->dataplane = NULL;
     qemu_del_vm_change_state_handler(s->change);
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6dd219944f..2ffd387a73 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -220,6 +220,11 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 
     add_boot_device_path(dev->conf.bootindex, &dev->qdev,
                          dev->unit ? "/disk@1" : "/disk@0");
+
+    add_boot_device_lchs(&dev->qdev, dev->unit ? "/disk@1" : "/disk@0",
+                         dev->conf.lcyls,
+                         dev->conf.lheads,
+                         dev->conf.lsecs);
 }
 
 static void ide_dev_get_bootindex(Object *obj, Visitor *v, const char *name,
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
 
@@ -2414,6 +2415,16 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     blk_set_guest_block_size(s->qdev.conf.blk, s->qdev.blocksize);
 
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
 
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
@@ -3018,6 +3029,7 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
 
     sc->realize      = scsi_hd_realize;
+    sc->unrealize    = scsi_unrealize;
     sc->alloc_req    = scsi_new_request;
     sc->unit_attention_reported = scsi_disk_unit_attention_reported;
     dc->desc = "virtual SCSI disk";
-- 
2.23.0.700.g56cf767bdb-goog


