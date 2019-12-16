Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C931C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5214E206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NO7k0iit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5214E206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igysc-0002Ag-8u
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybX-0005bv-O1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybW-0007gb-62
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:39 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybV-0007fA-Um
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:38 -0500
Received: by mail-pf1-x444.google.com with SMTP id q8so6375364pfh.7
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EBuG90/vK8B36Mf6d2sHl6oKF9FxUrNicyhDw+0iJQ0=;
 b=NO7k0iit9iUGLeZ/HIHUaYiwXpR6/W1ZMbdayoHB3bUU4u4dktb3kJ9uEk7dYESoMP
 reD+W9eZCOaoc2Y3OSQe9HypCtNcZ7YVwT9wwfNrFm1QsM5mJFcdpGo27nus1gV2ySxJ
 2ADI1le9gJmEixAjwC5B1EuOoe6qfZOlHw7ljwu3+FdE4MCfx2SIVxgWpkGWbG0QwBKI
 W6vtX1j7gL8A28rMuml9EeoEqL8e4p0VbXWwusMtQYw9CWZeLMSLxqH4sPqiNKirm5+h
 xljpP8GFXOw6HQsUZxzWKIiM+QtNydDaXAvXzPsyPGKFOefm7oQSZxT3pdd+mcceKe1H
 orHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBuG90/vK8B36Mf6d2sHl6oKF9FxUrNicyhDw+0iJQ0=;
 b=MQabkB5ohdrub+O34HuXkzoSLg8jkEnAQvS9fHuddJqOODLjTLw1n+xPUh94t9u21h
 PgiC3i6VzWNVyUhW2p3g9YyKdyyJ68+2Gljxsf/INwcYjjvzhtkt5JGmhf2qbxsVelYY
 D8yllHRB8hji6kqGybEu1eVjAHdV4XrjhlMXrxezaeZQtkShgYmBs95HaouGQTCNyXhe
 SlV3YS9XnECNqqyLJUvjEL9A/Eph8uI9rCdPO6BojpBxOnUR5h0rB/00hVzNjFA6/atp
 irqifRRgQjb2fXuh3pflLMzWtu+EIQLcX4JzkvKaiGUtt9H1/wEZBHRrk9HAdL1ScGm0
 u8Rg==
X-Gm-Message-State: APjAAAU9rInf7mq9KdGbiNqNGEHW1XcDCwHCd0d0YWXvYhGFa0KvLLII
 yXE3q+1bZL9JiCc4WwEwWQIUIoKRKAE=
X-Google-Smtp-Source: APXvYqw8ISNGQ3LByAO+oPy7DfbWOfNTRO589P8iPSQRSA7vbb0x+U1e/qQn6lW7GXou30m2qK6A5g==
X-Received: by 2002:a63:4416:: with SMTP id r22mr21022359pga.254.1576534356610; 
 Mon, 16 Dec 2019 14:12:36 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/28] target/m68k: Use cpu_*_mmuidx_ra instead of
 MMU_MODE{0, 1}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:53 -1000
Message-Id: <20191216221158.29572-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generated *_user functions are unused.  The *_kernel functions
have a couple of users in op_helper.c; use *_mmuidx_ra instead,
with MMU_KERNEL_IDX.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use *_mmuidx_ra directly, without intermediate macros.
---
 target/m68k/cpu.h       |  2 --
 target/m68k/op_helper.c | 77 +++++++++++++++++++++++++----------------
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 20de3c379a..89af14e899 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -516,8 +516,6 @@ enum {
 #define cpu_list m68k_cpu_list
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index bc4f845e3f..202498deb5 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -42,8 +42,8 @@ static void cf_rte(CPUM68KState *env)
     uint32_t fmt;
 
     sp = env->aregs[7];
-    fmt = cpu_ldl_kernel(env, sp);
-    env->pc = cpu_ldl_kernel(env, sp + 4);
+    fmt = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
+    env->pc = cpu_ldl_mmuidx_ra(env, sp + 4, MMU_KERNEL_IDX, 0);
     sp |= (fmt >> 28) & 3;
     env->aregs[7] = sp + 8;
 
@@ -58,13 +58,13 @@ static void m68k_rte(CPUM68KState *env)
 
     sp = env->aregs[7];
 throwaway:
-    sr = cpu_lduw_kernel(env, sp);
+    sr = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
     sp += 2;
-    env->pc = cpu_ldl_kernel(env, sp);
+    env->pc = cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
     sp += 4;
     if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
         /*  all except 68000 */
-        fmt = cpu_lduw_kernel(env, sp);
+        fmt = cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
         sp += 2;
         switch (fmt >> 12) {
         case 0:
@@ -260,12 +260,12 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
     /* ??? This could cause MMU faults.  */
     sp &= ~3;
     sp -= 4;
-    cpu_stl_kernel(env, sp, retaddr);
+    cpu_stl_mmuidx_ra(env, sp, retaddr, MMU_KERNEL_IDX, 0);
     sp -= 4;
-    cpu_stl_kernel(env, sp, fmt);
+    cpu_stl_mmuidx_ra(env, sp, fmt, MMU_KERNEL_IDX, 0);
     env->aregs[7] = sp;
     /* Jump to vector.  */
-    env->pc = cpu_ldl_kernel(env, env->vbr + vector);
+    env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
 }
 
 static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
@@ -278,23 +278,24 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
         switch (format) {
         case 4:
             *sp -= 4;
-            cpu_stl_kernel(env, *sp, env->pc);
+            cpu_stl_mmuidx_ra(env, *sp, env->pc, MMU_KERNEL_IDX, 0);
             *sp -= 4;
-            cpu_stl_kernel(env, *sp, addr);
+            cpu_stl_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
             break;
         case 3:
         case 2:
             *sp -= 4;
-            cpu_stl_kernel(env, *sp, addr);
+            cpu_stl_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
             break;
         }
         *sp -= 2;
-        cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index << 2));
+        cpu_stw_mmuidx_ra(env, *sp, (format << 12) + (cs->exception_index << 2),
+                          MMU_KERNEL_IDX, 0);
     }
     *sp -= 4;
-    cpu_stl_kernel(env, *sp, retaddr);
+    cpu_stl_mmuidx_ra(env, *sp, retaddr, MMU_KERNEL_IDX, 0);
     *sp -= 2;
-    cpu_stw_kernel(env, *sp, sr);
+    cpu_stw_mmuidx_ra(env, *sp, sr, MMU_KERNEL_IDX, 0);
 }
 
 static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
@@ -353,36 +354,52 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
             cpu_abort(cs, "DOUBLE MMU FAULT\n");
         }
         env->mmu.fault = true;
+        /* push data 3 */
         sp -= 4;
-        cpu_stl_kernel(env, sp, 0); /* push data 3 */
+        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* push data 2 */
         sp -= 4;
-        cpu_stl_kernel(env, sp, 0); /* push data 2 */
+        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* push data 1 */
         sp -= 4;
-        cpu_stl_kernel(env, sp, 0); /* push data 1 */
+        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* write back 1 / push data 0 */
         sp -= 4;
-        cpu_stl_kernel(env, sp, 0); /* write back 1 / push data 0 */
+        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* write back 1 address */
         sp -= 4;
-        cpu_stl_kernel(env, sp, 0); /* write back 1 address */
+        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* write back 2 data */
         sp -= 4;
-        cpu_stl_kernel(env, sp, 0); /* write back 2 data */
+        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* write back 2 address */
         sp -= 4;
-        cpu_stl_kernel(env, sp, 0); /* write back 2 address */
+        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* write back 3 data */
         sp -= 4;
-        cpu_stl_kernel(env, sp, 0); /* write back 3 data */
+        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* write back 3 address */
         sp -= 4;
-        cpu_stl_kernel(env, sp, env->mmu.ar); /* write back 3 address */
+        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+        /* fault address */
         sp -= 4;
-        cpu_stl_kernel(env, sp, env->mmu.ar); /* fault address */
+        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+        /* write back 1 status */
         sp -= 2;
-        cpu_stw_kernel(env, sp, 0); /* write back 1 status */
+        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* write back 2 status */
         sp -= 2;
-        cpu_stw_kernel(env, sp, 0); /* write back 2 status */
+        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* write back 3 status */
         sp -= 2;
-        cpu_stw_kernel(env, sp, 0); /* write back 3 status */
+        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+        /* special status word */
         sp -= 2;
-        cpu_stw_kernel(env, sp, env->mmu.ssw); /* special status word */
+        cpu_stw_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
+        /* effective address */
         sp -= 4;
-        cpu_stl_kernel(env, sp, env->mmu.ar); /* effective address */
+        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+
         do_stack_frame(env, &sp, 7, oldsr, 0, retaddr);
         env->mmu.fault = false;
         if (qemu_loglevel_mask(CPU_LOG_INT)) {
@@ -414,7 +431,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
 
     env->aregs[7] = sp;
     /* Jump to vector.  */
-    env->pc = cpu_ldl_kernel(env, env->vbr + vector);
+    env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
 }
 
 static void do_interrupt_all(CPUM68KState *env, int is_hw)
-- 
2.20.1


