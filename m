Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF06CA9EB0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EF520882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyHt3QJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EF520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMgON-0008GV-Ca
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 18:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iMgJQ-0001wr-Us
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iMgJO-00018Q-Sr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:38:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iMgJM-00016h-Tn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:38:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id l10so15320807wrb.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9d/uDGv85dLEv33nEDGWywNGXN8GQJeP0QFNxDLvG8o=;
 b=kyHt3QJu3Snzhu/9s52UEXkULD6ZWlIbn19KWhov1JGlpBpI9vLH8dxEeB5jbtKsbm
 Xm3r7j9sJP/E0oi6urTcPSYkjfewqdGVwNHibw4MwYYkjcU7bTpicjhYkSUa4+Os+7kz
 +BLthlSew+1a4S56Z9okmn7bFCCStJBOs7DCWdrfykALDXV6Q4X1TLv7Ho6HXY9FNNOb
 2XbJYnuq0uD/0oSqY5C2ooGFW+knKx7dF5DkEjtcopYS0WqzB1UKKLmrHSVZCFzJaU6u
 R0sVLR3UViknFAwz1OT3oxUwk/DmyCxXMFGcLNZaejcFspzVEpxQ/OhHoqOUUNQT4SQ4
 ttqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9d/uDGv85dLEv33nEDGWywNGXN8GQJeP0QFNxDLvG8o=;
 b=hTQHwKiDMxJENLZAT/VYn17Vow08RtIhPaeTis9yJ7ZHsOaASxxKfkKQic2McgGTrS
 S1GQLgBFbgonlGWLf2BqwchLDhcFUqmkOMBUpOl7Rck+P5bHI2RLyOzE4Lze9610NBsf
 B04qUs0/vWVssV6PHqka/G1tSqzh8A7Es3HDRjjXX23iKCi0qP/MI0o5EsmZHDWTWyNO
 EFLfWe/W+1ps0TB1JTTMPHKs5AME/dNibyBHQ4vdWZv13kVudVyWfy1pbBg/IuE8J7T2
 HgrLjYCWeoxpzQuvVMgtjnrJCaRRQKs06OBHrClxrYigums2P+XqCH9TTpLeTBuYLm2Q
 KP7g==
X-Gm-Message-State: APjAAAUZysDOwMF/rD1gyJ2uKA+prdxbBe3r9rhDD/5bV7cz4iS61K7v
 ouDIzswUWFyiKu+pc46LNQlvWRrB+ZFhkw==
X-Google-Smtp-Source: APXvYqwJLNjlnOGe4dlWGGacczlSrFoGKhJPfqPpP1b5SXDuYw9GnpIwy7S9LN4yXECGGE1knTGuhg==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr443970wrr.81.1571697478664;
 Mon, 21 Oct 2019 15:37:58 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-50-254.red.bezeqint.net. [109.65.50.254])
 by smtp.gmail.com with ESMTPSA id q66sm16951271wme.39.2019.10.21.15.37.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 21 Oct 2019 15:37:58 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v33 13/13] target/avr: Add tests
Date: Tue, 22 Oct 2019 01:37:11 +0300
Message-Id: <20191021223711.66955-14-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191021223711.66955-1-mrolnik@gmail.com>
References: <20191021223711.66955-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

1. Avocado test
    The test is based on
    https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
    demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out.
    it also demostrates that timer and IRQ are working

2. Boot serial test
    Print out 'T' through serial port

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include           |  2 ++
 tests/acceptance/machine_avr6.py | 36 ++++++++++++++++++++++++++++++++
 tests/boot-serial-test.c         | 10 +++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 tests/acceptance/machine_avr6.py

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451ed3..376d7dfea3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -199,6 +199,8 @@ check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 
+check-qtest-avr-y += tests/boot-serial-test$(EXESUF)
+
 check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
 check-qtest-alpha-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
new file mode 100644
index 0000000000..0601080b01
--- /dev/null
+++ b/tests/acceptance/machine_avr6.py
@@ -0,0 +1,36 @@
+import logging
+import time
+import distutils.spawn
+
+from avocado import skipUnless
+from avocado_qemu import Test
+from avocado.utils import process
+
+class AVR6Machine(Test):
+    timeout = 5
+
+    def test_freertos(self):
+        """
+        :avocado: tags=arch:avr
+        :avocado: tags=machine:sample
+        """
+        """
+        https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
+        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
+        """
+        rom_url = 'https://github.com/seharris/qemu-avr-tests'
+        rom_url += '/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
+        rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
+        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
+
+        self.vm.set_machine('sample')
+        self.vm.add_args('-bios', rom_path)
+        self.vm.add_args('-nographic')
+        self.vm.launch()
+
+        time.sleep(2)
+        self.vm.shutdown()
+
+        match = 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
+
+        self.assertIn(match, self.vm.get_log())
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index d3a54a0ba5..1121ed0db2 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -16,6 +16,15 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
+static const uint8_t bios_avr[] = {
+    0x88, 0xe0,             /* ldi r24, 0x08   */
+    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
+    0x86, 0xe0,             /* ldi r24, 0x06   */
+    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to 8 */
+    0x84, 0xe5,             /* ldi r24, 0x54   */
+    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
+};
+
 static const uint8_t kernel_mcf5208[] = {
     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
     0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
@@ -103,6 +112,7 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
-- 
2.17.2 (Apple Git-113)


