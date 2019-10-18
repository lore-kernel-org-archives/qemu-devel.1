Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EFBCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DBA21D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqqk+gJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DBA21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWaq-0000SL-F0
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIw-0006Y9-Py
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIu-0005RZ-EF
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:46 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWIu-0005Pq-6Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:44 -0400
Received: by mail-pf1-x444.google.com with SMTP id q12so4311358pff.9
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EExBny+oAa/2RvpDTj0xViQxKJSM6o83jutlTagIpwU=;
 b=jqqk+gJiZ9YrCR3dy0o3Lgiw7Z6ZqhF1P8W+cy4NtzomqpZ8PrM4mz/jL6j2JhgsR5
 HxiaSaMqOiq7zTWCHl0SU8YnfWKfBh8Rau+7AdBfO00MPF7tCs1D/nW7POj3E6RR4+Np
 fvCuO5qo5WDIrHNgR2CL6kUZfBP+V1HA6e8McptspXkKcsXDJxDCi4edsDzua71ZCdsc
 +4OwL01JdMDficT9qtIHihX0x/W6TZ9kchFmNVS7QjKblCnpR3QuWPYoEoJ+v/3u6fYa
 QOFbuZzbGa1IvMe1rUEXsXulOD4ZUJMSU3Kl2PS5ECL2v5n5gPqxEJQCa3zcxsXR88pG
 ZHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EExBny+oAa/2RvpDTj0xViQxKJSM6o83jutlTagIpwU=;
 b=XOiGNherXt8KTVN8r/CoFT2BXlj0kE9rvTG9KQj7WbUfLj8SZ/u8hfEaH3E3kxsuLx
 9sHocId7eDLdt5pC1zhGy5Ioa1LVqraFlOcnoQEAlDq9m+IVHElaRzi32mcrLVLJFFmm
 kLPMxOihc/BBVYr+/gS4Ks7Bv6aAb9dyX44O+rX+2bq0iC9SLki372xVzZXnqXYjP1S0
 3B7Ylngn1ozb91SIjtqxC0d56CNxKAzCRHluevTrlxxU9dV0M8WIvfL2A0ClgwE5z+Fp
 MvjVBfIoieVxSTN/CvMxQgcQudj41+fDn2hHcBKkWbAdJC8Hk2p+Nc32iR+7Vlogyrqt
 jOHg==
X-Gm-Message-State: APjAAAVsALiqBTI+ig6yp/r0cq+dRVB+GUBuSo0Nj6PKxuSzKvTVha1X
 BfAU8vrrJaBFwtsM+uxSDUuqHznC0R8=
X-Google-Smtp-Source: APXvYqzLQUC6hh/IqxoPtGDjyO1VhA5GgyP8xz1xzWcTx/3ot4w+5tTZnPHPfizhpflbjIvQy1ggDw==
X-Received: by 2002:a62:b616:: with SMTP id j22mr8036487pff.55.1571420682064; 
 Fri, 18 Oct 2019 10:44:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/22] target/arm: Split out rebuild_hflags_aprofile
Date: Fri, 18 Oct 2019 10:44:17 -0700
Message-Id: <20191018174431.1784-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a function to compute the values of the TBFLAG_ANY bits
that will be cached, and are used by A-profile.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1cd54cc93..ddd21edfcf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,18 +11106,28 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_aprofile(CPUARMState *env)
+{
+    int flags = 0;
+
+    flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL,
+                       arm_debug_target_el(env));
+    return flags;
+}
+
 static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
-    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+    uint32_t flags = rebuild_hflags_aprofile(env);
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
+    uint32_t flags = rebuild_hflags_aprofile(env);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
     ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-    uint32_t flags = 0;
     uint64_t sctlr;
     int tbii, tbid;
 
@@ -11262,12 +11272,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (!arm_feature(env, ARM_FEATURE_M)) {
-        int target_el = arm_debug_target_el(env);
-
-        flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL, target_el);
-    }
-
     *pflags = flags;
     *cs_base = 0;
 }
-- 
2.17.1


