Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F93C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6690420848
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0ve0wyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6690420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2aa-0004SV-6C
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JI-0005Fm-Vw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JH-0003zp-Ap
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:08 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:43158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2JH-0003yp-3J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:07 -0500
Received: by mail-pl1-x62e.google.com with SMTP id p27so536471pli.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W3QOqVQcKxICfZINGRR4Q5RpPfv/b9Q6JOcMtLEYvg8=;
 b=o0ve0wywOlN2ERZ3vmg31g7DtnywCk6pts9m/npu6li7XQyFCsx6p9IqC0NJxliPS4
 bycMD/KLjfVj7TZBoTL5YnjWk1Q6aVKSjWcsvkfe5Gn7wS242fiaHtaECPesEeiSEICV
 Wy9gfdeW6EG6RsYoGYLtv26xLWtBj7xRK3cgxpWjSl0uxz1SOyOmtoCQuRg7PXvIOGrR
 1731eyJzzNz+sFpvcHCI4uLAgtFX4xYuMlRM+MvlvJUb2Bl6e8k9UeSlPXbt0w2o1PW0
 3kmQoO9odXIiU+vCZ8FKa7cSSK2k7H592B8xSzhrK6h3IvG+TS1KMaibNy1szufF5Sfm
 BZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W3QOqVQcKxICfZINGRR4Q5RpPfv/b9Q6JOcMtLEYvg8=;
 b=dPg3zNix1As2K1yVOAAun/rnr0kvPLNz6ywY4PgdcU/MdJ14HBk5wfbrymSHrGnXS9
 oAaBwSgtKt8hfuE44nnu8jVw0WNZTecxd2Nkc7KQJ6XkLBnCBfz/QnBuctq+HIlQ5K6H
 UZYjuus+Bbg+UUxkWF0+6w1Zpn20SMN5X6QfWqZbFtnA3CrLC+NzPL1DaerKoc1c7G03
 2goG+W11hKMdHf0ig7pWvC68xTPk6LhpHe93rdXYRma3UayhReM0cruLJ7DPAjn/bIcq
 o94BHqVbsvZSi+e1s3TgSwNxp3aUxJU3TfpL8wD6rc/Ckvm0bBiipYhxVwM9vsgDoFUi
 +hoA==
X-Gm-Message-State: APjAAAUqYMZM5lcWSnbY0hidfOyYmmKhed1QmonPWeyGzEy+gIMTUarM
 lV8x/uD0CeIyUMEC+DrsUjOB6QCTJKNTGg==
X-Google-Smtp-Source: APXvYqyd/brezsHSTc4OOpL5u5URgyawG7tIWNGakBUZRsM29RLZKKhBdSZB2z2MP3AAr5yU07mcmA==
X-Received: by 2002:a17:90a:3945:: with SMTP id
 n5mr2125150pjf.34.1578455225780; 
 Tue, 07 Jan 2020 19:47:05 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/41] target/m68k: Use cpu_*_mmuidx_ra instead of MMU_MODE{0,
 1}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:13 +1100
Message-Id: <20200108034523.17349-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62e
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generated *_user functions are unused.  The *_kernel functions
have a couple of users in op_helper.c; use *_mmuidx_ra instead,
with MMU_KERNEL_IDX.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use *_mmuidx_ra directly, without intermediate macros.
---
 target/m68k/cpu.h       |  2 --
 target/m68k/op_helper.c | 77 +++++++++++++++++++++++++----------------
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 11c71fa962..3de8e06dfe 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -519,8 +519,6 @@ enum {
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


