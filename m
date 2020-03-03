Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9AD24677
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQj8IFd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9AD24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vp8-0002L8-JA
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkF-00012E-Rl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkE-0004A2-Mm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:11 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:35909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkE-00049M-Fy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:10 -0500
Received: by mail-pj1-x102e.google.com with SMTP id d7so546563pjw.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=ANkDW0pV9KWX3pfShIfpn+QJJdRLLaIrASHy4mCGa4o=;
 b=NQj8IFd9g2uBiB4uWXv4HjYv67DmVCkTfCQjvhPodfwT+H0rNKeLOJEQs7ZPMhb9rm
 AVL1fKgVUMIPR+tqdbF7yJg3m/uTXB3jeulPinJrtvChX0lzeGitssq8EKGsKhM073xy
 IUuPw2gCegKQH82IZ/cU8tyF04RqBUj7th/3z6PAfMxMQz3G41kv/z0ECwpG3jdoH7Ru
 nLBUfd1I0LG9UqKfo/Wve4E/bUY7l1weVgOSXeT2m0/IM1Qf1kqSmTREWQXkro6V00XU
 uJjAxCctUCokwi1NQu9BK/XmtFxNRD1OdbiQ30ES4dCjOTS3UMas+Uw1VfrTqiPzOFVu
 dLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ANkDW0pV9KWX3pfShIfpn+QJJdRLLaIrASHy4mCGa4o=;
 b=g1peTuE42CK/qcdpwgbK2ecduY73PZOBcFSubdpXi4SR44MRkFFZw9SpxOTfWQzkjP
 sHIlQ5YQoKSjt2oye/tXBUqtRyKGj6rQoKF/uQNgA0/qxfd8HFsnvOSYcoiXVegiX8zC
 IMQ7hYaO0XqN+IkWFZFvDIcE9GYToIM04z+5DluJ/wpsf1ps8tk6JlNSl6QLCjvniIrF
 p9w9PM/3hLZ60gyxR6BcY+3wAM2jQSqQ6OkOuIl5Fo9y7Oy3NM3w/ZwUehG5HKhm1ZUe
 0AcFYPPvusLFBjxI904vFHEfZbpBsKk++FSf8Po0RNSCDewCHh+Hv/6OdGrkago1lhTM
 VMUA==
X-Gm-Message-State: ANhLgQ1gZ/k8GbujvOMt1RfwqisVZ3zUYJjGEaBj+ACim0DUf6U/7kxG
 sakBM186NKzQdAIe2XGkERxqzOeuX9GbNQ==
X-Google-Smtp-Source: ADFU+vsUM+d5+NDMvZshjdSzDL+34bBRrCajz6HLvUUwrbef0Je+/Cp93XE7Rkcb1i6FhjJ+bzv2Yw==
X-Received: by 2002:a17:90b:438b:: with SMTP id
 in11mr1247550pjb.84.1583196549275; 
 Mon, 02 Mar 2020 16:49:09 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id y23sm22450558pfn.101.2020.03.02.16.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:08 -0800 (PST)
Subject: [PULL 07/38] target/riscv: Add the force HS exception mode
Date: Mon,  2 Mar 2020 16:48:17 -0800
Message-Id: <20200303004848.136788-8-palmerdabbelt@google.com>
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
X-Received-From: 2607:f8b0:4864:20::102e
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

Add a FORCE_HS_EXCEP mode to the RISC-V virtulisation status. This bit
specifies if an exeption should be taken to HS mode no matter the
current delegation status. This is used when an exeption must be taken
to HS mode, such as when handling interrupts.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a9cbd8584e..42720d65f9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -273,6 +273,8 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 2cdb0de4fe..ad6479796c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -432,6 +432,12 @@
 
 /* Virtulisation Register Fields */
 #define VIRT_ONOFF          1
+/* This is used to save state for when we take an exception. If this is set
+ * that means that we want to force a HS level exception (no matter what the
+ * delegation is set to). This will occur for things such as a second level
+ * page table fault.
+ */
+#define FORCE_HS_EXCEP      2
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e5311160e7..e36ee7d58e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -100,6 +100,24 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, VIRT_ONOFF, enable);
 }
 
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, FORCE_HS_EXCEP);
+}
+
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, FORCE_HS_EXCEP, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.25.0.265.gbab2e86ba0-goog


