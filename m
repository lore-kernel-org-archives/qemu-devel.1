Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC07C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 12:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5F82077C
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTQN33Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5F82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Te1-0003lw-BA
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 08:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1i9TWq-0005FE-GY
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 08:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1i9TWp-0001R6-0x
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 08:21:20 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1i9TWo-0001QQ-QW
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 08:21:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id v17so6664839wml.4
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=omaKXpcvgU9Kt6ByBsDjcQekqvHhhz8d9mSZhfKeNec=;
 b=aTQN33Mj0hxa5fZ1QhqNS13lokqtxf9g0ObYo1RTVjdSsbj+4VonlCD+ejFE0P8i4W
 WZ/YsvRVg67f3tyFZwHmM05LtZtYAMbNGYqMEkjvtqcmwT+M+IqDh3MT/t6Gk8R635dT
 5siOXLaigVn1Lk5eJLGtlr8pB5qcqHwd4GhPmxCqWez8Ft7Zm8/emdjxz7XvPcLpTxR6
 e9HjXACg96NvCii61O4jMaG/hf7XqXyOz9ShsTbdkAJMwarQMYVJIhiVqyL332C5f6JH
 vWj92mTL4ziUFAFrcidSNMsfPsP4TNL83cYDe2wf8Mokf8Ap0VFKOYuPYXvry4ioSsXt
 k+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=omaKXpcvgU9Kt6ByBsDjcQekqvHhhz8d9mSZhfKeNec=;
 b=UH9OUQfzXraggJPxm/5gp24Vdq4zbJ3x7XNDFcwJT6vZ4Ya6zM+GuV6NhekrSJjagG
 dB6pp9Ag4EDVFwGpNCM26x+yfF/cDOTxQzuUGtWJHEABQARiFa+1Ivij/Xb3lHPZzn+u
 pF6fVwKoLk3ROi8Uwjf8UqHbwUfioW/G65RwKJd1vHAdhO/WLlZo20lwg4QGpLD1v+ao
 TH/NKnRzGxkEfOpSjqzR1OYgckd/s2djDb6xuNCaNZKnHw2LGKlMAC1bxIxsqVZ3xwpw
 4+M0oxI/SM8Uw8oH1q2oxI0F0xS8h9xUL5ArHa0zhUeZ6/bLtOUw7lrkPSf8EWiIeE44
 aq5Q==
X-Gm-Message-State: APjAAAWlg5YrAud6eE994vnLJd5CuhEcJ5ZiRZDH9LkT3Te24he4mgeA
 LGxQphCg1gzlt9hgFgPpNDOvwPS8RanOVQ==
X-Google-Smtp-Source: APXvYqyz1kfttdX+w0aSX7DOt7pPEHsY8J140Qw7Qv393c/C0uqpWqnyuf10nxnG9UCO4k/5/z/uvA==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr7627594wmh.142.1568550077496; 
 Sun, 15 Sep 2019 05:21:17 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com ([213.57.17.146])
 by smtp.gmail.com with ESMTPSA id b194sm15947032wmg.46.2019.09.15.05.21.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 15 Sep 2019 05:21:17 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 15:20:15 +0300
Message-Id: <20190915122015.45852-9-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190915122015.45852-1-mrolnik@gmail.com>
References: <20190915122015.45852-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v31 8/8] target/avr: Add tests
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
Cc: thuth@redhat.com, dovgaluk@ispras.ru, richard.henderson@linaro.org,
 Michael Rolnik <mrolnik@gmail.com>, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

1. Avocado test
    The test is based on
    https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
    demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out.
    it also demostrates that timer and IRQ are working

2. Boot serial test
    Prinit out 'T' through serial port

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
index b39860a8d0..a2430c55bb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -202,6 +202,8 @@ check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
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


