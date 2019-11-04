Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D453CA9EC9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DE8217F5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=holoplot-com.20150623.gappssmtp.com header.i=@holoplot-com.20150623.gappssmtp.com header.b="CpVDj8d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DE8217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holoplot.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRkSo-0005K9-Ex
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 17:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.ziegert@holoplot.com>) id 1iRgu4-0008MP-VC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.ziegert@holoplot.com>) id 1iRgu3-0006Zg-Oh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:16:36 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.ziegert@holoplot.com>)
 id 1iRgu3-0006Yv-8l
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:16:35 -0500
Received: by mail-wm1-x342.google.com with SMTP id c17so10418285wmk.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=holoplot-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vZlHRNrWzOSLywQj2MWXmHR9NXbEechkL9y1Q+q5kes=;
 b=CpVDj8d5jarBg9AgbBvLnr6G6Ny10ptuL3kZjzoDBd/JJ1TxIz4daZ3n0jHlAm3BAd
 Kk/0GLs+FBfikPVkJh6lQuPDV5btsM1aNBVdizVGG5jVU0R1PeLpgfRDBN5heeYQu5mh
 RGLCtOREljfsAiN3PGj6zcG2IMx0vwpyqlgEQRJNg1sZanVZWopFW71euSuI0UMxbEV7
 CJfQgjfq2rNCJJgaPzGLEC0vGXCLhlMFxbkGaux7TX5iko/wxEh/rOsMCGRd6cmWqN/l
 eUIZlRGh2p0ZLSgKQFlildIzK3Tti0xNoHQMXzr4oXy/YzSAW6/wgCHix/KQlMVuJ+aO
 DxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vZlHRNrWzOSLywQj2MWXmHR9NXbEechkL9y1Q+q5kes=;
 b=icrCh2ETmCGVYTjJTqUetq68LPl9kN8d0rpIVm1ronEk5ZknM8cKvnZvHgqONVLmRv
 nEOwIzOx43bRQstu1fnW5dvmjW1oAP1/2GawzfM0+ISg+uiDAHzMTNVydFknDVByD8At
 KLyUeHuipYEC83nXO7GQ/+3TuCxNq7C16Cum38xKlwQvn7BGBxjxm96sUdfoXHuhaJjV
 RvnOrVaLmf0YNxCvIukiveBpcshlTVskGMICvgUQfko8EZkIsJfbbbhzHBzbSJnFEptf
 7oWZ3Awju6B48geF88eCz8gr0cEC/HC7dXUYGOghShbeRDJuTa/YmCb8IxE8+4ueE3LP
 xpgg==
X-Gm-Message-State: APjAAAU6Vl3bvDQGH8imrG7aESW4SI7GvlH/XELYk0JQj6HLtWCuklW0
 pozbPkyBUW24GaUdFLLreV4lYp/Yo3Dhg3Vu
X-Google-Smtp-Source: APXvYqwBEg4tldsJiHmHURGcHn6YbY28cQeit2IjyAhc+ybQdMfmv/7xH2K7N29EQBRFNPNaGm84qw==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr408194wmc.130.1572891393265; 
 Mon, 04 Nov 2019 10:16:33 -0800 (PST)
Received: from localhost.localdomain ([194.162.236.226])
 by smtp.gmail.com with ESMTPSA id q15sm17165703wrr.82.2019.11.04.10.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 10:16:32 -0800 (PST)
From: linus.ziegert@holoplot.com
X-Google-Original-From: linus.ziegert+qemu@holoplot.com
To: qemu-devel@nongnu.org
Subject: [PATCH] net/cadence_gem: Set PHY autonegotiation restart status
Date: Mon,  4 Nov 2019 19:16:04 +0100
Message-Id: <20191104181604.21943-1-linus.ziegert+qemu@holoplot.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-Mailman-Approved-At: Mon, 04 Nov 2019 17:02:21 -0500
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Linus Ziegert <linus.ziegert+qemu@holoplot.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Linus Ziegert <linus.ziegert+qemu@holoplot.com>

The Linux kernel PHY driver sets AN_RESTART in the BMCR of the
PHY when autonegotiation is started.
Recently the kernel started to read back the PHY's AN_RESTART
bit and now checks whether the autonegotiation is complete and
the bit was cleared [1]. Otherwise the link status is down.

The emulated PHY needs to clear AN_RESTART immediately to inform
the kernel driver about the completion of autonegotiation phase.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c36757eb9dee

Signed-off-by: Linus Ziegert <linus.ziegert+qemu@holoplot.com>
---
 hw/net/cadence_gem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7f9cb5ab95..b8be73dc55 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -271,9 +271,10 @@
 #define PHY_REG_EXT_PHYSPCFC_ST   27
 #define PHY_REG_CABLE_DIAG   28
 
-#define PHY_REG_CONTROL_RST  0x8000
-#define PHY_REG_CONTROL_LOOP 0x4000
-#define PHY_REG_CONTROL_ANEG 0x1000
+#define PHY_REG_CONTROL_RST       0x8000
+#define PHY_REG_CONTROL_LOOP      0x4000
+#define PHY_REG_CONTROL_ANEG      0x1000
+#define PHY_REG_CONTROL_ANRESTART 0x0200
 
 #define PHY_REG_STATUS_LINK     0x0004
 #define PHY_REG_STATUS_ANEGCMPL 0x0020
@@ -1345,7 +1346,7 @@ static void gem_phy_write(CadenceGEMState *s, unsigned reg_num, uint16_t val)
         }
         if (val & PHY_REG_CONTROL_ANEG) {
             /* Complete autonegotiation immediately */
-            val &= ~PHY_REG_CONTROL_ANEG;
+            val &= ~(PHY_REG_CONTROL_ANEG | PHY_REG_CONTROL_ANRESTART);
             s->phy_regs[PHY_REG_STATUS] |= PHY_REG_STATUS_ANEGCMPL;
         }
         if (val & PHY_REG_CONTROL_LOOP) {
-- 
2.21.0


