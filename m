Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22283CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C0820679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSLUh47a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C0820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgXt-0006Xl-Eo
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxo-0007Qn-Dz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxn-0000oc-2O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxm-0000oH-Sd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id c22so3225427wmd.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IVPjk80/vMxw/zuAjIrvBHIged7KPUhTphMMQkeon5g=;
 b=CSLUh47aZB0XE4LqNXyIeDwTL4Hfmnhxd8FZBdvPQT/6fTZQx02xLEOxV9ImVW8UfX
 Rrtzh+GaZXD7YPyHaqcqyTb0PwHR/txhM4dVHucBW8E/Lzlc7sv4f+XyxrabouE89EKM
 8x5uBX9UUCXiUWGNwGCuwMlvZHSXjvDD6Q25Ycji+inr6E/pviyaD+TibcTFEeiz4Yhj
 cQuhxVrYe6ppq926dS2dCZJgxoofYMYtLxzryvcDX9/BLTJQrTm4/iOVc5mV4RJjD/Ef
 kIHrGqZ0z4qJkhtDvupo3zs4YYcCRWyInefaeN2pJsR2jy4xi2m+u8Rq2YNNaVlMNTWX
 /OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IVPjk80/vMxw/zuAjIrvBHIged7KPUhTphMMQkeon5g=;
 b=ci3l2Hl6qhzVvHn5pkhfBMaVvxB5b3FTGF1JvtHqfkmEYmNAB80o3OYd+OY5TaCnIg
 C12Oyvm/wexUq+IhLYCsErdUxh1H4tWyp3wbTm7vjbiQRCSt+FaigGJzSrZdk0WjNZmJ
 eZuZPHc6WawHiiv1+Fm383qeS+FfsQ8YjDqt/Folg6yOD3Ng+b245NL2jFpQid12vVQS
 CIHuRaYSYvKBW61ypqb5g6wazDUU3aJLrBYTXwrX/TPJo/s4umU21IzhpKoz9xjyzw83
 y1AzfQBlOGTIntEIViZTkWvTSJE5UjEvO3+/OJSbsDpOBwq+k6HBLrEXmyyrLkr482aR
 6SjQ==
X-Gm-Message-State: APjAAAXRH6/7oUYEzy9ajxXrARePt+/Opd3S5+DDDDWBPXG8MdFymRI4
 zBR3wQnpDdSAfO8cX+Y3644ncR81/FQ=
X-Google-Smtp-Source: APXvYqxZRw2F1vc3iUEiNRNqOP/TTYD3FI/0RO6OZAXhSnbKQ1UAgSVXZg9/ewE5bQvyIh9VBOGjmQ==
X-Received: by 2002:a7b:cf36:: with SMTP id m22mr5421716wmg.98.1571934469681; 
 Thu, 24 Oct 2019 09:27:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/51] target/arm: Rebuild hflags at EL changes
Date: Thu, 24 Oct 2019 17:26:51 +0100
Message-Id: <20191024162724.31675-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

Begin setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c    | 1 +
 target/arm/cpu.c        | 1 +
 target/arm/helper-a64.c | 3 +++
 target/arm/helper.c     | 2 ++
 target/arm/machine.c    | 1 +
 target/arm/op_helper.c  | 1 +
 6 files changed, 9 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f1ab81b9177..530c8433036 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9984,6 +9984,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     aarch64_sve_narrow_vq(env, vq);
                 }
                 env->vfp.zcr_el[1] = vq - 1;
+                arm_rebuild_hflags(env);
                 ret = vq * 16;
             }
             return ret;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 13813fb2135..ab3e1a03616 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -406,6 +406,7 @@ static void arm_cpu_reset(CPUState *s)
 
     hw_breakpoint_update_all(cpu);
     hw_watchpoint_update_all(cpu);
+    arm_rebuild_hflags(env);
 }
 
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index bca80bdc38b..b4cd680fc48 100644
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
index b2d701cf004..aae7b62458f 100644
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
index 5c36707a7c9..eb28b2381bb 100644
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
index 0fd4bd02385..ccc2cecb467 100644
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
2.20.1


