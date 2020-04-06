Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A821C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25CF2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySiyOg+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25CF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOqC-0000u9-5A
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjt-0006pe-5l
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjr-0002vB-Qp
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjr-0002uW-KV
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id f20so6118490wmh.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lJK5pRrZeOgvwi0MkqfizMKvlaa5ce7cwoPnkorTG8c=;
 b=ySiyOg+o85M2Kc9stcp62VnsFU8RHu0dQlx1PuxTRFZqgMy4dXokc7KfAvb6Lzugxe
 TyE9nHTfv5gtD9A8+CyTq5AbGaXAoswtbb8hmx/1UiD6m5+GtzJhDuph8gg6LvDwEh7D
 5nT8njMPELJ7k5in10d2SnO1A3nxtw9yzSGklPkrWzxOM3h3Q6Zq/487yrQ9b3W59fdt
 PlckIznLiZA9Jh6g2vaHrf3g2r7v1DCQnFCwpgcHp3mPscSArxXG1VFVfk3A/oH8TgQr
 wuIL2K2BGZ42lKj6QbYaCh00ldBa6rNVfedz67PQAzxqpd6TJ94W0IB31JtI4iRNMslG
 dM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lJK5pRrZeOgvwi0MkqfizMKvlaa5ce7cwoPnkorTG8c=;
 b=YHbbNHc5Akir6x/cWgid7evOHSvbzyeWyB2FUv1zFr3f5FOe5Qtobr/cyVc5lEmJrn
 HBDCiFDRMMWvwyPFRl0kd1n+m3mCcQ1rAJqcQYBDIjcJ7s5bMBezESbI8ZYVZvpZJWAQ
 Tbw6aggP4ClTChUTDB2Ukrqffo6ME/UW00iJeLgHgKFjPJDK0Lb4BjHnK6G02GQ971l6
 +Vee3DZPW0uvhbYNpjJeoFXzTtPbN2xj7Eod8DVa6NGqm8AOUH7JWV9YZZrPudJ1KBSh
 OA7lWB1/wXxVr7oGRPOTOrU45LGwBw2zRwjMQ3/wOpWpUvUlKRQPV+Ar7fSr/mJrstTU
 pITw==
X-Gm-Message-State: AGi0Pub4rRGqh04Iftr/r5mIyf63aMErSX7mRL6vntHGRV2I7Eplf6Fv
 dyHFSOteIfvMhRRqnrA6b7BJ+zQJF6d2Aw==
X-Google-Smtp-Source: APiQypKFzEnKbj8ESttpcGR7zgUpUelah9zcEWwHP6ZI1wMNauknyToK3HlFtTkBoKANWVh8ekgjuQ==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr9047886wmg.109.1586167938289; 
 Mon, 06 Apr 2020 03:12:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] dma/xlnx-zdma: Reorg to fix CUR_DSCR
Date: Mon,  6 Apr 2020 11:12:05 +0100
Message-Id: <20200406101205.23027-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Reorganize the descriptor handling so that CUR_DSCR always
points to the next descriptor to be processed.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20200402134721.27863-6-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zdma.c | 47 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index e856d233f2d..1c45367f3c6 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -333,10 +333,28 @@ static void zdma_load_src_descriptor(XlnxZDMA *s)
     }
 }
 
+static void zdma_update_descr_addr(XlnxZDMA *s, bool type,
+                                   unsigned int basereg)
+{
+    uint64_t addr, next;
+
+    if (type == DTYPE_LINEAR) {
+        addr = zdma_get_regaddr64(s, basereg);
+        next = addr + sizeof(s->dsc_dst);
+    } else {
+        addr = zdma_get_regaddr64(s, basereg);
+        addr += sizeof(s->dsc_dst);
+        address_space_read(s->dma_as, addr, s->attr, (void *) &next, 8);
+    }
+
+    zdma_put_regaddr64(s, basereg, next);
+}
+
 static void zdma_load_dst_descriptor(XlnxZDMA *s)
 {
     uint64_t dst_addr;
     unsigned int ptype = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POINT_TYPE);
+    bool dst_type;
 
     if (ptype == PT_REG) {
         memcpy(&s->dsc_dst, &s->regs[R_ZDMA_CH_DST_DSCR_WORD0],
@@ -349,24 +367,10 @@ static void zdma_load_dst_descriptor(XlnxZDMA *s)
     if (!zdma_load_descriptor(s, dst_addr, &s->dsc_dst)) {
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, AXI_RD_DST_DSCR, true);
     }
-}
 
-static uint64_t zdma_update_descr_addr(XlnxZDMA *s, bool type,
-                                       unsigned int basereg)
-{
-    uint64_t addr, next;
-
-    if (type == DTYPE_LINEAR) {
-        next = zdma_get_regaddr64(s, basereg);
-        next += sizeof(s->dsc_dst);
-        zdma_put_regaddr64(s, basereg, next);
-    } else {
-        addr = zdma_get_regaddr64(s, basereg);
-        addr += sizeof(s->dsc_dst);
-        address_space_read(s->dma_as, addr, s->attr, &next, 8);
-        zdma_put_regaddr64(s, basereg, next);
-    }
-    return next;
+    /* Advance the descriptor pointer.  */
+    dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3, TYPE);
+    zdma_update_descr_addr(s, dst_type, R_ZDMA_CH_DST_CUR_DSCR_LSB);
 }
 
 static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
@@ -387,14 +391,7 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
         dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
                               SIZE);
         if (dst_size == 0 && ptype == PT_MEM) {
-            uint64_t next;
-            bool dst_type = FIELD_EX32(s->dsc_dst.words[3],
-                                       ZDMA_CH_DST_DSCR_WORD3,
-                                       TYPE);
-
-            next = zdma_update_descr_addr(s, dst_type,
-                                          R_ZDMA_CH_DST_CUR_DSCR_LSB);
-            zdma_load_descriptor(s, next, &s->dsc_dst);
+            zdma_load_dst_descriptor(s);
             dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
                                   SIZE);
         }
-- 
2.20.1


