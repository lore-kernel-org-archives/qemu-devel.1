Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89AAC31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912FE2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/K5WUnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912FE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzHT-0002Vg-TL
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 15:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33003)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5D-0006vn-Hg
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5B-0007SF-KW
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:47 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz59-0007Oy-L3
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:44 -0400
Received: by mail-pl1-x643.google.com with SMTP id b7so34933483pls.6
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4Ze85vH/aQjxlcuWsjYuHifd5A5xyc14ioC1rkP0Yto=;
 b=B/K5WUnnGiy111NPTwOaiQW0NtyN9hpfo4MH+vcSVcsOM/2oss8u0hV3oRVIh0AYHT
 Q9X/yodCD/1/kDno63G/LcVovJJW9iHlyBX9ihwk5aeRS+mLvzxOt6LWUnYKffOMdALc
 8kQ9ZcY0bj3js5usQnd1daxvaGay8B7k6IRXr0W24a8TIsrx9bnj3IwL5yBIa2aCyuKT
 J1HSY9fImd3SmYU/7JQN3uWubz7I6BH++g0KihvBQT7bQEx2AAeNwOLZzSRTVLUjF3w0
 L+JnCj9eer4GkI2V/tXWBV8W+bIl6bil4kr89MYOhpuVVxpEKi+uHWL4KIYumKvxoUev
 468Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4Ze85vH/aQjxlcuWsjYuHifd5A5xyc14ioC1rkP0Yto=;
 b=g6Zf4BnZZTBWgxvrFkT1L7+5p2agrZpz+PBFnzYsN7fx/nlSbhmLjxrvv5zod47NsD
 GeWABKE/IAGPXgGi6KaATv3VJnnwzxFsq6fegrUc5LPqc+tC6banbWtAhXSQWZNYVXmk
 kwd8/f3G0FuvIRRx4S7q2WHJZqDNqT8h6zWfQm9/OxbDU0vKCMw6tk4Bs9rrOtwpqtD3
 rEcsgRdd9lZX5o1gPs8HJsXyEf1GpkN58NR5+ZWxX4uoFJDBUFD44lLEb2O0h/MHCn+1
 hVDVHffC4chKvxDpNn2f4QXCdajaK/NiucYl/exPk2dRe6t/Z/PLAp3evVURBiKf4PbM
 FwvA==
X-Gm-Message-State: APjAAAUziHgcxg8h0nmbDwy+bS5pXoHeZBauvWiFksE0dipChpa0iUoE
 18SuS8LpiJgtVVP5E8ZKtD3ioUJZIS8=
X-Google-Smtp-Source: APXvYqzJFO+1FmGoDSJ9r7CICKD1CR4xMc85MG0BDcvENkf1v3+QwuGOrezYuv0NcVNbI0lt6Kk2OA==
X-Received: by 2002:a17:902:9041:: with SMTP id
 w1mr23791104plz.132.1564858117384; 
 Sat, 03 Aug 2019 11:48:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:55 -0700
Message-Id: <20190803184800.8221-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v3 29/34] target/arm: Update
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
index 984a441cc4..a0969b78bf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7968,6 +7968,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
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


