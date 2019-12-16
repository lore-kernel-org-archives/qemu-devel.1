Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F321C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38197206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDIr5UjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38197206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoPM-0002YB-0A
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFd-0007c8-Fc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFb-0007lM-8j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:21 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFb-0007kH-2P
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:19 -0500
Received: by mail-wr1-x436.google.com with SMTP id z3so6731899wru.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QD+79veTer7FPiPBdF+SAJ8aBHWDVP6IlE9SRsgpnIk=;
 b=cDIr5UjBL8ljfe4FCdbjYixpga6PbOSVaVEEwERydB8SSbV2jL6/45nKYk8HZsetrc
 pTbdBXO8PWgC0mvrJf3Xb/h2gimHYQTAz0miOH97yz9YapPL9dsnH+0pk3GuRmD6cMN9
 Ze1z6MhNGZN33v5XnKTjuCFO0Ag4aNR56r0JXVx65L/3kSSFClt7jnrI3wTQnUzxofC2
 J9o1SIkP32UeGd5L6kEExkHeTxi9niUEzGBfW0xNsvFY8GOBZtMqqVWFnhUU0uGfWjUm
 TRCwidkV7nWz5chgVoovltkM6iZkK4QPjJ1/YmhiLbPLLFLMR+kpxkq/LhUgpVzLLDJV
 RvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QD+79veTer7FPiPBdF+SAJ8aBHWDVP6IlE9SRsgpnIk=;
 b=oHtAWgXHrFwUGAHiIYgjHQEbfuks6UPAKPDSpCYwXq2VCilsmqnNedlYzkbg14w0+8
 UD9Xub4hNWx9V9SND6xbH/44Gf80YPFo7NG/plisqhVfnKSH4jTeXuVrxp55TiGS9fvn
 DJcWnDSNrrYdfgfiSpS1f7cMiFZByUCIc4u/4L5aX7h8k4ub3PRy9wgcc3oDVsAFsG4U
 7rdJlxhduAxPoBvtpvIxVhh96nWuLbJmRWIr8cT+I8811F2wBeB8NRcjxiUO2z4rt1aQ
 9YCnN3zwVuKjEBGUhFmeXX+ARwTzLoD77LkOjqXoPPcXRjvevOLOsAFHg71HlxmUDMv5
 LGyA==
X-Gm-Message-State: APjAAAW/iTMGeF+Sc4l9YWoNapU5GwGZ3bJ+cz76xW28gVT/lVl8Nkx1
 49IW015VuYQtukkRS5TmrZUqVfP9hYOpzQ==
X-Google-Smtp-Source: APXvYqwAnmK5wEykYwcKL8U8sceOxLdk0DZjq1OaHsnP61DlZQjVFJp1mZ8OQAmup8mng3iBSG3LQw==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr28467027wro.209.1576494557935; 
 Mon, 16 Dec 2019 03:09:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/34] aspeed/scu: Fix W1C behavior
Date: Mon, 16 Dec 2019 11:08:39 +0000
Message-Id: <20191216110904.30815-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

From: Joel Stanley <joel@jms.id.au>

This models the clock write one to clear registers, and fixes up some
incorrect behavior in all of the write to clear registers.

There was also a typo in one of the register definitions.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-8-clg@kaod.org
[clg: checkpatch.pl fixes ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_scu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 717509bc546..f62fa25e347 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -98,7 +98,7 @@
 #define AST2600_CLK_STOP_CTRL     TO_REG(0x80)
 #define AST2600_CLK_STOP_CTRL_CLR TO_REG(0x84)
 #define AST2600_CLK_STOP_CTRL2     TO_REG(0x90)
-#define AST2600_CLK_STOP_CTR2L_CLR TO_REG(0x94)
+#define AST2600_CLK_STOP_CTRL2_CLR TO_REG(0x94)
 #define AST2600_SDRAM_HANDSHAKE   TO_REG(0x100)
 #define AST2600_HPLL_PARAM        TO_REG(0x200)
 #define AST2600_HPLL_EXT          TO_REG(0x204)
@@ -532,11 +532,13 @@ static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
     return s->regs[reg];
 }
 
-static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data,
-                                     unsigned size)
+static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
+                                     uint64_t data64, unsigned size)
 {
     AspeedSCUState *s = ASPEED_SCU(opaque);
     int reg = TO_REG(offset);
+    /* Truncate here so bitwise operations below behave as expected */
+    uint32_t data = data64;
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -563,15 +565,22 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data,
         /* fall through */
     case AST2600_SYS_RST_CTRL:
     case AST2600_SYS_RST_CTRL2:
+    case AST2600_CLK_STOP_CTRL:
+    case AST2600_CLK_STOP_CTRL2:
         /* W1S (Write 1 to set) registers */
         s->regs[reg] |= data;
         return;
     case AST2600_SYS_RST_CTRL_CLR:
     case AST2600_SYS_RST_CTRL2_CLR:
+    case AST2600_CLK_STOP_CTRL_CLR:
+    case AST2600_CLK_STOP_CTRL2_CLR:
     case AST2600_HW_STRAP1_CLR:
     case AST2600_HW_STRAP2_CLR:
-        /* W1C (Write 1 to clear) registers */
-        s->regs[reg] &= ~data;
+        /*
+         * W1C (Write 1 to clear) registers are offset by one address from
+         * the data register
+         */
+        s->regs[reg - 1] &= ~data;
         return;
 
     case AST2600_RNG_DATA:
-- 
2.20.1


