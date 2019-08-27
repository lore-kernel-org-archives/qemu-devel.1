Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BBBC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2C22053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OZK5x3Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2C22053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2WrO-0001uU-Jp
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36729)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <33uhkXQYKCjUjRdVZUXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--sameid.bounces.google.com>)
 id 1i2Wmn-0004xm-5c
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <33uhkXQYKCjUjRdVZUXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--sameid.bounces.google.com>)
 id 1i2Wml-0007rJ-VI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:05 -0400
Received: from mail-vs1-xe4a.google.com ([2607:f8b0:4864:20::e4a]:54520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <33uhkXQYKCjUjRdVZUXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--sameid.bounces.google.com>)
 id 1i2Wml-0007qu-QM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:03 -0400
Received: by mail-vs1-xe4a.google.com with SMTP id x20so4629511vsq.21
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ouYipv769+h8e/fgBXMjwvu10/GoLSDxKV1jgFaYSYQ=;
 b=OZK5x3Fd1PnNWB8XFa6+t0GhQSAafiN3+wjVjpeVDi82xq4mw3BznjsdOwaui7Q7FU
 /lby9N/5iPWEcXuyRDwjzSf24JHG3nShNi3t6a1xTnwhRn5Bo+JCxcau9EgC5qVynjO2
 kSprrOVI3zOMz/5UlkH/hEqKy0lBAfsAwLcrqb1+4tRv+4cKjo0l96sHSDQ6BW1eGexF
 Gdrs9e/Eyixb7Y+Z5ZgCSmL+MQW2ftfDTKT1xVGnd3s+FS3xL81htHf+ZkPFWPiG3Ch+
 ner1i4lcC4B/2jKVkeK8sCdiCpDQTO1+FfvNZVG88pH6FJOS3ZKKtw5KcI3OU6Ac9C4A
 oC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ouYipv769+h8e/fgBXMjwvu10/GoLSDxKV1jgFaYSYQ=;
 b=Y4pNhFJ1CssR22CG0xPHU8dw/IhU2YUAUJPEbVyATmORY6cIDzFtNwomvEU0UrelfI
 fcTL8NWTxVpQhdlSMD2nUBqg+/sLJ+pbGvOwqaYYZokQgEs/VKKqnLA7DoHBHrmcUmqt
 AlyemV8YBJ2AUBKUjo4229mNf1FyvpP7W7YsBE0cnGvFbo278GzWKvAi5xGQLYi3oM5I
 HBsfSGy+csCNKfy6BlxfPlGOxQMsQPfAkaZApFAmaTgneNf84Yl6tkdmguCO6jbeRpDY
 PlBG/rwdrNC+i0Sz/rBz1/S9xFVXsxZdN3Wj30GS3wsCPhjig2gaA3LaMOvjY4j0HVEW
 7D+A==
X-Gm-Message-State: APjAAAVLpnKwCIlHZwXNVCiDwfhp2h/lWjjpBcrM+WrgnSRO6Tr2bwF9
 g+zIHwHf19cmJJCMO36iMa1eUKE3jXhtisUzk8kuArZOOCW1gSwhzW/34FHSqT1nblVXYBHmfYs
 KLhZ07HGVCwanvYF+Gj4rrmAr71csQJl7VDDiDLpEOKmyBWn7c6NxVEA/eIHI
X-Google-Smtp-Source: APXvYqxJyxCreTVb4T4qwuVvr8uxbPKYUuU2j7I64MDeyOlT2mUoUzmHr++PAL4FJTRHEHXfj5RPdgjIiZk=
X-Received: by 2002:ab0:73da:: with SMTP id m26mr10195338uaq.119.1566894302143; 
 Tue, 27 Aug 2019 01:25:02 -0700 (PDT)
Date: Tue, 27 Aug 2019 11:24:23 +0300
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Message-Id: <20190827082427.64280-5-sameid@google.com>
Mime-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e4a
Subject: [Qemu-devel] [PATCH v6 4/8] scsi: Propagate unrealize() callback to
 scsi-hd
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
2.23.0.187.g17f5b7556c-goog


