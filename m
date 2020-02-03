Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09169C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1AC2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIH351M8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1AC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd7n-0004g2-2N
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0o-0007Lo-1k
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0m-0003Zd-Pk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0m-0003XP-Hn
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:40 -0500
Received: by mail-wr1-x442.google.com with SMTP id w12so7618269wrt.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n25wa1lNKzA3qMHXUq9DJlF06TNEvhgokWarr1Y211Q=;
 b=wIH351M8p77wzGZYb8BBlxl8blks686bS3l1ybHB2FE8tDOW5vsmorCA8/5x05cA5J
 WGekc67qznSDHxKocX4c4C6T2WsQfHCG77HlqkUG5WJCkjpPAFwa7LiqvQ9943Y4gHxl
 CwfBhue34L0xuCP0iucwMrYMm50uY9xQQwZhGjYSYHeoGTvoI/o4gmd9piKjkIKElBN0
 klpaF64VXvX1SqNIaDAE94RJSHay2FLvDXXyhHLYe/CeAJA2aBBtRdOmttvuKxOxzCvV
 An8miXYO2KKJxelVu+S1a8/kbuisNzZ8QIdV2/hVckArNgh8kJdoY7sqKIUerNwlgimT
 Nvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n25wa1lNKzA3qMHXUq9DJlF06TNEvhgokWarr1Y211Q=;
 b=QQrc8wruAVJCBxhphHyaXb7vBdXfH9HVvUUyYSX0PfQWcSbb+p2ThD/w8/m5BZLtsb
 6SXG5C3uzBJkCSCYQ1CRjTYXCFfgXnYjeYFM2pz91z/QL1jXYvjowhx2z73YfxVn9yoF
 2N8IXaHZZFDy36lF+eatHHoZzBwWGPnjCsqE0qq/nYCqeXrDEATW7uMqKWqSnIE7uoRI
 AOeIx9JE+ErPZH7SSuR+FXrR6/bElI5kw3rRfkz7A09rkStB4Ndz3szcbmpmDH4VYXG7
 yvf11ynwjfijivQ2B45WpctKjzXxW79aDKCBn6/m9ELHJLf3BafFe05O2APTNP0EwtF6
 Qw8Q==
X-Gm-Message-State: APjAAAWizqlK1WIUA8tYj4xiti++0nP2bOFOrMT++jILcowbg2wRuuPN
 J5R4UWLB7gHvuDsVKdqOpyqHrgjygajeqQ==
X-Google-Smtp-Source: APXvYqzJPKJxRO2gmpQSJv/hQ0ANcrBvCzSXl9ffZB1vaZriz7e3Hjl8rHdiACe/lOoCJ9ZWmDF5Iw==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr15988719wrs.81.1580741259354; 
 Mon, 03 Feb 2020 06:47:39 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/20] target/arm: Enable ARMv8.2-UAO in -cpu max
Date: Mon,  3 Feb 2020 14:47:16 +0000
Message-Id: <20200203144716.32204-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 57fbc5eade..1359564c55 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -676,6 +676,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
+        t = cpu->isar.id_aa64mmfr2;
+        t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);
+        cpu->isar.id_aa64mmfr2 = t;
+
         /* Replicate the same data to the 32-bit id registers.  */
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
-- 
2.20.1


