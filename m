Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C6CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9845F2082C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbTWNm05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9845F2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqp2-0001yn-DD
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkf-000574-KQ
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqke-0002rP-Kl
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:37052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqke-0002qp-Fb
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id f22so8753614wmc.2
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L17Gkpekc5/KDSlV7uWJjFxc0f5cH+nD4BY7UX0P8ME=;
 b=VbTWNm05GGkKArp4LyU8HhBqRSYshuND0h/tYWWOaIjlduqCpKuT2IUsXog4FnzL99
 V30OCecJAZcENWPydi53HJxNlyfKfOJmpmkWZabu840F9p0wxDRkndXAGyZPz4seuWCf
 sM94HiFCm9iJ0Z+epzzGB/aVH3q/hFPXS20hOLRSuqrz1D1RCV/ni3eDmQ4/XqAw3XjH
 BI+Oz69jAHHYTXz8qGNzy7gUg+msOP1kJLyYT+SDSC5cOIV0Zy9JyY43GQosK2I8r7j5
 5dlyT0KSW9MuUV0k3ifrUYky3bS0Bw4OpVwmeHksMk4wP/pWaOiPIfUqoE5G/NLBiXEF
 VaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=L17Gkpekc5/KDSlV7uWJjFxc0f5cH+nD4BY7UX0P8ME=;
 b=Nwt2E5gYlA+QP3glKt7RulyrweEZEIUuPvEBJ7657gdLEyNa51Hx7b2QCx+TlZYK+o
 Z13znp14EQBZCtAWugKRa3yna3zjQMN9kF9E41KONZA2/Bek3vgrU/GyCk/LkXMITYG4
 Tg+cWz4+PX8oClzyn/QIarX6ShH24W7eaZbxr3eryzdLHTY9s+zVOcOH+defefH55CT7
 ZiRwb/97lCG5+nDyZ8Mo08SIS+7+MaWGXNxvlIU2iRCXWYvnlfYg55FaKJqUsC+65eQO
 Pr/q2eazpl7DA+sORMHh2UD9AN44PyMqM3svI3GLslpp1AoBsa6UEHRp79sV/h8KdJ2K
 iVnw==
X-Gm-Message-State: APjAAAVO3bTfikvxfwufaCABgeuE/XJgTaGmVtcipgMdeu9uslJxW7u7
 scCjI+iCI8yDA6qAwffJQgiiaHdD
X-Google-Smtp-Source: APXvYqzYa7pnmv62Bdo1K0pV/nZLzv+TqHN89ETx0czpXxYGJeTnD52UVxty1+nM8PYr5tm9KZOUYQ==
X-Received: by 2002:a1c:99d5:: with SMTP id b204mr7051001wme.64.1571499283337; 
 Sat, 19 Oct 2019 08:34:43 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/11] tests/acceptance: Send <carriage return> on serial
 lines
Date: Sat, 19 Oct 2019 17:34:29 +0200
Message-Id: <20191019153437.9820-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019153437.9820-1-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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
index 8897e0c253..497faa4f7f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -34,7 +34,7 @@ class BootLinuxConsole(Test):
                                  failure_message='Kernel panic - not syncing')
 
     def exec_command_and_wait_for_pattern(self, command, success_message):
-        command += '\n'
+        command += '\r\n'
         self.vm.console_socket.sendall(command.encode())
         wait_for_console_pattern(self, success_message)
 
-- 
2.21.0


