Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D2C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBC3217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JElk8Zfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBC3217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfId-000085-Uu
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf70-0001oQ-Nn
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6z-0005yb-Dy
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:34 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6z-0005yH-71
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:33 -0500
Received: by mail-wr1-x429.google.com with SMTP id q10so1063904wrm.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PKTXExoANFsgS8Ee5P5ychq32drqafI8xSRUijLe4QA=;
 b=JElk8ZfxaW0vbZWvuPu1QPzma+S3K3fJVaonIU/j1yuhmR5IW39bJDdwe3iLp8oE5w
 HHw8dEY91yJ817/BTm271Idh5KPIP05Bgnce/DIQ7a365CmYoKNm7Buqwob9rDf423fp
 N4yGaS+KdCYCO/j16NdXFWodkiebJuKGupd8GQPKEWrdxE5CH231YiUnAxetCS1B5R2G
 TGvETPjtg0DeLF48CR/QZTfCQ+SneeJMu7lZRrhjAfpDirrsSxSSvlNVsqKKCqRL6td1
 4lVTyNcGUnmkKp9N+BUvqlYLuT9jhAYCvbBZ/9up8JoAw6hets6MFfRLRdSBISe+hAMg
 mlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PKTXExoANFsgS8Ee5P5ychq32drqafI8xSRUijLe4QA=;
 b=BhLxez0F/BDJQ+F2LRHymz/y9sAiSRin0squMD9E2rl5ksJu9TGIfhArgtMdS0CsKd
 LmteGEJS+BO9f894aMHmZELiZ7QUd3wd5njOw1htIj5HZG/MY73NeO8VhBTke8j3Ipcr
 1eLdu8p0rPRiXKfWppj8dlEv/xuS0h0QNmCWSe10vZL/BaMG3NI3gYiy4RZToYu8Obcj
 J0y5HX8x4NfwSVaAywr5b7Up7/z58a/B0MJaYP/DOsF8uFD9GI9VESUCQLhazLaxo3NT
 M+QWHzFKJlcBOQzT30KMenWT9HpErlo4DadETKDZYW0UwtoRC389ceRvCdnB5/I5j2Mf
 Hbqg==
X-Gm-Message-State: APjAAAX7sVLJ7Nrj1wqzfG8e2PHO96S0C0KrQhELVj4cqgs3J4zkX6de
 ZecGK6Kd9ZqRrelFf2cAl6uNaFtW
X-Google-Smtp-Source: APXvYqx3GuIZj6HIVqFPnrFmVWGegg8mBIv+f9vG+uHM5EQJfVmG/N6htfb2dQYSmGYn16mvbZY0vg==
X-Received: by 2002:a5d:6346:: with SMTP id b6mr1499549wrw.354.1579557692019; 
 Mon, 20 Jan 2020 14:01:32 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/18] tests/acceptance: Test the Arduino MEGA2560 board
Date: Mon, 20 Jan 2020 23:01:05 +0100
Message-Id: <20200120220107.17825-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the path name demonstrates, the FreeRTOS tests target a
board based on a ATMega2560 MCU. We have one, the Arduino
MEGA2560.

Complementary documentation:

https://feilipu.me/2012/01/15/ethermega-arduino-mega-2560-and-freertos/
https://feilipu.me/2015/11/24/arduino_freertos/ (see 'Compatibility')

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_avr6.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
index 611f6a62a4..b644d2a81c 100644
--- a/tests/acceptance/machine_avr6.py
+++ b/tests/acceptance/machine_avr6.py
@@ -27,7 +27,7 @@ class AVR6Machine(Test):
     def test_freertos(self):
         """
         :avocado: tags=arch:avr
-        :avocado: tags=machine:sample
+        :avocado: tags=machine:arduino-mega-2560-v3
         """
         """
         https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
-- 
2.21.1


