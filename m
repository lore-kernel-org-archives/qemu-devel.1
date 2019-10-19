Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B1CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A85C222CD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdvTdsHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A85C222CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqQF-0002wr-Ib
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNn-0001BV-JD
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNm-0006wl-J2
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:33770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNm-0006vx-DM
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:06 -0400
Received: by mail-wm1-x32e.google.com with SMTP id r17so11356179wme.0
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L17Gkpekc5/KDSlV7uWJjFxc0f5cH+nD4BY7UX0P8ME=;
 b=cdvTdsHLJ9xm713HYol6fuZg3dwqzEwv2lt/uVKRv2cQXDtsSqCzZRvxWsSoMoz73Q
 86Uqh6GDgMDwM2k4IMj8CWwRcfRufCzbkk8Q8Y8Xp0rX9jhHhLkFoiHKN4NA8T1fGJej
 9CqgSWbGQDEsoL43yf/J/4pv3P+jTpchbwnf329qOdbm6lffePCO6R6MV8TJ4lP8U9eA
 saQBCCcWiZB0LDKa+8pqAGH9c8CdcqPLFWJ/9iAlI94swRdLd+ulnbNHxm/4Ei+FCmuw
 YTsANHOX+GRv2TF19ffFAjgOo+5rxBK8jxFuFUZ+O7uqOZ3oWhZFkc/tbB3Muvbltwxl
 j5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=L17Gkpekc5/KDSlV7uWJjFxc0f5cH+nD4BY7UX0P8ME=;
 b=Whqgz/qqaCBVZAwDajfVs6FqdwMdSxvNvxT/zIAAvUl5SIlwWgWJGXUk5AATb0zZ+I
 Zsv9WbnLizlmatAQh0I/Ht8QNrn3bEeQiCVlXRvF92l26tAT6dOzHijH9DV3dlxS00Gg
 NwqXCpcCNCWjK+TsO7kCwhQwHEs9sg1pA5LRRHP17oqCuWsi2/Lr0dNU1B6zHlmJmotX
 YKqqC+zLxD/72e4OB2io+V0zi4D1f0QTVGySBeE1Ipd4hPPAQ0ywLXbWRGK+mwXwR+sg
 BLksWGnyAkrRxm4nd0a2G0kXP6NwcB8EKsZPXVFGTOUcOccZkrVOLy8YVbz+Y8PbhYvT
 JeQA==
X-Gm-Message-State: APjAAAVICbGexYRoytUPPvpTtHI1JGm3g4tLfBe0p5qKGV0aqtw2BCXx
 f+SLqueOcnAfwOdfoN5Xw8VEf/GF
X-Google-Smtp-Source: APXvYqyOL9OvMOahIfKpTn7TTLB+igP5pLZuuf2G6z3XYDavh2IbDeHUpp2qW53qdzuHaRHOWDO1Aw==
X-Received: by 2002:a05:600c:143:: with SMTP id
 w3mr11172913wmm.35.1571497865239; 
 Sat, 19 Oct 2019 08:11:05 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:11:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/11] tests/acceptance: Send <carriage return> on serial lines
Date: Sat, 19 Oct 2019 17:10:50 +0200
Message-Id: <20191019151058.31733-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019151058.31733-1-f4bug@amsat.org>
References: <20191019151058.31733-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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


