Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08011C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31672067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7pjYuEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31672067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXt4-0003i3-HZ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRn-0000Io-BH
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRm-0005gO-53
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRl-0005fn-Ve
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id r3so7641766wrj.6
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d629WtGJt6HDAvXZ7DoHJ09hXukU8B9JEhQ8A4kBLxQ=;
 b=S7pjYuEyKZZDtP9BYk6L7cIu24ELAG6oMPpfY4nrCYqT33m4CtXn6n20hhlCRPxW2F
 rN1zR4oCd1glkrjjSr173CeSiMQYeaxio/uaHPtN+/YgEY6CQzVw5SfuYTjlfc+zp4vw
 kO5jCgMLic8WaCWxcEi1uPOlzS5/OXuMjgrSF9zTEBrqJApWcBTHUQ12NgP7kok8DHQy
 hZscNyUt6Z/9nmvJkqNV+q9daOl0CQfCLXGW+F8AVMn2oY4LoDCcKsz237/y5kJiTQ9O
 6AU5vxWup/8CbjMLCYk6almWImP0yAiOFku4IA2TPfxxhuaaPXMCScyQ6FvEVMs20bSE
 eOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=d629WtGJt6HDAvXZ7DoHJ09hXukU8B9JEhQ8A4kBLxQ=;
 b=rxhnVfdE+s5aoDXVS1UuGC+oML47xhz9L+Vtjo2zsgof/JxxiPyFAoLMvv9HhQoaPc
 9lQISQEz3vjb1UCpGLB8taU1ZhRgrBhyFUvwkmbvYGxAw0x44gd6nmHlQYLHBX4A+U/G
 ZgmkC8g2MvoLeGzqItntfCDUBmoenibzjJgyr+Y0BiL8phbhhpjzFvJSA+DVmtO3DDQp
 ZCKL0M8OoGhgGgvXs6T4/km9qBZo1PdHucqS9ZQ97d4h619w/2ONvtu3XObuZYauS5vO
 qAD5mqsCSX0rjGk3Wf7OM2BETfr7N2wPkXPsVNJ6dmAuQu/Ie8PHgD8WYNQmoIOqWA0A
 TZxA==
X-Gm-Message-State: APjAAAVCfrvekXRBTO+ZaosQ6jLN9mx2rC04qp4YhMP0EH9SZ7Ao60mB
 1Y5pDk0YxQQkd/Rwg81n7Tte8VzTbn8=
X-Google-Smtp-Source: APXvYqw4jZKIs+7S+2skSbFw5gVoc0lYzqG60cxtTXoBmAYAy5GzGeIgQ1+e9/IwWgiPJwOEIH/gSQ==
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr8350071wrs.384.1570710092682; 
 Thu, 10 Oct 2019 05:21:32 -0700 (PDT)
Received: from x1w.redhat.com (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o4sm12413169wre.91.2019.10.10.05.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 05:21:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests/boot_console: Send <carriage return> on serial lines
Date: Thu, 10 Oct 2019 14:21:27 +0200
Message-Id: <20191010122128.29000-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010122128.29000-1-f4bug@amsat.org>
References: <20191010122128.29000-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
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
index 8a9a314ab4..f05452824e 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -51,7 +51,7 @@ class BootLinuxConsole(Test):
                 self.fail(fail)
 
     def exec_command_and_wait_for_pattern(self, command, success_message):
-        command += '\n'
+        command += '\r\n'
         self.vm.console_socket.sendall(command.encode())
         self.wait_for_console_pattern(success_message)
 
-- 
2.21.0


