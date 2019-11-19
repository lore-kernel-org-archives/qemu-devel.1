Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D98C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E85223AC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9t7UvUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E85223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6CG-00034P-91
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63u-000207-DQ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63t-00068v-4e
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:34951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63s-00068T-UQ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id 8so4365562wmo.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=84AXGKd0a/dx96HO4dm8J3dMCUNzIh5I2fM2rW+So9Q=;
 b=r9t7UvUho1TLYTzhudNOQXO1MyL4i6b472qsm9NP4KyC8Qmel6V9mSn44HLQ3y+ad+
 9XUizctHpcdGPPM4+S3yAdgzVyGPNGXZyYJvQ0HomOUW7OH8YECbkYTnA0HZYSZU/VMX
 FwXy+OriSXo211ibrgvT5fD4Cy7IEgxMp+jNwo5cj4NIn95UMweX0do2SVHzWBB6bCH2
 sWnIpWvlJTQ/U5w+PQmDk86XObyKmXetHqD0tRw0mIyM9WvZgUE6/kllPsg0lypSQQ8M
 9lzlpBJIowd0LgqTpY5N25EU0xTN0tMKDpw0WvQlnHrSl6Zi+xL1mrJp7Ppq6keKkSFS
 Q+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=84AXGKd0a/dx96HO4dm8J3dMCUNzIh5I2fM2rW+So9Q=;
 b=eqglkvCOS9rTGO8XTekxJdMkcYtC29uYHjolo02U8LJC7Qkyxhg7Sj7f4ZhnJ82ktH
 SPekfHwikV25ZQNcakriIzH+7WWS+9kEHWR6DWKdqdcdq+BxVh7S2hQGD3cIj7e/RlIY
 WWUvBZP3GiCuB4NfCwCj7kWyaZkPNauCXzZjWcS9nnQcaD4vEV/xh28cRottUgwSG7lG
 MiW0h2896/MyBjOJCPkK1JcWm/pi6GRoYjBj+OZu5HMk1eiUYw0DPlnxbfwg7MEhdCMh
 F1q6IKMyaAU5+FkNyZx0HBOT8ozK3tbhSFFM2grvtS0n1eJKcMtIIRG6z/4EWd7GjKju
 im/Q==
X-Gm-Message-State: APjAAAUJmGhkLfgr1ivqf3DPotIDQj0lkDPDDoA6PdWZ9aSyxrJJUkk7
 NXZYy27Lx/JPNr7XRIvhiA7WuBYX
X-Google-Smtp-Source: APXvYqz7sECQOk7FW+4B8rlMM0MNLEtlzN10BBIM68Zd6gQxsMix+IIQmNDrQnn2ORhGp1YDbbE9wQ==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr6809842wmc.130.1574179743560; 
 Tue, 19 Nov 2019 08:09:03 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.09.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:09:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] scsi: deprecate scsi-disk
Date: Tue, 19 Nov 2019 17:08:46 +0100
Message-Id: <1574179728-35535-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

It's an old compatibility shim that just delegates to scsi-cd or scsi-hd.
Just like ide-drive, we don't need this.

Acked-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c            | 12 +++++++++++-
 hw/scsi/scsi-disk.c           |  3 +++
 qemu-deprecated.texi          |  5 +++++
 tests/qemu-iotests/051.pc.out |  6 ++++--
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 359d50d..ad0e7f6 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -254,8 +254,18 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     char *name;
     DeviceState *dev;
     Error *err = NULL;
+    DriveInfo *dinfo;
 
-    driver = blk_is_sg(blk) ? "scsi-generic" : "scsi-disk";
+    if (blk_is_sg(blk)) {
+        driver = "scsi-generic";
+    } else {
+        dinfo = blk_legacy_dinfo(blk);
+        if (dinfo && dinfo->media_cd) {
+            driver = "scsi-cd";
+        } else {
+            driver = "scsi-hd";
+        }
+    }
     dev = qdev_create(&bus->qbus, driver);
     name = g_strdup_printf("legacy[%d]", unit);
     object_property_add_child(OBJECT(bus), name, OBJECT(dev), NULL);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 07fb5eb..e44c61e 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2481,6 +2481,9 @@ static void scsi_disk_realize(SCSIDevice *dev, Error **errp)
     DriveInfo *dinfo;
     Error *local_err = NULL;
 
+    warn_report("'scsi-disk' is deprecated, "
+                "please use 'scsi-hd' or 'scsi-cd' instead");
+
     if (!dev->conf.blk) {
         scsi_realize(dev, &local_err);
         assert(local_err);
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 296bfc9..4b4b742 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -259,6 +259,11 @@ their usecases.
 The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
 'ide-cd' as appropriate to get an IDE hard disk or CD-ROM as needed.
 
+@subsection scsi-disk (since 4.2)
+
+The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
+'scsi-cd' as appropriate to get a SCSI hard disk or CD-ROM as needed.
+
 @section System emulator machines
 
 @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 34849dd..0ea80d3 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -167,7 +167,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=none,id=disk -device lsi53c895a -device scsi-disk,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-disk,drive=disk: Device needs media, but drive is empty
+(qemu) QEMU_PROG: -device scsi-disk,drive=disk: warning: 'scsi-disk' is deprecated, please use 'scsi-hd' or 'scsi-cd' instead
+QEMU_PROG: -device scsi-disk,drive=disk: Device needs media, but drive is empty
 
 Testing: -drive if=none,id=disk -device lsi53c895a -device scsi-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -238,7 +239,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-disk,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+(qemu) QEMU_PROG: -device scsi-disk,drive=disk: warning: 'scsi-disk' is deprecated, please use 'scsi-hd' or 'scsi-cd' instead
+quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
1.8.3.1



