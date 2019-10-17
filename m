Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B38ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E3C2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+/SwNG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E3C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9lu-0006Nl-EX
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91D-0001B9-DV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91C-0006cw-6b
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:52:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:51597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91C-0006cG-0b; Thu, 17 Oct 2019 12:52:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id 7so3312311wme.1;
 Thu, 17 Oct 2019 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0xXz6e28KynrM5DlHHkebUU7iiubU1U+3QXcLu3E9vs=;
 b=f+/SwNG/8nc6itrdhLCuM6LdD5K2asTG2kL6A4MasN5yN89ds6wR/+e1zZ1Hwe0aR0
 F2Cf/FLfxTLLA8s83UWKMJyFmyAvyW/ozAS74xTM4yoy2H/MxmKKekstS3MDbqMKSBs+
 UO7oO8PmLUbbojKS51vVymISVRhR1wHfBJwCG/JffbdtGz3hMAJJOsaWzYtFKu2lLsN/
 DxcwXtyv8IWzXdCtR1+YIrrI66rUIRaNgHxyBqR5tdTC6CCev8CIZGzT/UnzLomhBHTR
 xzkMTR7f7fXZq0YrVdafe5pKB5ML46zZWsv739PitDOX5jEh559efh3Y99fOXtG8Zr97
 J4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0xXz6e28KynrM5DlHHkebUU7iiubU1U+3QXcLu3E9vs=;
 b=KgP2PragMZWZ1VsSwUam5FIiKWp2Y8/CzpzJuoaSAvLztAcNu4qxCxfJSenn98milC
 22SYyatvPlZxsr6tLVG5qLSA3ZJ4cQzblo4iQIdhEZqWS8n6/wS+9VbjRnnwvravpawj
 2IRiWL+QKOeJKus38kyqGsLLu+mlzGDXySwqLMwHORzYvsZ1E2vH8xHMiPy6SbFtxDgB
 F04jD2VgjIf2aZUXIohFnbC8t1qw1wL2ICSjaXRgcNH+DZmy8YHlBbRR0D7qHTEPHZBa
 UjTQojCWqws2l/YwhrTUy4MMJLcL3utvCx1FWgA5qOhCdGmP3LiCFn/rIVvtUqy6IHcV
 sUQg==
X-Gm-Message-State: APjAAAUbRUwtpPKLJ4IZVpwcwmygdS2qhQyTir0UVAvii5v0NwXhl6wh
 IgBTrlmLyzWE3mjsWCGlaGU7pVNZEaI=
X-Google-Smtp-Source: APXvYqwqOZM6lue9w1nkdk6NJF8tgoqZhXEvoD/iO3k+D/sQSL8KIELQkJn7r4HK6VHhxNexPp26wA==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr3715068wmq.137.1571331172815; 
 Thu, 17 Oct 2019 09:52:52 -0700 (PDT)
Received: from x1w.redhat.com (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id w22sm2557363wmc.16.2019.10.17.09.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:52:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] tests/acceptance: Send <carriage return> on serial
 lines
Date: Thu, 17 Oct 2019 18:52:33 +0200
Message-Id: <20191017165239.30159-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017165239.30159-1-f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some firmwares don't parse the <Newline> control character and
expect a <carriage return>.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 9ff2213874..bf9861296a 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -30,7 +30,7 @@ class BootLinuxConsole(Test):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
     def exec_command_and_wait_for_pattern(self, command, success_message):
-        command += '\n'
+        command += '\r\n'
         self.vm.console_socket.sendall(command.encode())
         wait_for_console_pattern(self, success_message)
 
-- 
2.21.0


