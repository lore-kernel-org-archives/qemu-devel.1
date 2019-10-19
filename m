Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A164CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9474222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEd3lqnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9474222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqal-00066S-RJ
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqO2-0001Le-1y
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNy-00079j-Vf
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNy-000781-Ph
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id b24so8705795wmj.5
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CMHbwukv5zQAWHD/pJCrE6K07x6qMk4wAjcROnJyKl4=;
 b=jEd3lqnZjZNfaLbSqhh/xZ+Adzq0FR8zU5pnXOlsoAZ0qwZ6J6xdiyx70UfMV5Eu5d
 e2EyV2nBHbNOODEFMXTFFMePTgIrgIA2/QpoTCKpFaQrAcsWvoiIkyOh5G6KpHCOH07T
 8V7txCphje+pBgXbpjs5nxCRdLtLRuNevM0JEiYbblXa2WycJPjo3Kj+BxepQI8/BRhO
 TIOpFiwa03d2mMF/j1ej0cOT8HLlC/yPhYdtaBzy9ozQDnLe53q+PNCeMKDrMB6IpPm3
 im1gOhX/Ldeo1MKpUwIMwwXZL5Tgi8ScMcUocPeyNCnclEeS+VGgWrkwY47rZ6oSMzZx
 zV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CMHbwukv5zQAWHD/pJCrE6K07x6qMk4wAjcROnJyKl4=;
 b=cPcizymUnqUPsZyf/YNHt5CixsnLoJZ/aUc6l0AZsK9ok+5yzUjssZxRgsx3YROVdY
 kne5XclKrfCT/D4hU4Yg/ZH8Wo0eeh6+UCIot8LOrFB8hDEP7NP0oF6dtF86eYD2M0AD
 eKMw3P18Iw1arCxL95M4fT46efdFuLCGac8gLP4Qn1W5uyRiHGrA0Jb9yBmiQgUBCf1A
 Tzjfpf/BEr7ByS+u4bN4gECfqU86CUlxPkf1tyr7BMOnd33Sb9LCu9/r5DOytQYTvgHo
 EvTwppbViz8WJucoapoTgqNmbWaoqAFac5NhRap5m+6g7dpCgl1QsZ30Cf34ClrMH96m
 4EYQ==
X-Gm-Message-State: APjAAAWHFmlztsW610VCy/XPZO19vVP+nOK2xYqGWOu4Q7mUkTk1KCx7
 xKS8bUImqU/6kUX2jYDlqDhmR8sY
X-Google-Smtp-Source: APXvYqwwy8+KD+Jxhdw9k+A5Fm2luaAhvyJmgYeJFPVWAdVlkcH+SHK3zZRcRZSUEAkEvLo50G3x2w==
X-Received: by 2002:a7b:c849:: with SMTP id c9mr12265293wml.58.1571497876661; 
 Sat, 19 Oct 2019 08:11:16 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:11:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] tests/ssh_linux_malta: Fix 64-bit target tests
Date: Sat, 19 Oct 2019 17:10:58 +0200
Message-Id: <20191019151058.31733-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019151058.31733-1-f4bug@amsat.org>
References: <20191019151058.31733-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 .mailmap                                 |  1 +
 tests/acceptance/linux_ssh_mips_malta.py | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0756a0bf66..fb7d7ede76 100644
--- a/.mailmap
+++ b/.mailmap
@@ -158,3 +158,4 @@ Zhengui Li <lizhengui@huawei.com>
 Zhenwei Pi <pizhenwei@bytedance.com>
 Zhenwei Pi <zhenwei.pi@youruncloud.com>
 Zhuang Yanying <ann.zhuangyanying@huawei.com>
+Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
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


