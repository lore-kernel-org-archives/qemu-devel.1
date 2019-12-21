Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82290C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1422082E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pc8MXOy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1422082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTBt-0004IA-0o
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAQ-0002aq-Tp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAP-0006zM-Mb
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:40172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAP-0006uh-DB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id t14so10923835wmi.5
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2YVDglugBElySB7guPNHOwioVDXQ7s9t5PIh4mBidKU=;
 b=pc8MXOy/Kt9sVNJZby3bXa7xC/4X5wbWeCGc1LWn/eL51iLGcvBeDSLFvPOo5FZr5X
 fPXbTPZ48/Iqow4kktLc9NP0rwOsaptRpt4AmvC0PksLyO4BQT3gfqnZfSpQ6269Rlmp
 B02A/tBef2oPCWkRJCQXG4bH+ZUdUNjCdZ0BqAGQeX1xSkapbb+EOUpMj3/6CiVw2PrF
 0Gh3fs8jtP3tsSf94YzRGHE/JDZDozUfDIeO+Qh6brq5rWu+qYCIpq0nP/W0xKIWU5Up
 Qf6pxcaJ6b1NxRvoVWC0kV8IH1Rc1IS5uYfqOGrt2QCFwvOL5DnJZMXory8s/5NuFoLg
 nW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2YVDglugBElySB7guPNHOwioVDXQ7s9t5PIh4mBidKU=;
 b=Yh/bg4VhPpBslWQCsa9fwgnxu8WeKBT26fyhupEwYpdyVFvIPmF+lbiXIL16a4ofTD
 HUUwv0xc9dj5ivnJTybmSfA4JNcihKtqErITMijfr/JVx9K1Nv+J1S1pt3IljgNCDCT+
 AtFGXFKGeppDudzVVQYexFkuygg4RqejbyAoeuORUoX7FHkMr1MtuLgBF1YmkPKmSKL9
 rJkdkSjruDQaBU/O2b1VkX9Fv0TrDD6giN3TZuh9yiLFZvglKmlRK0UdqnIPOrtFkJSQ
 lW9UQdY6kOwmvA4easQAM+EeSkQv8AYli4o7OPHMV5bh0fXQGtPTlTNNCuBN0p8uTZhZ
 +4Hg==
X-Gm-Message-State: APjAAAUkYcHOG10/2TzuJ63y3sQEZsqyaKX+c7hAgU0/pwXGcotIE3SI
 p3z/Ljybp17GSS90jn4PmvaLZvYr
X-Google-Smtp-Source: APXvYqxTgSjS9fQVGS6OKisz3BLoVTYfSd3VqeiL+rSF8b0f1ajt6wLpUTCoovEL4LnEHQGi//BipQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr18647905wmb.73.1576890168306; 
 Fri, 20 Dec 2019 17:02:48 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t125sm8449596wmf.17.2019.12.20.17.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 17:02:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 7/8] tests/acceptance: Keep multilines comment consistent
 with other tests
Date: Sat, 21 Dec 2019 02:02:25 +0100
Message-Id: <20191221010226.9230-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191221010226.9230-1-f4bug@amsat.org>
References: <20191221010226.9230-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Cleber Rosa <crosa@redhat.com>

 tests/acceptance/machine_avr6.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
index 394b3d4f8f..94a8004e94 100644
--- a/tests/acceptance/machine_avr6.py
+++ b/tests/acceptance/machine_avr6.py
@@ -37,11 +37,9 @@ class AVR6Machine(Test):
         https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
         constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
         """
-        rom_url = 'https://github.com/seharris/qemu-avr-tests'
-        rom_sha1= '36c3e67b8755dcf37e06af6730ef5d477b8ed16d'
-        rom_url += '/raw/'
-        rom_url += rom_sha1
-        rom_url += '/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
+        rom_url = ('https://github.com/seharris/qemu-avr-tests'
+                   '/raw/36c3e67b8755dcf/free-rtos/Demo'
+                   '/AVR_ATMega2560_GCC/demo.elf')
         rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
-- 
2.21.0


