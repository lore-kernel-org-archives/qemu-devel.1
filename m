Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF5C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839CA217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IEuYGP1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839CA217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Woc-0006td-A3
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36776)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <34uhkXQYKCjknVhZdYbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--sameid.bounces.google.com>)
 id 1i2Wmr-00054C-Qb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <34uhkXQYKCjknVhZdYbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--sameid.bounces.google.com>)
 id 1i2Wmq-0007vf-96
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:09 -0400
Received: from mail-vk1-xa49.google.com ([2607:f8b0:4864:20::a49]:39635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <34uhkXQYKCjknVhZdYbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--sameid.bounces.google.com>)
 id 1i2Wmq-0007u8-3o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:08 -0400
Received: by mail-vk1-xa49.google.com with SMTP id f188so5261199vkh.6
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jN/yicpY7TigP5XcFMtmhHBGVv+suQiHAOiD2OyYqr4=;
 b=IEuYGP1UzR9GmAOQvs6wszqOm67fQV5xbra/fTG6H9lBMIifIVR1AoVJqopc0NoDpp
 LNC2SDKS2H7nMwMmjNufMtMeAKW9+6wMv7PNl9PdaiYdtixHZRftwPPdxvJW7q6bcjNX
 PV0pBH6yPos+qkHTPE0y8BHsxo7g6V4UW4IZftlP0+vKXSCsoKudrMvHkJLxUUgjRqFe
 Q5JDz10s5qpR0ouAgOlsVtXBB9qvWsPvzTfLaq7GpseWN/FZzCqtk+mCjq3JPvKRFp2d
 tlW6YbVvammZjcYC949qch2kG5KiSUyyNUaHO79osO+ESmVwYYXOc0Vx1mmG3+czJB6E
 3atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jN/yicpY7TigP5XcFMtmhHBGVv+suQiHAOiD2OyYqr4=;
 b=GgSFPQmdu5Q3C+zFAP/5Am+UmEgp5gmTZI79/Sune+AjhQ1EeWZ4mGqGyqHaT9SoP4
 htmswMVce5+okXaNN5gHte1VrrNUftQm4EazGmjqULm7Zs/ByqYGN0G5e+9JHbF3YHHe
 mVaxbGNJD6RNnGP7vbv6rLhEflJbSNgZC74Us2YlcL55hgUMT7ehJDjPeXKJQaFB57CV
 lY8JfVm0PGKuEH4GZFv+pLpR2t5S79vVY5Vh9bM6lg0sExvYLfmkvCG1+YNAbozpkKym
 jdIIgbSFE/Xj6gmth9neCDM1OnoR2523emovIF7Ldj++7+rE/fZZ4aoHNLBY2iaslObw
 b4Cw==
X-Gm-Message-State: APjAAAUksOfu50c8t28j5ZQhDeE/rJGxxSNdoIXPKXuUcD8C2TWRPAyJ
 vN1XeecMt/d9sl0krCfb8KLvXZkOTyvnRKu0DKqEXqiF6/yrb9b3028QwLh3kXpdZ6Ae3fQb/yG
 /NYCAKpnZJ+n+fUfFceX5KwSNNH2PsQO7C3dyn5xP2HHHLHJBm2InNpYLoWjD
X-Google-Smtp-Source: APXvYqzAioivcnN3mUVRflxxjbKcHiHwkJ3YyF3OqEk6fCxi59fK3/wUm2jlkYxZDD1nV6F5iTtCZssGF3s=
X-Received: by 2002:a67:f4ce:: with SMTP id s14mr1734968vsn.107.1566894306627; 
 Tue, 27 Aug 2019 01:25:06 -0700 (PDT)
Date: Tue, 27 Aug 2019 11:24:24 +0300
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Message-Id: <20190827082427.64280-6-sameid@google.com>
Mime-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a49
Subject: [Qemu-devel] [PATCH v6 5/8] bootdevice: Gather LCHS from all
 relevant devices
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Arbel Moshe <arbel.moshe@oracle.com>, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, sameid@google.com,
 karl.heubaum@oracle.com
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
---
 hw/block/virtio-blk.c |  6 ++++++
 hw/ide/qdev.c         |  5 +++++
 hw/scsi/scsi-disk.c   | 12 ++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 18851601cb..6d8ff34a16 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1186,6 +1186,11 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);
 
     blk_iostatus_enable(s->blk);
+
+    add_boot_device_lchs(dev, "/disk@0,0",
+                         conf->conf.lcyls,
+                         conf->conf.lheads,
+                         conf->conf.lsecs);
 }
 
 static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
@@ -1193,6 +1198,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
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
 
@@ -2402,6 +2403,16 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
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
@@ -3006,6 +3017,7 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
 
     sc->realize      = scsi_hd_realize;
+    sc->unrealize    = scsi_unrealize;
     sc->alloc_req    = scsi_new_request;
     sc->unit_attention_reported = scsi_disk_unit_attention_reported;
     dc->desc = "virtual SCSI disk";
-- 
2.23.0.187.g17f5b7556c-goog


