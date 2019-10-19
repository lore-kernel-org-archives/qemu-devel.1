Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0534ACA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C459920854
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3AX8Tbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C459920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqs9-0005vV-Ov
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkq-0005M2-4N
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqko-0002xI-PL
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqko-0002wq-JU
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id a6so8967303wma.5
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NgJtsZYXc8GUBV9Y62Y8rMxQDFlakDpMkIO4EX7Mgs8=;
 b=E3AX8TbgQiqEq8dUqYFtOi4V3lWDMUcO/q2fz2futfdy4m5C7+isj3Ent22hMojLZB
 5dUSR3FtZ8/IjP9WGix6pZkihO0BTfs0KhemiyDW4H7UieztSPMcLTWQF57EOo5c7S90
 9UgZos4CqbYY/FCevnQYU1MzEzaT+BVjvPv7M+zdN7jeziwVXqB1Hv5vWtSJ7KrXv6KG
 W6WuY7D/Dv1720LtXWIbxqpfLMSS7/KgXtLj2cSY5Ytv08KT4qZBca9begLOazZKqqqA
 IWHFW9E5+puByCfK1tvje4IE+OGF9HaTi0J0m/LeAZ9mHXbET5usREY3Tae8r4asvi2c
 n3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NgJtsZYXc8GUBV9Y62Y8rMxQDFlakDpMkIO4EX7Mgs8=;
 b=lmzZYiD55ujzATtECpktS16xO93KtdHTF49HZuJxm8uxEeHcqgjm39yN1RQbPLqixc
 ssSFBQX1dU2/qrJd4hOGBchLH70exjHAJlDurB5jnBHJ3hG5urhNOmLGXK7fXarRLNo3
 2HYn4lPeheN/jcxJ/2JMMJju62YYhbIx3S58Scum+WEP681LX+6m+U5de/kQnG90xo+5
 AhYwzNXut3uThh+Nu14ArL1IcFc5ypTxuyJf71xOLyf5ald4W+JUJbq2piAv5Tbd2PSX
 z0gCNx54X8nCCG/gKSsxOmcdgtgU7JBfE1W7PPizXQKW1jyIyQKHjNdFVGy+rEDIlRPJ
 Oi2Q==
X-Gm-Message-State: APjAAAU7WJhRCBk4QcNeTXW2ez6ifjyOkjOvFImOHOs7X1wVth9LBXxS
 GS0lZR4CZmV+YQDyXxpTSLZsofhg
X-Google-Smtp-Source: APXvYqxhKIErd2dXNAFmNjv+BevWeVg9xNanZEtdr3OiDr1BIzL6lL2gFfwAcdrm37y/mQ3sfVQVNw==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr12569936wmb.93.1571499293434; 
 Sat, 19 Oct 2019 08:34:53 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/11] tests/ssh_linux_malta: Fix 64-bit target tests
Date: Sat, 19 Oct 2019 17:34:37 +0200
Message-Id: <20191019153437.9820-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019153437.9820-1-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 9090d3332cdcc added tests for specific to the 32-bit
machines, which inadvertently make the 64-bit tests failing.
Now than we have this information available in the CPU_INFO
array, use it to have the 64-bit tests back.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: do not include Aleksandar Rikalo mailmap change
---
 tests/acceptance/linux_ssh_mips_malta.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index 2139c80f5f..fc13f9e4d4 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -44,8 +44,8 @@ class LinuxSSH(Test):
               }
         }
     CPU_INFO = {
-        32: {'kernel_release': '3.2.0-4-4kc-malta'},
-        64: {'kernel_release': '3.2.0-4-5kc-malta'}
+        32: {'cpu': 'MIPS 24Kc', 'kernel_release': '3.2.0-4-4kc-malta'},
+        64: {'cpu': 'MIPS 20Kc', 'kernel_release': '3.2.0-4-5kc-malta'}
         }
 
     def get_url(self, endianess, path=''):
@@ -143,16 +143,16 @@ class LinuxSSH(Test):
         else:
             self.fail('"%s" output does not contain "%s"' % (cmd, exp))
 
-    def run_common_commands(self):
+    def run_common_commands(self, wordsize):
         self.ssh_command_output_contains(
             'cat /proc/cpuinfo',
-            '24Kc')
+            self.CPU_INFO[wordsize]['cpu'])
         self.ssh_command_output_contains(
             'uname -m',
             'mips')
         self.ssh_command_output_contains(
             'uname -r',
-            '3.2.0-4-4kc-malta')
+            self.CPU_INFO[wordsize]['kernel_release'])
         self.ssh_command_output_contains(
             'cat /proc/interrupts',
             'XT-PIC  timer')
@@ -209,7 +209,7 @@ class LinuxSSH(Test):
         stdout, _ = self.ssh_command('uname -a')
         self.assertIn(True, [uname_m + " GNU/Linux" in line for line in stdout])
 
-        self.run_common_commands()
+        self.run_common_commands(wordsize)
         self.shutdown_via_ssh()
 
     def test_mips_malta32eb_kernel3_2_0(self):
-- 
2.21.0


