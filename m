Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E87C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2397D20723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2397D20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jewLE-0007uc-Be
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 03:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jewJS-0004bz-Ed
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:53:51 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jewJP-0006oF-RP
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:53:50 -0400
Received: by mail-wr1-f51.google.com with SMTP id j10so6348762wrw.8
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 00:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wFdBnHgQNGk6NbYxej0U62uLjbPptI9VkmjnafRHsSg=;
 b=HiEH2gkubuhojlfm8YrQn/Xvk7DXPJ+CG0Qf/sCns/6yBuyNf9r5j8PUINbh2hHgMA
 inWusxfrKoXoPy+ftZFu9+bLv51pfdQ73HjfakM6FmVGu6S3/0m39mv3H0VQaia7aMiP
 EAKa/GItSjw1aq7cUdOTZ5P2FgHnmEWvHMXoMwWbYKNchDFtlX4atgSNX0BJl138TBIr
 P3qT6NjSZbkGFlqrxGIobnpxKOi+viYghl7JUn303hq+dUPL6XLzJL/EyV5TY3d3zHFU
 i9UM3BAF1tu06CjNdBGS7UCOepGqMWhb+EcRTJymWSNvBswvFJ0u7+1ke10y4Rofhzug
 IVCQ==
X-Gm-Message-State: AOAM533XnJ0HxaNQJIFbLJCvVK8vu3y0Na+STJtL+bnRQMorgrsjwJdX
 VVMkYd+xBMGt4yDoTK9YE5u6Rd4N
X-Google-Smtp-Source: ABdhPJwXNofOZJRTJTzOsfBhyTPChSPOo+vb2h/dCmqs6vumSWdjhmw1GAf9PfBmaSeJYd9mAAw9Cg==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr13524742wrs.292.1590825226370; 
 Sat, 30 May 2020 00:53:46 -0700 (PDT)
Received: from localhost.localdomain (x590fef72.dyn.telefonica.de.
 [89.15.239.114])
 by smtp.gmail.com with ESMTPSA id o20sm13139310wra.29.2020.05.30.00.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 00:53:46 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/2] hw/m68k/mcf5206: Reduce m5206_mbar_read/write() offset arg
 to 16-bit
Date: Sat, 30 May 2020 09:53:19 +0200
Message-Id: <20200530075320.18854-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530075320.18854-1-huth@tuxfamily.org>
References: <20200530075320.18854-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.221.51; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f51.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 03:53:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

All calls to m5206_mbar_read/m5206_mbar_write are used with
'offset = hwaddr & 0x3ff', so we are sure the offset fits
in 16-bit.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200526094052.1723-2-f4bug@amsat.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5206.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b155dd8170..187291e1f6 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -273,7 +273,7 @@ static void m5206_mbar_reset(m5206_mbar_state *s)
 }
 
 static uint64_t m5206_mbar_read(m5206_mbar_state *s,
-                                uint64_t offset, unsigned size)
+                                uint16_t offset, unsigned size)
 {
     if (offset >= 0x100 && offset < 0x120) {
         return m5206_timer_read(s->timer[0], offset - 0x100);
@@ -306,11 +306,11 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
     case 0x170: return s->uivr[0];
     case 0x1b0: return s->uivr[1];
     }
-    hw_error("Bad MBAR read offset 0x%x", (int)offset);
+    hw_error("Bad MBAR read offset 0x%"PRIx16, offset);
     return 0;
 }
 
-static void m5206_mbar_write(m5206_mbar_state *s, uint32_t offset,
+static void m5206_mbar_write(m5206_mbar_state *s, uint16_t offset,
                              uint64_t value, unsigned size)
 {
     if (offset >= 0x100 && offset < 0x120) {
@@ -360,7 +360,7 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint32_t offset,
         s->uivr[1] = value;
         break;
     default:
-        hw_error("Bad MBAR write offset 0x%x", (int)offset);
+        hw_error("Bad MBAR write offset 0x%"PRIx16, offset);
         break;
     }
 }
-- 
2.26.2


