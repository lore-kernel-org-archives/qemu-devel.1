Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E80C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E042064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="C5oOixWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E042064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOgh-0005Sb-0r
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 07:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPOc8-00012j-0a
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 07:25:08 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPOc5-0005l4-TF
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 07:25:07 -0400
Received: by mail-lf1-x141.google.com with SMTP id d24so6414525lfa.8
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ccmqdfsrzFPvU6jOggomYthaCnUM8cLMSV0C95sc+To=;
 b=C5oOixWMpqEOIppoPh0wD2P/DQW4wvxePa5zrTt2IFMU68qb6fGLuAv4lPLw5MFDtf
 plId6KaQEQFZFvquorruE2Qd904A4wm+Ywzksd9j2rKepwDjfyRs/jPtbBTLa+rIcKcK
 JQZ1Q+ZpwFpg759SNIfJpFodiIO31D2wgXF9ZkvFOen9eVJ3bQEbF1IR+U+gjQwCo4u/
 48wDDcavl2U3dBRbPGamyKrtfyJTa1Fd1oMiP/GVCeDwYTiHzkBJ5ZMboqejbU05J1+B
 ubt4YvC/k9Niqxj+U8kvnOUsllPDDZmsR3JQp5TVkZjxEOTZzN1o4pHrPndkSItqI06C
 /vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ccmqdfsrzFPvU6jOggomYthaCnUM8cLMSV0C95sc+To=;
 b=J6gJTYettifwcS93aFBoOvwqRbMlIRrJjmEWlWkE3RFR047oRa3ISSsvwv0AF3Q0Pu
 0raxJuhX3TU7E+FX+I9vMUL5ejbehuKU8X1pofbZ2A+2cMmAFmZCrKdkiKPGMXRcrbEr
 UcLCizoLYBb0+ce9Cs85LQF3wZsYTst4oSow42dVaILYA5fi2mzpx+edyOCjSeoh7qmE
 EhcAvb2CMiTc4O8wgyZNlfNxfL2EWThVpLSIrZFlEXL4x+6jQmGcaJVHq2l318H1qXyJ
 DXGDuSKmZ9Oy9e8+lrnmiWkLk15VLUyQvI1CAMSOnkAAuE1XGloQ2sSLepGXaqBsPslL
 1NFg==
X-Gm-Message-State: AOAM531/ofgqkkYGiNlSOXYJMgSe6QqY0fcpc+MB/dPDKITbR0y9a0ZN
 sQM+KMui6+msijB6O9qL0GMAR+ozQXBhBg==
X-Google-Smtp-Source: ABdhPJzfK23iAXuneIGWNrlD+GOlGg2fDH/y9lu44HlI5gIxph00UbxcrQz6btEnzrt4PHKa5fUBQA==
X-Received: by 2002:a19:df53:: with SMTP id q19mr5071552lfj.119.1601897103824; 
 Mon, 05 Oct 2020 04:25:03 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id f10sm1546514ljn.87.2020.10.05.04.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 04:25:03 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] hw/virtio-pci Added AER capability.
Date: Mon,  5 Oct 2020 14:56:01 +0300
Message-Id: <20201005115601.103791-3-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005115601.103791-1-andrew@daynix.com>
References: <20201005115601.103791-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::141;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1878465
Added AER capability for virtio-pci devices.
Also added property for devices, by default AER is disabled.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/virtio/virtio-pci.c | 16 ++++++++++++++++
 hw/virtio/virtio-pci.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ae60c1e249..e0a7936f9c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1807,6 +1807,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
          */
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
+            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
+                          PCI_ERR_SIZEOF, NULL);
+            last_pcie_cap_offset += PCI_ERR_SIZEOF;
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
             /* Init error enabling flags */
             pcie_cap_deverr_init(pci_dev);
@@ -1848,7 +1854,15 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
 static void virtio_pci_exit(PCIDevice *pci_dev)
 {
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
+    bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
+                     !pci_bus_is_root(pci_get_bus(pci_dev));
+
     msix_uninit_exclusive_bar(pci_dev);
+    if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
+        pci_is_express(pci_dev)) {
+        pcie_aer_exit(pci_dev);
+    }
 }
 
 static void virtio_pci_reset(DeviceState *qdev)
@@ -1901,6 +1915,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
+    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_AER_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 91096f0291..3986b4f0e3 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -45,6 +45,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
     VIRTIO_PCI_FLAG_INIT_PM_BIT,
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
+    VIRTIO_PCI_FLAG_AER_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -84,6 +85,9 @@ enum {
 /* Init Function Level Reset capability */
 #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
 
+/* Advanced Error Reporting capability */
+#define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
-- 
2.28.0


