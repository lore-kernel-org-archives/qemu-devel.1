Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50196C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BAD2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfDfqNBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BAD2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3r4-0004Fs-9u
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:28:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Gi-0003Gg-RJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Gf-0002mq-Mv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:51:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3Gf-0002m2-Fp
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:51:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so15301187wrs.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Sy0WFm2MPPX0JE4Sw4IHzF1G+za7ZNoZ8lYBMqWvoGQ=;
 b=XfDfqNBQrt3zosQ62oDrLackWZ5LGomx+UIqBao3FyccDQqlOYg/KkMNfwM4EPRDHt
 C45Ls4D6df1CUsmqsaqdMYLRf7jihyD2mfB1ijn/QixfJo9+yktX1756XivbPvtzl5+B
 +KOagQzU9nhq3RbhuXo4aLTPPWa7b/7UETD8CqDsr3zzWNMT7Mfn9MZCefeyWLwL77XH
 +rQ8ZdlngHQT4Vs0/UuFPuYDLBsxXgvuhv8LfmwqM2DNo4yYmz7y4a1qOjYKPkyfveyn
 0Z4pGaHS4INoBtfgJQwzuCiLhuYrZD2+6SLQ/bNIt7wJYBR0da8ywVWPrveUmAWhZ696
 5rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sy0WFm2MPPX0JE4Sw4IHzF1G+za7ZNoZ8lYBMqWvoGQ=;
 b=JZC6N4oCRhSqS2Zg4NMH4pK4E6pfsoV76GOsVpuXZJwNhQqotdjWtnq3dxG+TFAvcP
 vjDLRlnN674iNeRsJjVCf7+xXwz5eVzPDlQ+9yatfAV7VnSUZ3jqdQnIcaB1zdnKoOOy
 aCyhIvvjSyLXd6iuQQ5V2CUumsxJkXvKcP6+GJpCG6T8toJhmIfwUaSCkMaTvj311eZa
 nsPxrSRJVoNr8BZL1hyRzZb5UOYhXA5cqEIYra/AcUT9eqx6sPLRHEoLHU29Wv55NkCe
 H9X+rXjH9MWNSe5d0io9Za3A0yfyqS6BZaiYXcqxae432YJwwmbAS02GQ+ce7eYxh1v3
 z2Ug==
X-Gm-Message-State: APjAAAVc854ccGGSlwgBNXmQuc5YiuXlsO7vvOttgp01+9tQReIK+k/e
 Opsz7cwDvBgzs3Bzn4lR+gfP52RCG9yvzA==
X-Google-Smtp-Source: APXvYqwxv60h2OSGZFEwplw032D4NjKucCAlotWWw8hyQnxMEgpVnQDzVYr+Rfle97GV7fR7V55a6g==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr13262612wrl.155.1561999193176; 
 Mon, 01 Jul 2019 09:39:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:05 +0100
Message-Id: <20190701163943.22313-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: [Qemu-devel] [PULL 08/46] i.mx7d: pci: Update PCI IRQ mapping to
 match HW
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

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Datasheet for i.MX7 is incorrect and i.MX7's PCI IRQ mapping matches
that of i.MX6:

    * INTD/MSI    122
    * INTC        123
    * INTB        124
    * INTA        125

Fix all of the relevant code to reflect that fact. Needed by latest
Linux kernels.

(Reference: Linux kernel commit 538d6e9d597584e80 from an
NXP employee confirming that the datasheet is incorrect and
with a report of a test against hardware.)

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added ref to kernel commit confirming the datasheet error]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx7.h | 8 ++++----
 hw/pci-host/designware.c  | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 09f4f33f6e5..8003d45d1e5 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -213,10 +213,10 @@ enum FslIMX7IRQs {
     FSL_IMX7_USB2_IRQ     = 42,
     FSL_IMX7_USB3_IRQ     = 40,
 
-    FSL_IMX7_PCI_INTA_IRQ = 122,
-    FSL_IMX7_PCI_INTB_IRQ = 123,
-    FSL_IMX7_PCI_INTC_IRQ = 124,
-    FSL_IMX7_PCI_INTD_IRQ = 125,
+    FSL_IMX7_PCI_INTA_IRQ = 125,
+    FSL_IMX7_PCI_INTB_IRQ = 124,
+    FSL_IMX7_PCI_INTC_IRQ = 123,
+    FSL_IMX7_PCI_INTD_IRQ = 122,
 
     FSL_IMX7_UART7_IRQ    = 126,
 
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 931cd954e87..9ae8c0deb75 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -51,6 +51,8 @@
 #define DESIGNWARE_PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
 #define DESIGNWARE_PCIE_ATU_UPPER_TARGET           0x91C
 
+#define DESIGNWARE_PCIE_IRQ_MSI                    3
+
 static DesignwarePCIEHost *
 designware_pcie_root_to_host(DesignwarePCIERoot *root)
 {
@@ -67,7 +69,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
     root->msi.intr[0].status |= BIT(val) & root->msi.intr[0].enable;
 
     if (root->msi.intr[0].status & ~root->msi.intr[0].mask) {
-        qemu_set_irq(host->pci.irqs[0], 1);
+        qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 1);
     }
 }
 
@@ -311,7 +313,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_MSI_INTR0_STATUS:
         root->msi.intr[0].status ^= val;
         if (!root->msi.intr[0].status) {
-            qemu_set_irq(host->pci.irqs[0], 0);
+            qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 0);
         }
         break;
 
-- 
2.20.1


