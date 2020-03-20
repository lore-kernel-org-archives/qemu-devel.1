Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7B0C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BC120732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDgifskk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BC120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFG7h-0000HF-7l
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jFG64-0007Jh-F6
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jFG5z-0008Dw-PE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:45:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jFG5z-0008Cp-76
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:45:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id d198so417290wmd.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TDipM9rGYjEtiaI6CSouTQvfuQ8pFm/kQ+ylrt2XN9A=;
 b=SDgifskkg/4S5zCku6kzcpWqsrCeZMxlLovTNGUEyQ81akCZZYLoj7bWk7DGqIA3Jo
 BTGzwgPs8IFGfVEMSrUTO6EsR4u6+67zsjNgUh5n7oftHhoC7AukB0VPYh15k7dznPXI
 0XMvC6VgNfvPmPHxtV6mffScgcoqfZodrdAo5sVd6BJO4h4epddyxscHgxQY2Oj59pZ1
 Q5Pe0W/Ub+rZkBUHVZrPWCDndxjFNP/b6/4D2y6+kqMU7tyZ8/4NKpVltWS1sy92jXYX
 lZHMvPCDjS9czDtpRUq4VnEhdIzmN+7aW/14T1W5Iur6McCUVbZxy8c3wiv+EaNBQYa/
 05aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TDipM9rGYjEtiaI6CSouTQvfuQ8pFm/kQ+ylrt2XN9A=;
 b=ldn7xtakk0WLKK88bbtbnVg0BJRuHVcx1tOdgpl8KT/YZJgHG5F9nBpZfHo/6bBXtp
 I8TcHmsKeIIYrTq+w0LYaCgb/XvB2csRjcnMMhYKTm5hBhrcT1ptrY9IsLLt6B8ZlHx4
 Nymqb0PxR7yIk0CJqoellj+kZU4AAgoHwaE65mwHO4Hd/1y51EJibt8fnBNBwAksFylF
 zuWjL9GL59zmylm/6uUDesKzqmi12JDJo1cnHzZ+mdKyNxHEuaLZlmSW5+QOJy+JuNEQ
 yTKS5yKUjQPXIoRiNxkdi6UoukIt5Sr2yYhh49SKEKrGWKWS00ijwJc1AXYMTtnvYIQD
 9xjA==
X-Gm-Message-State: ANhLgQ0YBxQmPU76ybELLiTZdhn0tbAPIefmzJv45MFA9pOfr3W1jqyU
 cqDwrz6jC2FRWyUMC3DVGSXuQA==
X-Google-Smtp-Source: ADFU+vsDEDknC3K4oKwu5D6JrJ4Rdps7XFFhrOFOUPVzoklWQmTT9AozsYTPlf0mK2tPrI+Y3rC3Cg==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr9663782wmc.188.1584704745947; 
 Fri, 20 Mar 2020 04:45:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n18sm7896591wrw.34.2020.03.20.04.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 04:45:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D2A721FF7E;
 Fri, 20 Mar 2020 11:45:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH for 5.0] configure: disable MTTCG for MIPS guests
Date: Fri, 20 Mar 2020 11:45:22 +0000
Message-Id: <20200320114522.16273-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While debugging check-acceptance failures I found an instability in
the mips64el test case. Briefly the test case:

  retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
    -display none -vga none -serial mon:stdio \
    -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
    -cpu I6400 -smp 8 -vga std \
    -append "printk.time=0 clocksource=GIC console=tty0 console=ttyS0 panic=-1" \
    --no-reboot

Reports about a 9% failure rate:

  Results summary:
  0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
  -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
  Ran command 100 times, 91 passes

When re-run with "--accel tcg,thread=single" the instability goes
away.

  Results summary:
  0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 deviation)
  Ran command 100 times, 100 passes

Which seems to indicate there is some aspect of the MIPS MTTCG fixes
that has been missed. Ideally we would fix that but I'm afraid I don't
have time to investigate and am not super familiar with the
architecture anyway.

I've disabled all the mips guests as I assume it's a fundamental
synchronisation primitive that is broken but I haven't tested them all
(there are a lot!).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 206d22c5153..002792d21dc 100755
--- a/configure
+++ b/configure
@@ -7832,19 +7832,19 @@ case "$target_name" in
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   mips|mipsel)
-    mttcg="yes"
+    mttcg="no"
     TARGET_ARCH=mips
     echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
   ;;
   mipsn32|mipsn32el)
-    mttcg="yes"
+    mttcg="no"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   mips64|mips64el)
-    mttcg="yes"
+    mttcg="no"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
-- 
2.20.1


