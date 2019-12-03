Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AE3206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSu/J7st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AE3206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyNp-0003UO-RV
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxK-0003NQ-I9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxI-0000BF-S1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:25 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxF-00006g-VH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:23 -0500
Received: by mail-pl1-x643.google.com with SMTP id bd4so1001765plb.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IK7rSI06S6h9YUMM4pqvJuR/qhJRw6SERUwBa547XN0=;
 b=QSu/J7steepWES5yflZElUbSs4dYALg07BxZKiUyqwzF8ZRJhwcsSiLhpMBpGtFFjE
 SFzjvMIyX6dUH6dGG6nLRadIwHxUH4nwjSgSJ4kO7NPV/APNgbFRZLYqkuzfRgV70N8H
 n50KZeRXtjCQtnPb+i5FfdHt78/jqKbaeX3DSyy1Nc2QEl3H6p6K/fJYVIhzB+2yd6FM
 CEXaFjodHuDCt+MKs78o8TzSGMQzHo/fAAf4yL18KoQ1w1fsbR4Ukbktwh9zH5sWePie
 e0J8AZ+uhgBjZK3LKD0EBks/gBCy45Z/PaTBLV6H2X9F6yvPe/ZKbJC/YY+PIq/zzGQI
 MkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IK7rSI06S6h9YUMM4pqvJuR/qhJRw6SERUwBa547XN0=;
 b=DSMBWJjVQwW5lIehdDhmhLYZjCRLPOPf8Mu7P6P0cq96Cj4f6KcvRHs36OsWttjp9L
 PCM31ihEFKEfz1qSqGC9gPkXzklseGzvLP+RJAYovXJhBiDUpEwq97/de/iN06ox9Wgo
 bZTmp/q9D1mwiE6sxLiqhU9Q5UWs9KO6KebvFnlRgPj1t3gc/tQ10V1eJea2Da2xzNm2
 7tw6UH8xZaSR6Pt1Z7rOiDYIwxxmJpf7d5tfaBQ6xVszYy+CpJGR0Cy8Qar0N8Lwz/PU
 N71HFjFYnsPQ9sa1dTikLrAgxe/5BpeW2VBPZm+ODOZEgtegNBDfIo0RWqY6ncOgL9Ba
 HbsA==
X-Gm-Message-State: APjAAAWGsu+kMj9WXOEk4crg2NtJmxkPNblsAWRX7MngTl58AI0KTn8k
 M6SRRdRqbAjoWCvnuCpj8ufZmk81NVQ=
X-Google-Smtp-Source: APXvYqxOz+Ih3oil3MtBE6RBbtUrjSr+FGT07F93ko1pnjgEq9cvsgF1EbmWxKQkiTt8xN6nNzlpsw==
X-Received: by 2002:a17:902:9a96:: with SMTP id
 w22mr2679175plp.124.1575340218750; 
 Mon, 02 Dec 2019 18:30:18 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 31/40] target/arm: Update arm_phys_excp_target_el for TGE
Date: Mon,  2 Dec 2019 18:29:28 -0800
Message-Id: <20191203022937.1474-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

The TGE bit routes all asynchronous exceptions to EL2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b059d9f81a..e0b8c81c5f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8316,6 +8316,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         break;
     };
 
+    /*
+     * For these purposes, TGE and AMO/IMO/FMO both force the
+     * interrupt to EL2.  Fold TGE into the bit extracted above.
+     */
+    hcr |= (hcr_el2 & HCR_TGE) != 0;
+
     /* Perform a table-lookup for the target EL given the current state */
     target_el = target_el_table[is64][scr][rw][hcr][secure][cur_el];
 
-- 
2.17.1


