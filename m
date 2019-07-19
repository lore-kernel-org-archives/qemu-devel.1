Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF97C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC35D20880
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFA8zQGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC35D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa5B-0006kH-Rf
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3Z-000870-NB
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3X-0005YT-2u
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3W-0005DB-G7
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:42 -0400
Received: by mail-pl1-x642.google.com with SMTP id b7so16204229pls.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sn9Ip3IXKGmzCPWyVRHRq/o5V+1VMHe6ik0L3AXMc28=;
 b=uFA8zQGhSTwGMg7PII9iiLXTN43TWAE95Rw2+bSEMD9D/MX3GIB1dDWh+aKmKYY8b1
 DbsWFyHheHkc6RbuLioyCBSc9PokGeajGUStrL+KU3E/zyAp5/q6BA9IIrjwcZFeWxF2
 0JxrM5vWEWyBnx5dAc2ulTmzeXfB/hFjaVYtjaLYEX9wiU3FanOuyuqq6HjGe0On+vu1
 eiz3jS7U7Bv+cRVpcTcW1RaRR+m9nuPAVf7ZRs4+QBcfGidyqLY5wzC3ytKwTspdtSW+
 R4xrB1+UpoOsELhUdnAn2Bq8plZpvK5FqRNaZjmuIy3V9eu7flK2bsOz2eu4/8vCZjED
 gamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sn9Ip3IXKGmzCPWyVRHRq/o5V+1VMHe6ik0L3AXMc28=;
 b=B+NCGoz9LyFu5JFFh1xj66ZoYMvWxkfoEP8uAwls9RM4UeDy7TcfJB9Z/zupOKylYR
 HCBNglHnz5wD0MgsDsi1SkbxNCNrpFC40OOVCnkGyDk3bII/GU+yXSKiiuNxGbQMejhN
 0C6ntXzHgzINrocE+Sdv0N+GLB/Bz8Bb6EYzHBM96pugfVrx0wpk2l+U20I9darz8qj0
 t80CJaj86SMLPCWU47Pc5JwkQmTl4i4iIAeNlZpam/JTHszVEWwC++l4qfnrZXxuoAhj
 UB6b2zFNGUZDpIfYJTZDflpi7U6Pe73TXm+svsGZ1WeH0rrYlBOiapMADmof0c7VDcij
 osKg==
X-Gm-Message-State: APjAAAXXWRmuR6ZMxwXp6XafuAf+Q9etCw0hMbWk/2rUVowmTjgxe4Sp
 es9S6mFOaLd+tjN7IurRctk3c/3bNNg=
X-Google-Smtp-Source: APXvYqwCvDgLMsZ5ZWK29wEI4AVN3cAAZeEpGt34VrsAtCioOZ08KAcukZRaer3TLM3P0Kw5v2W4rA==
X-Received: by 2002:a17:902:9004:: with SMTP id
 a4mr59351948plp.109.1563570233620; 
 Fri, 19 Jul 2019 14:03:53 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:23 -0700
Message-Id: <20190719210326.15466-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH for-4.2 21/24] target/arm: Update
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TGE bit routes all asynchronous exceptions to EL2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe022f51d6..f06e7bcd77 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7928,6 +7928,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
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


