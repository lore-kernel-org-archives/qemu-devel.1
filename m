Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D08C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40AB206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOmET2Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40AB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istvC-00007a-O3
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1istfT-0006ZN-E6
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1istfS-0007pq-3K
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:21:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:32999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1istfR-0007o5-Ks
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:21:57 -0500
Received: by mail-wm1-x32d.google.com with SMTP id d139so11830268wmd.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a8XNKbJukO9kBpqm/Qv2mq3ysWrme/1jTK6NG2Oci+Q=;
 b=gOmET2CppQ1/rlmfs6eRDVEv6ZAzXS52ZH8blnrKXX6gVt3bTMPtYss9iWS/XeCIuz
 lzDqDz5d2Z+ksTm51vDDt2+5KjeXBKbeogEJA3hTuXdZJ7B3fg7Veo1FPoWNqyWHadlX
 D+skK8AiYAeJZMLZ06pCon4KHMSkiWrx7xLmoeE2Bd5cakjdAtGR8aRaS84AvgsrW1y/
 toGxWYjBjgT71+XRypAGguL27L8ev+6+PPn2QA15VRDkSIvGzREbTA2sykyYlq71/dqb
 6/Mv56ilrwMHXqPXpj9SKB2nhtxShAsDZOG7bZPdMPhEFeMTmoWL2QllO6dGlOuOKy61
 HV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a8XNKbJukO9kBpqm/Qv2mq3ysWrme/1jTK6NG2Oci+Q=;
 b=feLS58YotA0zQlRSbxk3N4atNHPdcHcG/CgoN7AXOBdj1aafGXq37AonoaTj4Ykvv1
 iCdBfIPAOdER1/yiqVtB9mCrrTPHmkNDYIuCLMifBWVvqZU0kPPObDKi+VN41bE6MaKo
 eUuZj9UJ6k7pWkmHEisW10G67cJmXgcvKBozoQeaROubPDMSFQxohhtB1CczybcfHiN6
 Jv1PuTQDlD6BpvuzGlNhs/1Eim8wNr6zhsLdeylivYfI/BQHRC9hSdwF/SPDpfguzhHD
 R5GxjqYPfaE+Xc+GGeEbhz3Bb+mqDPg1x2dVRcCqG03jfXj8TazVYSfhhhVJQbKnogj3
 Fx8w==
X-Gm-Message-State: APjAAAVPp1uSl9vTEviZH8m9HqqJ6ZYsOcxdAaKCWdLqcDf0/ua0hFYd
 pBoEhxvZTwPww/HoGLZuKf8OK4AB496R13My
X-Google-Smtp-Source: APXvYqx3EWGaC5clsNKqRt4t6ffUJT7Z1W0sKYL077lh2kkIVBwFL9gwuBzP6QSSH4znkty/dDPrDQ==
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr10842129wmc.162.1579375315721; 
 Sat, 18 Jan 2020 11:21:55 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-108-13.red.bezeqint.net. [109.65.108.13])
 by smtp.gmail.com with ESMTPSA id o16sm2875468wmc.18.2020.01.18.11.21.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 18 Jan 2020 11:21:55 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v41 20/21] target/avr: Add Avocado test
Date: Sat, 18 Jan 2020 21:14:15 +0200
Message-Id: <20200118191416.19934-21-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200118191416.19934-1-mrolnik@gmail.com>
References: <20200118191416.19934-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
 tests/acceptance/machine_avr6.py | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tests/acceptance/machine_avr6.py

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
new file mode 100644
index 0000000000..43501b26a3
--- /dev/null
+++ b/tests/acceptance/machine_avr6.py
@@ -0,0 +1,53 @@
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
+        self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',
+                self.vm.get_log())
-- 
2.17.2 (Apple Git-113)


