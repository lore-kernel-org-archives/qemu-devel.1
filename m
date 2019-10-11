Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D1ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1D5206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vls3T+ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1D5206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxST-00083G-F0
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGo-0002LU-81
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGn-0007eO-4s
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:58 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:39998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGn-0007e3-1R
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:57 -0400
Received: by mail-yb1-xb43.google.com with SMTP id s7so3254895ybq.7
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nFJqxK8OKOrQev/1CQPrr0VKM/9+1cXcigS/dy+zmf4=;
 b=vls3T+ax6QRQgGywOLqQFOiAiTSTvgQafBGaYNxZtVrM/3E7oeVhIBRlMQZZGuqHE7
 eyYrnew1A3OkIWvu0J8mxfckeIwXrl918zUEsg0AJu/0SgTSBXL3UxhA+CfmVTm/FJhN
 bmCM+fx1E/RuODQVfOcwN3OSyehSek5kTgC5VY+yz1vkvTivJSAJObPfhiMZ53knNzmZ
 54y121qSTjSHL3YoFb64MaFOV33BCRKL9u9WB3ld68MXu/FhgbB3aevfVVsvO07eRDDg
 q8P5c0sJvO7mx9q20WkQ9KQUSj2AYDgLUGxtVjOKAPAhWoU/3nC89/VhRYI90Y9P+fRL
 insQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nFJqxK8OKOrQev/1CQPrr0VKM/9+1cXcigS/dy+zmf4=;
 b=k6GHrKek8K0KRdUG/Vkvq4W/RRPQIJbCAJ5M4xYLqvBI7tXj6bedwWNknqZwOfBYd+
 D1ll+5/1BlE8ZRDObPVYSRrQdNt2UOKoJa0qwdrL0C096snRVxlhG0kefH+XzQuMCl7r
 Hv4dXiXxGimyMd7AZelrKuMStIPk8FMj+PcMWJMn5mvZcL52iIW95gczWtjFJYnYo3g5
 Z2gyhHc+MMoKvHu6y3DV3IzJMLhpy1HejnL+s7ijV2uEVAEGRDQ2U0CK+SHosWTllMGU
 Fu4GtJIFtLhpMO9y+U1mjKEUeqsn8Kux+Ab/X6Igj5wYd1pd0xql1wR7HTRxujATOv+z
 SjJg==
X-Gm-Message-State: APjAAAUzuV+UH+myBthuyGAhxzxzIsx7r6RjwnkuvpEQckahheO5F67D
 CNq1gf4hWJob8odggjqB61GZy3WzQJs=
X-Google-Smtp-Source: APXvYqx9PQe1obtcaKCiO8stP/SdAr/rm60qXZi4Dk3j9MzWIyImUZnEu1U31KuMMfUza6myQEQAng==
X-Received: by 2002:a25:388f:: with SMTP id
 f137mr10148377yba.223.1570809356070; 
 Fri, 11 Oct 2019 08:55:56 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:55:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/20] target/arm: Split out rebuild_hflags_a32
Date: Fri, 11 Oct 2019 11:55:33 -0400
Message-Id: <20191011155546.14342-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently a trivial wrapper for rebuild_hflags_common_32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 296a4b2232..d1cd54cc93 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,6 +11106,12 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11218,7 +11224,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-- 
2.17.1


