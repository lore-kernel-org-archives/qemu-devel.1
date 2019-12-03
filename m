Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8586820674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiqfWNAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8586820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyKB-0006h9-GI
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxO-0003UC-Og
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxN-0000N1-Eq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:30 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxN-0000KX-2K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:29 -0500
Received: by mail-pl1-x643.google.com with SMTP id h13so1014551plr.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=k0XWWezVOhFzaYm0qz5tHBxEXRK+lD5naHKLwWqhpHI=;
 b=aiqfWNARXyYW1/8OallmGR59GeT1kMy70QH+mVXvlf6z3mxGUsjV/0NFlv8LehWnGM
 60PbnV+bpa23kpyBRPu1apbnhzVsCXluJZXGNE0mdLrI15gP8sJHW+AnECa1ZqfUnU4c
 kJYjotMwAruV4yacXRCnrnTDLQPj/TQunGi5yaeMwuf/EXleaIXN+SD7e4JgHZEPaTlF
 6RK24uwym9UVLGXS2WIAnyb/Kc6vWCsk0ApMGA+a+vkYLBxm5ERzIfbD1jdhp6/POVat
 kcIwbGrfHV2ZUbI/Jao5JX0/bbvdqobwFvgRBkIJAvsDcwAFK4Yx2K85lW/iYll/wBg0
 SjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=k0XWWezVOhFzaYm0qz5tHBxEXRK+lD5naHKLwWqhpHI=;
 b=YM3M6hhjkl3XfzJRvCr/UUnD28LTdNDIuOvWWUidDBTtPiy//jsjZAazOjpblugQJL
 L7Nw/JQ3MU5BZuOG7HeLo08WsI2DtJ+Ey1nkOQGZ4ZTF5UjnbCeZA/dGNZnmRnbMmclo
 EJGF4PqAzPvJmo+AQ06YlTDc5nFzDdgIC82idQInovypbkhfSML91qU9scHYgBePXCo0
 pcp4M4rC5yBGxAqiUmq1CbZQMhRzWJ4CKk6XRoXyCWJJvkEivZ0yM2N6en2+HAQKWyPD
 BIBHwJXfJ1iKhsYRpxELSl75k0FE8Kvt/Mbo3pW1bMzbvupSHBDSXAAV4e3jbY/eNTcW
 R9CA==
X-Gm-Message-State: APjAAAWQyNY+XobMjnTsUoLbxey+MyqeNgmrN/un/iIEups/8ffXORMe
 fPx5gZOSoJE1RaPtV4lZVDNBDsmI+nQ=
X-Google-Smtp-Source: APXvYqxe7OPYGL9jUAmy+H8UzhHfvbqMiUL2MZtjGC1DbPgBF/JOmSHDVWSZ9/F8AJSd3mVGaRBCCA==
X-Received: by 2002:a17:902:43:: with SMTP id 61mr2772112pla.88.1575340227615; 
 Mon, 02 Dec 2019 18:30:27 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 38/40] target/arm: Pass more cpu state to arm_excp_unmasked
Date: Mon,  2 Dec 2019 18:29:35 -0800
Message-Id: <20191203022937.1474-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid redundant computation of cpu state by passing it in
from the caller, which has already computed it for itself.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a36344d4c7..7a1177b883 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -411,14 +411,13 @@ static void arm_cpu_reset(CPUState *s)
 }
 
 static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
-                                     unsigned int target_el)
+                                     unsigned int target_el,
+                                     unsigned int cur_el, bool secure,
+                                     uint64_t hcr_el2)
 {
     CPUARMState *env = cs->env_ptr;
-    unsigned int cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
     bool pstate_unmasked;
     int8_t unmasked = 0;
-    uint64_t hcr_el2;
 
     /*
      * Don't take exceptions if they target a lower EL.
@@ -429,8 +428,6 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
         return false;
     }
 
-    hcr_el2 = arm_hcr_el2_eff(env);
-
     switch (excp_idx) {
     case EXCP_FIQ:
         pstate_unmasked = !(env->daif & PSTATE_F);
@@ -535,6 +532,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     CPUARMState *env = cs->env_ptr;
     uint32_t cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint32_t target_el;
     uint32_t excp_idx;
     bool ret = false;
@@ -542,7 +540,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
         excp_idx = EXCP_FIQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
-        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
             cs->exception_index = excp_idx;
             env->exception.target_el = target_el;
             cc->do_interrupt(cs);
@@ -552,7 +551,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         excp_idx = EXCP_IRQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
-        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
             cs->exception_index = excp_idx;
             env->exception.target_el = target_el;
             cc->do_interrupt(cs);
@@ -562,7 +562,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_VIRQ) {
         excp_idx = EXCP_VIRQ;
         target_el = 1;
-        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
             cs->exception_index = excp_idx;
             env->exception.target_el = target_el;
             cc->do_interrupt(cs);
@@ -572,7 +573,8 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_VFIQ) {
         excp_idx = EXCP_VFIQ;
         target_el = 1;
-        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
             cs->exception_index = excp_idx;
             env->exception.target_el = target_el;
             cc->do_interrupt(cs);
-- 
2.17.1


