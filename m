Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC9C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBED206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohHwlKZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBED206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxXq-0006s2-CN
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGv-0002Zl-C8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGu-0007kM-2B
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:05 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:42231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGt-0007k5-Ul
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:04 -0400
Received: by mail-yb1-xb43.google.com with SMTP id 4so3245167ybq.9
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5HJoq6lK/mQpFrv0P0Kk1NFyZoCClraFEphXXr+4OkQ=;
 b=ohHwlKZW6TvjzLmcmZaKtzK8LuoHGIehuZTlYRiet+nqIvXkd7UC/4eF4SQpI9xxnu
 lNjkP0PpRAjjYxQj894T894kq5XmxE66w8B7O0WnET65IgP8w15Tj62Rvavp1qXIJD9m
 rjUMrTz8FNUHlBiD4IO6Kb5vA0XGNq5LJf5K7mU37WIutuBe+SDMB9GLEHIIFCtW9BiN
 y8AvTpGbhZnbYTYKaCrn2XuAA+YqNDgdFfu2MNJjb6nlRZjd3wZYkIHZgZgRgZG4JXBA
 zVl4mhpfaMRWf0CSW5UCzzZjtx9Zo9OV3IK91gSX0/qIUFwTIF+xPdLworg1qWHL4vuv
 O6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5HJoq6lK/mQpFrv0P0Kk1NFyZoCClraFEphXXr+4OkQ=;
 b=Jlp0cp2oyDgJGsrONdZhW7/cam/rZyXoUa4xXQhOZwvNMhq2VwaNJr4QjOmPDs3l9A
 9r8g//66SCCQOoVlXJHWfP5rbFEWUOo84MZggGcKgPm+/frFjlOk2qyWPTtbd6iT/lpU
 STKnAyVP6RDvZtXmEOP8kWbsz2TTU7j3ShL14tckUMd58mTNClmPmhWRS5a8p8coORvt
 f4GJ9Tv5cIxhHZ/1CUaXpC3TvmoUDckI/wiIGP1F+dP9Ldf59HXgmln3zZRmRstcLnVi
 +l23Kcx17jUWC/WKDZXj2CiOlKx3J2XZneu90QO92W2y2fK3zIaXgLgLpSZW0aq1kCyO
 /Ypg==
X-Gm-Message-State: APjAAAWCQ79bUR9EZvIzZxriXwHgz8yO6MHcz1DsPxbET5GQ8rUhbV3G
 DsoKxnLjVINxb8Lu4IVfgh8IezXTovg=
X-Google-Smtp-Source: APXvYqxZFtvA0i/Q/lh+8ZJRwllCAWuNXe+/w0HneazqhEj0gs1U9IZH+8KNr4pt5/x0FpKsIsZYDw==
X-Received: by 2002:a25:680e:: with SMTP id d14mr1717687ybc.510.1570809363073; 
 Fri, 11 Oct 2019 08:56:03 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 13/20] target/arm: Split out arm_mmu_idx_el
Date: Fri, 11 Oct 2019 11:55:39 -0400
Message-Id: <20191011155546.14342-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Avoid calling arm_current_el() twice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  9 +++++++++
 target/arm/helper.c    | 12 +++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 232d963875..f5313dd3d4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -949,6 +949,15 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
 
+/**
+ * arm_mmu_idx_el:
+ * @env: The cpu environment
+ * @el: The EL to use.
+ *
+ * Return the full ARMMMUIdx for the translation regime for EL.
+ */
+ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
+
 /**
  * arm_mmu_idx:
  * @env: The cpu environment
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 85de96d071..3f7d3f257d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11026,15 +11026,12 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 }
 #endif
 
-ARMMMUIdx arm_mmu_idx(CPUARMState *env)
+ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
 {
-    int el;
-
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
-    el = arm_current_el(env);
     if (el < 2 && arm_is_secure_below_el3(env)) {
         return ARMMMUIdx_S1SE0 + el;
     } else {
@@ -11042,6 +11039,11 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     }
 }
 
+ARMMMUIdx arm_mmu_idx(CPUARMState *env)
+{
+    return arm_mmu_idx_el(env, arm_current_el(env));
+}
+
 int cpu_mmu_index(CPUARMState *env, bool ifetch)
 {
     return arm_to_core_mmu_idx(arm_mmu_idx(env));
@@ -11202,7 +11204,7 @@ static uint32_t rebuild_hflags_internal(CPUARMState *env)
 {
     int el = arm_current_el(env);
     int fp_el = fp_exception_el(env, el);
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
 
     if (is_a64(env)) {
         return rebuild_hflags_a64(env, el, fp_el, mmu_idx);
-- 
2.17.1


