Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A7C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E00D206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLoHT3uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E00D206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQUH-0007jd-Lt
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuQTg-0007Kh-Um
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuQTf-000078-IS
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:36:08 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuQTf-000066-CT
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:36:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so733567wmb.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/2apbwhRNfDklNmkih1t8Cxh6sWeUkA+QXjuH6egj8I=;
 b=dLoHT3uUYFFmkCDMW3+FTF4oRnxQB3XifbNI4V5nY1vTBtS+PNRgnmdcKIqRikyZWx
 DS7Z+aJOiXNjerRCESTr/IePkOK5pFG8YePzI73pzxW55m37ufQeY5PfHjF0gfMTRXDH
 XeOpREW8ZaijhexoCuT5AwN+iv9xjLVZk+77thCcr1dFO0Z4cbgTG7JvJPn2AkwDkbYQ
 f23bumu2KJcd2sE5hvTjcHcOQ5vdIlIcnei0XnpY/ULGVC6pLpb5LB1XQ6S8UqBu73CD
 lQz6d27QpmOjvuDIRXPTTbNXpYd91pdFS4fu3DDRUR3Uv1pQ78a/FIEUXPaQj3BtW5/z
 3JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/2apbwhRNfDklNmkih1t8Cxh6sWeUkA+QXjuH6egj8I=;
 b=T+SHW8jc1uCydoHEJp6efbO6q4xQHEeZZYZfWLZAYKt11Q0smIQmNMFhdGwEXStSH5
 az7WUcWE0dgd/lUh3g7sdOaj53p5NxDl4QVLCno0anIdIIA4VhneFZ30OuDA0z0mlkK+
 xKsjVMYU9g/yNLm7h7rRNB6PMA+H9V2BtSuOZGFCO9VY0+LTKTSaruXgS0My72JJIGny
 uI6VyXPjaWr0ivFvoulGDzL27SBMeIx5sA9bfPwIeHxOaCTi68DYU4cob6+xucmebKX5
 9IW9ju5s0U8OLnrPZGZiBpnANzAhFI+6L+RGZn+TqBA90pCDgzeYtazRkwZuLie21d1m
 ALTw==
X-Gm-Message-State: APjAAAWwuZLkx8XL+BppxOumh76o0nQ0vXJuy/A5ELR76Dtjl7ASyA3l
 FkMOda59qlyFYxQP4Ac8lcFM03sZ
X-Google-Smtp-Source: APXvYqxUNQErt/RnWarRlqNvZkr1xJaSM+TAS9jfKIiw2pGf0wB8Z6WG91pItnufyqinG21t4NR2og==
X-Received: by 2002:a1c:2dcd:: with SMTP id t196mr833229wmt.22.1579739765837; 
 Wed, 22 Jan 2020 16:36:05 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n16sm649500wro.88.2020.01.22.16.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:36:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/boot-serial-test: Allow the HPPA machine to shudown
Date: Thu, 23 Jan 2020 01:36:03 +0100
Message-Id: <20200123003603.11610-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The boot-serial test uses SeaBIOS on HPPA, and expects to read the
"SeaBIOS wants SYSTEM HALT" string, see [*]:

 122 void __VISIBLE __noreturn hlt(void)
 123 {
 124     if (pdc_debug)
 125         printf("HALT initiated from %p\n",  __builtin_return_address(0));
 126     printf("SeaBIOS wants SYSTEM HALT.\n\n");
 127     asm volatile("\t.word 0xfffdead0": : :"memory");
 128     while (1);
 129 }

A 'SYSTEM HALT' would really halts the CPU, but SeaBIOS implements
it as an infinite loop.

If SeaBIOS does not use the expected serial port but another device,
we might poll the console indefinitely while the machine is halted.

Allow the HPPA machine to 'shutdown'. When it does, we'll get
a qtest error:

  $ make check-qtest-hppa
    TEST    check-qtest-hppa: tests/qtest/boot-serial-test
  ** (tests/qtest/boot-serial-test:31924): ERROR **: 01:12:37.604: Failed to find expected string. Please check '/tmp/qtest-boot-serial-sjxoM6Q'
  ERROR - Bail out! FATAL-ERROR: Failed to find expected string. Please check '/tmp/qtest-boot-serial-sjxoM6Q'
  make: *** [tests/Makefile.include:628: check-qtest-hppa] Error 1

[*] https://github.com/qemu/seabios-hppa/blob/1630ac7d65/src/parisc/parisc.c#L138

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I first used:

    shutdown = !strcmp(test->arch, "hppa");

Then remembered we'll have other HPPA machines soon.

Instead of:

    shutdown = !strcmp(test->machine, "hppa");

I find the check on the SeaBIOS specific string more accurate
(since someone might add some assembly lines as the other tests).
---
 tests/qtest/boot-serial-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 05c7f44457..4e92f292f5 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -188,6 +188,17 @@ static void test_machine(const void *data)
     const uint8_t *code = NULL;
     QTestState *qts;
     int ser_fd;
+    bool shutdown;
+
+    /*
+     * This test uses SeaBIOS on HPPA, and expects to read the
+     * "SeaBIOS wants SYSTEM HALT" string. A 'SYSTEM HALT' really
+     * halts the CPU. If SeaBIOS does not use the expected serial
+     * port but another device, we might poll the console
+     * indefinitely while the machine is halted.
+     * Keep using this option for all the other tests.
+     */
+    shutdown = !strcmp(test->expect, "SeaBIOS wants SYSTEM HALT");
 
     ser_fd = mkstemp(serialtmp);
     g_assert(ser_fd != -1);
@@ -215,10 +226,11 @@ static void test_machine(const void *data)
      * Make sure that this test uses tcg if available: It is used as a
      * fast-enough smoketest for that.
      */
-    qts = qtest_initf("%s %s -M %s -no-shutdown "
+    qts = qtest_initf("%s %s -M %s %s "
                       "-chardev file,id=serial0,path=%s "
                       "-serial chardev:serial0 -accel tcg -accel kvm %s",
                       codeparam, code ? codetmp : "", test->machine,
+                      shutdown ? "" : "-no-shutdown",
                       serialtmp, test->extra);
     if (code) {
         unlink(codetmp);
-- 
2.21.1


