Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3094FC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3BA208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLCZwY6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3BA208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwiz0-0004aU-87
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisr-0005v9-PX
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisq-0003w2-3l
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisp-0003vX-TC; Sun, 11 Aug 2019 04:07:20 -0400
Received: by mail-pf1-x442.google.com with SMTP id t16so48212950pfe.11;
 Sun, 11 Aug 2019 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=LbO6AS0E0Vdiv1H1qDs7gNwzu6RVEobJlJR1+rAtbfw=;
 b=lLCZwY6FhouKhBp2KYSqEircqaegfyEomNeksSNoKD1i8JtJyQdW9dhAnqmM8l3fRy
 zBcELrXmxvAXXeZggLTxkuQqKI04kpFpzzgvye3hEKICMqKlt43XP5/q1QwaKBvcWgSs
 46JnHzlcQ2eBv9fKu61qrj7DA8W7SXANErXpwEToJZRVg7TayOphddSJKpMZX0qQ37pS
 0oxuN/8Xtv+IWTB3b7Bv4lQw4eLnJSNAxDsjyehxpsAvJJ41vmS9GfgPBO68Y7NUKAxQ
 UoVIN79Y90GMd3MgbExH4NoRN3SziqldJTxMXsy/xrqfUWwGa+BWeW7sSAadfJmon4a/
 5UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=LbO6AS0E0Vdiv1H1qDs7gNwzu6RVEobJlJR1+rAtbfw=;
 b=AxYVMVGziuLlnjVDTfEvM96R48N/n/9B3hJPOT2A1gWm4TixiyCrnCh2QZwPpJ0vqX
 W9M2Dv9dTJYA5qxAWjWrIhbh6Me8M9OxTeIulpn9CJjVt3VGRmoosO6FPIaBTQ6IvhH3
 U0Pl21lwqj6fPYZTF7ko/xMsW22nHq6spPqS72qDyBjv3e01W2F9F8ZThmkx+1tfxYGi
 0Xqknkc7VX9AJCg61K8k12Lflw3ty8ZN+CdIPrN53f8BinA6ionGb5DcLkwlgwcuI2BB
 JE9gSupidssmOZUAxADka8kBPliyY4V5hKbVQf6wDLtyaH1rDEZKcBY6eqTdH1Uxl6mJ
 Xiiw==
X-Gm-Message-State: APjAAAWH29sn2xlFYy2owVJ5wLkymLO5qM/JehVkgU5/aFHwQb2Y+nCF
 2Skmdt1/3/9QSfXkI/Rii4I=
X-Google-Smtp-Source: APXvYqxLHocHXol/fq1s58Q/xVONXUb62qwHCwc5nngiLx3sYqFfGDXm5dkQDbK3hsmK4XtOma+kXA==
X-Received: by 2002:a63:d04e:: with SMTP id s14mr23946502pgi.189.1565510838994; 
 Sun, 11 Aug 2019 01:07:18 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.18
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:18 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:44 -0700
Message-Id: <1565510821-3927-12-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 11/28] riscv: sifive: Rename sifive_prci.{c,
 h} to sifive_e_prci.{c, h}
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

Current SiFive PRCI model only works with sifive_e machine, as it
only emulates registers or PRCI block in the FE310 SoC.

Rename the file name to make it clear that it is for sifive_e.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/Makefile.objs                              |  2 +-
 hw/riscv/sifive_e.c                                 |  4 ++--
 hw/riscv/{sifive_prci.c => sifive_e_prci.c}         | 14 +++++++-------
 include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} | 14 +++++++-------
 4 files changed, 17 insertions(+), 17 deletions(-)
 rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (90%)
 rename include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} (82%)

diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index eb9d4f9..c859697 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -2,9 +2,9 @@ obj-y += boot.o
 obj-$(CONFIG_SPIKE) += riscv_htif.o
 obj-$(CONFIG_HART) += riscv_hart.o
 obj-$(CONFIG_SIFIVE_E) += sifive_e.o
+obj-$(CONFIG_SIFIVE_E) += sifive_e_prci.o
 obj-$(CONFIG_SIFIVE) += sifive_clint.o
 obj-$(CONFIG_SIFIVE) += sifive_gpio.o
-obj-$(CONFIG_SIFIVE) += sifive_prci.o
 obj-$(CONFIG_SIFIVE) += sifive_plic.o
 obj-$(CONFIG_SIFIVE) += sifive_test.o
 obj-$(CONFIG_SIFIVE_U) += sifive_u.o
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 2a499d8..2d67670 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -41,9 +41,9 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
-#include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_e.h"
+#include "hw/riscv/sifive_e_prci.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
@@ -174,7 +174,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
-    sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
+    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
 
     /* GPIO */
 
diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_e_prci.c
similarity index 90%
rename from hw/riscv/sifive_prci.c
rename to hw/riscv/sifive_e_prci.c
index f406682..acb914d 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -1,5 +1,5 @@
 /*
- * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt)
+ * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt)
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
@@ -22,7 +22,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
-#include "hw/riscv/sifive_prci.h"
+#include "hw/riscv/sifive_e_prci.h"
 
 static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -82,10 +82,10 @@ static const MemoryRegionOps sifive_prci_ops = {
 
 static void sifive_prci_init(Object *obj)
 {
-    SiFivePRCIState *s = SIFIVE_PRCI(obj);
+    SiFivePRCIState *s = SIFIVE_E_PRCI(obj);
 
     memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
-                          TYPE_SIFIVE_PRCI, 0x8000);
+                          TYPE_SIFIVE_E_PRCI, 0x8000);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
@@ -97,7 +97,7 @@ static void sifive_prci_init(Object *obj)
 }
 
 static const TypeInfo sifive_prci_info = {
-    .name          = TYPE_SIFIVE_PRCI,
+    .name          = TYPE_SIFIVE_E_PRCI,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SiFivePRCIState),
     .instance_init = sifive_prci_init,
@@ -114,9 +114,9 @@ type_init(sifive_prci_register_types)
 /*
  * Create PRCI device.
  */
-DeviceState *sifive_prci_create(hwaddr addr)
+DeviceState *sifive_e_prci_create(hwaddr addr)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_PRCI);
+    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_E_PRCI);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_e_prci.h
similarity index 82%
rename from include/hw/riscv/sifive_prci.h
rename to include/hw/riscv/sifive_e_prci.h
index bd51c4a..7932fe7 100644
--- a/include/hw/riscv/sifive_prci.h
+++ b/include/hw/riscv/sifive_e_prci.h
@@ -1,5 +1,5 @@
 /*
- * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt) interface
+ * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt) interface
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
@@ -16,8 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HW_SIFIVE_PRCI_H
-#define HW_SIFIVE_PRCI_H
+#ifndef HW_SIFIVE_E_PRCI_H
+#define HW_SIFIVE_E_PRCI_H
 
 enum {
     SIFIVE_PRCI_HFROSCCFG   = 0x0,
@@ -47,10 +47,10 @@ enum {
     SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
 };
 
-#define TYPE_SIFIVE_PRCI "riscv.sifive.prci"
+#define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
 
-#define SIFIVE_PRCI(obj) \
-    OBJECT_CHECK(SiFivePRCIState, (obj), TYPE_SIFIVE_PRCI)
+#define SIFIVE_E_PRCI(obj) \
+    OBJECT_CHECK(SiFivePRCIState, (obj), TYPE_SIFIVE_E_PRCI)
 
 typedef struct SiFivePRCIState {
     /*< private >*/
@@ -64,6 +64,6 @@ typedef struct SiFivePRCIState {
     uint32_t plloutdiv;
 } SiFivePRCIState;
 
-DeviceState *sifive_prci_create(hwaddr addr);
+DeviceState *sifive_e_prci_create(hwaddr addr);
 
 #endif
-- 
2.7.4


