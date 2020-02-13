Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B59C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF112222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drz3xSOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF112222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2O84-0000xQ-W2
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7J-00087h-15
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7I-0002ut-1I
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7H-0002u8-RW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id g1so8141408wmh.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ilhK2PUI4HwKsXGLBT+WPiq+otgNyfY04DB23QrFmJw=;
 b=drz3xSOR4LZ6A0Wf3412j4W/90A2CNH4N3dEE1jfsB8v6//Q0bD5zFIR4eTNzxGU3R
 bHrPTSHSrJlkNmSvY64LavRid6/ghfkXReBneAUROHrCZGAdEO0akBgzhHBkPdqbg58l
 2xmVkJaTmM6jAoe5JslHjjIeE9FjJC8ZMDj/xSlOrd0+JbUoKZTqFBCjKPWvtZqUXKbj
 l5lDqsi9E2wrmnAeH/Ihqf4SGmq6DNS8p01SNnDBuJtq+fBTV3fPxsVSvpccD0bULKSd
 6G7akHZv3jsN6EAmwYGkRrk4DUs+4zftrb/CkkCTOWY4j+RMTiboGqmvkP1s3V9OA4A4
 35Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ilhK2PUI4HwKsXGLBT+WPiq+otgNyfY04DB23QrFmJw=;
 b=PKBKCV6xpBXvFeMSPRexskYlQnSpWv8XqfX/FBPLii74HwfSa5bQJJTN7y3yTzVZKK
 wSNyp/xftXvqGegy4YowYK4FScFAJ/XjNRLXzCm0XY2KQ4WPv2KlpdtgveV+yj3PDmLV
 0Bl7yQmy4Bjib3jS1yWka7XdSa8n5GR6Lhmwf2qCnfudcQDgyBJnGYPvU08jBBjrXhFE
 NKZX4ElK79WPBzhrTHzh/p9b0nvOWAvO/8X8m5St/4SWFZiIeSFqkRBzI/GX3Zm83bqd
 sZeXMudUDQhlNRDfgv8isMeSp9bwb8c1kSgW2v+4wOHiThMK53jU3BF+haUGMKKzytJN
 olTg==
X-Gm-Message-State: APjAAAWpw7r63npEr/RS1D7oEHlq5bx8aYf98SJ6o9ZhtdeNeC5lZVB9
 K5fjVhWnsowpahKL2HASyfo=
X-Google-Smtp-Source: APXvYqzNKajWO2c0dkj5S6zO8WfOOY6l/3S0sFQo9N1MaHQ5/+D6knyPfIw5STgCKyPekmmox6ttRw==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr468548wmi.101.1581637315023; 
 Thu, 13 Feb 2020 15:41:55 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d4sm1521065wra.14.2020.02.13.15.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:41:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [RFC PATCH 3/4] hw/hppa/dino: Fix PCIROR register access bitmask
Date: Fri, 14 Feb 2020 00:41:47 +0100
Message-Id: <20200213234148.8434-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200213234148.8434-1-f4bug@amsat.org>
References: <20200213234148.8434-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only 24 bits of the PCIROR register are documented
(see pp. 37 of datasheet referenced in this file header).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/dino.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 8868e31793..be799aad43 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -94,7 +94,7 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
     MAKE_64BIT_MASK(0, 32), /* Undefined */
     MAKE_64BIT_MASK(0, 8),  /* MLTIM */
     MAKE_64BIT_MASK(0, 30), /* BRDG_FEAT */
-    MAKE_64BIT_MASK(0, 25), /* PCIROR */
+    MAKE_64BIT_MASK(0, 24), /* PCIROR */
     MAKE_64BIT_MASK(0, 22), /* PCIWOR */
     MAKE_64BIT_MASK(0, 32), /* Undocumented */
     MAKE_64BIT_MASK(0, 9),  /* TLTIM */
-- 
2.21.1


