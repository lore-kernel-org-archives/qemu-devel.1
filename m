Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A368EC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F76820409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rO2jorlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F76820409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7uk-0001xA-IQ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7lA-0003mf-2O
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l7-00082n-13
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7l6-00082D-Qr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id m17so3554562wrw.11
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1B9ZUTBnoU4gxY0Jsk9Kmh/Dj86gf5UMxsBDuamh5Qs=;
 b=rO2jorlHHy0o23+Ls3obwOWSYjXvemFHSuj+tEMu0Ey7w7vtbScF+6ryKH5wYV2GCG
 HNWvfVQLtR8f4642LvIPhadc40x1+lBfLgHp/4LHwVuWogME6V9urSTlo8obQ7NDy3TP
 M6AhQ8HIKytn0IowObVz5OUVMZUfY53qYSU2J/wV3L9lZIFeiFHqevLbtie81h2ToEfy
 YyDRqVAWNHt1uAD3SIzA80DjB/kq9wunvqpOLq7yEEY468uMQNAj1eT+WqLQVqCF05Au
 335jSMU8P92KPpXAJUlQdtnl3lpV6JzYXNDZiv5y7vfe5g15+5DhN41BzyWCODTxyN6G
 Rbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1B9ZUTBnoU4gxY0Jsk9Kmh/Dj86gf5UMxsBDuamh5Qs=;
 b=dTcd/6pSpsL4OKzRq3fQku4B9yyQ/Z6sqM7Y94j8Cz2X5Vo5tKuy9jEcKAMF5Zk4Yn
 NEe97nAu53zos4hHqMMamXnkAyB4GKBx8lASQv9JSLBhM5E9vecjXOIs3plWs6GLoYRv
 ngS5BelgPDygGBNXeY8kPwyK1uNek2U9lF0bVUesJU2icUm3WmpWl4iIyKTbkswQGsL4
 5nNw6BU061fydGUdirruo8G2vxNDj+sfIdpxNXi5WOItcw0yVdoVWL3SLZplOZH/+qfV
 jCeHUGtyJNCa16/ITrWLRL7xjMK/yc7E/GlONbULeL5L5l4r2aqHwn74DyUIAAB8hl/4
 tltQ==
X-Gm-Message-State: ANhLgQ0uILK9ffIrqHUcjzuVc26uxfnJac8IpyeMt6aHCtPyhfnHlCcE
 QjnaDfCOm3ROfNF+2COhFlYd2A==
X-Google-Smtp-Source: ADFU+vuti0f5u7CyHOW7xdb/TSYs/FKmmCLVN4ZcjaEg2kYEUI4j6fmuduXPVUHSlVfR/bC0gX6//w==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr4135046wrb.188.1585149355747; 
 Wed, 25 Mar 2020 08:15:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t12sm19019151wrm.0.2020.03.25.08.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA3D71FF92;
 Wed, 25 Mar 2020 15:15:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/11] configure: disable MTTCG for MIPS guests
Date: Wed, 25 Mar 2020 15:15:38 +0000
Message-Id: <20200325151543.32478-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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
architecture anyway. In lieu of someone tracking down the failure lets
disable it for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-Id: <20200323161514.23952-7-alex.bennee@linaro.org>

diff --git a/configure b/configure
index da09c358957..6e274a993b9 100755
--- a/configure
+++ b/configure
@@ -7885,7 +7885,7 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=n32
   ;;
   mips64|mips64el)
-    mttcg="yes"
+    mttcg="no"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
-- 
2.20.1


