Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1004C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6850C20409
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZA1tm6+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6850C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3hQ-0000Hv-Cm
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bq-0003Nm-AW
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bo-0004Ck-Qs
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:58 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3bo-0004C8-L5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:56 -0500
Received: by mail-wr1-x42b.google.com with SMTP id n1so23814796wra.10
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=y2M3WHGY+Q1Ah8M4tb/j4vEz9JAnBUgll0Pz7NMzIJ8=;
 b=ZA1tm6+tl4AfOzzUBuCyJSnvBPnYK6u8D36c3B0nTMk7/9Oadnxvde6jkrS3EJqHKV
 UPLx8mVgeGO3AYle6pXpVj+F7Jbp9PV2NR5YTH4wMOX+tr3MbeE9QbiCsokuz3V7Yv2n
 vLk3nOJ9BLUXAf7s6RGe/FJKVHnl3Rf2SCa44ebaLBMNAJwOpG7ybvvZuF6HmA8YXD0R
 E9xybEWSkHAI4vouhYsNpADY11CoyLwmd7/9fOW3ZknyMkZyTIrwaVjtqVVe1Uhzp6M7
 TxVnUJSXvhtNPWqwWb7pKxBr4PrcdvLgIayhuIRoQ8G6Vp3zxSI2xDe6ra7A8/laa5/t
 W1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y2M3WHGY+Q1Ah8M4tb/j4vEz9JAnBUgll0Pz7NMzIJ8=;
 b=AOtEIdgQYA0Ja7qohPjtkbRmBqpjXonDJ1uKsHjTZ4k5jiblAcJ8LVD1B2oNEOvADr
 ffxYSRER06LWkg73MY72TKrFKeNsNHadmPM6fhliiyheqA7oDHY4pdjFMvGCRetAvYZ/
 zDGHDAO7sbSpIJst+te9SJlZ2RHDgjV0dct4Yh346x4iNYbhkllG1K+nrttTJXZE+ZKy
 0qXCvYVj1AXZFkFRi2qzuhsA2qCievTnZ+89d+w9S6GWAwQVYN2ArCtDhwAhTsUPv/7b
 2Jd1BIC4Rh/EvX0+k729xsmbFw2gleyHn2L0t2kxrKU0fXGXzRrXtDjmGlG7kVgXpRJu
 wkWA==
X-Gm-Message-State: APjAAAV4cCG5eILntgPcjAVH+DuU6ib4WKcc92SWLG8IC+JMW13pZOic
 mQsLRmRNy5cT0ezRWqE9+5tqfGmjttxTIw==
X-Google-Smtp-Source: APXvYqzv3hwCaHqUzsTaAjZp+ZDvCX7AlDpjKXMxUiRh3nPVhsfcrOClSi0Je/S/RQQwLuGB5HcZ6w==
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr9329155wrx.154.1574170315356; 
 Tue, 19 Nov 2019 05:31:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g8sm3094905wmk.23.2019.11.19.05.31.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 05:31:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] target/arm: Do not reject rt == rt2 for strexd
Date: Tue, 19 Nov 2019 13:31:43 +0000
Message-Id: <20191119133145.31466-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119133145.31466-1-peter.maydell@linaro.org>
References: <20191119133145.31466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

There was too much cut and paste between ldrexd and strexd,
as ldrexd does prohibit two output registers the same.

Fixes: af288228995
Reported-by: Michael Goffioul <michael.goffioul@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191117090621.32425-2-richard.henderson@linaro.org
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2ea9da7637b..b285b23858e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8934,7 +8934,7 @@ static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
         || (s->thumb && (a->rd == 13 || a->rt == 13))
         || (mop == MO_64
             && (a->rt2 == 15
-                || a->rd == a->rt2 || a->rt == a->rt2
+                || a->rd == a->rt2
                 || (s->thumb && a->rt2 == 13)))) {
         unallocated_encoding(s);
         return true;
-- 
2.20.1


