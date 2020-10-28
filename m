Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62EBC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E241A24813
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8i9GMqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E241A24813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqyK-0006FI-H3
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 15:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXqwm-0004iJ-UG
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:17:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXqwi-0007a0-1l
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:17:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id t3so343084wmi.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t9TzEw+5lSfoYMnb9djte7cKvh5seLsAJB+iLYPKOyU=;
 b=D8i9GMqnKB3nl+KwjctvK3niE9NTEDkSCqoj8cZygsHAXXnGv07iTv+v6ce4gT/4WS
 U0l0ge3oLggS3ck1sOdFclGf5TxKevH7a62Fprwr/YQ4NkFQeHGWtZiWs+hwCJiS8vgd
 jfFPwGxZzM3ftPbf4DduuO+4hDtj285yTLBshk2UDPFzuqKue96rH577qh+XBLdRJQ2u
 3ahnuz//tgWpV/NtcReiVnzinq4ycqjjBot79jMdBpV3U7PoLeKY673cp8jEV+F4TeEp
 J7Z6FAChvfLfqufTCCrYOoCEGYgGnSR0eSLxOCbbqDM0B3guGRGm8OVkoKwvQuTTK5O1
 7AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t9TzEw+5lSfoYMnb9djte7cKvh5seLsAJB+iLYPKOyU=;
 b=P9X/X6QDZcZrygIURqH6OKAHj5V00ou7Y4ofqijVfvfM7fNXETEMcSlLg6uoo0A1P9
 LVmwfVVekcXBn4DkUFsKtZN0DgK1toRhjhP/YE6v4sCGtPv76bMDyyvH0CEiIa2kcoL8
 B54f8dB0aRTUTjjeygM5HR8EYPYXCqlbkaFSot+DpUoMxzaT+FePET/A4tVpktPY8bxL
 UXPBpVm1nQ3iDkqBmRjNp/G8dR/TsSqBxOGfVKULFQrGQv9XwOzXb8kJVqyKzcTNVA7T
 EXAzX61j9by5q1jEzVdn1ukLAxWA2CWOzj0M2A0/KLsgppOBJ6yR8kJhK4uM0Abipwuy
 uiAQ==
X-Gm-Message-State: AOAM531bq3kP9B4o5g9xNMP7ddGOVn0fnKWhucSBiGwtV89zcsXrWdbZ
 4Q3Cb6Xgsld6DxLmMSi4t3WH2w==
X-Google-Smtp-Source: ABdhPJwC53uZKvaNgozpthKdgc/Yk8dYmpNIK8XcZiAr73P2qa2kBzxTeBKwyxma4XvEpCTM8lhUFQ==
X-Received: by 2002:a1c:7d49:: with SMTP id y70mr302920wmc.103.1603912636259; 
 Wed, 28 Oct 2020 12:17:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l16sm743953wrx.5.2020.10.28.12.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 12:17:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/arm: Fix float16 pairwise Neon ops on big-endian
 hosts
Date: Wed, 28 Oct 2020 19:17:11 +0000
Message-Id: <20201028191712.4910-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201028191712.4910-1-peter.maydell@linaro.org>
References: <20201028191712.4910-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the neon_padd/pmax/pmin helpers for float16, a cut-and-paste error
meant we were using the H4() address swizzler macro rather than the
H2() which is required for 2-byte data.  This had no effect on
little-endian hosts but meant we put the result data into the
destination Dreg in the wrong order on big-endian hosts.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vec_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index a973454e4f4..30d76d05beb 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1858,10 +1858,10 @@ DO_ABA(gvec_uaba_d, uint64_t)
         r2 = float16_##OP(m[H2(0)], m[H2(1)], fpst);                    \
         r3 = float16_##OP(m[H2(2)], m[H2(3)], fpst);                    \
                                                                         \
-        d[H4(0)] = r0;                                                  \
-        d[H4(1)] = r1;                                                  \
-        d[H4(2)] = r2;                                                  \
-        d[H4(3)] = r3;                                                  \
+        d[H2(0)] = r0;                                                  \
+        d[H2(1)] = r1;                                                  \
+        d[H2(2)] = r2;                                                  \
+        d[H2(3)] = r3;                                                  \
     }
 
 DO_NEON_PAIRWISE(neon_padd, add)
-- 
2.20.1


