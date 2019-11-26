Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B40CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B042073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkILFrEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B042073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZV2P-00032Z-7M
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSvG-0007We-Py
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSvE-0006c4-LR
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:57:58 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:38094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZSvB-0006aQ-17
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:57:54 -0500
Received: by mail-pg1-x52f.google.com with SMTP id t3so7895580pgl.5
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 20:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b98zR+wGXQim4gXI2+OB9X/VHrXcUGrK0TX4LzaEvvI=;
 b=lkILFrEtrhJGw+XFQL9mQQA3OwRfLOX5oCrQXrobUXLkCv/dUATcQ2b7JCdl+EAvXF
 J2doCu4cq1ud7vKxeV5mNx5lVnUamxMN0zlVg8vQHk3DH857okYgoCM+Dfxn0J9yCg8l
 /GexfQVyDbF6/kbcoMGUI9L3W3AHwYW4iWjwf9CJUCfhvk8UGacqZIM+n4ZGwy11nLNZ
 anSA/QkE0q3Kt18EBGHtNuoaNGt3Xgjtbj5gkoOTFj2uhRiFyys4OWuKDUYw2Uu4hDVO
 Rn6i6jeEqrCQsfJNOsAU5wmBuqzBwoSz5ovbLaxlg2o9Fj0gJ4LEA1RRs45paWb96UMA
 Kvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b98zR+wGXQim4gXI2+OB9X/VHrXcUGrK0TX4LzaEvvI=;
 b=pQUcHd2JISWzsYaVUiFm1r++a/eMD2hqqvkOk5OXWbd08rux/YdVsrI4kOJLMWuVFE
 shYMuWuvKc0lqbGPcNYlda4sNXDIRdcy7pjGzQy1Acrhn6tAqUjMQmOFwHV+itfR3DiO
 +RKxQU9sb0EeeorMtRrBuCrDjuUg0HBynmiWMuVOqJTxND2l0PngN3Wk91Cnsl8Q1fEL
 T1EjS40ufiQOXvgpNd13MDRZ2F+X7gw5JiiV/xRWvkxA7ZfR6HaTi0nUYYka2Q5F6Q2u
 2+/6fusB7MAznUjMEXyz1RSv0EHaR9eZH5J6WyY/NQPzjkItOF9x+WJR9YliykfKKJab
 wjQQ==
X-Gm-Message-State: APjAAAXloUD8bNDW3yAt8n5H9mQQjPOGxEP1Zp/YhL7Y80abHI74SU/Y
 qsjt0xjUexzigopp/yel9zeS0Z3yZDQf5uO2
X-Google-Smtp-Source: APXvYqxFIrIA4gdQ0OEVgbO0ny3mbP2cAG/1+DLnGSmtN7J3j0BxBJzAZFaQEHZAjafyJGdtW9BqwA==
X-Received: by 2002:a62:180a:: with SMTP id 10mr39464545pfy.40.1574744271202; 
 Mon, 25 Nov 2019 20:57:51 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:73:1f7e:c8d0:6181:5329:cc21])
 by smtp.gmail.com with ESMTPSA id
 z1sm1081328pju.27.2019.11.25.20.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 20:57:50 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 6/8] Fix MC STATUS resgister
Date: Tue, 26 Nov 2019 10:26:19 +0530
Message-Id: <20191126045621.11344-7-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
References: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52f
X-Mailman-Approved-At: Tue, 26 Nov 2019 02:04:16 -0500
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
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

---
 hw/display/r300.c | 15 ++++++++++++---
 hw/display/r300.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/display/r300.c b/hw/display/r300.c
index 94e90b7a95..653474c3aa 100644
--- a/hw/display/r300.c
+++ b/hw/display/r300.c
@@ -278,6 +278,10 @@ static uint64_t r300_mm_read(void *opaque, hwaddr addr, unsigned int size)
     uint64_t val = 0;
 
     switch (addr) {
+    case RADEON_MC_STATUS:
+        val = s->regs.mc_status;
+        break;
+
     case RADEON_MM_INDEX:
         val = s->regs.mm_index;
         break;
@@ -358,9 +362,9 @@ static uint64_t r300_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case RADEON_CONFIG_REG_APER_SIZE:
         val = memory_region_size(&s->mm);
         break;
-    case RADEON_MC_STATUS:
-        val = 5;
-        break;
+    // case RADEON_MC_STATUS:
+    //     val = 5;
+    //     break;
     case RADEON_RBBM_STATUS:
         val = 64; /* free CMDFIFO entries */
         break;
@@ -512,6 +516,10 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         trace_ati_mm_write(size, addr, r300_reg_name(addr & ~3ULL), data);
     }
     switch (addr) {
+      case RADEON_MC_STATUS:
+        s->regs.mc_status = R300_MC_IDLE;
+        s->regs.mc_status = data;
+        break;
       case RADEON_RBBM_STATUS:
         s->regs.rbbm_status = data|= RADEON_RBBM_FIFOCNT_MASK;
         break;
@@ -946,6 +954,7 @@ static void r300_vga_realize(PCIDevice *dev, Error **errp)
 static void r300_vga_reset(DeviceState *dev)
 {
     RADVGAState *s = RAD_VGA(dev);
+    s->regs.mc_status = R300_MC_IDLE;
 
     timer_del(&s->vblank_timer);
     r300_vga_update_irq(s);
diff --git a/hw/display/r300.h b/hw/display/r300.h
index 60f572647f..a9e1db32be 100644
--- a/hw/display/r300.h
+++ b/hw/display/r300.h
@@ -81,6 +81,7 @@ typedef struct RADVGARegs{
   uint32_t default_pitch;
   uint32_t default_tile;
   uint32_t default_sc_bottom_right;
+  uint32_t mc_status;
 
 //Color Buffer RB3D
   uint32_t r300_rb3d_aaresolve_ctl;
-- 
2.24.0


