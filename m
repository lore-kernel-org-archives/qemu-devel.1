Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E7C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088AE20722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6iln52n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088AE20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wTh-0000nc-S1
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSX-000805-Vp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSW-0007Bv-W9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:17 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSW-000791-I3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:16 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so22413760wrl.13
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZEnCz22/lMoX438dE+AVCeyGWeT3h5NvPmvnHleFQyA=;
 b=l6iln52nRqYuloUTsipGqEbsTvYJe3SlJ28+5HGa44iYEIqpLX+vW09TzBVZUQrm74
 7oJ/HDdniVc/Puejnf33dYmHLiHhNoN8AkYX+UmvyDfFCqnzXDjux67EMAl/aI6QLACL
 YG09l09dTvAZbp/whf4H1CVystMvcXbikU2nEBfypgKjVPuV60yqRxmUeWJojFqSLVa3
 uUBQfKs/cg8kH8gCfHuRre34UkgZuuAC/HZYaQj5X9/2r4rNX1H/HJ9Pf1EMDe2FA2pI
 bTTiLlVo8EnNfnOyThwESSiPB6Efa7CMPJKy0RlqbUeG0aMCHz4Ic4bDnfofW0R3QQM7
 pFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZEnCz22/lMoX438dE+AVCeyGWeT3h5NvPmvnHleFQyA=;
 b=TJHuFabst6fN7kQzRSPw/3Hi2HHPXQlJDUGCAJJMIqbnQCnicjnQ0M7LGe7F/tSNUG
 T9fgNiMI1qutZHzRraYw0d1JAJyMQPsSx0Oe7dE3mjlGgPNTeU/XDuIQ2rdgQ+OzsboN
 tRGdxPTVhQvPfnQThu1uLqIS9sGUZZXeQQDgYJxL0mxatqkSzjk1ddM2k3ZgOGtidLVx
 PcmyBFIwuU3rM/JxNFDvLaqT54b+aIY6hNOFiksToO7T0aOj70ZLoZdldftRtSSYII/U
 4FiYHuFFmYhAOOskLbGoagmjLRdCth+c6lX0f6dQvFwFxeRaIFui0VznRhpQ0imC+1zP
 jVzg==
X-Gm-Message-State: APjAAAU6OgdL+hahEhFSlOHLjdrjGxEGy66pgei+F25QpXROq2zJEtG1
 fZIL/duB98NREqKQA0gBzh0=
X-Google-Smtp-Source: APXvYqzBmrRQq+e/Uo5HTRLbcne9TquDRtGvVgpwh0YoWASbhAKH29BTLWxDWuB/kxV7gVgvDCk1rw==
X-Received: by 2002:a5d:560d:: with SMTP id l13mr774391wrv.222.1582007638595; 
 Mon, 17 Feb 2020 22:33:58 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y7sm4374683wrr.56.2020.02.17.22.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 22:33:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 1/4] hw/hppa/dino: Add comments with register name
Date: Tue, 18 Feb 2020 07:33:52 +0100
Message-Id: <20200218063355.18577-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218063355.18577-1-f4bug@amsat.org>
References: <20200218063355.18577-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a comment with the name of each register in the 0x800-0x8ff range.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/dino.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 9797a7f0d9..c237ad3b1b 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -85,18 +85,18 @@
 
 #define DINO800_REGS ((DINO_TLTIM - DINO_GMASK) / 4)
 static const uint32_t reg800_keep_bits[DINO800_REGS] = {
-            MAKE_64BIT_MASK(0, 1),
-            MAKE_64BIT_MASK(0, 7),
-            MAKE_64BIT_MASK(0, 7),
-            MAKE_64BIT_MASK(0, 8),
-            MAKE_64BIT_MASK(0, 7),
-            MAKE_64BIT_MASK(0, 9),
-            MAKE_64BIT_MASK(0, 32),
-            MAKE_64BIT_MASK(0, 8),
-            MAKE_64BIT_MASK(0, 30),
-            MAKE_64BIT_MASK(0, 25),
-            MAKE_64BIT_MASK(0, 22),
-            MAKE_64BIT_MASK(0, 9),
+    MAKE_64BIT_MASK(0, 1),  /* GMASK */
+    MAKE_64BIT_MASK(0, 7),  /* PAMR */
+    MAKE_64BIT_MASK(0, 7),  /* PAPR */
+    MAKE_64BIT_MASK(0, 8),  /* DAMODE */
+    MAKE_64BIT_MASK(0, 7),  /* PCICMD */
+    MAKE_64BIT_MASK(0, 9),  /* PCISTS */
+    MAKE_64BIT_MASK(0, 32), /* Undefined */
+    MAKE_64BIT_MASK(0, 8),  /* MLTIM */
+    MAKE_64BIT_MASK(0, 30), /* BRDG_FEAT */
+    MAKE_64BIT_MASK(0, 25), /* PCIROR */
+    MAKE_64BIT_MASK(0, 22), /* PCIWOR */
+    MAKE_64BIT_MASK(0, 9),  /* TLTIM */
 };
 
 typedef struct DinoState {
-- 
2.21.1


