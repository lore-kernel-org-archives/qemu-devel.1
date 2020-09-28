Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA559C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE4420756
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="accCgtIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE4420756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMq9j-0004ih-Bs
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kMq8d-0003f9-BN
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:12:07 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kMq8a-0001Rm-FL
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:12:07 -0400
Received: by mail-pj1-x1041.google.com with SMTP id b17so367232pji.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EcaAE9/QEvSGpNwNrLMhItuN/KVCOVDKbhwuItE368U=;
 b=accCgtIVEt7kyhcRhwJzoIqD4dl+Qdyo620dRYLr3yTFvZP5DzNAJMkk/anLO2fd4C
 yImUlSPxSncBMu8Ui7zt46fn1FosRZRw2UulQco5wwrpvBtRjFH5PmkFJ7W3K28HT6AS
 fTzlpsYggcoTkQ35FLmcpaYXT+aqWOuTQMgTDRf2liRGzjdd4U1JRbZ080NJl4IjlySf
 GmTi9PSWr7YmvqYtvX9qx7Bl6XaYiTPhpR4dIArTlp/trBeB3hHOKgUhVpZJY6Pm7WjH
 6RtbfFCr7dHdfF731eZCeXgR9JP8QX9W6LIusYpRyOuV/cKb9VIUEzgUiuYVkMvgKcI5
 9dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EcaAE9/QEvSGpNwNrLMhItuN/KVCOVDKbhwuItE368U=;
 b=hFUMn1Qsx93XKi2vqe/Hio81ryM/y8V+mfARgYASgJ8EzMKFs1rjqYTs4IlKIDCWcd
 6JmlqgwvoGmSlZRtgdU7o1rd37OtvT8pOWLHQBNJVZ5DJ7sPbzBHTcvEFcU3dmVTTDky
 WLGb5FrjyGqNBQfLJx7Njz4306yvm9fISB3kzloqimWm0+En1o4uYxhUhwMMykJQHNEE
 4CY//VGjdlz0BpsNXYTKIFkGKm0X1qtxoX2lnG4HQ9oHtZjDpaUUzT4MCNankhjKZPcs
 WsEqzfZgySBg+g5tWnyOUXuo6MVPK/vf6gWAIyFJGRiR8qg8sBgFLV+4jbuhkaTJU0NN
 pmzg==
X-Gm-Message-State: AOAM532XsAf9pjsron3SDMqpCq3vdS+PTQx3nq1KHVfVbWRVg7yxXHok
 ++B11N8dsPY5vzC+FO/NohKbQTyMH5nkCw==
X-Google-Smtp-Source: ABdhPJweAkynNS0iQmDhVQb7EmBSftbfSG5SyCukTq6sk2TJKVUmQ/Ze04pvAL74/fyvcZLOinteEQ==
X-Received: by 2002:a17:90a:ee0d:: with SMTP id
 e13mr673588pjy.227.1601287922058; 
 Mon, 28 Sep 2020 03:12:02 -0700 (PDT)
Received: from localhost.localdomain (111-241-115-7.dynamic-ip.hinet.net.
 [111.241.115.7])
 by smtp.gmail.com with ESMTPSA id u2sm814747pji.50.2020.09.28.03.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 03:12:01 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v6 2/2] hw/misc/sifive_u_otp: Add backend drive support
Date: Mon, 28 Sep 2020 18:11:46 +0800
Message-Id: <20200928101146.12786-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928101146.12786-1-green.wan@sifive.com>
References: <20200928101146.12786-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=green.wan@sifive.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Green Wan <green.wan@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add '-drive' support to OTP device. Allow users to assign a raw file
as OTP image.

test commands for 16k otp.img filled with zero:

dd if=/dev/zero of=./otp.img bs=1k count=16
./qemu-system-riscv64 -M sifive_u -m 256M -nographic -bios none \
-kernel ../opensbi/build/platform/sifive/fu540/firmware/fw_payload.elf \
-d guest_errors -drive if=none,format=raw,file=otp.img

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/misc/sifive_u_otp.c         | 51 ++++++++++++++++++++++++++++++++++
 include/hw/misc/sifive_u_otp.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 685c1f8e07..f2585c1ed7 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -19,11 +19,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/misc/sifive_u_otp.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/block-backend.h"
 
 #define WRITTEN_BIT_ON 0x1
 
@@ -54,6 +57,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
         if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
             (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
             (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
+
+            /* read from backend */
+            if (s->blk) {
+                int32_t buf;
+
+                blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
+                          SIFIVE_U_OTP_FUSE_WORD);
+                return buf;
+            }
+
             return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
         } else {
             return 0xff;
@@ -145,6 +158,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
             /* write bit data */
             SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
 
+            /* write to backend */
+            if (s->blk) {
+                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
+                           SIFIVE_U_OTP_FUSE_WORD, 0);
+            }
+
             /* update written bit */
             SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
         }
@@ -168,16 +187,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
 
 static Property sifive_u_otp_properties[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
+    DEFINE_PROP_DRIVE("drive", SiFiveUOTPState, blk),
     DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_u_otp_realize(DeviceState *dev, Error **errp)
 {
     SiFiveUOTPState *s = SIFIVE_U_OTP(dev);
+    DriveInfo *dinfo;
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_u_otp_ops, s,
                           TYPE_SIFIVE_U_OTP, SIFIVE_U_OTP_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    dinfo = drive_get_next(IF_NONE);
+    if (dinfo) {
+        int ret;
+        uint64_t perm;
+        int filesize;
+        BlockBackend *blk;
+
+        blk = blk_by_legacy_dinfo(dinfo);
+        filesize = SIFIVE_U_OTP_NUM_FUSES * SIFIVE_U_OTP_FUSE_WORD;
+        if (blk_getlength(blk) < filesize) {
+            error_setg(errp, "OTP drive size < 16K");
+            return;
+        }
+
+        qdev_prop_set_drive_err(dev, "drive", blk, errp);
+
+        if (s->blk) {
+            perm = BLK_PERM_CONSISTENT_READ |
+                   (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
+            ret = blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
+            if (ret < 0) {
+                return;
+            }
+
+            if (blk_pread(s->blk, 0, s->fuse, filesize) != filesize) {
+                error_setg(errp, "failed to read the initial flash content");
+            }
+        }
+    }
 }
 
 static void sifive_u_otp_reset(DeviceState *dev)
diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
index ebffbc1fa5..5d0d7df455 100644
--- a/include/hw/misc/sifive_u_otp.h
+++ b/include/hw/misc/sifive_u_otp.h
@@ -46,6 +46,7 @@
 
 #define SIFIVE_U_OTP_PA_MASK        0xfff
 #define SIFIVE_U_OTP_NUM_FUSES      0x1000
+#define SIFIVE_U_OTP_FUSE_WORD      4
 #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
 
 #define SIFIVE_U_OTP_REG_SIZE       0x1000
@@ -80,6 +81,7 @@ struct SiFiveUOTPState {
     uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
+    BlockBackend *blk;
 };
 
 #endif /* HW_SIFIVE_U_OTP_H */
-- 
2.17.1


