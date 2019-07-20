Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3AC76186
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 23:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCBB20823
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 23:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYh9rdYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCBB20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoz5X-0004Wr-F1
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 19:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35460)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hoz5H-0003eB-S2
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hoz5G-0002we-SB
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:11 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1hoz5G-0002vd-Lw
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 19:48:10 -0400
Received: by mail-pl1-x644.google.com with SMTP id m9so17288751pls.8
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YfW1aH+Wpw10vSj+L0zxMi7E9GI7IXk5GtJx8ieye+k=;
 b=cYh9rdYJVQF9qlBb+UYRb4LF9xub5bGioGf3vFC4vh4ZzNUTiYGeoHKXOm2jexX5pz
 H3sZOLnVeSI9UVlXZJahQyfNep3BGpTvJuih5YdELTXYKU3z5QBSbrm+l9XMrA+jJZee
 ooCX8dwI6klYkhmZDHEMg4k6erUlddRGrPrdxAHF5mf7OUeVg6nWaTs5Gw22mGBxxmpu
 ZXbDjUgvSmvTHF79VtJqPEut2GFcOHEqL9Q/xRcFDykBTL38yAj9cboLy+AEaU0X5eZc
 ztBtaEPlrLQRfHx1d7etfQl1ou8R4Larrw4tl72/tMhfuCEVx+8c7JN7bN/wccrpeswZ
 VaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YfW1aH+Wpw10vSj+L0zxMi7E9GI7IXk5GtJx8ieye+k=;
 b=mHuXq0/EhOLmvGottslKCbGDbY+GNUULhddp831rGkFf8nM4KyEoR/OgoYHYN1f+jM
 46Nt0szmLW78MVsWk57zG9n/HALeMpixj46m5um6NzD8X5OCLMkOvc6hyDj0m473HF8p
 2jjGjmoHYtS3ZV5WXP5U1gEr3VYZ0Jjz0hxRjYE4IoEoAzxy1FlLIEUFjygzhkCnJ3iP
 VmikhfQHoVpwZ0colsk42Z/5T1f0vG0snzhN+g7P8DOJUr/Sx4/USoB5+88+yRYjKe4z
 K82aDljRZdmLXKi5xc6zIZX7PADWQsRuql47Cb6wIHiiC+Gk7LgppLV6kUaJ1BE94QMX
 q3nQ==
X-Gm-Message-State: APjAAAWen5ULaNe3gdFhzH1FOqKkAeLPcTFedoCf/FMEBMjolZBlX5dT
 c9BHiHbyyhZ/Djh8ZjfkJL4FDO/N
X-Google-Smtp-Source: APXvYqwOrfgQg8AI3I1OzcLDcPrbV5MoptZ4cy7hbLjQ/JH4+5Qti3dzGvOEgCW+FEseUIXJWCPQGQ==
X-Received: by 2002:a17:902:7448:: with SMTP id
 e8mr66062080plt.85.1563666489452; 
 Sat, 20 Jul 2019 16:48:09 -0700 (PDT)
Received: from beta.cse.iitb.ac.in ([2405:204:20e:f16f:2a5b:d596:9ab:8e05])
 by smtp.gmail.com with ESMTPSA id b6sm31229151pgq.26.2019.07.20.16.48.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 16:48:08 -0700 (PDT)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 21 Jul 2019 05:18:02 +0530
Message-Id: <20190720234803.18938-2-skrtbhtngr@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720234803.18938-1-skrtbhtngr@gmail.com>
References: <20190720234803.18938-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [RFC v3 1/2] hw/pvrdma: make DSR mapping idempotent in
 load_dsr()
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Map to DSR only when there is no mapping done already i.e., when
dev->dsr_info.dsr is NULL. This allows the rest of mappings and
ring inits to be done by calling load_dsr() when DSR has already
been mapped to, somewhere else.

Move free_dsr() out of load_dsr() and call it before the latter
as and when needed. This aids the case where load_dsr() is called
having DSR mapping already done, but the rest of map and init
operations are pending, and prevents an unmap of the DSR.

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index adcf79cd63..6c90db96f9 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -172,15 +172,15 @@ static int load_dsr(PVRDMADev *dev)
     DSRInfo *dsr_info;
     struct pvrdma_device_shared_region *dsr;
 
-    free_dsr(dev);
-
-    /* Map to DSR */
-    dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
-                              sizeof(struct pvrdma_device_shared_region));
     if (!dev->dsr_info.dsr) {
-        rdma_error_report("Failed to map to DSR");
-        rc = -ENOMEM;
-        goto out;
+        /* Map to DSR */
+        dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
+                                  sizeof(struct pvrdma_device_shared_region));
+        if (!dev->dsr_info.dsr) {
+            rdma_error_report("Failed to map to DSR");
+            rc = -ENOMEM;
+            goto out;
+        }
     }
 
     /* Shortcuts */
@@ -402,6 +402,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
     case PVRDMA_REG_DSRHIGH:
         trace_pvrdma_regs_write(addr, val, "DSRHIGH", "");
         dev->dsr_info.dma |= val << 32;
+        free_dsr(dev);
         load_dsr(dev);
         init_dsr_dev_caps(dev);
         break;
-- 
2.21.0


