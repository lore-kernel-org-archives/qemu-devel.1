Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10AC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63539207E0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIDX9X1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63539207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilgmI-0001NB-He
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilgV5-0007r5-SF
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilgV4-0004J4-H9
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilgV4-0004G4-9G
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:26 -0500
Received: by mail-wm1-x331.google.com with SMTP id p17so12858391wmb.0
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 13:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fuht1ahwiE11JwSlXF7XmtmpSUzGlU/Kyo3G3cPff64=;
 b=jIDX9X1URvwZvF9I/DlFpjnYi1PTqKrTiQoDbbq16alZYDUGEbPFzo58/YmdigzHeb
 xny0qdGWWCdjnyht6KRsTtsE40PhwD3DWgYqJpVnfOnxTDo10Ldzb7Ite/O/QJS7J5g2
 8s34hV9Qz9lELWMKGR/uHsZ52DMU3Sm1yiYUQ2FQzlFFf37X1IIVCWcmX2524DbUy2qh
 XAtNfM7JSqGMZ88xA7OIBnd/ehXu9JLpZLSvAV+xP7Py0XU7h0LzZHi4mzv5VfbvGAcs
 gRQs0sWvyqGHaVnr8cXOGtsZLXZ9F6FoWHDEHbqqmFbTg7liPWIR/5+XR6tPlKR+BKB+
 l1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fuht1ahwiE11JwSlXF7XmtmpSUzGlU/Kyo3G3cPff64=;
 b=VSX0kKmoPKCS2QUBKlW72U9Aopqi7wYQwNP0z6n0M/S0arh0eWI5UWHGPoa8FHgPdi
 u4eeUzZUwDX61ogtZX8YTu1XnT6WBkxpkHul6oBlhni4M1RLky51whbBD6BWtAeAytAi
 1umQIOGF9d7qsNJOdLpioo1ZlMhJWvaHROujz/MyXbpSr441BsOcyu5UT+1nf6M98Iwd
 HpBnySQb/VXCv6BCs/KrKpjMMw0aMubQbx6UlJhDX2k2QEwgNcYUzKLvt3bhVybf2c6o
 5IuyRaAWgCR8aDuExhNc6BOw/8IYCzCTjoj2QOh1mtN+grwzS5BFuPeJzKHPWxp4zstj
 MDHw==
X-Gm-Message-State: APjAAAVCLh4MlVZ7RXROvMK07HkXsDqYJEsX+hhVIyvkQY5kSSKRfha7
 SrqjeOUqUnKA3HT8NG2FdMIN6ubzmpA/Zg==
X-Google-Smtp-Source: APXvYqxLDTZGzixYSejs1UL86GZor+/LA6Xw0qLASpvKRUlyYdm52dnmwHlnfgPzDg08SD+8blvtoQ==
X-Received: by 2002:a05:600c:30a:: with SMTP id
 q10mr29742283wmd.84.1577656405032; 
 Sun, 29 Dec 2019 13:53:25 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-183-93-3.red.bezeqint.net. [79.183.93.3])
 by smtp.gmail.com with ESMTPSA id 25sm18182850wmi.32.2019.12.29.13.53.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 29 Dec 2019 13:53:24 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v40 20/21] target/avr: Add Avocado test
Date: Sun, 29 Dec 2019 23:51:57 +0200
Message-Id: <20191229215158.5788-21-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191229215158.5788-1-mrolnik@gmail.com>
References: <20191229215158.5788-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
 tests/acceptance/machine_avr6.py | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tests/acceptance/machine_avr6.py

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
new file mode 100644
index 0000000000..7a7d8afc29
--- /dev/null
+++ b/tests/acceptance/machine_avr6.py
@@ -0,0 +1,58 @@
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
+        rom_url += '/raw/'
+        rom_url += rom_sha1
+        rom_url += '/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
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


