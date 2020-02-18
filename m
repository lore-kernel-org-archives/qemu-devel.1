Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB36AC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97ADA20722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeG+AhwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ADA20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wTm-0000qN-RT
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSX-000800-Tj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSX-0007C0-00
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:17 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSW-00079N-I0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:16 -0500
Received: by mail-wr1-x443.google.com with SMTP id k11so22425013wrd.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CUTlMRFxyq2wU+LUYyVinYtmHtyQQUF4r0SxHNLjeD8=;
 b=oeG+AhwDUFvFRJyX2fwfNVyU5x03r9TTB6xe+hEeaxunodkEbK/HRfqQUyWxMI84AQ
 WdBn1TMYMP07wS8Y0I7KFX2fcW/FOGvCbK0W91yTWmQYIOGYi4Bw4VOYXyPFAQb4+A79
 kOOeS5NybxhNO4BhKpVP2sE6eNOrG6myMpn28ArbWN43M8r4VXlTtk00wUBDc/3nyM5w
 iDYZG4d3VDkow5hM90pxdgAHRHZpNu4P/NvhWCDtIOdxyuhiRMxKfiRgcMA27Kmo+PFm
 8PTfkAxQa9q8jnWnE4RPAPT1Fjxg1JnlroK20NnyfYm5oAVsE3djLxVBWhY3tl8RaaGX
 rV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CUTlMRFxyq2wU+LUYyVinYtmHtyQQUF4r0SxHNLjeD8=;
 b=h+6SGdWZ/5L7ZEvgebySPSmb0f+4Th6+hkvJI7i6Xw1HiuuPfSVIUIOe+9tpKrOX0x
 hnp0GaUUewOHh9jZ8V2CIJo23vcONwtikF5Rb6CGmO3r5hcYgoqVEHVy0RjKp2sZuJWf
 uceCMzRk/d0MzKCaIJXjqt0pDATUGJH8YG4QRKDSroF1uI1MYFxlrauzciNMqYvV0u1y
 VjfkXCJID6nZLJJOiZ6+jsxUXJ9Wlf4DEbU9z8hKhj6zpbxJgTVRsqRYNTXN/KaVJLGp
 L+W+LsnExRiEVzPcbzY79Iv5QVgnHwANqT3PK6YfKqNG+lndO0xEC8vanlU5C1qE49mL
 ZElQ==
X-Gm-Message-State: APjAAAUuWx2GJTkw24CCpgCyMgLhnYttE+2hHCWrkZ+OsGA97B74BMFH
 OWmxM6FerHlEgYW59Rc1WaK0O4tS/W8=
X-Google-Smtp-Source: APXvYqxgMjtJSe3WaFRTTAc8LrGMW8wBmhS6snDuEJIFac5xGPdfGR878PufVfWcCDo06bAf7WGYxA==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr26317307wrb.407.1582007641102; 
 Mon, 17 Feb 2020 22:34:01 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y7sm4374683wrr.56.2020.02.17.22.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 22:34:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 3/4] hw/hppa/dino: Fix bitmask for the PCIROR register
Date: Tue, 18 Feb 2020 07:33:54 +0100
Message-Id: <20200218063355.18577-4-f4bug@amsat.org>
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

Only 24 bits of the PCIROR register are documented
(see pp. 37 of datasheet referenced in this file header).

Acked-by: Helge Deller <deller@gmx.de>
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


