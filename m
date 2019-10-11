Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CFAC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED85E206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+a2RbvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED85E206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxim-0002hE-DT
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxH0-0002i9-4e
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGx-0007o9-Ok
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:09 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:38344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGx-0007nt-Ky
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:07 -0400
Received: by mail-yb1-xb43.google.com with SMTP id r68so3254204ybf.5
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ALPpYr32kDp1ytFcWYZfVKvxKTo3nP4X483s1waY7YI=;
 b=p+a2RbvWCC2j7OSyXcBZbKEeDC2pvN+BnPhCoYPrQtgn0NCDdffUgrWvuzbEJqEiHd
 Yb72S8SnCmZgzzbYiK4kP57NrgTzhjpPGLV2Ln380+0y7TTZMAueyUf2mhXWHHe4FyDZ
 F7CYVhN1gIqOTSzxJ/d2xv9Cs7IjczZ8gjgoKx7fqZgwBEV/LQX2XOarbJDJdHLIFjDT
 20GTr+4Xx3fhvfEJdaqfMjaF6v48e/o8UEfLhfNdLKEHxOOTJOtYCTJkkr8x/OuUrDj+
 GQ4ntR+1XxXBC33tiL/a3nR6iAFPP4T/hKELuoRDCoxri50WXZh4H+q5E8V9FfSx5+md
 pGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ALPpYr32kDp1ytFcWYZfVKvxKTo3nP4X483s1waY7YI=;
 b=ayZLGiGOYIzMpHz/KyHxNo5rMc+TI43UxAEbwDire3C/WbB+OeTEiWk8QuOx89Msh/
 JO1+gbLPHan+Afbyy/G1SGpZnT3EbCBJFE/TJvnhM5XMfOlCV6VLYf3nBQMc7JCwAd3x
 tg4TaIt+bT8dvQsPtv/xx3c48aLdqmPzjEdfYPXek2WkDVqTwxpMAz0W/SrEiKsXp4jJ
 QycJtYT/ydwm6z1i0857WEfpnw4N4dD01PaFZxX9QCmpyP0hZ176CXruY80P5HYAbyoG
 VYhN0c8IXmMVrEqU7JgsHMortPJFt9gSiioRkXuW6/wnnbABmAZbj7d9efi33kQ6pm17
 6G6A==
X-Gm-Message-State: APjAAAW6UTJPrHCTtr41sOo4m17ucrSUOiCFOR+aW5t50hYis4UbBJJi
 d4XWG21XmDE70UGIHNhxutbKGvdGu0A=
X-Google-Smtp-Source: APXvYqydZyBrjNlur0gaOLTd816jkFLvrJnhh3eEW14gVrtLmPmy1CGqP65Oza1YeisZ1+mrYupkGQ==
X-Received: by 2002:a25:d4a:: with SMTP id 71mr10604797ybn.311.1570809366729; 
 Fri, 11 Oct 2019 08:56:06 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 16/20] target/arm: Rebuild hflags at EL changes
Date: Fri, 11 Oct 2019 11:55:42 -0400
Message-Id: <20191011155546.14342-17-richard.henderson@linaro.org>
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

Begin setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c    | 1 +
 target/arm/cpu.c        | 1 +
 target/arm/helper-a64.c | 3 +++
 target/arm/helper.c     | 2 ++
 target/arm/machine.c    | 1 +
 target/arm/op_helper.c  | 1 +
 6 files changed, 9 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e2af3c1494..ebefd05140 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9982,6 +9982,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     aarch64_sve_narrow_vq(env, vq);
                 }
                 env->vfp.zcr_el[1] = vq - 1;
+                arm_rebuild_hflags(env);
                 ret = vq * 16;
             }
             return ret;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c14471..d043e75166 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -406,6 +406,7 @@ static void arm_cpu_reset(CPUState *s)
 
     hw_breakpoint_update_all(cpu);
     hw_watchpoint_update_all(cpu);
+    arm_rebuild_hflags(env);
 }
 
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index bca80bdc38..b4cd680fc4 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1025,6 +1025,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         } else {
             env->regs[15] = new_pc & ~0x3;
         }
+        helper_rebuild_hflags_a32(env, new_el);
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
                       cur_el, new_el, env->regs[15]);
@@ -1036,10 +1037,12 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         }
         aarch64_restore_sp(env, new_el);
         env->pc = new_pc;
+        helper_rebuild_hflags_a64(env, new_el);
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch64 EL%d PC 0x%" PRIx64 "\n",
                       cur_el, new_el, env->pc);
     }
+
     /*
      * Note that cur_el can never be 0.  If new_el is 0, then
      * el0_a64 is return_to_aa64, else el0_a64 is ignored.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b2d701cf00..aae7b62458 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7998,6 +7998,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->regs[14] = env->regs[15] + offset;
     }
     env->regs[15] = newpc;
+    arm_rebuild_hflags(env);
 }
 
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
@@ -8345,6 +8346,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
     aarch64_restore_sp(env, new_el);
+    helper_rebuild_hflags_a64(env, new_el);
 
     env->pc = addr;
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 5c36707a7c..eb28b2381b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -756,6 +756,7 @@ static int cpu_post_load(void *opaque, int version_id)
     if (!kvm_enabled()) {
         pmu_op_finish(&cpu->env);
     }
+    arm_rebuild_hflags(&cpu->env);
 
     return 0;
 }
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 0fd4bd0238..ccc2cecb46 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -404,6 +404,7 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
      * state. Do the masking now.
      */
     env->regs[15] &= (env->thumb ? ~1 : ~3);
+    arm_rebuild_hflags(env);
 
     qemu_mutex_lock_iothread();
     arm_call_el_change_hook(env_archcpu(env));
-- 
2.17.1


