Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D244C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C16217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfe02ht2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C16217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfFq-0004TB-Q3
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6y-0001mD-SP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6x-0005xj-PY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:32 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6x-0005xZ-Jb
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id q10so1063855wrm.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xg0HdeiM+XtBmFtO3KRtANHzmSdpyDnaxVEyGkgZkR8=;
 b=rfe02ht2iq5YEKlmbe/kcIYVoissh8/cW66pIlwxIsuphyLhCINQYi0ARGCmojmh8z
 8uDV6ZmwidAx35oKiQ6wzqN9kdfzB8SQvocksef6rGVb/9idrdbTFJj3BCheIBekcv2C
 +ZOZWj1zmpI7jpt/OrFQlazEcQ7ghOX41r/N8YqLS299/vvw3Ua21ABZReOw3T96rqpo
 qCDUw8t2+zkjmTLLnwzscaDSfG6qMc+0T5frKPdqNHkp538LQtekeV3NWOnnzW0+eUbW
 NVVHbqIbXtdGGKNMCt4A2YHbjR0v/MVxGDFRBZXSju1jFqgGdwLV1mXOLSgW3Hi0pGrw
 CcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Xg0HdeiM+XtBmFtO3KRtANHzmSdpyDnaxVEyGkgZkR8=;
 b=uOVqoNN385dxkRTXRRr3PQV17qErE0gowHKkWcx8nNaBqfFJdQvgRoWkluUtP0JYI0
 EKEds5h2iYvUyUy2TqQQ+sKIU7l9nnlm2MgDRHpeAUApOGl5o8TXySRIcp0sFFQS5gHw
 sgdfeqCA0dIaxPn3ovLRDI/KrmiOsYQK1ARyTrVgyuoj8Fre2Rn32bfBGJVZPJxmooQL
 hvwtUUO+8NzYijBWXypvBURah2ua/xRDZ8Q4g1nedQJHxrQzDojTMyqeLjln5aWb/qtT
 cE41HsxPpUGOo06YV4dq5tMjBdTS92LoGnk7VN3QBi16IRYd1RAp0GcISO+Uz5b9W36+
 lhtw==
X-Gm-Message-State: APjAAAUEbDTF32GwWw5W4x8gsJuRx1TIMnwoFmv1Kr0MJ0GTZZ5C73Hl
 bjVdniO7Zul/PdYazdaYRb4u3mSq
X-Google-Smtp-Source: APXvYqyABbklxgpRz0UDe8cX6hPRKiHVf7KY+Dd5muUHOa0w+afZyqEEpzFhlLASxNr56CiOQP4kvQ==
X-Received: by 2002:a05:6000:1047:: with SMTP id
 c7mr1486452wrx.341.1579557690509; 
 Mon, 20 Jan 2020 14:01:30 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/18] tests/boot-serial-test: Test some Arduino boards
 (AVR based)
Date: Mon, 20 Jan 2020 23:01:04 +0100
Message-Id: <20200120220107.17825-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Arduino Duemilanove is based on a AVR5 CPU, while the
Arduino MEGA2560 on a AVR6 CPU.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/boot-serial-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index e556f09db8..582a497963 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -113,6 +113,8 @@ typedef struct testdef {
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
     { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-duemilanove", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-mega-2560-v3", "", "T", sizeof(bios_avr), NULL, bios_avr},
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
-- 
2.21.1


