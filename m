Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0BDC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150DB24673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clvFHz4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150DB24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQGy-0005cS-NM
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzo-0002Jt-8e
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPze-0002MZ-PL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:15 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPze-0002MK-JM
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:06 -0500
Received: by mail-pf1-f173.google.com with SMTP id x185so615502pfc.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o/0LBH6n2hjGa6hjpJuLZDn+SG9HeO73iwdRgg3fV20=;
 b=clvFHz4Z6gIdpAnEm0+AGZmteU43LW9ImVBceUD42WDAFFRtvM6tovEZzWz2010yA7
 b58IlAZh0s8GbDGjGu3TJ828QiOEzm+9gr8VQADY5msNYu60jj45eJDAyS55NeoG7Eu7
 8VpbwHP5D7ILc0lyOoeF/UZR+SEvPLthnjbSq6zZ5Gv7KraYlxqhOgx/wXRWxGseH7M7
 jrXEGveFOKt7DDd+iW7wvX+snD6V1cBb9pf+oTTXzhERPvn6BzWndbj4r+0ipgdAPjVb
 WTFYLTkUEzVk+y0Kd6Cusf9/bNE0keDuW3pE3LFqdHHOjIOj3xQRsYgzIj054JcwxoBa
 XDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o/0LBH6n2hjGa6hjpJuLZDn+SG9HeO73iwdRgg3fV20=;
 b=tb7WVi8XXMcUFOgOqijB+mMBcuwfZLsfYpNefxlcoroPBh5NhOm9SJ6tjHeJpVbwXn
 F7TSCJPAEGW3SmJ+RRxIFyneHSPYP6KTstmJPMzSGVhEn9KyktpSPTaRyBVYTvV+fVg8
 l49RG+rvodAYcAV5a3vDAPeCQfox0AlrUvrLZtbwLXktze+uU38EL5AYUWJcGBaM6Sx7
 wd7TeG7vq2HOkAqcp2qnYYeM+rcHqQ5O7ukzAuMQTfEi+tKrzahXn8sOSH1BvEkghKTA
 AsWFOmvpFSbtiMEBmSgpc5uN+TsaoBweSb1IQpLDrkr+CJoGQOKKdNujFvZlh7cugPXE
 U5Xw==
X-Gm-Message-State: APjAAAXSW8NeLRsD2Eu4kzFlBtyuIs+yjbY17H9VikUHGqkO5vAJFRVy
 Uq6d33zbL6MyFiGr8qGBaDq3vAw+eVE=
X-Google-Smtp-Source: APXvYqwRxFGHFxzSgN8ONqIHHTw2zVGwBfOhRdmZ1BbKIO2xqiue9xa+U6l/pRIRCICWQlBGpuQZ0Q==
X-Received: by 2002:aa7:81c7:: with SMTP id c7mr5132322pfn.203.1579737845231; 
 Wed, 22 Jan 2020 16:04:05 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:04:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 23/24] tests/acceptance: Test the Arduino MEGA2560 board
Date: Wed, 22 Jan 2020 14:03:06 -1000
Message-Id: <20200123000307.11541-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.173
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

The test is based on
https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out.
it also demostrates that timer and IRQ are working

As the path name demonstrates, the FreeRTOS tests target a
board based on a ATMega2560 MCU. We have one, the Arduino
MEGA2560.

Complementary documentation:

https://feilipu.me/2012/01/15/ethermega-arduino-mega-2560-and-freertos/
https://feilipu.me/2015/11/24/arduino_freertos/ (see 'Compatibility')

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200118191416.19934-21-mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash multiple avocado fixups from f4bug]
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/acceptance/machine_avr6.py | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tests/acceptance/machine_avr6.py

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
new file mode 100644
index 0000000000..b644d2a81c
--- /dev/null
+++ b/tests/acceptance/machine_avr6.py
@@ -0,0 +1,50 @@
+#
+# QEMU AVR
+#
+# Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import time
+
+from avocado_qemu import Test
+
+class AVR6Machine(Test):
+    timeout = 5
+
+    def test_freertos(self):
+        """
+        :avocado: tags=arch:avr
+        :avocado: tags=machine:arduino-mega-2560-v3
+        """
+        """
+        https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
+        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
+        """
+        rom_url = ('https://github.com/seharris/qemu-avr-tests'
+                   '/raw/36c3e67b8755dcf/free-rtos/Demo'
+                   '/AVR_ATMega2560_GCC/demo.elf')
+        rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
+        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
+
+        self.vm.add_args('-bios', rom_path)
+        self.vm.add_args('-nographic')
+        self.vm.launch()
+
+        time.sleep(2)
+        self.vm.shutdown()
+
+        self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',
+                self.vm.get_log())
-- 
2.20.1


