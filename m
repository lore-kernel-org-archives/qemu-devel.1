Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F03C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6822246A2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoymvsOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6822246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7r1x-0007sp-3u
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvg-0004zO-Ib
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvf-00068t-HX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:32 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qvf-00068F-Bh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:31 -0500
Received: by mail-pg1-x544.google.com with SMTP id 6so2406195pgk.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=46JVchtXjykCWqulQO2w6tf7omk6UGW3sCrnOh12e0E=;
 b=BoymvsOD3qbq0L3fy/L2uRDzKeSoq5LrhJya1oN22KEaREmQ1/Itn49gglufn9laO6
 B+7CWTE4z5NUgz/+Zwb9y+0TQt0FY4fGlfiqzqwR1gWu+qfWyiSb/MAoBJ35RHBSiiAY
 kkyp2k2o2bmAgM+9w9xtPZ/TsgM2EFXD+UifSuiV0YcOaYaC5e6YM0O08Q9KaMUBjkb8
 SdSJq80tD6c69j5yFYcChUv0Jtg+6EZq/T1MH9KHl84HB0GnIpQLPjzE62JIhKHpXPrY
 nfl6r6eff3L5iPG5dPoTTI4cFT9LDAWmyByvILK1qPGhpKwdCUluy8C9sgR9viHGirrv
 Cqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=46JVchtXjykCWqulQO2w6tf7omk6UGW3sCrnOh12e0E=;
 b=QjV0Elb7lNv+SHrh/gQusVtJvG0RMtU1xVNGx7B5BIheO/zLIxjObgXkPa5IKjR3yV
 XQwTYjjqBi2RMagERdt7fpCD6cEYnF+jh/ORs9XElUBaN7XgCEXJqKIQl+6hddS1IDUT
 lLVZhWQOE41HTDS7WIJffNasGzTF4/8GkHhajIZ7269JCZcBRy0Qw01M3tXvSHkvE8IV
 pWXUDuOGvqxPz9m/k0a30yHiCRoSwUTNUlMGOadqml+ksx33cC++4V0Hqk2QRkmj6MSj
 D3IA8xtLMJTqxKA3rVoH4GJG2oN5nFNXzpHDPi17BVvtLDaBIzPRIINHtb25Vcg74bes
 1WxQ==
X-Gm-Message-State: APjAAAVhEVPPAq9CbUdJWB2id5qs4JKjsxL8tiigAFYd5zoHeQdRh/40
 fOXa6EgH2QthNGnTOem8xgMTFWmAaHo=
X-Google-Smtp-Source: APXvYqxNbk7QHZqLzA8PZ56XbX3nena+9Mj48dMaZcAqkXlzrVGevQISRvkBk8WRXR6CM+r5LncGnQ==
X-Received: by 2002:a63:4a47:: with SMTP id j7mr7310472pgl.196.1582939710052; 
 Fri, 28 Feb 2020 17:28:30 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/12] tests/tcg/aarch64: Add newline in pauth-1 printf
Date: Fri, 28 Feb 2020 17:28:11 -0800
Message-Id: <20200229012811.24129-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the output just a bit prettier when running by hand.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/pauth-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
index ea0984ea82..d3878cbeb6 100644
--- a/tests/tcg/aarch64/pauth-1.c
+++ b/tests/tcg/aarch64/pauth-1.c
@@ -29,7 +29,7 @@ int main()
     }
 
     perc = (float) count / (float) (TESTS * 2);
-    printf("Ptr Check: %0.2f%%", perc * 100.0);
+    printf("Ptr Check: %0.2f%%\n", perc * 100.0);
     assert(perc > 0.95);
     return 0;
 }
-- 
2.20.1


