Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E2DC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96C6222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okj3QJqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96C6222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2O8u-0002ep-0X
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7G-00085N-CC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7F-0002sB-FQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:54 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7F-0002r5-9X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:53 -0500
Received: by mail-wm1-x341.google.com with SMTP id g1so8141340wmh.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZHa5SRLQcSqztFZ5l0K3j51fwiOgQoZhIG6RRALjXP0=;
 b=Okj3QJqiCbysVu+BVIj/KLbMa7A4Zfx4eVBxOlCVRgqLkhKc6QmzWPnj/nfI+6GoI4
 QgpkyXOHfGG2AFx4aWoiX1CLLsdjc6mbIhN8JmE8Tn0XmyigWQTNNt/w9fuURKCgvSwz
 5S/lgq5Hs4S6TnTpDitQNjweDDNSGN18T9AiwETwEhofJH2TkQ/CQJJCi4JojQKGrwXN
 X+eXMrqB4DgplXxIa5oPmkvJSIGmwmavhL59WfC1p9AKqk7VdOU2yy3u9RZiDih31BDN
 MBFuBYenUj1c6tAftM86BwCrxJKXeT+3YjuF8dAEwCh/Nix//uyY3Asr5hGgecHlVieu
 AitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZHa5SRLQcSqztFZ5l0K3j51fwiOgQoZhIG6RRALjXP0=;
 b=ZgFQ5RV+ZAX6gNY1E6RkiFRo0VDUp8tx4LboiAxFxVKynd/4bjZXVH23Hkoz8toL9k
 vrri1IYkg3ch7Kk/bgKNZ+W2tic+jXjYSusprVXSbHOFtnuKGIF6FAywdnd7OXqRpFP4
 5rIrV6xtvws9vVwiV+kPzuy+fzTzzMs7z+ymhF1ewXikdRpR0oovKu6lUYev/lhwMIye
 Opd2hJJsffyUrHqAbxMvQ3Mb8CSYRsc3RwOZBndVVe4ySahreRWoOCqm6ZUORinDq3Sp
 FO29JV8tLLoJIFvdnR4oh7/yC3ouMGQuPPL+3f/AJY+Wf2BmxNwg3gER4CHZMIk0MQ3i
 inHw==
X-Gm-Message-State: APjAAAXE2iLqIp3z5yxe6hCkU+fJKH45QhKANBcPTMeXdtMu6zml5EGu
 pvQLpxtUGBfVV1LlLqFXm5E=
X-Google-Smtp-Source: APXvYqxZ+odHaJBHz9q4yVEwdmlLlAXXiqI/kzR/Kx7fb36riS77Kuz9Jh0+B8K/leT9iEuYkSAInw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr460247wmi.45.1581637312329;
 Thu, 13 Feb 2020 15:41:52 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d4sm1521065wra.14.2020.02.13.15.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:41:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 1/4] hw/hppa/dino: Add comments with register name
Date: Fri, 14 Feb 2020 00:41:45 +0100
Message-Id: <20200213234148.8434-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200213234148.8434-1-f4bug@amsat.org>
References: <20200213234148.8434-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Add a comment with the name of each register in the 0x800-0x833 range.

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


