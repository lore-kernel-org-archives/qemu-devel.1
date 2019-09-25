Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF21C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFC5214D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="itCwXwjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFC5214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5Iz-0001hm-1o
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44859)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3U0qLXQYKCgg0iumqlowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--sameid.bounces.google.com>)
 id 1iD58R-000831-1z
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3U0qLXQYKCgg0iumqlowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--sameid.bounces.google.com>)
 id 1iD58P-0004Tu-QA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:02 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a]:55102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3U0qLXQYKCgg0iumqlowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--sameid.bounces.google.com>)
 id 1iD58P-0004Sv-FM
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:01 -0400
Received: by mail-wr1-x44a.google.com with SMTP id z1so2172327wrw.21
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=7sLdv/qenkIM9QFawRYLGJz07khj1BZO3MCkag3rnZQ=;
 b=itCwXwjF4HKp1ICF6u3BN3A5+ZtwlWC6Eq2uxgit+woEDyX2oSLgiiK4vxSEDQslOI
 aXV3EkzwgzVG8QY8YVYqfbJoanaukt8YsfJnzmdrz2Ynm11oDdynnLgGyL4cVDuq2JQc
 b8fQfcsYto11MzGaezOWLcf46EbxRkg74VPLv0Imxig+fyvNyz6w80igSHKwU1Xx2yit
 D50lPa9P9K81uayNbNiyB7VZqClZhy3GLdmCHvXo4ZHOyF1EQrOxagMdy7M8AG+nGRLs
 UFiFczzfkAQu+qUePLob1YEV7yKM1UVhS4PU1am/rVQK2d/cq3x6wsOsKOkLjzEV4fX1
 wKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=7sLdv/qenkIM9QFawRYLGJz07khj1BZO3MCkag3rnZQ=;
 b=Pwv8yCfxv7jAjBCNyVvKdoCbkk6CUum72gCeYRUwQke8bhLb06K+nLwWwsdlRkX2hT
 0MsY72fdtYIxgmwQiUZ3P2HKocX7u4G7yo6XqCE5nAm2TqNNR2HUNPVH+nv8hLH84KlZ
 p/fl+HNP2lfeim5XXqK+gKjkLy2e4R1CK0XUsCoXsxtC6RY0HmkjHkFlY+gX8zjJJo+T
 kV8XmO4TjzznenULOJCV7/79HpOAUIfUCHpx7Lf3lDxPwYUU+RBBnccQfVweyng0obfz
 Ty3R87FotaQEJ+/3DsbvqpHXZAcCsX9NE1Ds6LVNhNmfY8ByLfr9vKWZ8jS3j9NpNN9J
 FFuQ==
X-Gm-Message-State: APjAAAVwwGv/qxAqWu0z44axyBGGnNqXFdnPCzZezqxjmxocSJZxJAZJ
 y8Scf3iFc11coBXd/ylSXepxtr86ep0re2dKv8uoNjzw+VsUOqKSsaAgYSD3j3PO0pE2vjHZ+Kn
 Bi9wedbHuRXlAY1mDrYFXriVkDsDPhUK1fxylm+az2XCrvJ4R/swvVRz9oWvz
X-Google-Smtp-Source: APXvYqwC2WZJOZmBBYlq0W2s0Z/KfuBqPF7r3H4ghdG6zJOxTM/8lCvcoKyM6HmFJYuBGAMAsGAOJ4UArDA=
X-Received: by 2002:adf:ed88:: with SMTP id c8mr9195400wro.329.1569409619883; 
 Wed, 25 Sep 2019 04:06:59 -0700 (PDT)
Date: Wed, 25 Sep 2019 14:06:35 +0300
In-Reply-To: <20190925110639.100699-1-sameid@google.com>
Message-Id: <20190925110639.100699-5-sameid@google.com>
Mime-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v7 4/8] scsi: Propagate unrealize() callback to scsi-hd
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::44a
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

We will need to add LCHS removal logic to scsi-hd's unrealize() in the
next commit.

Signed-off-by: Sam Eiderman <sameid@google.com>
Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 hw/scsi/scsi-bus.c     | 16 ++++++++++++++++
 include/hw/scsi/scsi.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index bccb7cc4c6..359d50d6d0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -59,6 +59,14 @@ static void scsi_device_realize(SCSIDevice *s, Error **errp)
     }
 }
 
+static void scsi_device_unrealize(SCSIDevice *s, Error **errp)
+{
+    SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
+    if (sc->unrealize) {
+        sc->unrealize(s, errp);
+    }
+}
+
 int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                        void *hba_private)
 {
@@ -217,12 +225,20 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
 static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev = SCSI_DEVICE(qdev);
+    Error *local_err = NULL;
 
     if (dev->vmsentry) {
         qemu_del_vm_change_state_handler(dev->vmsentry);
     }
 
     scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
+
+    scsi_device_unrealize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     blockdev_mark_auto_del(dev->conf.blk);
 }
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index d77a92361b..332ef602f4 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -59,6 +59,7 @@ struct SCSIRequest {
 typedef struct SCSIDeviceClass {
     DeviceClass parent_class;
     void (*realize)(SCSIDevice *dev, Error **errp);
+    void (*unrealize)(SCSIDevice *dev, Error **errp);
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      void *hba_private);
     SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t lun,
-- 
2.23.0.351.gc4317032e6-goog


