Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A6ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069BF21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXGvP0/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069BF21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLBFb-0003om-4i
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs9-0001KI-8p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs6-0000xG-IV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLAs6-0000uv-AV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id 205so2222924pfw.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ksJ29EsO4EC0RqRT/ptTGb/nh233vty3hFHL48/i7gI=;
 b=SXGvP0/aPjZW/oFXhMmNuaGEV4bjpX608aNzrFC7TlEbbPFSMI+wQvU2E9jV+yZ0p7
 bT97NzOr3Ug0rEjwUpks4DPJ7tY1o3aJ/Mhk7ZC14H83DlPlp746ASUct0VTAJapvoyk
 YOZWsmExontfuIlIAfIBYT+Q47+Cbe/2vbngw8UOh0NrTZHGAm6ffCwA3qWNWvSrh6Jk
 y4pnQzMfN5AeBdaZCsdfvjaalInsT46V3Ytc+vF4q/KK2Ok3bFsQnao9YlB7Be86WdqO
 pQKSpBhgAjSk8buNzny9vp3j6zd8yAJKmgzY8LVLUfWQjWZfzE/cOrl+QiiXsb7HUY6T
 Sk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ksJ29EsO4EC0RqRT/ptTGb/nh233vty3hFHL48/i7gI=;
 b=njgjkxcK1Red/snr3D0l7LclxpfRuhekX998+XQweiCQ7oiMS8ZnUJOBbC7k6Ea/OO
 tsbbic/IbzsqUK6DW96/wA6OcQqu7tFYJy8JVgY1UsHF9v9yJ6sNjLXpfA5kKvGTgEmW
 pcFfAxN75EuDXekr4mo0K6ZbMLrupgkycWCEpJ3LHZUjMtwt18JgilkLO9iyG4HUw3Fe
 CT1ycEr/NTs0E+PEWFwbvulVYv/iYVsTA4xWcM2ZGA7zeaufJLBV2KE/lIns9iRRbvhS
 k2gBDQuv0kwyPuwn0xkeOsHO7ZgT6E/j1dJnRmRfBigYhOg/qlD/vfpFJAIwXJN058CV
 CVLg==
X-Gm-Message-State: APjAAAXv5B1BGN5V9z14G84Oihe2N+GmCTTbF0rcV01e9hubIPQ5lWm2
 FdQ+H55OYe4PMQTS+K951y79qIS9hM0=
X-Google-Smtp-Source: APXvYqzMceDlRpvsJEwCkdP374QUGo9yYaeCLs1YjcTYWnSJ/8c8sOVy6/XmWcLGpdjVkK6eUoD/oA==
X-Received: by 2002:a65:400b:: with SMTP id f11mr5791836pgp.57.1571338291875; 
 Thu, 17 Oct 2019 11:51:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 15/20] target/arm: Add HELPER(rebuild_hflags_{a32, a64,
 m32})
Date: Thu, 17 Oct 2019 11:51:05 -0700
Message-Id: <20191017185110.539-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

This functions are given the mode and el state of the cpu
and writes the computed value to env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h |  4 ++++
 target/arm/helper.c | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1fb2cb5a77..3d4ec267a2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -90,6 +90,10 @@ DEF_HELPER_4(msr_banked, void, env, i32, i32, i32)
 DEF_HELPER_2(get_user_reg, i32, env, i32)
 DEF_HELPER_3(set_user_reg, void, env, i32, i32)
 
+DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
+DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
+DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
+
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37424e3d4d..b2d701cf00 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11220,6 +11220,30 @@ void arm_rebuild_hflags(CPUARMState *env)
     env->hflags = rebuild_hflags_internal(env);
 }
 
+void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
+{
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+
+    env->hflags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+}
+
+void HELPER(rebuild_hflags_a32)(CPUARMState *env, int el)
+{
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+
+    env->hflags = rebuild_hflags_a32(env, fp_el, mmu_idx);
+}
+
+void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
+{
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+
+    env->hflags = rebuild_hflags_a64(env, el, fp_el, mmu_idx);
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-- 
2.17.1


