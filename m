Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC1FC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72A02071F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7lxyamU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72A02071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia95C-0006wl-TW
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xD-00067T-Lj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xC-0004Sw-F3
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:47 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xC-0004Ri-8E
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:46 -0500
Received: by mail-wr1-x442.google.com with SMTP id w9so29149335wrr.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3BT3meJheG4+qZxzcdyTyi7aZ+LLbjh+2zS7fhUeV8o=;
 b=V7lxyamULmYm0JNSFEaEm5URDVCz11S7Smo2ba4Fpy2j4A+iB2kD3bNkL2zAN2lkgw
 ss46HPEUX0OHpAv9anJzZGdK7dbH4u0AF+frvglp190qsIGiAB/iNlgS96oYmWxFyEII
 F5CUHlTK1e4HvNhgairh+Oj/I/ow07GUNDupjjy1MS44Xw6M+0cNMZuh0AISP2WiZZv6
 03O5MRgpX5ntrIGGppQy3auaQ7yIUP018XMzrV2SinoxavDFOZod9En304MjWhRnAJir
 TgPO4l02mAY77CNblDirea4zYp6u72mbKshsIsvRyQfD+8VkTMxY45TfvEMKvV4qpC8o
 2fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3BT3meJheG4+qZxzcdyTyi7aZ+LLbjh+2zS7fhUeV8o=;
 b=aIWHGKhvPt35TY6ghjZ61z5UA81T+3ZobnUfgNJ8nY3w+j8VjbHgouTq9dEIO6c2TM
 7ZLiNYUPxupKPoOePrIXaIGGsg/xz2z8BtOxyDqsJU3GfRvrsPx8LID7Qv9oga7ThGsk
 SRU4cMa+hy1vmb4u6676euXmqEQKu3/kt7BMNEsnysLg08TWob4B5pJZX6zviuo0ZDaN
 +GsxYALE9jRGP2q+qKngNIUwpV7NsLHj/6GbIWkkma3CTdRwdaFG1T5HpuQxD9wj0KRV
 rP2JeDZJwuhiKnO6Zd3bYMJFdPueXoAaZ4DYJWZ+6AszhGKf2AYK099cB2cXBBlV05bt
 jXiQ==
X-Gm-Message-State: APjAAAXD4nf7BrXWZopwbwzTka1Lfp/iwfCP4wMR1AW2q8Asym6YQ0+E
 1xl0778kbmTEdCLA/EwngDV38fvR
X-Google-Smtp-Source: APXvYqx2jYNlrywBT4RRgikYXDDz5RNk+//Py3wtRrzfM/DmLJZ2f8XScZTGwC3gSC6Pau5+GAep4w==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr21946010wrm.213.1574905845092; 
 Wed, 27 Nov 2019 17:50:45 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 08/10] tests/acceptance: Keep multilines comment consistent
 with other tests
Date: Thu, 28 Nov 2019 02:50:28 +0100
Message-Id: <20191128015030.27543-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_avr6.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
index ba1f47dd70..2ef4a9ac2c 100644
--- a/tests/acceptance/machine_avr6.py
+++ b/tests/acceptance/machine_avr6.py
@@ -37,9 +37,9 @@ class AVR6Machine(Test):
         https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
         constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
         """
-        rom_url = 'https://github.com/seharris/qemu-avr-tests'
-        rom_sha1= '36c3e67b8755dcf37e06af6730ef5d477b8ed16d'
-        rom_url += '/raw/' + rom_sha1 + '/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
+        rom_url = ('https://github.com/seharris/qemu-avr-tests'
+                   '/raw/36c3e67b8755dcf/free-rtos/Demo'
+                   '/AVR_ATMega2560_GCC/demo.elf')
         rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
-- 
2.21.0


