Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D2CC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421742087E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRjyv3Fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421742087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRl77-0000Hc-9V
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 19:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5V-0007EL-0g
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5R-0006m9-0n
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5Q-0006iY-Em
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id u127so8649371wmg.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zzy57pNEhs2f791KQEcET9NOuU+baFBolmqcxp5hb4k=;
 b=KRjyv3Flp2igbZSFmZiPHBeSM9+NjI0IJFxBnHnVhzkhlcqyMYXUiqaAt1GU1Lu8Iv
 13wtjVOIqrLxi05OwHTlPXubU2zB1xYRoiH2IXUtIivHXNPAkGi21qasrcbZv4ACS0Ro
 kEHQu3N/XrhEo+5fmnXrU7VccYECtUsQOLQaoKAlcslrx2R1SWLNaxADR3v+tmUeYVxP
 2TuXpCW5ySY84ZDinSsU4D74MM09ZRKwAvm5JQ0hBhz3BFOGBSdo210z2gPI6DKKUcCR
 +YFXKHS50qM1W79y/zBKjdwSigsTmE8tWonvHXHVc129936Uc9aFtQ+78JeG5I05dfiI
 3Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Zzy57pNEhs2f791KQEcET9NOuU+baFBolmqcxp5hb4k=;
 b=Ng2PUFiYsAqxuUeEsExeP4VjMVMOQ9jkCA7la37kOSwGX5e0ovzz8nPA4fuo92sb2b
 IpG6KnHH7OkugZdHqA2GC6zpP4SoU26M/U7ZTBKq73CYy/8iL216Ta2qm0z6Zzbi46kn
 4T4irX6Q2gJgWTqC4BbvwAvWyK1xAUu5Z7ZjbcGS7lh9UCW3+/9kGYNUDOQRgN1054lB
 obeXZJ3uObcw2XzhTq/lnZw51VTxTLfPXLx8VOZpe/fOKELNhPj0K2/bbNKojdvG90VD
 dPgxVXZOAvjMfJOi+ZZ4oCFGw01UsbOVLINvVucOq157zn2rtlKFjaqZZVolrvu66NgA
 47JQ==
X-Gm-Message-State: AGi0Puanqp27oj+NTsecVsk3yr89RSJ+zdd4wzxKYVJaFb8QcVDz167W
 Bh5okcocDFtANlbY8EZh+CVDC5/L
X-Google-Smtp-Source: APiQypKNLaXSB8e5qYj2hk2DCTpxJNPC9nfi+qUSHaCMWnOGZTCnysYwtvi1lEr8G6pI/qGYLAGm8g==
X-Received: by 2002:a05:600c:2214:: with SMTP id
 z20mr7172214wml.189.1587683808667; 
 Thu, 23 Apr 2020 16:16:48 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h13sm5498122wrs.22.2020.04.23.16.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 16:16:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] hw/net/tulip: Fix 'Descriptor Error' definition
Date: Fri, 24 Apr 2020 01:16:42 +0200
Message-Id: <20200423231644.15786-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423231644.15786-1-f4bug@amsat.org>
References: <20200423231644.15786-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bit #14 is "DE" for 'Descriptor Error':

  When set, indicates a frame truncation caused by a frame
  that does not fit within the current descriptor buffers,
  and that the 21143 does not own the next descriptor.

  [Table 4-1. RDES0 Bit Fields Description]

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/tulip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/tulip.h b/hw/net/tulip.h
index 97521b21db..5271aad8d5 100644
--- a/hw/net/tulip.h
+++ b/hw/net/tulip.h
@@ -211,7 +211,7 @@
 #define RDES0_RF         BIT(11)
 #define RDES0_DT_SHIFT   12
 #define RDES0_DT_MASK    3
-#define RDES0_LE         BIT(14)
+#define RDES0_DE         BIT(14)
 #define RDES0_ES         BIT(15)
 #define RDES0_FL_SHIFT   16
 #define RDES0_FL_MASK    0x3fff
-- 
2.21.1


