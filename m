Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72041C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8D02070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAhMVOP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8D02070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HQS-00038Z-20
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyv-0004w3-VF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyq-0004c7-9X
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:05 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6Gyp-0004Zw-Nv; Fri, 06 Sep 2019 12:21:00 -0400
Received: by mail-pl1-x641.google.com with SMTP id m9so3383412pls.8;
 Fri, 06 Sep 2019 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=xuYTsctnk9CwrN+Ms2l/EHNwW4y7q4Tqefw1LDEzGjA=;
 b=aAhMVOP0leNyHx0FPtV8vj0LyQ8OQCQLD68s0t3e/gYttGuVwNzMLu+kzXV9Cu/DTf
 /i1DGggk2YmUpLECFpaLkwJIr2k6QB8TvASzcpQLahP8IEgkBVx1Uhe5pBD5BjarEKeY
 hBBlzEX7se0UNU7NlfdMVuia03TuQvr+y9pWqSgp4jlNa4nYw87yF3jDcFmRSc2rJMQA
 rQsoXKxn17EVwcfmzODfYCAGJb4OttE8W8Epqkk3OBZTFuyu0YNWVFC+K4bKueoVVNvo
 x+sqqP1PX+Rw9+cnjmb4CTBqFshFziFkzK4Bf80KC/kX1JJHOOYSinnZQDtRWHmFzIfy
 MSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=xuYTsctnk9CwrN+Ms2l/EHNwW4y7q4Tqefw1LDEzGjA=;
 b=GyWUdn/VJlIw+MDedosCrqfv6U0lG6fNEGGyIOvfcl3RL8qL/KnEegf+NfHsAOSOu+
 QyYYujI6RFi+cVTUyw5jC4s+9UWPiep3KwWHu40qhKaxlCRZFHU/R9AEyVdng/39k6cW
 lmXowsosNZHX0FnyEBG+5WWGimYbyth872a1Dpc5YCRjiBn4beLldkV3rEIn7HY1k8X0
 BRc+qb578hllr0p0qEZvWq3m31dMr9tqvbQiqY2vZjooryXkaNGHDwyaJI8cKjYVQXau
 mWVPccX34jXWZZEd1bFIQZedPuNOwy0Zb8+HffcoIgEd8L8mJ2ElBQc2tByJWWl8SBQi
 B2Iw==
X-Gm-Message-State: APjAAAXqalg1s/2oWOLtwhM1bjaM36d0wDJ2zeil8QWOWpOeiOvkIJMA
 pssXhC2ltm5tHjlbjXPP19Y=
X-Google-Smtp-Source: APXvYqwJBLXApo85jDZRUWzMRSaIJJ02IZrzfukxDWIzD1JHihysCrRSSdVfwuY55XMvF8Ymecqk3g==
X-Received: by 2002:a17:902:9001:: with SMTP id
 a1mr1471273plp.148.1567786856178; 
 Fri, 06 Sep 2019 09:20:56 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.55
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:55 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:17 -0700
Message-Id: <1567786819-22142-31-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v8 30/32] riscv: sifive_u: Fix broken GEM
 support
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

At present the GEM support in sifive_u machine is seriously broken.
The GEM block register base was set to a weird number (0x100900FC),
which for no way could work with the cadence_gem model in QEMU.

Not like other GEM variants, the FU540-specific GEM has a management
block to control 10/100/1000Mbps link speed changes, that is mapped
to 0x100a0000. We can simply map it into MMIO space without special
handling using create_unimplemented_device().

Update the GEM node compatible string to use the official name used
by the upstream Linux kernel, and add the management block reg base
& size to the <reg> property encoding.

Tested with upstream U-Boot and Linux kernel MACB drivers.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v8:
- select UNIMP in sifive_u Kconfig due to applied commit
  "hw/misc: Add a config switch for the "unimplemented" device"
  in latest qemu/master

Changes in v7: None
Changes in v6: None
Changes in v5:
- add the missing "local-mac-address" property in the ethernet node

Changes in v4: None
Changes in v3: None
Changes in v2:
- use create_unimplemented_device() to create the GEM management
  block instead of sifive_mmio_emulate()
- add "phy-handle" property to the ethernet node

 hw/riscv/Kconfig            |  1 +
 hw/riscv/sifive_u.c         | 24 ++++++++++++++++++++----
 include/hw/riscv/sifive_u.h |  3 ++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 33e54b0..fb19b2d 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -19,6 +19,7 @@ config SIFIVE_U
     select CADENCE
     select HART
     select SIFIVE
+    select UNIMP
 
 config SPIKE
     bool
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 4803e47..3b61fab 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
  * Copyright (c) 2017 SiFive, Inc.
+ * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
  *
  * Provides a board compatible with the SiFive Freedom U SDK:
  *
@@ -11,6 +12,7 @@
  * 2) PLIC (Platform Level Interrupt Controller)
  * 3) PRCI (Power, Reset, Clock, Interrupt)
  * 4) OTP (One-Time Programmable) memory with stored serial number
+ * 5) GEM (Gigabit Ethernet Controller) and management block
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -37,6 +39,7 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "hw/cpu/cluster.h"
+#include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
@@ -45,6 +48,7 @@
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
+#include "net/eth.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
@@ -67,7 +71,8 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
-    [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
+    [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
+    [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
 };
 
 #define OTP_SERIAL          1
@@ -84,7 +89,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     char ethclk_names[] = "pclk\0hclk";
     uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
     uint32_t uartclk_phandle;
-    uint32_t hfclk_phandle, rtcclk_phandle;
+    uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -254,21 +259,28 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
+    phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "cdns,macb");
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+        "sifive,fu540-c000-gem");
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_GEM].base,
-        0x0, memmap[SIFIVE_U_GEM].size);
+        0x0, memmap[SIFIVE_U_GEM].size,
+        0x0, memmap[SIFIVE_U_GEM_MGMT].base,
+        0x0, memmap[SIFIVE_U_GEM_MGMT].size);
     qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
     qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
+    qemu_fdt_setprop_cell(fdt, nodename, "phy-handle", phy_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
         prci_phandle, PRCI_CLK_GEMGXLPLL, prci_phandle, PRCI_CLK_GEMGXLPLL);
     qemu_fdt_setprop(fdt, nodename, "clock-names", ethclk_names,
         sizeof(ethclk_names));
+    qemu_fdt_setprop(fdt, nodename, "local-mac-address",
+        s->soc.gem.conf.macaddr.a, ETH_ALEN);
     qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
     g_free(nodename);
@@ -276,6 +288,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
         (long)memmap[SIFIVE_U_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", phy_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
@@ -525,6 +538,9 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
                        plic_gpios[SIFIVE_U_GEM_IRQ]);
+
+    create_unimplemented_device("riscv.sifive.u.gem-mgmt",
+        memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
 static void riscv_sifive_u_machine_init(MachineClass *mc)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 4d4733c..5270851 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -64,7 +64,8 @@ enum {
     SIFIVE_U_UART1,
     SIFIVE_U_OTP,
     SIFIVE_U_DRAM,
-    SIFIVE_U_GEM
+    SIFIVE_U_GEM,
+    SIFIVE_U_GEM_MGMT
 };
 
 enum {
-- 
2.7.4


