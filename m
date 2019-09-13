Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EA8C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECD720640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAXpenHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECD720640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nOP-0001Z3-PV
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLX-0007fl-Nx
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLW-0000KP-AZ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8nLW-0000JQ-29
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:50 -0400
Received: by mail-wm1-x341.google.com with SMTP id r195so3212846wme.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=030jYKOrb3z68e1uTpgGQV2krhpB89rckomNZ9iGnkc=;
 b=kAXpenHhf0+ToE8W4LprDkWvMeKl4BGl+GaEvs8zfDKC3R6bc2RiDiMLcInLxgzKon
 Wu3KP6k8n2ZeQJMJu/P9kSjqUY9r6yIQ5q/k28lksgVuR122n0YDdoLx10mBKi/f9O8d
 A86usICDJQTsUpvMbmj0k2xNo1mGvkPC+ugs13D70J3KX144DCZ6Twy0J4g+0M6KgVZU
 HLosmQRSzecPUWQpAh2/9U9OswAgYZSnCvJU4bytWYvZGUmzVsfhozmd9TtI1KiUSqtF
 TULyHs+5NGjV6GMXiMGWPPV32e5JDpcrfJCFp4oe0RBlHP+BNeyUAzi3Khzykv4iZZ4Q
 CRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=030jYKOrb3z68e1uTpgGQV2krhpB89rckomNZ9iGnkc=;
 b=NFipaofBKK8dq7CX4GFsvQUx4J1xY0AoDBh0w/LzNazxrBuXeW6eo1OE7NWpD0M3Qa
 OeXuYCnIfOBqc65LKnG7K8GvNO/H4pam6Pzm5Y+03bxDLvKPeT4BM4+cL79B3M1cPxKO
 b8ySurDrbljrsW1atGw5Yc88TE8rwegqyUwSQxTNlDCkxm6RSX+xepjPleQdcD075q5p
 hZQmLRdTp7Quz3HAQqlffIJJ0W4mwyxf4TJSmQZV0hqr4H2Wd28N/q5R0c5i1Ywe3A3T
 WMutKjBjsInmkuEpTf2YbJ14td1h88wp95MwRIGBgwZrWxy3huJgbQLfgKrS6cYAxu5q
 fLWA==
X-Gm-Message-State: APjAAAV2bljId1nAI56920iJEmve7NygXigq6OrlAoFKrusOWtqSnhNM
 Sqqrw5h+yIm2p02yVvqm4IhH6A==
X-Google-Smtp-Source: APXvYqx9DDgI/LjGnP+K5paUzdOLBqOD3VK7H+O05+VhII/VFCsFp6/w1CuodAEXr+jtkfoosVethQ==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr3600724wmf.72.1568387928890; 
 Fri, 13 Sep 2019 08:18:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y186sm5091013wmb.41.2019.09.13.08.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:18:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B13081FF90;
 Fri, 13 Sep 2019 16:18:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 16:18:42 +0100
Message-Id: <20190913151845.12582-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913151845.12582-1-alex.bennee@linaro.org>
References: <20190913151845.12582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v6 3/6] target/arm: handle A-profile
 semihosting at translate time
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As for the other semihosting calls we can resolve this at translate
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
v2
  - update for change to gen_exception_internal_insn API
v3
  - update for decode tree, merge T32 & A32 commits
  - dropped r-b due to changes
v4
  - !IS_USER and !arm_dc_feature(s, ARM_FEATURE_M)
v5
  - only if !IS_USER for softmmu, linux-user is still allowed
---
 target/arm/translate.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b5272119330..698c594e8ce 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10222,14 +10222,25 @@ static bool trans_CBZ(DisasContext *s, arg_CBZ *a)
 }
 
 /*
- * Supervisor call
+ * Supervisor call - both T32 & A32 come here so we need to check
+ * which mode we are in when checking for semihosting.
  */
 
 static bool trans_SVC(DisasContext *s, arg_SVC *a)
 {
-    gen_set_pc_im(s, s->base.pc_next);
-    s->svc_imm = a->imm;
-    s->base.is_jmp = DISAS_SWI;
+    const uint32_t semihost_imm = s->thumb ? 0xab : 0x123456;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M) && semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        !IS_USER(s) &&
+#endif
+        (a->imm == semihost_imm)) {
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+    } else {
+        gen_set_pc_im(s, s->base.pc_next);
+        s->svc_imm = a->imm;
+        s->base.is_jmp = DISAS_SWI;
+    }
     return true;
 }
 
-- 
2.20.1


