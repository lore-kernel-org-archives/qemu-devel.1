Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D09C2D0F3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713F3208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxFqDsHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713F3208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEXA-0006NM-K1
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU0-0002MB-CD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJETy-0006GR-Nt
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJETy-0006FM-IA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:50:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id w10so25375569wrm.4
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ONe6r8GpThcKL7DODhjdJnCo+VHtig9T6C7dDsrvCOM=;
 b=OxFqDsHQFo3JUXB5y90BJtB/QXKJXAIFlqHWWbCVELj3X9bv6KvERbZrry5SVe0rnM
 QOVhPcTtAWSrvAro+SpRc7IcN31oJS4TMlXKCdniQ1GT72VeOy7F0qBvzeoufxwR9zp3
 zubg9QXFIige3U0fe/dLcNOxdIxK8Aq+87Q1F5RtWOijwOmsqYRuwmDbQ1UXXXmj9b/g
 J7Jy34PtMbAeGAthKuOUoLswoGIWOxFY7JGpxVNhAE5fmf84OBlLN15FbaD0dwluhyPG
 i6RqcYdJlZ8jeeevxa6BSS9NCkLu0XQrYI5LlT4mjYEj7wh+0/+e99ok3jV7J6XRdWRs
 UXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ONe6r8GpThcKL7DODhjdJnCo+VHtig9T6C7dDsrvCOM=;
 b=mGrFnQwYVrosa00u0c67COdXNb7iKdSlFijyTFqVhT/Vvbyz1mgPRCnhLdXwqRd1JG
 v0Q4rzIeY3h5amF8wI3v82qSkqlktIwa0jnrv4uIdp6PaDB3Z2ncFmkm6Fx0M86VCrNu
 TCw3Bgm1PIgiRj8xUnoTyvjS3LLOdo2MQZOSu9m+wW9cDREB04sWxAzIS9zttbqRWwkT
 yuZpWjS/64SbYL3CMSS5wiDoCG0w2tRZDfQcX7OX5PoFdV/5TNuqa7pHtqI/0tvZ7ka3
 iAZn3ArrznSsuRhT4N2DiQMU5p+J/XKNVm9eA+/lvJIfAgwqUub7Sut+wY+FlFyPwGJA
 liAQ==
X-Gm-Message-State: ANhLgQ1O1HXzXNfVVQ9DSULzsCZCiD261EcegHGrK7RLafYVL0siMdoC
 vvreeSvZE+VD+9t6A1YtewJ5cgkscG8=
X-Google-Smtp-Source: ADFU+vvL6zgzSFx3/4B8OAiH9o7ME8WiuL8p9yLzLEH0mS1E2Nj5pPCVyIZi0t17Ll5+I4lbyhvA9g==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr20619972wrr.280.1585651856624; 
 Tue, 31 Mar 2020 03:50:56 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w3sm26042830wrn.31.2020.03.31.03.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 03:50:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
Date: Tue, 31 Mar 2020 12:50:42 +0200
Message-Id: <20200331105048.27989-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331105048.27989-1-f4bug@amsat.org>
References: <20200331105048.27989-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test was written/tested around beginning of 2019, but was
extracted from a bigger series and posted end of June 2019 [*].
Unfortunately I did not notice commit 162abf1a8 was merged by
then, which implements the AHB and APB plug and play devices.

HelenOS 0.6 is expecting the PnP registers to be not implemented
by QEMU, then forces the discovered AMBA devices (see [2]).

Before 162abf1a8, the console was displaying:

  HelenOS bootloader, release 0.6.0 (Elastic Horse)
  Built on 2014-12-21 20:17:42 for sparc32
  Copyright (c) 2001-2014 HelenOS project
   0x4000bf20|0x4000bf20: kernel image (496640/128466 bytes)
   0x4002b4f2|0x4002b4f2: ns image (154195/66444 bytes)
   0x4003b87e|0x4003b87e: loader image (153182/66437 bytes)
   0x4004bc03|0x4004bc03: init image (155339/66834 bytes)
   0x4005c115|0x4005c115: locsrv image (162063/70267 bytes)
   0x4006d390|0x4006d390: rd image (152678/65889 bytes)
   0x4007d4f1|0x4007d4f1: vfs image (168480/73394 bytes)
   0x4008f3a3|0x4008f3a3: logger image (158034/68368 bytes)
   0x4009feb3|0x4009feb3: ext4fs image (234510/100301 bytes)
   0x400b8680|0x400b8680: initrd image (8388608/1668901 bytes)
  ABMA devices:
  <1:00c> at 0x80000100 irq 3
  <1:00d> at 0x80000200
  <1:011> at 0x80000300 irq 8
  Memory size: 64 MB

As of this commit, it is now confused:

  ABMA devices:
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  ...

As this test is not working as expected, simply disable it (by
skipping it) for now.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg627094.html
[2] https://github.com/HelenOS/helenos/blob/0.6.0/boot/arch/sparc32/src/ambapp.c#L75

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_sparc_leon3.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/machine_sparc_leon3.py
index f77e210ccb..2405cd7a0d 100644
--- a/tests/acceptance/machine_sparc_leon3.py
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -7,12 +7,16 @@
 
 from avocado_qemu import Test
 from avocado_qemu import wait_for_console_pattern
+from avocado import skip
 
 
 class Leon3Machine(Test):
 
     timeout = 60
 
+    @skip("Test currently broken")
+    # A Window Underflow exception occurs before booting the kernel,
+    # and QEMU exit calling cpu_abort(), which makes this test to fail.
     def test_leon3_helenos_uimage(self):
         """
         :avocado: tags=arch:sparc
-- 
2.21.1


