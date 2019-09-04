Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD375C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACB821726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2bi62r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACB821726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cjO-0003Ac-SK
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9Y-0006Av-MD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9X-0006li-C4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:46604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9X-0006lF-3l
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id t1so71297plq.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DCUh3pxo77uhgP+ZJoHLASbE9LI4j7qaNhsFo5dJ8X8=;
 b=X2bi62r7E6W+ANGD6dXapnAAlHBs1N3/il/xLnEE7kwqaqLsgvdMHhI2V1TnDsM9ch
 Gaz9tPsxLcbwTnHCZ40PstdFNm7Xcer9TwuSq/UAaZmbLXOM+Y2wKxaULda82NniwX3J
 qKsVxJROJUlSrkl+Uca9oK/RPc5d4U/u9TyzA9rN/LEfMVoWRA3IIwG29DYGnRbcdtcd
 ZWnSlctUGaRdwj4vNgjEy2VnQL99SbYwBBbvotgGzbseMv/9ZvIvBbC6UvxEl9zdPOCq
 Rjh3RyW84hJ2Fc5Tr0Ylhs0wSdGOMFHZeAS9GalIvjXSMsi7Rbv9fz+3yQSUWegjROaq
 9vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DCUh3pxo77uhgP+ZJoHLASbE9LI4j7qaNhsFo5dJ8X8=;
 b=ghMnbdi0RMyMqytOgqdXpAn162jqyj3tjU21KMajXIG3P/sX/Gz8WowsVCxyW3g5n6
 CNObnsrOu7zX1qpAKSbs4Jy+3wiBWI+ypJijAv909BQMWFlcT5Scol12gAhpavbKMK9V
 TQg/ul5yvAUViur9t0OYY+zzaHxmA/hyYgc6YjcZ20dTvgjNIsBXEFbK4pDxi5lQkOq5
 9RfdKF4PrkUg7VZ1Bp+DVO9lYWuBwp1Yc1nuXV7Rd46jKofxSnhcZYLyZcF/7lmhTlpG
 nHTe6VAFAsVfhaW5qI7lYz/JrmUok/seFYxEcXt9bKQAHznRJDXHs/+nxSWekzRDu9GL
 jsJg==
X-Gm-Message-State: APjAAAX0ud7aSvVk4rw8Ou2Vmyy8uZZOFZyhe3Z5+lAK3vhD5xY4OrjV
 hPppApSW4jc15TCD2E1mKHi87eOqiRI=
X-Google-Smtp-Source: APXvYqx5v94WzMwOFVmCtMSSiRpoGce2IzOWju5lW9w/pBOonHhRzFJ9SKEqlCDzxaIuqdxUHSVIlQ==
X-Received: by 2002:a17:902:44c:: with SMTP id
 70mr41774517ple.225.1567629917984; 
 Wed, 04 Sep 2019 13:45:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:45:01 -0700
Message-Id: <20190904204507.32457-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: [Qemu-devel] [PULL 07/13] target/openrisc: Fix lf.ftoi.s
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The specification of this insn is round-to-zero.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index b9d2ebbb8c..4cc5b297c5 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -78,7 +78,7 @@ uint64_t HELPER(ftoid)(CPUOpenRISCState *env, uint64_t val)
 
 uint32_t HELPER(ftois)(CPUOpenRISCState *env, uint32_t val)
 {
-    return float32_to_int32(val, &env->fp_status);
+    return float32_to_int32_round_to_zero(val, &env->fp_status);
 }
 
 #define FLOAT_CALC(name)                                                  \
-- 
2.17.1


