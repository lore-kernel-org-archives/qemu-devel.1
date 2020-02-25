Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607AAC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB262064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzpLR4/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB262064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aQY-00013M-Af
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcK-0005IZ-Dk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcJ-0007BS-Bo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:16 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcJ-0007B2-51
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:15 -0500
Received: by mail-wm1-x343.google.com with SMTP id t23so2867743wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FlL6Bcf4soitUd0txOakm4oS8jrNtXcuMA7Ur/DGB9o=;
 b=yzpLR4/GSjEq8Vpb1x4S5WLc2cp3WDwrwTeZrZRKkT6rS3wqxx5VkLnSHIEfye4DXh
 z6gvN7SOmGYIp0X7Yf7MUMGuav5sl04G5SdfizTYnLtrSXMfuMdPK0t09xI3GrbCWGDT
 UfiFenbI0rePdE/n3ohManUdbat53r0SgxbOQpitNaQX93CLjpEsRP6DhWSfOcC9/gZO
 iw4vv3UvXawrPhadvvOFKmttaLdsyatKnAiXKPByzOef6bb1Qlgqr9TgGUduCwDcf2fA
 kkq855QPaDEqLGdLRlggvPL4jX+t7TalWJ05wOf0M60jkanaOmhOCjLJN2Gj/NDCDrwm
 yYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FlL6Bcf4soitUd0txOakm4oS8jrNtXcuMA7Ur/DGB9o=;
 b=DBYQd2xUh+Smzjv3WdB3GFVPXLEIiMKrIZaBjbxQp5vXfg9dlM7Sl03ZX1JfvyEW8v
 UlrNqC7/QetuMw6bhpGmJX7DH/MeLQTDLJd++p8jaWu0RJq+wOZrK3cR974GzYhuxDYK
 u13A4LvE//yg4xoUEcv89vDV8DCNEXHP/uTnc7yYT9VHJ/N2xV/Sv9LZNHldg9gkczV6
 5McH3mMJqZIUtLKyGNhFNeVHFH+PIo/5HGxV3ULu2O9M0hOGQI9XxB24jwv17rT/51FY
 U/5ZdV3fcgLXzR1hc10llUhXtmylzUwYJPLTow72oKTl3U+wk+8jVVE0W1YhcXxzbEs6
 h8eg==
X-Gm-Message-State: APjAAAWHDuOXx05CoyytK8AFz/Irn78fUgrPRmDUlnU8QL0Abn+Ctvp6
 aw7h95dl+AhVcKTQoUIuyeJFew==
X-Google-Smtp-Source: APXvYqwwELpkjVJyBP3Q14wPoTe29zIB5pXpTM5k37Kio5eJkywGVLhIaPAh2KmHLLa0jSZp0jC5xQ==
X-Received: by 2002:a7b:ca58:: with SMTP id m24mr2304593wml.129.1582634834239; 
 Tue, 25 Feb 2020 04:47:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n3sm4048803wmc.27.2020.02.25.04.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:11 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 723A61FF8F;
 Tue, 25 Feb 2020 12:47:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 02/19] tests/rcutorture: update usage hint
Date: Tue, 25 Feb 2020 12:46:53 +0000
Message-Id: <20200225124710.14152-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although documented in the comments we don't display all the various
invocations we can in the usage.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 49311c82ea4..e8b2169e7dd 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -413,7 +413,8 @@ static void gtest_stress_10_5(void)
 
 static void usage(int argc, char *argv[])
 {
-    fprintf(stderr, "Usage: %s [nreaders [ perf | stress ] ]\n", argv[0]);
+    fprintf(stderr, "Usage: %s [nreaders [ [r|u]perf | stress [duration]]\n",
+            argv[0]);
     exit(-1);
 }
 
-- 
2.20.1


