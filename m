Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E02DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C0E21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFbyRebU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C0E21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vr5-0005nc-EW
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkQ-0001P5-Hy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkP-0004HE-BH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:22 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:36148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkP-0004Gx-4U
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:21 -0500
Received: by mail-pg1-x530.google.com with SMTP id d9so675393pgu.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=qlFv3YRXTwQy0O+/NzrDPo73khkwZmApr8yWHMhQ1Bo=;
 b=nFbyRebUfOLNRNzRRzUVIZElB2hvVhxbf9G3CsEOQYZuobhv0UJODrazDLvrIrhnH2
 +GEqL5UuyoVTBpGzsXpEYCFaQJQrT7hwxuBA4fWnlRD4thxbBvmV6ZRX87JRCYaEKh/l
 bPvVp/L5H2qLQNKOacKEZfAHc1NK9t8JiuLtWTOGrZNSSiMiDSEhhnP6bRh2oBN6tpx9
 u/x3CW8LLZun7qHjbJSR4IV33Ua8HL3ZSMz8IIsLPt4t8VYdElyhAY40JzeMxT5YBDsO
 N6nxPaNYXcUXyrzwi9rwWe+ab4Cd5n6zLdz46dRhgygdQ3A2ElcUtGkTc90jafiOLYoU
 +8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=qlFv3YRXTwQy0O+/NzrDPo73khkwZmApr8yWHMhQ1Bo=;
 b=llEjpMc0lhQ0xiwi0k/p4OUuBs0oHzRWwFek/dVmkMvbaPRZV60+mIDeuPnxifo2mK
 mmnoKFlKV9J8leVllOZqs88IhyA8Y7Sq+H9kamoGefoiHTIB8NKjiAkbVDewW62VD0ty
 KHw+jmftGzh5ncy9JBExtIyCUfhOjoM0QnWjxzOyeAUA6MGKpkwNbJ4sloLJYs1noEcB
 +gmAtONPfng02MR8eQCJ4GAvEQxgJjAuIMXSl2JDZuqZoIuh9nojBCPRpxCcF5Ewo/zn
 OUG1tbn81CwjD9tCwqzH+WCvpH53+z9ttWFEQ8Wq9ZRUZXQ89F5av5hvQDYtjXQjY2au
 FiMQ==
X-Gm-Message-State: ANhLgQ3q+3yjKmMiEzsxlcmz1jxYK4ybziiF7hu5hB+Zx3USsBGuwzVR
 YdwsbOo5bXPoDr0k23NBtYKlWw==
X-Google-Smtp-Source: ADFU+vuat02E7wLr0Xzmldv8us6BXxDSovTdbK/XVprOfiSssOUNcwM3HZ5qRdLWz0E3xh40Sh1snQ==
X-Received: by 2002:a63:e54b:: with SMTP id z11mr1552944pgj.160.1583196560093; 
 Mon, 02 Mar 2020 16:49:20 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id f81sm18976998pfa.44.2020.03.02.16.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:19 -0800 (PST)
Subject: [PULL 14/38] target/riscv: Add virtual register swapping function
Date: Mon,  2 Mar 2020 16:48:24 -0800
Message-Id: <20200303004848.136788-15-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h        | 11 +++++++
 target/riscv/cpu_bits.h   |  7 +++++
 target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 42720d65f9..5b889a0065 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -125,6 +125,7 @@ struct CPURISCVState {
     target_ulong mstatus;
 
     target_ulong mip;
+
     uint32_t miclaim;
 
     target_ulong mie;
@@ -166,6 +167,15 @@ struct CPURISCVState {
     target_ulong mtval2;
     target_ulong mtinst;
 
+    /* HS Backup CSRs */
+    target_ulong stvec_hs;
+    target_ulong sscratch_hs;
+    target_ulong sepc_hs;
+    target_ulong scause_hs;
+    target_ulong stval_hs;
+    target_ulong satp_hs;
+    target_ulong mstatus_hs;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
@@ -296,6 +306,7 @@ void riscv_cpu_list(void);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ad6479796c..a24654d137 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -553,4 +553,11 @@
 #define SIP_STIP                           MIP_STIP
 #define SIP_SEIP                           MIP_SEIP
 
+/* MIE masks */
+#define MIE_SEIE                           (1 << IRQ_S_EXT)
+#define MIE_UEIE                           (1 << IRQ_U_EXT)
+#define MIE_STIE                           (1 << IRQ_S_TIMER)
+#define MIE_UTIE                           (1 << IRQ_U_TIMER)
+#define MIE_SSIE                           (1 << IRQ_S_SOFT)
+#define MIE_USIE                           (1 << IRQ_U_SOFT)
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e36ee7d58e..9d5a06499f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -82,6 +82,67 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
     return false;
 }
 
+void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
+{
+    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
+                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
+    bool current_virt = riscv_cpu_virt_enabled(env);
+
+    g_assert(riscv_has_ext(env, RVH));
+
+#if defined(TARGET_RISCV64)
+    mstatus_mask |= MSTATUS64_UXL;
+#endif
+
+    if (current_virt) {
+        /* Current V=1 and we are about to change to V=0 */
+        env->vsstatus = env->mstatus & mstatus_mask;
+        env->mstatus &= ~mstatus_mask;
+        env->mstatus |= env->mstatus_hs;
+
+        env->vstvec = env->stvec;
+        env->stvec = env->stvec_hs;
+
+        env->vsscratch = env->sscratch;
+        env->sscratch = env->sscratch_hs;
+
+        env->vsepc = env->sepc;
+        env->sepc = env->sepc_hs;
+
+        env->vscause = env->scause;
+        env->scause = env->scause_hs;
+
+        env->vstval = env->sbadaddr;
+        env->sbadaddr = env->stval_hs;
+
+        env->vsatp = env->satp;
+        env->satp = env->satp_hs;
+    } else {
+        /* Current V=0 and we are about to change to V=1 */
+        env->mstatus_hs = env->mstatus & mstatus_mask;
+        env->mstatus &= ~mstatus_mask;
+        env->mstatus |= env->vsstatus;
+
+        env->stvec_hs = env->stvec;
+        env->stvec = env->vstvec;
+
+        env->sscratch_hs = env->sscratch;
+        env->sscratch = env->vsscratch;
+
+        env->sepc_hs = env->sepc;
+        env->sepc = env->vsepc;
+
+        env->scause_hs = env->scause;
+        env->scause = env->vscause;
+
+        env->stval_hs = env->sbadaddr;
+        env->sbadaddr = env->vstval;
+
+        env->satp_hs = env->satp;
+        env->satp = env->vsatp;
+    }
+}
+
 bool riscv_cpu_virt_enabled(CPURISCVState *env)
 {
     if (!riscv_has_ext(env, RVH)) {
-- 
2.25.0.265.gbab2e86ba0-goog


