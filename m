Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9514DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEE62184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA4xddtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEE62184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMugx-0000DC-10
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuH5-00034s-LJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuH4-0001PI-It
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuH4-0001Op-8I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id f22so16202252wmc.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AjxV4oGswa4GKpOinnwqKxedXmy/4M53xUpHLL3DeFg=;
 b=UA4xddtFN3NA9QBCkGvT4fWs8xPF0gMxbjQeQM6JYkbYJl/2m6cdhhd/cchdKlV4+R
 NhxP96htrBjCHfoUhOYehDNAB+k9suRrGrFUKA9k4TRT4cdH0FxJGkosZFnqajn82Xt/
 19EJs1F4AtKWiGyqJIolj4Y4x5ipMuWiED5XesLNELRRedAQfAGMll0XMcj8qLKgbZgO
 +zC+y331OpgX/Y/5suqKNmzTbjPMI/ynU5Hazny5DB0BZKkVe1SCiMRwOHyhcqt77+4b
 7uYqoRB8rLZaOpbXGzgdC1zHbrG+EHYFgdE1OsB8Kyq8JoeJgeMfCIyZIfJv3Rct1qM9
 i/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AjxV4oGswa4GKpOinnwqKxedXmy/4M53xUpHLL3DeFg=;
 b=P3/G16pw4wH//Xgluk89NMYl/oSDERyBasGZa3hNxLRxszDigmqytLyHc2NAF9kHiv
 BEjblVCzKi9wzf6RD/YUXfgIC2O93OClkEAU2nYh9Se3LiFeN9viFLahMAu4lnEd1p+l
 MJL/LKHuQIH8a12VUDvrYR/p4S4/r/y7lxKsp8lV47hOCqJ23GA91ghLJdAJFP8fQb8F
 4cjkAu5pWQSkybEt5VrEaQB2JydsOZT3zdXVk56IeJFmWLolN9u+PKkKif1HQbLErb8u
 LfPCmA0ERj8xxRWktnQVUxHiDtfTfnNzf6nL4Wnpyi1uPnr+qxrOUy6M4CLpptdYJbGA
 6HOQ==
X-Gm-Message-State: APjAAAWMMgk+8LaPPzQuqp+6bWBK+IOszWosLdBW3TMCiasx7sQYC6Bl
 NnZppaeMaKZ3pfAXQbD47KXmIIBttpw=
X-Google-Smtp-Source: APXvYqzldmPfRBjoczp0Rnp/QZd/35mHL+TYAE+2w4+j2w555AsraPMWBbRBsoWeujq7JwUhvZyyWw==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr3309684wme.92.1571751152635; 
 Tue, 22 Oct 2019 06:32:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/41] target/arm: Split out arm_mmu_idx_el
Date: Tue, 22 Oct 2019 14:31:16 +0100
Message-Id: <20191022133134.14487-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Avoid calling arm_current_el() twice.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  9 +++++++++
 target/arm/helper.c    | 12 +++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 232d9638753..f5313dd3d42 100644
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
index 85de96d071a..3f7d3f257d8 100644
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
2.20.1


