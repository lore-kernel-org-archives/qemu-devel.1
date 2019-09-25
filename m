Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2867C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE492082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="q/CdKGwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE492082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5B0-0001uc-CM
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44878)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3WEqLXQYKCg05nzrvqt11tyr.p1z3rz7-qr8ry010t07.14t@flex--sameid.bounces.google.com>)
 id 1iD58U-000888-Tm
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3WEqLXQYKCg05nzrvqt11tyr.p1z3rz7-qr8ry010t07.14t@flex--sameid.bounces.google.com>)
 id 1iD58T-0004WF-Fx
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:06 -0400
Received: from mail-ua1-x94a.google.com ([2607:f8b0:4864:20::94a]:39687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3WEqLXQYKCg05nzrvqt11tyr.p1z3rz7-qr8ry010t07.14t@flex--sameid.bounces.google.com>)
 id 1iD58T-0004Vo-Bn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:05 -0400
Received: by mail-ua1-x94a.google.com with SMTP id 93so921436uav.6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ntmhuLh/qhZlaDmWWEGtABSx++pJ8zRHlQJB1iBCCeM=;
 b=q/CdKGwK2P4ra3icnbeFpba2duuZbeziNYIlBj+Vfz2LnHK1YCNe5yqzkUQwWLgATF
 uG/jqgQEBJrvKzj3i0g1ixNc6vidFsENKXdJHQOTq27BvZ3zDBIyJQsy4++2BbMWsTNa
 0YWytQ6Awb1sc7N2hu55ceLKE+VN9TQ6xM88gaqrW0CcgdL5WY7Nxp9ZBngMa7OfjxnD
 gD95B1ZsJayLzazoVyFAccyfJP/niv+1Ejjv46A9njNDgCQA2FacqYJCgc9PhZht5vph
 NVJV3grRPMuMqMtDerVYCL38VzQG3f+RGZdaf9eMfhapjLQUEIf7O0cRrKy6jo5nnxEh
 ZCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ntmhuLh/qhZlaDmWWEGtABSx++pJ8zRHlQJB1iBCCeM=;
 b=uDg0POzC9QtuEOIsFHFIOrkXwianBLVh+uNcezBQgFwoW2Dn163Sk4mAWHBMob/DWy
 UqJF0kK6Ek9TGEQwkq/AAU6Y4Qh+HG2sOmD8oh0eVdXo8PiQA/espuksq71ZQzbeIYGD
 KXpAHTCjuv1KOJexM/GU64JVtMUflmWCS690IB3tiqOCC5Rp0FBiVeo1nbq5LfF4U6/F
 SdoyicETVjo9eqB9ojFoNgVonz0QrEMRQPeoL6J5O669GXz2MjIFH+Uo/iWZkHpBb85G
 6r80T+daiwvpg2+pMc6+Rs/fdmKfijsTa7bgS0ex8ECphlyQB3DNmTYMxEuwZyhdD0Pi
 jhrQ==
X-Gm-Message-State: APjAAAVBlexpsqAqFTBk8oxIyvpSY3rYKj1DPH+/Yf2hXDukjOUuB3m7
 iwKn8kPmePuv9FiMYC/9nUeSwOczED7b1KpPfAc9UpvamkMiEthTFpzPeTsPa61iwYePAbG5hOo
 0RFj5k/0UBAexd+jOV+Xp2OXOnA+dLFkzVDCNcOP9ytBp75wSgbRuqissGyNa
X-Google-Smtp-Source: APXvYqwaOgOMNGzT7SpCpTtc42b1qzyS0/7xnmjCYyEE0vSlKawb/cT6s0tjvMgul/wpb0gYMJmUMncXhps=
X-Received: by 2002:a1f:19d8:: with SMTP id 207mr2064708vkz.54.1569409624300; 
 Wed, 25 Sep 2019 04:07:04 -0700 (PDT)
Date: Wed, 25 Sep 2019 14:06:36 +0300
In-Reply-To: <20190925110639.100699-1-sameid@google.com>
Message-Id: <20190925110639.100699-6-sameid@google.com>
Mime-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v7 5/8] bootdevice: Gather LCHS from all relevant devices
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::94a
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, kevin@koconnor.net, liran.alon@oracle.com,
 kraxel@redhat.com, Sam Eiderman <shmuel.eiderman@oracle.com>,
 sameid@google.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Sam Eiderman <sameid@google.com>
From: Sam Eiderman via <qemu-devel@nongnu.org>

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
2.23.0.351.gc4317032e6-goog


