Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C28C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C715D22247
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrqgHKnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C715D22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSvGR-00081Z-Rk
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 00:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSvFQ-0006jm-IG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:52:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSvFO-0003PK-Px
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:52:16 -0400
Received: by mail-pf1-x441.google.com with SMTP id e7so1221542pfn.12
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 21:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1LCwDo1eVMbYFulmkO+AZzovxuJTVRnkzThWv1cuvF4=;
 b=LrqgHKnAnqWsHG1ZZjrjSydj+SxI9hI3jPEkbFl24t7FOOFlPGNXRx1s6kNdUGjmM6
 AWvavUFZ6K3uQjdJI9yjCAvGQqCA+6XQiukq4wMezLEzR5adzUbQxHF4BTvjpFHyUfXD
 0vBAlA7Vy8N+aIEBaeXstObJuR29gDtc17+LMajJubblFdjLMMUV5+KFljQF6tQhCCHr
 t/CnvOByMnsGZyHOL0f4n/N7bV8AXADLvbXVC1SSFlHf2l3Doju1HUOKcPTLEY5r+hAE
 qY6xU8B7sqelp3zMG/3E2Xqmk4aPQUsYs8U+g5ZbkFWfgfQp4BvsMhLJN4NMXTGYlGE0
 4K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1LCwDo1eVMbYFulmkO+AZzovxuJTVRnkzThWv1cuvF4=;
 b=XQdRBtHLRxEL1/GeIMK2EB4rKE/NxRyXQG/cXnNzcmR5G/TCI+asMfuiPJ3CBLG79T
 82EeTy/89mtsK01YnIhgmsP30ZA+Ype8ckKIuJTqnAOXojMlb/CStXLcYdv+0O5dpknM
 ukjq/V7lxccudYv7CnNHkZoBmVz/dNTLxR/FmkHQ8zIaQ6PrQ8lB0WKBP51jSRucVVxm
 +bwZaGkrRDYbvDc33FPdcNkgee+/HOSM1z7O6+44OAjPCxXdoGHT/YaBZqREcsAcZm1L
 F9vs8C1Xc4HJrQnOXyzHJ1Sg89IQPHiY3Bh4yEgfohp147xae//Uc+/EkgaUZNzDzome
 wElw==
X-Gm-Message-State: AOAM531vLqT65eHZuza/7zBx5Jw3sOogG3f5dxc9gGi2VEbXvG7i4OAF
 yukDnyZyE7W5im6pzr3Tt6NuSh0G5PwidQ==
X-Google-Smtp-Source: ABdhPJy6E+5W64+fnQTkUv0NcYMYWaQQsdZWGHeDks11CctYJk/nObvJqeryytOZuQaCczcQNCLXVw==
X-Received: by 2002:a63:4e4f:: with SMTP id o15mr1882600pgl.202.1602737532965; 
 Wed, 14 Oct 2020 21:52:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q66sm1407493pfc.109.2020.10.14.21.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 21:52:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] linux-user/microblaze: Implement rt signal frames
Date: Wed, 14 Oct 2020 21:52:07 -0700
Message-Id: <20201015045208.595044-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015045208.595044-1-richard.henderson@linaro.org>
References: <20201015045208.595044-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allows microblaze to pass tests/tcg/multiarch/linux-test.c.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/signal.c | 91 ++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 9 deletions(-)

diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index b4eeef4673..3d316a22f1 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -35,9 +35,9 @@ struct target_stack_t {
 struct target_ucontext {
     abi_ulong tuc_flags;
     abi_ulong tuc_link;
-    struct target_stack_t tuc_stack;
+    target_stack_t tuc_stack;
     struct target_sigcontext tuc_mcontext;
-    uint32_t tuc_extramask[TARGET_NSIG_WORDS - 1];
+    target_sigset_t tuc_sigmask;
 };
 
 /* Signal frames. */
@@ -47,9 +47,9 @@ struct target_signal_frame {
     uint32_t tramp[2];
 };
 
-struct rt_signal_frame {
-    siginfo_t info;
-    ucontext_t uc;
+struct target_rt_sigframe {
+    target_siginfo_t info;
+    struct target_ucontext uc;
     uint32_t tramp[2];
 };
 
@@ -200,7 +200,55 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPUMBState *env)
 {
-    qemu_log_mask(LOG_UNIMP, "setup_rt_frame: not implemented\n");
+    struct target_rt_sigframe *frame;
+    abi_ulong frame_addr;
+
+    frame_addr = get_sigframe(ka, env, sizeof *frame);
+    trace_user_setup_rt_frame(env, frame_addr);
+
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        force_sigsegv(sig);
+        return;
+    }
+
+    tswap_siginfo(&frame->info, info);
+
+    __put_user(0, &frame->uc.tuc_flags);
+    __put_user(0, &frame->uc.tuc_link);
+
+    target_save_altstack(&frame->uc.tuc_stack, env);
+    setup_sigcontext(&frame->uc.tuc_mcontext, env);
+
+    for (int i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
+    }
+
+    /* Kernel does not use SA_RESTORER. */
+
+    /* addi r12, r0, __NR_sigreturn */
+    __put_user(0x31800000U | TARGET_NR_rt_sigreturn, frame->tramp + 0);
+    /* brki r14, 0x8 */
+    __put_user(0xb9cc0008U, frame->tramp + 1);
+
+    /*
+     * Return from sighandler will jump to the tramp.
+     * Negative 8 offset because return is rtsd r15, 8
+     */
+    env->regs[15] =
+        frame_addr + offsetof(struct target_rt_sigframe, tramp) - 8;
+
+    /* Set up registers for signal handler */
+    env->regs[1] = frame_addr;
+
+    /* Signal handler args: */
+    env->regs[5] = sig;
+    env->regs[6] = frame_addr + offsetof(struct target_rt_sigframe, info);
+    env->regs[7] = frame_addr + offsetof(struct target_rt_sigframe, uc);
+
+    /* Offset to handle microblaze rtid r14, 0 */
+    env->pc = (unsigned long)ka->_sa_handler;
+
+    unlock_user_struct(frame, frame_addr, 1);
 }
 
 long do_sigreturn(CPUMBState *env)
@@ -239,7 +287,32 @@ badframe:
 
 long do_rt_sigreturn(CPUMBState *env)
 {
-    trace_user_do_rt_sigreturn(env, 0);
-    qemu_log_mask(LOG_UNIMP, "do_rt_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
+    struct target_rt_sigframe *frame = NULL;
+    abi_ulong frame_addr = env->regs[1];
+    sigset_t set;
+
+    trace_user_do_rt_sigreturn(env, frame_addr);
+
+    if  (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
+    set_sigmask(&set);
+
+    restore_sigcontext(&frame->uc.tuc_mcontext, env);
+
+    if (do_sigaltstack(frame_addr +
+                       offsetof(struct target_rt_sigframe, uc.tuc_stack),
+                       0, get_sp_from_cpustate(env)) == -EFAULT) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+ badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
 }
-- 
2.25.1


