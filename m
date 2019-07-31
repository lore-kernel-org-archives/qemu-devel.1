Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC1C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33272171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="unuLZm42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33272171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvVD-00080C-Ad
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33125)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN7-0005UU-Sp
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN6-0003mV-UY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:53 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvN5-0003ju-4y
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:51 -0400
Received: by mail-pf1-x444.google.com with SMTP id f17so28520722pfn.6
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=z5x3XqHQzkXZQb+8jCB+i1sKV2y2i8Y/ULFiYsKcHrY=;
 b=unuLZm42rCfAS60ozJ8safaC8nD5g8e6LVR3KeYDg1q53pmRe0lkVvvNHy+0ERYAcr
 90sHJtzbhPU/PZeOJo6qqDShpBl+p8/30jic2Or34llqjfrj3godzX2M2OjfB1u0V2pY
 oCWfgFcJ6S22TBgXB/aPpe4m7Py+bf18Mi/IJNsteMgY+NveKvhnK2O0IDQlZirmys2B
 qwpYtL+JEumSF9rCTv6wkKAQiG0wPxLWPO3cs9aqw3n6IGlL7dbKdR9UfIQiWbx8T4r3
 p0EnhK8Ws5jBfxeOuzSB/nGPuue8PQzOlti58271GPmD0KdMIuaNsu09sutaU4oa/W6G
 WICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=z5x3XqHQzkXZQb+8jCB+i1sKV2y2i8Y/ULFiYsKcHrY=;
 b=ILTe957sGxq33m6F3FWFfCMrTuRWoYeu3100DetPOPI87NZOKB6FTtgboMkZmGsC/T
 LOUwZTGZCiCQFUFSBwqYDz0LCNIJaqYC36lG2b5xVfuivDPmtpjGPoRMyipTzetIhS2h
 koegOJwo3lOrg89vsNrk1Ygu2cRBf7/6sS/wYllOJUvljcRKVdr01GvJ1hNpvP9G5qGx
 ABPopDlPf8321mwVEzt8vPV/59a19aUZuQoUfvegyTum2qyEhxAbNzOGnJdZ6djnIauZ
 jrf6XrDnKKT2j9K3nYnToK8w22rBmqb2ikE6Zk6ULjjJ1Khfay2umvuhzvxrhx3bJwTz
 HQ5g==
X-Gm-Message-State: APjAAAUQkfGw3Za3hVA3vq1QVo4IlGY9mCaSjETSkJ1HszbZhmaALIN1
 bEZ3tfk7UOlYZJSotUDKpgEbH9Mt6l8=
X-Google-Smtp-Source: APXvYqwKeOX88xREAURGqT8TV39GAj9Y+FheZvGgBkI7coD5tzOSsrTpB1fmstqXKVf5GIFu5q7ZsQ==
X-Received: by 2002:a17:90a:b011:: with SMTP id
 x17mr4737759pjq.113.1564605528486; 
 Wed, 31 Jul 2019 13:38:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:08 -0700
Message-Id: <20190731203813.30765-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 27/32] target/arm: Update
 arm_phys_excp_target_el for TGE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TGE bit routes all asynchronous exceptions to EL2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b9f0d387f4..c6b40a12b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7936,6 +7936,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
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


