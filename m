Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF32C0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2453B208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hih0GHsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2453B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwiui-0002HT-De
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisi-0005SA-4F
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisg-0003pN-Aj
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:12 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisg-0003p1-4Y; Sun, 11 Aug 2019 04:07:10 -0400
Received: by mail-pg1-x544.google.com with SMTP id n190so7170131pgn.0;
 Sun, 11 Aug 2019 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=plHQblLcQrAA+aqvTE+t7pbZ1l60zxX8q/18+gdtDDM=;
 b=hih0GHsHuuMXY/I3UsKxcCkBfjCH58nZxKa1ZAOEFzYG87V8Np9YZ6sgzPsydXBXtZ
 KvNEDQfxVWgwGvAQeuwCr4CeR3R9wmJEELlXJ0JZb9lqa+VeDpZvjcJmVfLWNhgaz9oy
 AgG0hHnGnYCjtfmXKY4oDborTA8UFSBg50MCTgUEbtKOIWpE1m2FHDikx/Wc2JQI8x0s
 7mJqIF5H+GuzfpytBUpib+zy86/S2v10MBtspEsb3JGLTMruYiW+PgZ45JeXruO19YRe
 1C5tbp6eOG4WNmFwutd18cFbGRuGvIhPv4WDWPK0VNmYYwRhb970BZBGlK898BFUiFZ4
 wxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=plHQblLcQrAA+aqvTE+t7pbZ1l60zxX8q/18+gdtDDM=;
 b=MUU07N9IplfcCgGb71Xy/nbv2RIxFSL7bCDZl9YLDQODFTQ27UAP2LCL9rtGtj01iX
 qMqM1wR8IIO5Wja6aNZAF2Ae9eEN/TRZ7hTu8te+mUFcfxJui6gAxnT7cGqLlgig9HYd
 3juD7rQSRSA/y/2doZscN9kdZO5WWIRsRpIAX67xXzaLhOZD5D9ecpDQ7/ED06Vo8EpQ
 Z3Ogw/KdU86dmprEwD6+dEUK+oioHo59PEjU3+jYXTE1E9UhFzKCGIQMeNAoBXb7dkh1
 ZcuGRcPDRIqY2oiTRpF+TdyzE7GLMYVrZ4VXESndGWAH2DX7kPTPJ3+INqXe4E6CAkA+
 J+gQ==
X-Gm-Message-State: APjAAAX3YzoBJR7d30jpzqH4j68dmcFAvseSKe9huZh7duUoi6M09qJi
 8pIjyeyCFvtEIBs60Q4YSzI=
X-Google-Smtp-Source: APXvYqx1/iO/XAR+QQ0LcQmxy/4gtZl5mI9mVnLTKcUhweXZnHFiF3icibXNltKj93dR1yTNqU5zqA==
X-Received: by 2002:a62:ac1a:: with SMTP id v26mr30931389pfe.184.1565510829298; 
 Sun, 11 Aug 2019 01:07:09 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.08
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:08 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:35 -0700
Message-Id: <1565510821-3927-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 02/28] riscv: hw: Use
 qemu_fdt_setprop_cell() for property with only 1 cell
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

Some of the properties only have 1 cell so we should use
qemu_fdt_setprop_cell() instead of qemu_fdt_setprop_cells().

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 16 ++++++++--------
 hw/riscv/virt.c     | 24 ++++++++++++------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ef36948..623ee64 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -182,7 +182,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
-    qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
@@ -207,20 +207,20 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         0x0, memmap[SIFIVE_U_GEM].size);
     qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
     qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
-    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
-    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
         ethclk_phandle, ethclk_phandle, ethclk_phandle);
     qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
         sizeof(ethclk_names));
-    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 1);
-    qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
+    qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
         (long)memmap[SIFIVE_U_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/uart@%lx",
@@ -232,8 +232,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         0x0, memmap[SIFIVE_U_UART0].size);
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
                           SIFIVE_U_CLOCK_FREQ / 2);
-    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
-    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_UART0_IRQ);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_UART0_IRQ);
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 00be05a..127f005 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -233,8 +233,8 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
         (long)memmap[VIRT_PLIC].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells",
-                           FDT_PLIC_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
+                          FDT_PLIC_ADDR_CELLS);
     qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
                           FDT_PLIC_INT_CELLS);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
@@ -247,7 +247,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
-    qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
@@ -260,19 +260,19 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_cells(fdt, nodename, "reg",
             0x0, memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
             0x0, memmap[VIRT_VIRTIO].size);
-        qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
-        qemu_fdt_setprop_cells(fdt, nodename, "interrupts", VIRTIO_IRQ + i);
+        qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+        qemu_fdt_setprop_cell(fdt, nodename, "interrupts", VIRTIO_IRQ + i);
         g_free(nodename);
     }
 
     nodename = g_strdup_printf("/soc/pci@%lx",
         (long) memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells",
-                           FDT_PCI_ADDR_CELLS);
-    qemu_fdt_setprop_cells(fdt, nodename, "#interrupt-cells",
-                           FDT_PCI_INT_CELLS);
-    qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
+                          FDT_PCI_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
+                          FDT_PCI_INT_CELLS);
+    qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0x2);
     qemu_fdt_setprop_string(fdt, nodename, "compatible",
                             "pci-host-ecam-generic");
     qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
@@ -309,8 +309,8 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         0x0, memmap[VIRT_UART0].base,
         0x0, memmap[VIRT_UART0].size);
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
-        qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
-        qemu_fdt_setprop_cells(fdt, nodename, "interrupts", UART0_IRQ);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", UART0_IRQ);
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-- 
2.7.4


