Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD8CC0650F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57542147A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbzBdBjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57542147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1humzG-0005hO-Rw
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33664)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1humyZ-0003xE-IT
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1humyX-0008Ff-Vr
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1humyX-0008F1-Q2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id c3so17316230pfa.13
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SmJ5Hdt1lX0FZop+Dbb79p/hOPSk025oMFCmVoyvZFY=;
 b=BbzBdBjO4n7vzM3PZK0IUtakO9usQ8aWxkJOng54QjZaoyKvGUxqLNz2I3WV9UmbjI
 hpyXFOWOd/vQ0bVh8UndVF8I3SIEvsDEPzPKfwjVJfA1DHVemQj4IFGlQj14cGSytR25
 VLFHE3QHCWbU1QOBMSuLkvQlBQ8GY3WGRKwkCv6LqHyEhh+OVOFkJBspyfRtRVzrbopB
 PeOqPc4SMbO7KvIZk8DqkjqEsMsGjyHRqp/x48pS8ojuicgztFRDdvCyLQbFC8kXOLR+
 hbIglURis2KyhoAxgiiPVxefhxymNsTa2pqgRcJwwwEseqRFbVteXMIHvSpJt/jQRolL
 nn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SmJ5Hdt1lX0FZop+Dbb79p/hOPSk025oMFCmVoyvZFY=;
 b=c1Kmg1CE2Y1Dz/IIOlgEhWwodlhW3w6iGvnoh6k5/mIfjz+c7+L2Yg/XPT81gjtFq9
 QrqQCPcTkuESgTZkrjyIoLB3HlkOdyMduH4dbuNPR1BvhRKW7zBHSnDiR7dYJ69ixL+R
 jHTk7Wd1AnHVoz2T/qkRKxnfoxutKnz4rw7cLKbxI9Lqt+X+TNhEod8O07s0RBX21o4t
 n59A5UMMyqDrKwOoewpOMZZ9parFNjs2GQVxqxSsV7scQA5DFNCnftZL8UsZJPwYMz4k
 9XryFjgd3hF28S4WGjUZP21HSViRwSofI/17n4JOWHuwDv/PR3oo3uRkOFOUkaqBiImB
 +TfQ==
X-Gm-Message-State: APjAAAWe4jLWC9yQ+dZXJrqk7f6IxsEEovqX2UKCttuS1l+hbFfbkN+a
 TNO0KLWW3o7CkGQN1va86OFoyFLMo9o=
X-Google-Smtp-Source: APXvYqw3hvjeLgjRdlC7P2nKL9VqLHj/NEdUdsI60uOL4jacRlm6kL8Qam43wBgXLnd6zts1ybEgrw==
X-Received: by 2002:a17:90a:21ac:: with SMTP id
 q41mr295306pjc.31.1565049912549; 
 Mon, 05 Aug 2019 17:05:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i3sm92149782pfo.138.2019.08.05.17.05.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 17:05:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:05:05 -0700
Message-Id: <20190806000506.10833-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806000506.10833-1-richard.henderson@linaro.org>
References: <20190806000506.10833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 2/3] target/arm: Rebuild hflags at EL
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fixed partial conversion to assignment to env->hflags.
---
 linux-user/syscall.c       |  1 +
 target/arm/cpu.c           |  1 +
 target/arm/helper-a64.c    |  3 +++
 target/arm/helper.c        |  2 ++
 target/arm/machine.c       |  1 +
 target/arm/op_helper.c     |  1 +
 target/arm/translate-a64.c |  6 +++++-
 target/arm/translate.c     | 14 ++++++++++++--
 8 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8367cb138d..55d5fdadf3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9979,6 +9979,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     aarch64_sve_narrow_vq(env, vq);
                 }
                 env->vfp.zcr_el[1] = vq - 1;
+                arm_rebuild_hflags(env);
                 ret = vq * 16;
             }
             return ret;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ec2ab95dbe..995f4ea355 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -406,6 +406,7 @@ static void arm_cpu_reset(CPUState *s)
 
     hw_breakpoint_update_all(cpu);
     hw_watchpoint_update_all(cpu);
+    arm_rebuild_hflags(env);
 }
 
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 060699b901..3bc364ebb7 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1025,6 +1025,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         } else {
             env->regs[15] = new_pc & ~0x3;
         }
+        env->hflags = rebuild_hflags_a32(env, new_el);
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
                       cur_el, new_el, env->regs[15]);
@@ -1036,10 +1037,12 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         }
         aarch64_restore_sp(env, new_el);
         env->pc = new_pc;
+        env->hflags = rebuild_hflags_a64(env, new_el);
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch64 EL%d PC 0x%" PRIx64 "\n",
                       cur_el, new_el, env->pc);
     }
+
     /*
      * Note that cur_el can never be 0.  If new_el is 0, then
      * el0_a64 is return_to_aa64, else el0_a64 is ignored.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 43b7c41f11..9b07350cfe 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7905,6 +7905,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->regs[14] = env->regs[15] + offset;
     }
     env->regs[15] = newpc;
+    env->hflags = rebuild_hflags_a32(env, arm_current_el(env));
 }
 
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
@@ -8251,6 +8252,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
+    env->hflags = rebuild_hflags_a64(env, new_el);
     aarch64_restore_sp(env, new_el);
 
     env->pc = addr;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 3fd319a309..838d154a3c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -758,6 +758,7 @@ static int cpu_post_load(void *opaque, int version_id)
     if (!kvm_enabled()) {
         pmu_op_finish(&cpu->env);
     }
+    arm_rebuild_hflags(&cpu->env);
 
     return 0;
 }
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 5e1625a1c8..6e6613b8a8 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -420,6 +420,7 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
      */
     env->regs[15] &= (env->thumb ? ~1 : ~3);
 
+    env->hflags = rebuild_hflags_a32(env, arm_current_el(env));
     qemu_mutex_lock_iothread();
     arm_call_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d3231477a2..f8b5debf82 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1799,11 +1799,15 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
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
index 7853462b21..cd14bbebf1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7164,6 +7164,8 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
     ri = get_arm_cp_reginfo(s->cp_regs,
             ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
     if (ri) {
+        bool need_exit_tb;
+
         /* Check access permissions */
         if (!cp_access_ok(s->current_el, ri, isread)) {
             return 1;
@@ -7336,15 +7338,23 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
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
+            gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+            tcg_temp_free_i32(tcg_el);
+            need_exit_tb = true;
+        }
+        if (need_exit_tb) {
             gen_lookup_tb(s);
         }
 
-- 
2.17.1


