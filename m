Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23714C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74522084B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6UqIgC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74522084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1xg-0002ux-Qf
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vy-0002JW-Eo
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vv-0006qm-IJ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ia1Vu-0006mt-EV
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:06 -0500
Received: by mail-wm1-x332.google.com with SMTP id u18so8033336wmc.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DolmdaVZLZ5W+1vjMtwlNeMuEUxtYYmNHj6F8bUM6UI=;
 b=L6UqIgC+3GqjngKoLiACy7gtwJBBu4v+kzFp859KOIZ1AUJ2K0z2zALw4Z9x0wfUqv
 I/fVyvvcNVIA6QcbjgGGZZx3StzRNZfnnJi1vT8qtmerjvySxb2Dvid4chzf5ovhhE0N
 RR5hQpp+VH9DLLwoTJb7HW0r/6XwRMuqMHFyKmB2p6BVV8Hgp62kox9gkBLLT4goxa1X
 vIZZD9T6cFBvvmqb4fHiTFCICclu3bfL+Lgm8zHwzz9B1NOCdPEXgzYtc4gPdLJkb8et
 /JTink7Yf4ge4Y1bKtY6qM2vCbaK179yfXJ/nZZGZOLZwQZ1RDZgDVaIhAj6pqBJ3ojB
 a/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DolmdaVZLZ5W+1vjMtwlNeMuEUxtYYmNHj6F8bUM6UI=;
 b=AJKtWog2wVkYGCND1VXsAxyT75dFnoIjMbeF7FNtbOs+gnSvo8PTRCzxaOAPE4CaMd
 hmMDBDUrztKy4nwySQ0fbSJlvmqr2AV6pgw9CMmOeZCEbz0lrVlpoDfXVjgbZJ6q44dO
 RD/YFNfp/35EuYXnahOtRqel/MxdUTnR0LOH7RZ6QScf+5UTjgNuRrRm9Z6Z1tXXAL8T
 Mma/03c0pJeBmUTxMkOQa8Bq+PJyduky/6PLE3Qplpq8aRWdK3gPl2hm4Ax0GRE4UN4k
 Cv869M1AUFOjMDRIuncgoz923nSK7shqVHBkioiOba0T5TegvMmTFmJFYgAyvL4J3RWa
 jVbQ==
X-Gm-Message-State: APjAAAUDPKD8f78uq82IJ2kckDk95EgRCpmQkB7TBEo/MgCawo7c4QGV
 alZ2kRi31oyvxD66B6jiCYRm2HQhqvxbcklF
X-Google-Smtp-Source: APXvYqy0KeY0GJVbYoiOPK03NEaPvhn8nUp5k0xksulld0kUSDbj9VReWk2R9PvBZLRXZBsBI1l0uA==
X-Received: by 2002:a7b:c098:: with SMTP id r24mr5736714wmh.63.1574877241793; 
 Wed, 27 Nov 2019 09:54:01 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-2-87.red.bezeqint.net. [79.178.2.87])
 by smtp.gmail.com with ESMTPSA id b2sm20238295wrr.76.2019.11.27.09.54.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 27 Nov 2019 09:54:01 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v37 16/17] target/avr: Add Avocado test
Date: Wed, 27 Nov 2019 19:52:56 +0200
Message-Id: <20191127175257.23480-17-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191127175257.23480-1-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test is based on
https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out.
it also demostrates that timer and IRQ are working

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/acceptance/machine_avr6.py | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 tests/acceptance/machine_avr6.py

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
new file mode 100644
index 0000000000..ba1f47dd70
--- /dev/null
+++ b/tests/acceptance/machine_avr6.py
@@ -0,0 +1,56 @@
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
+        rom_sha1= '36c3e67b8755dcf37e06af6730ef5d477b8ed16d'
+        rom_url += '/raw/' + rom_sha1 + '/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
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
-- 
2.17.2 (Apple Git-113)


