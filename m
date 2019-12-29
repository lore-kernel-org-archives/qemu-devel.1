Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B12C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9BD207E0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/Ej2aeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9BD207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilhRZ-0001uX-AU
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJK-0002aF-Qw
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJJ-0001yA-Gh
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:22 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJJ-0001wA-9N
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:21 -0500
Received: by mail-wr1-x436.google.com with SMTP id q6so31205206wro.9
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 14:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Axh3SDMRIAYFo/SxEXYU1q310bgOy7N4rDsJmWBEGVo=;
 b=B/Ej2aeAVCbPxa9uSJzxHxxIoxcDjGLRToXCwDhaoO90oQxYZjeHCxbtdyJ66WFAgc
 I8AjVz/c6WItNCgPI7BA7QLCWXPxsHrxrkb0WV4R6ks5qETiOVp1w+5FGgRYd2FBWzsP
 +3aI7Y/KuzJi6x6g46LYzqHB7Qq0r2K5tTii3JkyrI6Tq3bg5VFVjnUD2xTZxuDc2cmE
 YM5+ScivMdAzj0LtTVywUqTa0/nxku1FHUQuGkCMDPiKr27Rq873zrlCCI7JoHaY2k28
 fIfkVN5GxLdz7t0IsmUTCIFh6dsehxlPpdnumhVjaqlNlgMwuFMuBH69ZnBg558kQ9jP
 oXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Axh3SDMRIAYFo/SxEXYU1q310bgOy7N4rDsJmWBEGVo=;
 b=DQVH/Q58ZT/08eCmRmi8D+z55quL16ICCfW7EqHNQC4Jv/EY5CMVtA9HIHC5bQ+WhT
 oE0+6kENBICruFsnrG29DHxyIrFqZAzjFd+PCLsfL7cWk5ZWgHBkQDZNY99mKBDGvylk
 pgIeFCMW/M0RCxo/vT35nLQqqxA9ZnRNBbSq27lMlxGUQE5qikGS2DuCpzywcJ2tErX6
 ECU+0u27YY4/iw4Fo8/MVQZqJyW7npdZF1hcr6dZvJ2CCnDF38e7Z8DXc0qleSSavDiv
 K1jrSbMfVJEnfQp7PfNKpuRLw0wnxm/pSX0UCXKSklTUecn1ntoB8oqGXoA7yyCroG9G
 2vaA==
X-Gm-Message-State: APjAAAUyLnuG50omz7YSDtUX0WGG29DPSqiopkOYHujVL+84pQUyppqq
 1K2UNAiCsrFVHsf/Tsss2RaRJZ2fDqs=
X-Google-Smtp-Source: APXvYqwH5J1B0zwv5D2kUU8Xe0J0aB/JBCsf2T2LFYi3BzMkgNeATlwKWqyMs9DvNUZtfjsbPKeOTA==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr61655776wru.230.1577659520137; 
 Sun, 29 Dec 2019 14:45:20 -0800 (PST)
Received: from x1w.home ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id x1sm42709188wru.50.2019.12.29.14.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2019 14:45:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/8] tests/acceptance: Test the Arduino MEGA2560 board
Date: Sun, 29 Dec 2019 23:45:05 +0100
Message-Id: <20191229224505.24466-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191229224505.24466-1-f4bug@amsat.org>
References: <20191229224505.24466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
index 94a8004e94..c5ff423e50 100644
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
-- 
2.21.0


