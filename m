Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576B9C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22005206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZqCEYIpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22005206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxUp-0003MU-L7
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGp-0002Pg-E5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGo-0007fp-Al
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:59 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:38344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGo-0007fK-6o
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:58 -0400
Received: by mail-yb1-xb44.google.com with SMTP id r68so3254063ybf.5
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nHlb3O+3OTrMLE5XtaApktPGFzFyl87vFrMc6HX9qtE=;
 b=ZqCEYIpKrjpd6xTcqoaQWD1C9Tkcc0sm9eGOxv1ubZPPqRcX+TOxubWYrzOSS9XNo5
 dYZTK851BM3lcBvB27RqGY5nfhDTv5ifqGKlWJCv9QK6aP4hojRXQ0H7Q+Td/9Rqh2An
 2F5ZYyMGCrVAdlUgkmk2KMvJL863w9y4bamf1jNqHQAVYelHZ2ibBVjreV1HetZ/bGft
 6dhLJ0k9ioCkWRpJx7swTcFEO9WY0WGfMQUYBfbrgr3tBgK7kijrrzhsSyI6h90Tq6WU
 AjmX6+7tODP1rKJIjOhZjo7diaIgg42/kuTaqpbuu8+eeuhn4liFCtUx8QbNV+BQePVs
 soGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nHlb3O+3OTrMLE5XtaApktPGFzFyl87vFrMc6HX9qtE=;
 b=ddR2wjN6ogK4DNwiafCJGxQzHEqRC3yqpAIpDYCoCqm6H0n3duRa1BUlZmKjFzzdnt
 524ug4lkQxOOoymF1X5QAERjpXiyha1eF7aLEfEsNZLRaEcESAD0PmBQ1tdrLZK4uIaX
 CRYj6riiHB27qGSXvUbi4qSOaiOgXf1rR3T0wa+bPCWplWpH2hQ+txRZ4T8mrNTxQe9Z
 E7uU+C38eJwvKrIsJwVfJpWILNSswXArurx/pPGmFAIr4OyfspB3mBLJPG4D2H2ygA3v
 0ymMwGM6WEre3her8DLCG6yN7Vvyw9uWGjAH9zVPDO4DK9szjta4UoiHiNqV+PcJ5gDn
 Qp1Q==
X-Gm-Message-State: APjAAAXkLSXim1Dpvriizdf2iBma5pgoLTfd00NNLUxwUItXO57DPVMl
 YLyfwhUyQ+Ys5Z9oB69zNmPHnSgUIX0=
X-Google-Smtp-Source: APXvYqyj0IvgkgsEXA2GvsIzB47U4To1fTFJHwWb9/AtYwruAQ/4U56uC+7/S9n8VHvSvR60MHRHBA==
X-Received: by 2002:a25:2644:: with SMTP id m65mr10846131ybm.462.1570809357334; 
 Fri, 11 Oct 2019 08:55:57 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:55:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/20] target/arm: Split out rebuild_hflags_aprofile
Date: Fri, 11 Oct 2019 11:55:34 -0400
Message-Id: <20191011155546.14342-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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

Create a function to compute the values of the TBFLAG_ANY bits
that will be cached, and are used by A-profile.

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


