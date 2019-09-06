Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E8FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25272082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhhf/YyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25272082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HFv-0000YC-A7
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gys-0004qg-3Z
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyp-0004bc-QK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:01 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6Gyn-0004ZR-D2; Fri, 06 Sep 2019 12:20:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id t1so3365714plq.13;
 Fri, 06 Sep 2019 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=c5K2gaTJfUjFgYGSZaUE8Ni+ud+kTdfF2ZoIRZwvUdY=;
 b=qhhf/YyRH0en3PST2au5TGvM3bZULYjBBQ0eFHGfmbppr/CnMVx4wxd0NlK4wtVahJ
 x9HUru5P6QM/EFqtnMtRRwj7ovj/uIapN8dCRqcPVztmyDNrAvjBQL4hdK2hdIDjTva/
 mW168BUFIBmxxmmnI3kR5yxm0OavPbNphCNP7CSryRW8dPyHG+fc/7jlSZqj6uHhzOPL
 hsMGe2bJW6qURsqcIGcwuskGteLWdX8FsOJ2BNAgMhcW2wcwKH3jKFZ40TTBMCE1etPo
 5ks4iFAV7QX54GQQ13lB1IW+EaZhGgUpE78x/RebuGsLo+SiA+X/UZxyGnw5q0oY5xoX
 JAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=c5K2gaTJfUjFgYGSZaUE8Ni+ud+kTdfF2ZoIRZwvUdY=;
 b=Ett2gSCr8oDu3OjAkye98Hq9iBbH5WnsKpyRi133sFCVx+UOGj3Tl0Ax95ryYOKMBB
 Up0s/MDBxI+yECybkn50xjDD6mTPKDnn1w18txzt76vz/Mk9r3l4T32DLHIQv0Lqq09J
 U8a4E6Wu+a9RVVkEegFoxJX1VfNOUcN5dZY6meVjJxSyCE0+jgYQUS/pRjuBAn7ZGtY1
 6s1xsUPrkUuK9O9WOvoXV+QeyiR+ml/yl6uQk36puSEqoKjO6ZFFNVan7acjkiurURAz
 zi6bA5ZfF5T/jQcPgkQnXAru5QSBci6wg3VzPeDeCxTFnMgAf0hd42dY7UbbjLRyO0V8
 IJ6A==
X-Gm-Message-State: APjAAAW/kXItICtO6AXQQwEmTSkXbsLDIXejy918Ii7yp2luPxlU045H
 U7N398WiP2j+DpSfBmYJjtw=
X-Google-Smtp-Source: APXvYqyPMcw2jTZKqMGzzwaJh0ryN57gCc6/ATH4w2hZIxH34YBdqcowlfwSZiZ0EZRRJVJr5tq+cg==
X-Received: by 2002:a17:902:7483:: with SMTP id
 h3mr9869570pll.163.1567786855146; 
 Fri, 06 Sep 2019 09:20:55 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.53
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:54 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:16 -0700
Message-Id: <1567786819-22142-30-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v8 29/32] riscv: sifive_u: Instantiate OTP
 memory with a serial number
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

This adds an OTP memory with a given serial number to the sifive_u
machine. With such support, the upstream U-Boot for sifive_fu540
boots out of the box on the sifive_u machine.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5:
- create sifive_u_otp block directly in the machine codes, instead
  of calling sifive_u_otp_create()

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c         | 9 +++++++++
 include/hw/riscv/sifive_u.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5ca3793..4803e47 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,6 +10,7 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  * 3) PRCI (Power, Reset, Clock, Interrupt)
+ * 4) OTP (One-Time Programmable) memory with stored serial number
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -64,10 +65,12 @@ static const struct MemmapEntry {
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
+    [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
 
+#define OTP_SERIAL          1
 #define GEM_REVISION        0x10070109
 
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
@@ -422,6 +425,9 @@ static void riscv_sifive_u_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "prci", &s->prci, sizeof(s->prci),
                           TYPE_SIFIVE_U_PRCI);
+    sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
+                          TYPE_SIFIVE_U_OTP);
+    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
 }
@@ -498,6 +504,9 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
+    object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
+
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
         plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
     }
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 7dfd1cb..4d4733c 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -23,6 +23,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
 #include "hw/riscv/sifive_u_prci.h"
+#include "hw/riscv/sifive_u_otp.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
@@ -39,6 +40,7 @@ typedef struct SiFiveUSoCState {
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
     SiFiveUPRCIState prci;
+    SiFiveUOTPState otp;
     CadenceGEMState gem;
 } SiFiveUSoCState;
 
@@ -60,6 +62,7 @@ enum {
     SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
+    SIFIVE_U_OTP,
     SIFIVE_U_DRAM,
     SIFIVE_U_GEM
 };
-- 
2.7.4


