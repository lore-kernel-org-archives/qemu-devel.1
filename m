Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B5DC2D0D2
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABEB2082E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvKDze3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABEB2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTBt-0004K1-Md
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAT-0002dl-2m
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAR-000766-GV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAR-000719-3y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id m24so10637384wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nPuTG4M7TlE5s+bjNAWfFW0OnOD1cQftLBezPWuqO9o=;
 b=OvKDze3F/TiO4HEA99+JGqdsI95BU3jLpWXfm/+6tu9yZmI6ijRdpRpyaJYMBL1DB5
 TXiy45rKggsS2Fsu6nKJ6BhFautUQoumnDq/VISjHSOqK11m6FaOjOjf8bz5VhOctL1j
 tlSNYnQwPGbRLsb3SUsv+6HJTMxQiVvDUgEPA75N5Qf0G7y8z5icV/61CC00Z3CBpws2
 4N13A/aPkt/7+h3pDSj5Lz7k9JkUfeukd3whrK4noei/3DyuTCU+q7/Cmu6Yt9GY7qaY
 9b2WHIDnsmTf26hIwU/+xw0FF3RLpBbaThhLRvDSCX8SJ+ynvXxyHpXbrS9ks7mcB5yR
 +LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nPuTG4M7TlE5s+bjNAWfFW0OnOD1cQftLBezPWuqO9o=;
 b=uBQVfAVHqL0NMNrKz687UmaL4vh2ntMEiBw5wPMgBAxuNO2ydZZgpEsm7WAj5fRUav
 aJjCzp+dwIEzSEy1L4VqYvnxTozcgS8nSiqKb5sQR+fdzyMPZJXUwTW4CWfk52YT+5yA
 lGrvxx4uP3ndS0g19jd9DSAFd5uK8C17WMZ6WSxoJhVdjAurX/4T4LMX3p4TR0cnNlnR
 5ar8R6lI7Df5Kw9X62LZSTTyvz4/+YcIIbZJWdBg8nRZ8pqFWkn1yx3bmFnB8kJ0/pup
 vz4QO1YHTVnSWte97RI/lDh3ze//wvGAhdo/q9KLca/WfN3z2xkJuR9raYhDC0AAcAt0
 RNww==
X-Gm-Message-State: APjAAAXth4pFco8f2IKi/SJEyeCvKv4/CRhO6DDi6Nbx+s9sQ1wztvJY
 u2Gp6ZKbXDZEl6hcf9VmEu9OvZ47
X-Google-Smtp-Source: APXvYqw0ffRFPTObIqdhijZVltP6JCsWY4cfxPhdhJc/CfMLXPwkPDEpZCvNKW/AxL8f7eMAn0R4cg==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr18898970wmo.12.1576890169858; 
 Fri, 20 Dec 2019 17:02:49 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t125sm8449596wmf.17.2019.12.20.17.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 17:02:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 8/8] tests/acceptance: Test the Arduino MEGA2560 board
Date: Sat, 21 Dec 2019 02:02:26 +0100
Message-Id: <20191221010226.9230-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191221010226.9230-1-f4bug@amsat.org>
References: <20191221010226.9230-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
 Phillip Stevens <phillip.stevens@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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
Cc: Cleber Rosa <crosa@redhat.com>
Cc: Phillip Stevens <phillip.stevens@gmail.com> (for FreeRTOS example)
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


