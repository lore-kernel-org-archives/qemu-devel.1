Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7FCC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871672173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7tU/SjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871672173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4mzQ-0008Db-ON
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 10:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1i4mtv-0003G9-3b
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1i4mtt-0007xf-HE
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:01:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:35665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1i4mtt-0007xN-BW
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:01:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id 205so6594390pfw.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wIt0RmRwb6KcSvUQOLm89hKh+s12FlIhCEewS+ETW/o=;
 b=R7tU/SjLAWqC8gHol72JkVkAGNF9HEANcvwBQd8HJVT95T5pxoCY9c10nN+UqnkNnY
 8t1Uro47RwAXyET9e+5L/UJ/4Kgrf6QL8zaIZsg6U3VxAngSpQdpwFx6EmaSZ6wgItMd
 pdfXmfmcKob3WMYCs8BIvS+xtTbxVg4dSheCKQmryPOA3aU8uFUAgHT5fH/2WLhakw5r
 ztVuzDPFPtCrn0azyUTVcbhnVwTbU0/Da0ue3FL/vYvagVh4sLWk8zgdRJYQM6y7GHcn
 1GkYVBkh0lX1Pg1K1JOibZucZVN9shuVzaIYfO97zfcEzmYxrccG8nbRAE7FEVInsRZX
 nx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wIt0RmRwb6KcSvUQOLm89hKh+s12FlIhCEewS+ETW/o=;
 b=nkV+rXdAjLozZe8DuBkpwivF8wFWnlvENzUEBVu8XlPOIwzfJ5T6nscwTUbBinJ+0c
 P3qmvh7BKxHHkWIsxOd6l4CpaIDangETCoA0ZIknChUkbYvNcj+kqURIvs2ExhMEMJWH
 W+w4iu5PBrfKPHW6xOGiIZCJ3KidcgYP+/5It0rYF8NoCjjcPXrTrwzcqxhlWdz4MVGF
 Cdc620O3s0clfv0tHbDmlauaXzrkpS2q15q/TpRUNJnk95cDHntDaINQruxyslLvbMuP
 WieEW0TXxVUhyRrcwy/Tt5werlAzVpjzxzTS5eDKxpWI+MDNg8kJZbEDxTvnOmyXFQjP
 k4Xw==
X-Gm-Message-State: APjAAAVfE02uGOe1yKfk4BurdevVCxm8yZQvuNBwtuOvKENt5MWdJpFD
 rDWL/Iqi8JY5kXEyb2FUI9CndIl10ROggGp2
X-Google-Smtp-Source: APXvYqwOO7G/LH5xXN3bFKiHozAH7XwBBCUnN0PpbcaOQRMIPKtDH/1L9FsMXACSdqJftODBHphZfQ==
X-Received: by 2002:a17:90a:17aa:: with SMTP id
 q39mr13188016pja.106.1567432904108; 
 Mon, 02 Sep 2019 07:01:44 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com ([206.81.201.98])
 by smtp.gmail.com with ESMTPSA id v18sm4562020pfn.24.2019.09.02.07.01.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 02 Sep 2019 07:01:43 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 17:01:34 +0300
Message-Id: <20190902140134.74081-9-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190902140134.74081-1-mrolnik@gmail.com>
References: <20190902140134.74081-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
Subject: [Qemu-devel] [PATCH v30 8/8] target/avr: Add tests
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
index 49684fd4f4..dbaeb87572 100644
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
index 24852d4c7d..22cbaccc1b 100644
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
@@ -92,6 +101,7 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
-- 
2.17.2 (Apple Git-113)


