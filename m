Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF4CC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9783922DD3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snn9cfGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9783922DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Bbw-0005tP-Dl
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM3-0000Ni-Ck
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM1-0000E1-Ln
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BM1-0000Cl-ET
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so5404pgb.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ImRJTwPFmMGzpCtfWM5MPA1kMhadsmFmyH6aw6AENWA=;
 b=snn9cfGjRBuC3kSQDv3NO4N+6ERHZjm22fqYbFRSjNBITKJbt53y3Ue8gstQKJIzNi
 oeFZuPeqmWCs6RGFs4cOYAli3EWZU1jjw0Y8wsYvNbdjwtienxJ9FJ77tZkeA+ezyZTN
 R8iI7S79EQxJTEMUfeFtbOCMqvMIViT4as3YHH8SEtjMwsF1qiJj7OWnMb+v+va6GgeV
 RdbWkopcpdG8+0VbnI71gqEY8Bi6MFrMgmPDCF7/w5gMkSwEIjGbC5yvOvB2Ro/uXtWe
 tdDTDY4YWMuT/okcto3j1JAMW8aMjY5VqaNm6acjeo2ozhEXLCsgIzf7THC9HwY/7AHb
 HXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ImRJTwPFmMGzpCtfWM5MPA1kMhadsmFmyH6aw6AENWA=;
 b=AkIGAdGFXOFiFutJKIsu2PO9PAiRT4LVw24LHnfl120QOw+hlGeERjuLayHWUIXXU4
 SiFyjdyG9rTuRMUEE2a9vAH3FNIAImeCvb5GUhKF4QJ2J2jLVbCqE+WgkwtV7lBhtPMX
 shn5DF0nZr3leItERTA66W855e0N1/wDteMqslLfmE5/RciR8VOzSUlty/2gWOX/9m3g
 /FieA7k1EG4mx/w9bUyoXMO8M9lBJQlTKW1APGz2wiJgOzEorP0Tlq9JQ3fllX7UlxjT
 3XHqFU+biQiPa4mkh/DZcTyUlEDbiufLq2SSsp9OfaIVqq0t3PYZOBsOYLdZDxWIbzUr
 uDIA==
X-Gm-Message-State: APjAAAWVkOo6QLsPy0C5zDcOoBY/nL2Fb4fjAfXRkUlhi/ExFZSexq7P
 f0bs7o/aapwVZR7wy8lTMvQB6xgEZoI=
X-Google-Smtp-Source: APXvYqzzQEKjDMtQpTeml2mtDrf3NHMaJbYBDDeIZgW2Vo6wqFb4h4MKavwgxXqjLGFJcNczC2CRBw==
X-Received: by 2002:a62:1808:: with SMTP id 8mr32241561pfy.177.1566335264072; 
 Tue, 20 Aug 2019 14:07:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:19 -0700
Message-Id: <20190820210720.18976-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 16/17] target/arm: Rebuild hflags at EL
 changes and MSR writes
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

Now setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c       |  1 +
 target/arm/cpu.c           |  1 +
 target/arm/helper-a64.c    |  3 +++
 target/arm/helper.c        |  2 ++
 target/arm/machine.c       |  1 +
 target/arm/op_helper.c     |  1 +
 target/arm/translate-a64.c |  6 +++++-
 target/arm/translate.c     | 18 ++++++++++++++++--
 8 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8b41a03901..be01c33759 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9980,6 +9980,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
index 53a7bd796b..d1bf71a260 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7908,6 +7908,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->regs[14] = env->regs[15] + offset;
     }
     env->regs[15] = newpc;
+    arm_rebuild_hflags(env);
 }
 
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
@@ -8255,6 +8256,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fc3e5f5c38..4412c60383 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1777,11 +1777,15 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         /* I/O operations must end the TB here (whether read or write) */
         gen_io_end();
         s->base.is_jmp = DISAS_UPDATE;
-    } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
+    }
+    if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
+        TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
+        gen_helper_rebuild_hflags_a64(cpu_env, tcg_el);
+        tcg_temp_free_i32(tcg_el);
         s->base.is_jmp = DISAS_UPDATE;
     }
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d948757131..2f7beca065 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7130,6 +7130,8 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
     ri = get_arm_cp_reginfo(s->cp_regs,
             ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
     if (ri) {
+        bool need_exit_tb;
+
         /* Check access permissions */
         if (!cp_access_ok(s->current_el, ri, isread)) {
             return 1;
@@ -7301,15 +7303,27 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
         }
 
+        need_exit_tb = false;
         if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or write) */
             gen_io_end();
-            gen_lookup_tb(s);
-        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
+            need_exit_tb = true;
+        }
+        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
             /* We default to ending the TB on a coprocessor register write,
              * but allow this to be suppressed by the register definition
              * (usually only necessary to work around guest bugs).
              */
+            TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
+            if (arm_dc_feature(s, ARM_FEATURE_M)) {
+                gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
+            } else {
+                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+            }
+            tcg_temp_free_i32(tcg_el);
+            need_exit_tb = true;
+        }
+        if (need_exit_tb) {
             gen_lookup_tb(s);
         }
 
-- 
2.17.1


