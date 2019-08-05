Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3745C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CF32064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlX9MSLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CF32064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufU1-0007pH-PF
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58214)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPV-0008UZ-CW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPT-0002lx-Kn
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:33 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPT-0002lI-EA; Mon, 05 Aug 2019 12:00:31 -0400
Received: by mail-pf1-x442.google.com with SMTP id r7so39875161pfl.3;
 Mon, 05 Aug 2019 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=mdOZHYB72+h5rorUmv2iv5y/NbklkxYCe2/8rZ8DW6s=;
 b=TlX9MSLqY7b8MJuhFNC/UL2k0pGbaC193V66r4z9QjhDLYzrDBLFCU37sfaRhhgSx3
 sUV4XGLIAgQd8aeX58nVo814sc32ruVgfBsLzrBOVO87Hr4cb7I7yqNZODQF8qjfEslg
 s9y2Q7sOUZCx53rg70ls5/b6iygvNaIwsm3IQ3NwIN2KnfPcW8FplT3dI+tEZK7han+o
 2kDyI58bAXLuiCawwpts7pnHgaedfg+lk8zaSP3cH8q8IVyOWVkuAiT8UmMrocT3jYer
 0qp/y4OsJFZG7aZkQP7ygITWB6qMe9rk7Jy6gj9WjUXA0WJ9K1EKHh2vGLIEHtpKxHFJ
 +d8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=mdOZHYB72+h5rorUmv2iv5y/NbklkxYCe2/8rZ8DW6s=;
 b=jjm2/70HQHR0hLtxWikFjg7O/lrCJb2nOqpJaXlfCrQExcOYtyCID7GW0df/QmqAKS
 KaS6O16l7nciwUhZKuZx8Ua2sPyRXnoZqgrGaDweqPrxlD2hpdMj53GCHUFbGcn1WXzw
 WvvQYdXP2EBsWoeNxG2RHWBaWL3kRnbASsNUU/4VyW0YC0ZKPohBYNBar2VvRFpK8eE5
 o9hQgLJfEvqOtpecSGyOoLC65AuHnZNHedJz19eBG8mtAiBMNlJic3d2lFaCujLYdPew
 ggVShaLbUAK95g+lwI3cnySUuFhy8VEEpMS2dn/SdvHhsmtSAAMwfX+/9TotufnI+FdH
 +Rbg==
X-Gm-Message-State: APjAAAU0ZOtINgmk9UyjPquv2pVWZVcqyUWFOe5Ve2qcHU6TIEUfc+yX
 4bt4Ob1jFP++dLxe8B83KK4=
X-Google-Smtp-Source: APXvYqysZZSCJLQhQuWnHUDCMhV2/P3+TqhoGluYY6FOrAC22xtdvR3zTcTWT/6qirwdCH+Tp+aXJg==
X-Received: by 2002:a63:d23:: with SMTP id c35mr136428667pgl.376.1565020830449; 
 Mon, 05 Aug 2019 09:00:30 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.29
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:29 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 08:59:57 -0700
Message-Id: <1565020823-24223-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 02/28] riscv: hw: Use qemu_fdt_setprop_cell()
 for property with only 1 cell
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
---

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


