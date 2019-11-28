Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25685C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 02:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1312215F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 02:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veDcFGtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1312215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia96P-0008Cx-09
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 21:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xI-0006AS-2o
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xF-0004XO-Sr
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:51 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xD-0004UY-Nl
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:47 -0500
Received: by mail-wr1-x443.google.com with SMTP id i12so29016006wrn.11
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MeneIUJW45nIc1M+4lSDNKGAKyXAqLAJa4tJHuB730k=;
 b=veDcFGtv+xoR++oyKZceUVyygMMClmOguktgvuNl1Eq8jbIpsgH+dt7ev8GEIb7h9s
 htcGipvD/Cm9lUBzvXkMLpfTczuplpvWDoewsNtMpY/A2IteH69juDltHv0IlYQ7Canr
 ZINyqGkkyuOQCZ5SW7NTFBzQ9zwU6o8BgAy5lRbe0Nxb7IVBhRA+ikKDt3uCiipnoSEe
 xXv9uqGj+Ugxo5pLK6xwzwdvegKBvInhpwFoVreHmvFRPtGJA5o2SSHN5c31HhtuVU9q
 lMu6mWth3TiL11BOgQc/GbDiqSF3KdZdCgIKPZ+CMePVvVFMDpT9dvPwPsS/SAhDLKTF
 4kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MeneIUJW45nIc1M+4lSDNKGAKyXAqLAJa4tJHuB730k=;
 b=AvvM20Jn58WgtEevlAEFkjj1Ifl3urW5Ur4J121KoARFhQs4E4kuO6itSQ8oW5Fndx
 RBJfJskUoHtjGSdEYyRqlJWlHbmy2YPFKonUdRjIw5wFICh1HYyZsa06rmTVD9bebS/s
 8lqB7HBSa3Y5ayUYI9rqsCRuuqoQfQXQZA5qywkJm5Bk0HIdXwTZSRLMAYH8ai+S3YZO
 b6qYTuhAqX3mAi9eTFXXj78DuWInDGpMNKAE4CUh83/lnXZEyBShRU2gLt6Ym9URnd6V
 1qu4oe+2CLB2sdiat1ydB7dN2d1WtXu0Cmtt2zvYgagKeiBbcuFjcR15bGvaf3xnz+Ht
 WseA==
X-Gm-Message-State: APjAAAUwpG4gdAMbV0M91wikozlVkdA7w9uzwkKN8oP2THwn+nj6OnXX
 Cst86o5vLCyfboKrKEReITbBfQif
X-Google-Smtp-Source: APXvYqyIuf3OzieLbC8xUxlQddVDWf3Xngn7Lo+hrS2E5qxRPvGX3tpzfERuXgBxmwl5qSbSEMhAoQ==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr48117810wrr.287.1574905846585; 
 Wed, 27 Nov 2019 17:50:46 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH 09/10] tests/acceptance: Use the ATmega2560 board
Date: Thu, 28 Nov 2019 02:50:29 +0100
Message-Id: <20191128015030.27543-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
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
 tests/acceptance/machine_avr6.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
index 2ef4a9ac2c..abe8d45b65 100644
--- a/tests/acceptance/machine_avr6.py
+++ b/tests/acceptance/machine_avr6.py
@@ -31,7 +31,7 @@ class AVR6Machine(Test):
     def test_freertos(self):
         """
         :avocado: tags=arch:avr
-        :avocado: tags=machine:sample
+        :avocado: tags=machine:arduino-mega-2560-v3
         """
         """
         https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
@@ -43,7 +43,7 @@ class AVR6Machine(Test):
         rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
-        self.vm.set_machine('sample')
+        self.vm.set_machine('arduino-mega-2560-v3')
         self.vm.add_args('-bios', rom_path)
         self.vm.add_args('-nographic')
         self.vm.launch()
-- 
2.21.0


