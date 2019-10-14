Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAA6ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3355220854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfJKuOq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3355220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4Ei-0000am-D6
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iK34K-0006Xz-Li
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iK34J-0007aP-9i
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iK34J-0007aF-2s
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id n14so20393625wrw.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9d/uDGv85dLEv33nEDGWywNGXN8GQJeP0QFNxDLvG8o=;
 b=GfJKuOq4ESGuaUxpx+6ovR1uYdwow39CrkmXDFFF/bF8qfvzbw/V76Htztk3tEGUiD
 uXjBBEvEiM/QvfKy9xhsTnkK2IOm5GYq99CI8K01FGaRCcFtvG4qHFAgyuTBj1vq3Awn
 s5w1wYpI1c8hPqSHVrSCqG7FL0srrALZQ8UKG52/gaVt+qPqzlM7dEsBL0IEMhbsNXCx
 SeUtTGcppS/vD5bPNY+q6re4uZkDnrMJFNxjdDNuhRgHW1MVGR8UhgaBB7fV1vBgScNN
 e1/KcNcjiy3+3vGYUQrqmnPVZakLdOT8jpfMu8CZgICbxGvTGLxJSiadXuSqY8PxN1Ma
 CJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9d/uDGv85dLEv33nEDGWywNGXN8GQJeP0QFNxDLvG8o=;
 b=V1fIfnFFOO/rDGt7Jaj8E/quS88lcWaYZ0/hqAnry/CT8Y4WYlUGwGLDNU3f6AxM7i
 DOhVZZQixmYDDmABCRb1/K3a7pJKixF+U9ZWpUrzt2t0cOi3F2aut7sL5nfXEShr+A+C
 xltkGJFi30PzvEj51aRKasFQjqE/oBO8Dm1pWLPnt/hVX/LyISYnXO/kcXWzLOch9xM3
 WjEk9K4yvP9Mz6fQdk9rJ54+a+ZcBg0/FtjG8F8Z3fgUIlOnHIjxKseyy4rhFJGqowGY
 Dk6JyM+KyIKbb2on6LDmuNcjUzfET2/8AbzzucUL0lzcxzPJhUsPwpygERIqszFq8Y1i
 Kscg==
X-Gm-Message-State: APjAAAWY6lYk1plgt5tFUl/kMTOdlDf8GzhXipohHGOcAwYt4rAnFPQ4
 ptrk68p+MiuaH9VtLjch2ZUqTdss/pE=
X-Google-Smtp-Source: APXvYqx0sUpqbezYqdztaupuNiNumTWPZxgpWggD7L2GJZKfqCF1bKGWLyLBci7GbL4SWevMbONfRg==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr13877325wrn.230.1571069973624; 
 Mon, 14 Oct 2019 09:19:33 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-11-117.red.bezeqint.net. [79.178.11.117])
 by smtp.gmail.com with ESMTPSA id c132sm28050861wme.27.2019.10.14.09.19.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 14 Oct 2019 09:19:33 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v32 13/13] target/avr: Add tests
Date: Mon, 14 Oct 2019 19:18:43 +0300
Message-Id: <20191014161843.84845-14-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191014161843.84845-1-mrolnik@gmail.com>
References: <20191014161843.84845-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


