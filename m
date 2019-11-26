Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA47BC43215
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BAA2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3wOs83X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BAA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZaGn-0003Ni-7y
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZaEx-0002Nu-DG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZaEw-0005sf-7e
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:46:47 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:44043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZaEw-0005qm-0H
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:46:46 -0500
Received: by mail-pj1-x1030.google.com with SMTP id w8so8239512pjh.11
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b98zR+wGXQim4gXI2+OB9X/VHrXcUGrK0TX4LzaEvvI=;
 b=b3wOs83XKvRApR2/Q3XDZPjVNptMLt8uVFHlB0eVl0Ck70nhS6u5uAmdO19FkjdWaJ
 bWGtLUfEpSk5/4C23Y5yDmyUCXdTBHjRvfzbRbeMdMzvfCDMzeNOujbRC/3DerjsrQPW
 Zjq3+ML8I7RgAOonu2z+oEI//oTh44wGNCoY3YMD31ZFELErO3nDe1vPs6ffc9reG/ul
 FkWUPVTEAOR0eRuK446QKGlj+z4uCHk/Cs18lSZCtNH6hFHdm1a61YRapY/pa4lEEpyB
 MBIirMvGfjOJSkOapIrDJe7qWY+RHVBTHE40y5siFHiirDW5fKoVaCli9n4oQ3LvjQ6X
 KUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b98zR+wGXQim4gXI2+OB9X/VHrXcUGrK0TX4LzaEvvI=;
 b=LTPbasGjQM9xajgMGsNSfdwhu33kX+UpbKreh0+Wb/qfbNoUnSwrSvc08Bg1OaMG2/
 oVhyRblB6RAvSYOk8dlNYjs4Fhf/ku+YOoXiC4+gMqBZ5wU+AdDbp1pNanhB0Fm6t7qv
 p9o/CyBqEs2i1mKjhtZjnYbMu+fgAkWFUAhYQYIMa1ZRsJqW+OM5JO/M0+gbJ0vj12Ky
 CDdgpdAfpPLOjP0QJf9kCg0sINZRVxJRPNv6ai4gMIWyPx9EYe2NhCgNrAF4ThnAPU32
 9y8WMLKwSGl7oM+LgB1OvUNue9Mvp9xRfiff4p1h4Gh7o6Sv+P3627+cgKiaMYYJU5h3
 5trg==
X-Gm-Message-State: APjAAAXjwA36y1tbnqs3A7sz2Wn0PzEi7QoTmJzihtGtmBM8VBGalcXH
 geUQ1Qj1hddD/hyNsDDHvXm7IesxMEXuiGmA
X-Google-Smtp-Source: APXvYqwzfgl1ywxwbxJPMelxYYhMHuDxnGeU8aK0jvLfcLtoNR2f7acgIauERax2ig339+giPun0kg==
X-Received: by 2002:a17:90a:d155:: with SMTP id
 t21mr6454472pjw.84.1574772404268; 
 Tue, 26 Nov 2019 04:46:44 -0800 (PST)
Received: from localhost.localdomain ([124.123.107.186])
 by smtp.gmail.com with ESMTPSA id d139sm13685922pfd.162.2019.11.26.04.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 04:46:43 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 06/10] Fix MC STATUS resgister
Date: Tue, 26 Nov 2019 18:14:31 +0530
Message-Id: <20191126124433.860-3-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126124433.860-1-aaron.zakhrov@gmail.com>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1030
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


