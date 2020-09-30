Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9582C4741F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AF42071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYyqtCqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AF42071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjAo-0004U9-2D
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj07-0003SY-E6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizw-0006Tm-L0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id d4so813167wmd.5
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T30PQRbG5c+x4h/vprfOn4o+/kj2pbFw+SxHgbkuaBk=;
 b=tYyqtCqAF3zlRXsO+icQIHQp0PNaCDopsEMC7e9GOo9NqkGfujKa2tp8e2/TwaUFaE
 QNKVJQ14IaJWrWNR/xEhF2JtIcwidUSUDH+Jws4R7fTik/s0j+MJQHUtq28m51WMUpFp
 VPYwRPrMk3FvpGereqMuSmkCeL8hHpN9jrM5D8XrnbaO3l0ocIgKAvahc3/MtqbsjzJl
 s2jKxwgmquxE5wSoih05tR4evB4aq9KeL/Zjg/uBFzvSEPhOzWb5tjaTBuJ1xtbo26df
 KKjl915oLL/XRSgsWx+AKVShm5rLeI5R83y/7zsGIyw9GjullzFUMs3Nc0OWXLKF9/k6
 ZqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T30PQRbG5c+x4h/vprfOn4o+/kj2pbFw+SxHgbkuaBk=;
 b=UVFK0UlBpTUHmQwlNQ9RBUN5JRXskqI1sQ5Kj5j8nmC/Yyu3Ru0goDwCfgcBjAWw19
 RQPZ/Vce6kXAsjW7DYyZiWO32aVZU+LqH9DibaALMbJlgI0YUyp/tPqNVmvBgvXJO+Gs
 NQmUrU55+MtlnfWsEHd5+ruj01GXg8vKsPJKvEpOzCmmfCJe+W/UWuFILq0bWRnweRJ4
 El1Gq7bm+nq3TTD0UQjtxnJBPwOHORRwvDMQmLDwV2Jg+xmN68vn06woKW5sAy8aE2eX
 oQ6bM4zmu98tBVQDJU8TGmNdCBwEY4Uojd0G1YnKyKHZwQYKPfz5RtLKsuIBXvgtAjRO
 LK6A==
X-Gm-Message-State: AOAM533oDpJZWa9/J6UXHuFdva8/RixaDADimWwf4LAaeU4AgmP7Gv9q
 qD/QfzKf1LLdSZKGH2Ln0zbMTKDDGDCfDQ==
X-Google-Smtp-Source: ABdhPJxk9h2uRVp8Y6gS9xOLPSi83JqGh54EG8EWTOrM0OFtG67XpvR1shAFFhFdkgCGevQ140RmCQ==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr4628993wmf.47.1601498804899;
 Wed, 30 Sep 2020 13:46:44 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:44 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 08/14] arc: Add IRQ and timer subsystem support
Date: Wed, 30 Sep 2020 21:45:58 +0100
Message-Id: <20200930204604.20663-9-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudiu Zissulescu <claziss@synopsys.com>

Signed-off-by: Claudiu Zissulescu <claziss@synopsys.com>
---
 target/arc/irq.c   | 658 +++++++++++++++++++++++++++++++++++++++++++++
 target/arc/irq.h   |  37 +++
 target/arc/timer.c | 456 +++++++++++++++++++++++++++++++
 target/arc/timer.h |  32 +++
 4 files changed, 1183 insertions(+)
 create mode 100644 target/arc/irq.c
 create mode 100644 target/arc/irq.h
 create mode 100644 target/arc/timer.c
 create mode 100644 target/arc/timer.h

diff --git a/target/arc/irq.c b/target/arc/irq.c
new file mode 100644
index 0000000000..ebbb2e1442
--- /dev/null
+++ b/target/arc/irq.c
@@ -0,0 +1,658 @@
+/*
+ * QEMU ARC CPU - IRQ subsystem
+ *
+ * Copyright (c) 2020
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/irq.h"
+#include "cpu.h"
+#include "qemu/main-loop.h"
+#include "irq.h"
+#include "exec/cpu_ldst.h"
+#include "translate.h"
+#include "qemu/host-utils.h"
+
+/* Static functions and variables. */
+
+static uint32_t save_reg_pair_32[] = {
+    0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30
+};
+
+static uint32_t save_reg_pair_16[] = {
+    0, 2, 10, 12, 14, 26, 28, 30
+};
+
+bool enabled_interrupts = false;
+
+/* Given a struct STATUS_R, pack it to 32 bit. */
+uint32_t pack_status32(status_t *status_r)
+{
+    uint32_t res = 0x00000000;
+
+    res |= (status_r->IEf & 0x1) << 31;
+    res |= (status_r->USf & 0x1) << 20;
+    res |= (status_r->ADf & 0x1) << 19;
+    res |= (status_r->RBf & 0x7) << 16;
+    res |= (status_r->ESf & 0x1) << 15;
+    res |= (status_r->SCf & 0x1) << 14;
+    res |= (status_r->DZf & 0x1) << 13;
+    res |= (status_r->Lf  & 0x1) << 12;
+    res |= (status_r->Zf  & 0x1) << 11;
+    res |= (status_r->Nf  & 0x1) << 10;
+    res |= (status_r->Cf  & 0x1) << 9;
+    res |= (status_r->Vf  & 0x1) << 8;
+    res |= (status_r->Uf  & 0x1) << 7;
+    res |= (status_r->DEf & 0x1) << 6;
+    res |= (status_r->AEf & 0x1) << 5;
+    res |= (status_r->Ef  & 0xf) << 1;
+
+    return res;
+}
+
+/* Reverse of the above function. */
+void unpack_status32(status_t *status_r, uint32_t value)
+{
+    status_r->IEf = ((value >> 31) & 0x1);
+    status_r->USf = ((value >> 20) & 0x1);
+    status_r->ADf = ((value >> 19) & 0x1);
+    status_r->RBf = ((value >> 16) & 0x7);
+    status_r->ESf = ((value >> 15) & 0x1);
+    status_r->SCf = ((value >> 14) & 0x1);
+    status_r->DZf = ((value >> 13) & 0x1);
+    status_r->Lf  = ((value >> 12) & 0x1);
+    status_r->Zf  = ((value >> 11) & 0x1);
+    status_r->Nf  = ((value >> 10) & 0x1);
+    status_r->Cf  = ((value >> 9)  & 0x1);
+    status_r->Vf  = ((value >> 8)  & 0x1);
+    status_r->Uf  = ((value >> 7)  & 0x1);
+    status_r->DEf = ((value >> 6)  & 0x1);
+    status_r->AEf = ((value >> 5)  & 0x1);
+    status_r->Ef  = ((value >> 1)  & 0xf);
+}
+
+/* Return from fast interrupts. */
+
+static void arc_rtie_firq(CPUARCState *env)
+{
+    assert(env->stat.AEf == 0);
+
+    qemu_log_mask(CPU_LOG_INT, "[IRQ] exit firq: U=%d, AUX_IRQ_ACT.U=%d\n",
+                  env->stat.Uf, env->aux_irq_act >> 31);
+
+    /* Clear currently active interrupt. */
+    env->aux_irq_act &= 0xfffffffe;
+
+    /* Check if we need to restore userland SP. */
+    if (((env->aux_irq_act & 0xFFFF) == 0) && (env->aux_irq_act & 0x80000000)) {
+        switchSP(env);
+    }
+
+    env->stat = env->stat_l1; /* FIXME use status32_p0 reg. */
+    env->aux_irq_act &= ~(env->stat.Uf << 31); /* Keep U-bit in sync. */
+
+    /* FIXME! fix current reg bank if RB bit is changed. */
+
+    CPU_PCL(env) = CPU_ILINK(env);
+    env->pc = CPU_ILINK(env);
+}
+
+/* Implements a pop operation from the CPU stack. */
+static uint32_t irq_pop(CPUARCState *env, const char *str)
+{
+    uint32_t rval;
+    rval = cpu_ldl_data(env, CPU_SP(env));
+
+    qemu_log_mask(CPU_LOG_INT, "[IRQ] Pop [SP:0x%08x] => 0x%08x (%s)\n",
+                  CPU_SP(env), rval, str ? str : "unk");
+    CPU_SP(env) += 4;
+    return rval;
+}
+
+/* Return from regular interrupts. */
+
+static void arc_rtie_irq(CPUARCState *env)
+{
+    uint32_t tmp;
+    ARCCPU *cpu = env_archcpu(env);
+
+    assert((env->aux_irq_act & 0xFFFF) != 0);
+    assert(env->stat.AEf == 0);
+
+    /* Clear currently active interrupt. */
+    tmp = ctz32(env->aux_irq_act & 0xffff);
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "[IRQ] exit irq:%d IRQ_ACT:0x%08x PRIO:%d\n",
+                  env->icause[tmp], env->aux_irq_act, tmp);
+
+    /*
+     * FIXME! I assume the current active interrupt is the one which is
+     * the highest in the aux_irq_act register.
+     */
+    env->aux_irq_act &= ~(1 << tmp);
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "[IRQ] exit irq:%d U:%d AE:%d IE:%d E:%d IRQ_ACT:0x%08x\n",
+                  env->icause[tmp], env->stat.Uf, env->stat.AEf, env->stat.IEf,
+                  env->stat.Ef, env->aux_irq_act);
+
+    if (((env->aux_irq_act & 0xffff) == 0) &&
+        (env->aux_irq_act & 0x80000000) && (env->aux_irq_ctrl & (1 << 11))) {
+        switchSP(env);
+    }
+
+    /* Pop requested number of registers. */
+    /* FIXME! select rf16 when needed. */
+    uint32_t *save_reg_pair = save_reg_pair_32;
+    char regname[6];
+    uint32_t i;
+    for (i = 0; i < (env->aux_irq_ctrl & 0x1F); ++i) {
+        sprintf(regname, "r%d", save_reg_pair[i]);
+        env->r[save_reg_pair[i]] = irq_pop(env, (const char *) regname);
+        sprintf(regname, "r%d", save_reg_pair[i] + 1);
+        env->r[save_reg_pair[i] + 1] = irq_pop(env, (const char *) regname);
+    }
+
+    /* Pop BLINK */
+    if (env->aux_irq_ctrl & (1 << 9) && ((env->aux_irq_ctrl & 0x1F) != 16)) {
+        CPU_BLINK(env) = irq_pop(env, "blink");
+    }
+
+    /* Pop lp_end, lp_start, lp_count if aux_irq_ctrl.l bit is set. */
+    if (env->aux_irq_ctrl & (1 << 10)) {
+        env->lpe = irq_pop(env, "LP_END");
+        env->lps = irq_pop(env, "LP_START");
+        CPU_LP(env) = irq_pop(env, "lp");
+    }
+
+    /*
+     * Pop EI_BASE, JLI_BASE, LDI_BASE if LP bit is set and Code
+     * Density feature is enabled. FIXME!
+     */
+    if (cpu->cfg.code_density && (env->aux_irq_ctrl & (1 << 13))) {
+        /* FIXME! env->aux_ei_base  = irq_pop(env); */
+        /* FIXME! env->aux_ldi_base = irq_pop(env); */
+        /* FIXME! env->aux_jli_base = irq_pop(env); */
+        irq_pop(env, "dummy EI_BASE");
+        irq_pop(env, "dummy LDI_BASE");
+        irq_pop(env, "dummy JLI_BASE");
+    }
+
+    CPU_ILINK(env) = irq_pop(env, "PC"); /* CPU PC*/
+    uint32_t tmp_stat = irq_pop(env, "STATUS32"); /* status. */
+    unpack_status32(&env->stat, tmp_stat);
+
+    /* Late switch to Kernel SP if previously in User thread. */
+    if (((env->aux_irq_act & 0xffff) == 0)
+        && env->stat.Uf && !(env->aux_irq_ctrl & (1 << 11))) {
+        switchSP(env);
+    }
+
+    env->aux_irq_act &= ~(env->stat.Uf << 31); /* Keep U-bit in sync. */
+    CPU_PCL(env) = CPU_ILINK(env);
+    env->pc = CPU_ILINK(env);
+}
+
+/* Helper, implements entering in a fast irq. */
+static void arc_enter_firq(ARCCPU *cpu, uint32_t vector)
+{
+    CPUARCState *env = &cpu->env;
+
+    assert(env->stat.DEf == 0);
+    assert(env->stat.is_delay_slot_instruction == 0);
+
+    /* Reset RTC state machine -> AUX_RTC_CTRL &= 0x3fffffff */
+    qemu_log_mask(CPU_LOG_INT,
+                  "[IRQ] enter firq:%d U:%d AE:%d IE:%d E:%d\n",
+                  vector, env->stat.Uf, env->stat.AEf, env->stat.IEf,
+                  env->stat.Ef);
+
+    /* Switch SP with AUX_SP. */
+    if (env->stat.Uf) {
+        switchSP(env);
+    }
+
+    /* Clobber ILINK with address of interrupting instruction. */
+    CPU_ILINK(env) = env->pc & 0xfffffffe;
+    env->stat_l1 = env->stat;
+
+    /* Set stat {Z = U; U = 0; L = 1; ES = 0; DZ = 0; DE = 0;} */
+    env->stat.Lf = 1;
+    env->stat.Zf = env->stat.Uf; /* Old User/Kernel bit. */
+    env->stat.Uf = 0;
+    env->stat.ESf = 0;
+    env->stat.DZf = 0;
+    env->stat.DEf = 0;
+    env->stat.is_delay_slot_instruction = 0;
+
+    /* Set .RB to 1 if additional register banks are specified. */
+    if (cpu->cfg.rgf_num_banks > 0) {
+        env->stat.RBf = 1;
+        /* FIXME! Switch to first register bank. */
+    }
+}
+
+/* Implements a push operation to the CPU stack. */
+static void irq_push(CPUARCState *env, uint32_t regval, const char *str)
+{
+    CPU_SP(env) -= 4;
+    qemu_log_mask(CPU_LOG_INT, "[IRQ] Push [SP:0x%08x] <= 0x%08x (%s)\n",
+                  CPU_SP(env), regval, str ? str : "unk");
+    uint32_t uf = env->stat.Uf;
+    env->stat.Uf = 0;
+    cpu_stl_data(env, CPU_SP(env), regval);
+    env->stat.Uf = uf;
+}
+
+/* Helper, implements the steps required to enter a simple interrupt. */
+static void arc_enter_irq(ARCCPU *cpu, uint32_t vector)
+{
+    CPUARCState *env = &cpu->env;
+
+    assert(env->stat.DEf == 0);
+    assert(env->stat.is_delay_slot_instruction == 0);
+
+    /* Reset RTC state machine -> AUX_RTC_CTRL &= 0x3fffffff */
+    qemu_log_mask(CPU_LOG_INT, "[IRQ] enter irq:%d U:%d AE:%d IE:%d E:%d\n",
+                  vector, env->stat.Uf, env->stat.AEf, env->stat.IEf,
+                  env->stat.Ef);
+
+    /* Early switch to kernel sp if previously in user thread */
+    if (env->stat.Uf && !(env->aux_irq_ctrl & (1 << 11))) {
+        switchSP(env);
+    }
+
+    /* Clobber ILINK with address of interrupting instruction. */
+    CPU_ILINK(env) = env->pc & 0xfffffffe;
+
+    /* Start pushing regs and stat. */
+    irq_push(env, pack_status32(&env->stat), "STATUS32");
+    irq_push(env, env->pc, "PC");
+
+    /*
+     * Push EI_BASE, JLI_BASE, LDI_BASE if LP bit is set and Code
+     * Density feature is enabled.
+     */
+    if (cpu->cfg.code_density && (env->aux_irq_ctrl & (1 << 13))) {
+        /* FIXME! irq_push(env, env->aux_jli_base, "JLI_BASE"); */
+        /* FIXME! irq_push(env, env->aux_ldi_base, "LDI_BASE""); */
+        /* FIXME! irq_push(env, env->aux_ei_base, "EI_BASE"); */
+        irq_push(env, 0xdeadbeef, "dummy JLI_BASE");
+        irq_push(env, 0xdeadbeef, "dummy LDI_BASE");
+        irq_push(env, 0xdeadbeef, "dummy EI_BASE");
+    }
+
+    /* Push LP_COUNT, LP_START, LP_END registers if required. */
+    if (env->aux_irq_ctrl & (1 << 10)) {
+        irq_push(env, CPU_LP(env), "lp");
+        irq_push(env, env->lps, "LP_START");
+        irq_push(env, env->lpe, "LP_END");
+    }
+
+    /* Push BLINK register if required */
+    if (env->aux_irq_ctrl & (1 << 9) && ((env->aux_irq_ctrl & 0x1F) != 16)) {
+        irq_push(env, CPU_BLINK(env), "blink");
+    }
+
+    /* Push selected AUX_IRQ_CTRL.NR of registers onto stack. */
+    uint32_t *save_reg_pair = cpu->cfg.rgf_num_regs == 32 ?
+        save_reg_pair_32 : save_reg_pair_16;
+    const uint32_t regspair = (cpu->cfg.rgf_num_regs == 32 ? 16 : 8);
+    const uint32_t upperlimit = (env->aux_irq_ctrl & 0x1F) < regspair ?
+        env->aux_irq_ctrl & 0x1F : regspair;
+    char regname[6];
+    uint32_t i;
+
+    for (i = upperlimit; i > 0; --i) {
+        sprintf(regname, "r%d", save_reg_pair[i - 1] + 1);
+        irq_push(env, env->r[save_reg_pair[i - 1] + 1], (const char *) regname);
+        sprintf(regname, "r%d", save_reg_pair[i - 1]);
+        irq_push(env, env->r[save_reg_pair[i - 1]], (const char *) regname);
+    }
+
+    /* Late switch to Kernel SP if previously in User thread. */
+    if (env->stat.Uf && (env->aux_irq_ctrl & (1 << 11))) {
+        switchSP(env);
+    }
+
+    /* Set STATUS bits */
+    env->stat.Zf = env->stat.Uf; /* Old User/Kernel mode. */
+    env->stat.Lf = 1;
+    env->stat.ESf = 0;
+    env->stat.DZf = 0;
+    env->stat.DEf  = 0;
+    env->stat.Uf = 0;
+}
+
+/* Function implementation for reading the IRQ related aux regs. */
+uint32_t aux_irq_get(const struct arc_aux_reg_detail *aux_reg_detail,
+                     void *data)
+{
+    CPUARCState *env = (CPUARCState *) data;
+    uint32_t tmp;
+
+    /* extract selected IRQ. */
+    const uint32_t irq = env->irq_select;
+    const arc_irq_t *irq_bank = &env->irq_bank[irq];
+
+    switch (aux_reg_detail->id) {
+    case AUX_ID_irq_pending:
+        return irq_bank->pending | (irq > 15 ? (env->aux_irq_hint == irq) : 0);
+
+    case AUX_ID_irq_select:
+        return env->irq_select;
+
+    case AUX_ID_irq_priority:
+        return irq_bank->priority;
+
+    case AUX_ID_irq_trigger:
+        return irq_bank->trigger;
+
+    case AUX_ID_irq_status:
+        return (irq_bank->priority
+                | irq_bank->enable << 4
+                | irq_bank->trigger << 5
+                | (irq_bank->pending
+                   | (irq > 15 ? ((env->aux_irq_hint == irq) << 31) : 0)));
+
+    case AUX_ID_aux_irq_act:
+        return env->aux_irq_act;
+
+    case AUX_ID_aux_irq_ctrl:
+        return env->aux_irq_ctrl;
+
+    case AUX_ID_icause:
+        if ((env->aux_irq_act & 0xffff) == 0) {
+            return 0;
+        }
+        tmp = ctz32(env->aux_irq_act & 0xffff);
+        return env->icause[tmp];
+
+    case AUX_ID_irq_build:
+        return env->irq_build;
+
+    case AUX_ID_int_vector_base:
+        return env->intvec;
+
+    case AUX_ID_vecbase_ac_build:
+        return env->vecbase_build;
+        break;
+
+    case AUX_ID_aux_user_sp:
+        return env->aux_user_sp;
+
+    case AUX_ID_aux_irq_hint:
+        return env->aux_irq_hint;
+
+    default:
+        break;
+    }
+    return 0;
+}
+
+/* Function implementation for writing the IRQ related aux regs. */
+void aux_irq_set(const struct arc_aux_reg_detail *aux_reg_detail,
+                 uint32_t val, void *data)
+{
+    CPUARCState *env = (CPUARCState *) data;
+    const uint32_t irq = env->irq_select;
+    arc_irq_t *irq_bank = &env->irq_bank[irq];
+
+    qemu_log_mask(CPU_LOG_INT, "[IRQ] set aux_reg: %s, with 0x%08x\n",
+                  arc_aux_reg_name[aux_reg_detail->id],
+                  val);
+
+
+    switch (aux_reg_detail->id) {
+    case AUX_ID_irq_select:
+        if (val <= (16 + ((env->irq_build >> 8) & 0xff)))
+            env->irq_select = val;
+        else
+            qemu_log_mask(LOG_UNIMP,
+                          "[IRQ] Invalid write 0x%08x to IRQ_SELECT aux reg.\n",
+                          val);
+        break;
+
+    case AUX_ID_aux_irq_hint:
+        qemu_mutex_lock_iothread();
+        if (val == 0) {
+            qemu_irq_lower(env->irq[env->aux_irq_hint]);
+        } else if (val >= 16) {
+            qemu_irq_raise(env->irq[val]);
+            env->aux_irq_hint = val;
+        }
+        qemu_mutex_unlock_iothread();
+        break;
+
+    case AUX_ID_irq_pulse_cancel:
+        irq_bank->pending = irq_bank->trigger ? (val & 0x01) : 0;
+        break;
+
+    case AUX_ID_irq_trigger:
+        irq_bank->trigger = val & 0x01;
+        break;
+
+    case AUX_ID_irq_priority:
+        if (val <= ((env->irq_build >> 24) & 0x0f)) {
+            irq_bank->priority = val & 0x0f;
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "[IRQ] Invalid write 0x%08x to IRQ_PRIORITY aux reg.\n",
+                          val);
+        }
+        break;
+
+    case AUX_ID_aux_irq_ctrl:
+        env->aux_irq_ctrl = val & 0x2e1f;
+        break;
+
+    case AUX_ID_irq_enable:
+        irq_bank->enable = val & 0x01;
+        break;
+
+    case AUX_ID_aux_irq_act:
+        env->aux_irq_act = val & 0x8000ffff;
+        break;
+
+    case AUX_ID_int_vector_base:
+        env->intvec = val;
+        break;
+
+    case AUX_ID_aux_user_sp:
+        env->aux_user_sp = val;
+        break;
+
+    default:
+        break;
+    }
+}
+
+/* Check if we can interrupt the cpu. */
+
+bool arc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    ARCCPU *cpu = ARC_CPU(cs);
+    CPUARCState *env = &cpu->env;
+    bool found = false;
+    uint32_t vectno = 0;
+    uint32_t offset, priority;
+
+    /* Check if we should execute this interrupt. */
+    if (env->stat.Hf
+        /* The interrupts are enabled. */
+        || (env->stat.IEf == 0)
+        /* We are not in an exception. */
+        || env->stat.AEf
+        /* Disable interrupts to happen after MissI exceptions. */
+        || enabled_interrupts == false
+        /* In a delay slot of branch */
+        || env->stat.is_delay_slot_instruction
+        || env->stat.DEf
+        || (!(interrupt_request & CPU_INTERRUPT_HARD))) {
+        return false;
+    }
+
+    /* Check if any interrupts are pending. */
+    if (!env->irq_priority_pending
+        /* Or we are serving at the same priority level. */
+        || (ctz32(env->irq_priority_pending) >= ctz32(env->aux_irq_act))) {
+        return false;
+    }
+
+    /* Find the first IRQ to serve. */
+    priority = 0;
+    do {
+        for (vectno = 0;
+             vectno < cpu->cfg.number_of_interrupts; vectno++) {
+            if (env->irq_bank[16 + vectno].priority == priority
+                && env->irq_bank[16 + vectno].enable
+                && env->irq_bank[16 + vectno].pending) {
+                found = true;
+                break;
+            }
+        }
+    } while (!found && ((++priority) <= env->stat.Ef));
+
+    /* No valid interrupt has been found. */
+    if (!found) {
+        return false;
+    }
+
+    qemu_log_mask(CPU_LOG_INT, "[IRQ] interrupt at pc=0x%08x\n", env->pc);
+
+    /* Adjust vector number. */
+    vectno += 16;
+
+    /* Set the AUX_IRQ_ACT. */
+    if ((env->aux_irq_act & 0xffff) == 0) {
+        env->aux_irq_act |= env->stat.Uf << 31;
+    }
+    env->aux_irq_act |= 1 << priority;
+
+    /* Set ICAUSE register. */
+    env->icause[priority] = vectno;
+
+    /* Do FIRQ if possible. */
+    if (cpu->cfg.firq_option && priority == 0) {
+        arc_enter_firq(cpu, vectno);
+    } else {
+        arc_enter_irq(cpu, vectno);
+    }
+
+    /* XX. The PC is set with the appropriate exception vector. */
+    offset = vectno << 2;
+    env->pc = cpu_ldl_code(env, env->intvec + offset);
+    CPU_PCL(env) = env->pc & 0xfffffffe;
+
+    qemu_log_mask(CPU_LOG_INT, "[IRQ] isr=0x%08x vec=0x%08x, priority=0x%04x\n",
+                  env->pc, offset, priority);
+
+    return true;
+}
+
+/* To be called in the RTIE helper. */
+
+bool arc_rtie_interrupts(CPUARCState *env)
+{
+    ARCCPU *cpu = env_archcpu(env);
+
+    if (env->stat.AEf || ((env->aux_irq_act & 0xffff) == 0)) {
+        return false;
+    }
+
+    /* FIXME! Reset RTC state. */
+
+    if ((env->aux_irq_act & 0xffff) == 1 && cpu->cfg.firq_option) {
+        arc_rtie_firq(env);
+    } else {
+        arc_rtie_irq(env);
+    }
+    return true;
+}
+
+/* Switch between AUX USER SP and CPU's SP. */
+void switchSP(CPUARCState *env)
+{
+    uint32_t tmp;
+    qemu_log_mask(CPU_LOG_INT,
+                  "[%s] swap: r28 = 0x%08x  AUX_USER_SP = 0x%08x\n",
+                  (env->aux_irq_act & 0xFFFF) ? "IRQ" : "EXCP",
+                  CPU_SP(env), env->aux_user_sp);
+
+    tmp = env->aux_user_sp;
+    env->aux_user_sp = CPU_SP(env);
+    CPU_SP(env) = tmp;
+    /*
+     * TODO: maybe we need to flush the tcg buffer to switch into
+     * kernel mode.
+     */
+}
+
+/* Reset the IRQ subsytem. */
+void arc_resetIRQ(ARCCPU *cpu)
+{
+    CPUARCState *env = &cpu->env;
+    uint32_t i;
+
+    if (!cpu->cfg.has_interrupts) {
+        return;
+    }
+
+    for (i = 0; i < (cpu->cfg.number_of_interrupts & 0xff); i++) {
+        env->irq_bank[16 + i].enable = 1;
+    }
+
+    if (cpu->cfg.has_timer_0) {
+        /* FIXME! add build default timer0 priority. */
+        env->irq_bank[16].priority = 0;
+    }
+
+    if (cpu->cfg.has_timer_1) {
+        /* FIXME! add build default timer1 priority. */
+        env->irq_bank[17].priority = 0;
+    }
+
+    qemu_log_mask(CPU_LOG_RESET, "[IRQ] Reset the IRQ subsystem.");
+}
+
+/* Initializing the IRQ subsystem. */
+void arc_initializeIRQ(ARCCPU *cpu)
+{
+    CPUARCState *env = &cpu->env;
+    uint32_t i;
+
+    if (cpu->cfg.has_interrupts) {
+        /* FIXME! add N (NMI) bit. */
+        env->irq_build = 0x01 | ((cpu->cfg.number_of_interrupts & 0xff) << 8) |
+            ((cpu->cfg.external_interrupts & 0xff) << 16) |
+            ((cpu->cfg.number_of_levels & 0x0f) << 24) |
+            (cpu->cfg.firq_option ? (1 << 28) : 0);
+
+        for (i = 0; i < (cpu->cfg.number_of_interrupts & 0xff); i++) {
+            env->irq_bank[16 + i].enable = 1;
+        }
+
+        env->vecbase_build = (cpu->cfg.intvbase_preset & (~0x3ffff))
+            | (0x04 << 2);
+        env->intvec = cpu->cfg.intvbase_preset & (~0x3ffff);
+    } else {
+        env->irq_build = 0;
+    }
+}
diff --git a/target/arc/irq.h b/target/arc/irq.h
new file mode 100644
index 0000000000..a248c5d20c
--- /dev/null
+++ b/target/arc/irq.h
@@ -0,0 +1,37 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2019
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#ifndef __IRQ_H__
+#define __IRQ_H__
+
+#include "target/arc/regs.h"
+#include "cpu.h"
+
+uint32_t aux_irq_get(const struct arc_aux_reg_detail *, void *);
+void aux_irq_set(const struct arc_aux_reg_detail *, uint32_t, void *);
+bool arc_cpu_exec_interrupt(CPUState *, int);
+bool arc_rtie_interrupts(CPUARCState *);
+void switchSP(CPUARCState *);
+void arc_initializeIRQ(ARCCPU *);
+void arc_resetIRQ(ARCCPU *);
+uint32_t pack_status32(status_t *);
+void unpack_status32(status_t *, uint32_t);
+
+#endif
diff --git a/target/arc/timer.c b/target/arc/timer.c
new file mode 100644
index 0000000000..a3a626beb2
--- /dev/null
+++ b/target/arc/timer.c
@@ -0,0 +1,456 @@
+/*
+ * QEMU ARC CPU-timer support
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "hw/irq.h"
+#include "hw/arc/cpudevs.h"
+#include "timer.h"
+#include "qemu/main-loop.h"
+
+#define TIMER_PERIOD(hz) (1000000000LL / (hz))
+#define TIMEOUT_LIMIT 1000000
+
+#define T_PERIOD (TIMER_PERIOD(env->freq_hz))
+#define T_COUNT(T)                                                      \
+    ((uint32_t) ((qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -               \
+                  env->timer[T].last_clk) / T_PERIOD))
+
+/* Update the next timeout time as difference between Count and Limit */
+static void cpu_arc_timer_update(CPUARCState *env, uint32_t timer)
+{
+    uint32_t delta;
+    uint32_t t_count = T_COUNT(timer);
+    uint64_t now =
+        (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / T_PERIOD) * T_PERIOD;
+    uint32_t period = T_PERIOD;
+
+    delta = env->timer[timer].T_Limit - t_count - 1;
+
+    /*
+     * Artificially limit timeout rate to something achievable under
+     * QEMU. Otherwise, QEMU spends all its time generating timer
+     * interrupts, and there is no forward progress. About ten
+     * microseconds is the fastest that really works on the current
+     * generation of host machines.
+     */
+    if ((delta * period) < TIMEOUT_LIMIT) {
+        delta = TIMEOUT_LIMIT / period;
+    }
+
+    timer_mod(env->cpu_timer[timer], now + ((uint64_t)delta * period));
+
+    qemu_log_mask(LOG_UNIMP,
+                  "[TMR%d] Timer update in 0x%08x - 0x%08x = 0x%08x "\
+                  "(ctrl:0x%08x @ %d Hz)\n",
+                  timer, env->timer[timer].T_Limit,
+                  t_count, delta, env->timer[timer].T_Cntrl, env->freq_hz);
+}
+
+/* Expire the timer function. Rise an interrupt if required. */
+
+static void cpu_arc_timer_expire(CPUARCState *env, uint32_t timer)
+{
+    assert(timer == 1 || timer == 0);
+    qemu_log_mask(LOG_UNIMP, "[TMR%d] Timer expired\n", timer);
+
+    uint32_t overflow = env->timer[timer].T_Cntrl & TMR_IP;
+    /* Set the IP bit. */
+
+    bool unlocked = !qemu_mutex_iothread_locked();
+    if (unlocked) {
+        qemu_mutex_lock_iothread();
+    }
+    env->timer[timer].T_Cntrl |= TMR_IP;
+    env->timer[timer].last_clk =
+        (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / T_PERIOD) * T_PERIOD;
+    if (unlocked) {
+        qemu_mutex_unlock_iothread();
+    }
+
+    /* Raise an interrupt if enabled. */
+    if ((env->timer[timer].T_Cntrl & TMR_IE) && !overflow) {
+        qemu_log_mask(CPU_LOG_INT, "[TMR%d] Rising IRQ\n", timer);
+        qemu_irq_raise(env->irq[TIMER0_IRQ + (timer & 0x01)]);
+    }
+}
+
+/*
+ * This callback should occur when the counter is exactly equal to the
+ * limit value. Offset the count by one to avoid immediately
+ * retriggering the callback before any virtual time has passed.
+ */
+
+static void arc_timer0_cb(void *opaque)
+{
+    CPUARCState *env = (CPUARCState *) opaque;
+
+    if (!(env->timer_build & TB_T0)) {
+        return;
+    }
+
+    cpu_arc_timer_expire(env, 0);
+    cpu_arc_timer_update(env, 0);
+}
+
+/* Like the above function but for TIMER1. */
+static void arc_timer1_cb(void *opaque)
+{
+    CPUARCState *env = (CPUARCState *) opaque;
+
+    if (!(env->timer_build & TB_T1)) {
+        return;
+    }
+
+    cpu_arc_timer_expire(env, 1);
+    cpu_arc_timer_update(env, 1);
+}
+
+/* RTC counter update. */
+static void cpu_rtc_count_update(CPUARCState *env)
+{
+    uint64_t now;
+    uint64_t llreg;
+
+    assert((env->timer_build & TB_RTC) && env->cpu_rtc);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (!(env->aux_rtc_ctrl & 0x01)) {
+        return;
+    }
+
+    llreg = ((now - env->last_clk_rtc) / TIMER_PERIOD(env->freq_hz));
+    llreg += env->aux_rtc_low + ((uint64_t)env->aux_rtc_high << 32);
+    env->aux_rtc_high = llreg >> 32;
+    env->aux_rtc_low = (uint32_t) llreg;
+
+    env->last_clk_rtc = now;
+    qemu_log_mask(LOG_UNIMP, "[RTC] RTC count-regs update\n");
+}
+
+/* Update the next timeout time as difference between Count and Limit */
+static void cpu_rtc_update(CPUARCState *env)
+{
+    uint64_t wait = 0;
+    uint64_t now, next, period;
+
+    assert(env->cpu_rtc);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (!(env->aux_rtc_ctrl & 0x01)) {
+        return;
+    }
+
+    period = TIMER_PERIOD(env->freq_hz);
+    wait = UINT64_MAX - ((((uint64_t) env->aux_rtc_high) << 32)
+                       + env->aux_rtc_low);
+    wait -= (now - env->last_clk_rtc) / period;
+
+    /* Limit timeout rate. */
+    if ((wait * period) < TIMEOUT_LIMIT) {
+        period = TIMEOUT_LIMIT / wait;
+    }
+
+    next = now + (uint64_t) wait * period;
+    timer_mod(env->cpu_rtc, next);
+    qemu_log_mask(LOG_UNIMP, "[RTC] RTC update\n");
+}
+
+/* RTC call back routine. */
+static void arc_rtc_cb(void *opaque)
+{
+    CPUARCState *env = (CPUARCState *) opaque;
+
+    if (!(env->timer_build & TB_RTC)) {
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "[RTC] RTC expired\n");
+
+    env->aux_rtc_high = 0;
+    env->aux_rtc_low = 0;
+    env->last_clk_rtc = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    cpu_rtc_update(env);
+}
+
+/* Helper used when resetting the system. */
+static void cpu_arc_count_reset(CPUARCState *env, uint32_t timer)
+{
+    assert(timer == 0 || timer == 1);
+    env->timer[timer].T_Cntrl = 0;
+    env->timer[timer].T_Limit = 0x00ffffff;
+}
+
+/* Get the counter value. */
+static uint32_t cpu_arc_count_get(CPUARCState *env, uint32_t timer)
+{
+    uint32_t count = T_COUNT(timer);
+    qemu_log_mask(LOG_UNIMP, "[TMR%d] Timer count %d.\n", timer, count);
+    return count;
+}
+
+/* Set the counter value. */
+static void cpu_arc_count_set(CPUARCState *env, uint32_t timer, uint32_t val)
+{
+    assert(timer == 0 || timer == 1);
+    bool unlocked = !qemu_mutex_iothread_locked();
+    if (unlocked) {
+        qemu_mutex_lock_iothread();
+    }
+    env->timer[timer].last_clk =
+        ((qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / T_PERIOD) + val) * T_PERIOD;
+    if (unlocked) {
+        qemu_mutex_unlock_iothread();
+    }
+    cpu_arc_timer_update(env, timer);
+}
+
+/* Store the counter limit. */
+static void cpu_arc_store_limit(CPUARCState *env,
+                                uint32_t timer, uint32_t value)
+{
+    switch (timer) {
+    case 0:
+        if (!(env->timer_build & TB_T0)) {
+            return;
+        }
+        break;
+    case 1:
+        if (!(env->timer_build & TB_T1)) {
+            return;
+        }
+        break;
+    default:
+        break;
+    }
+    env->timer[timer].T_Limit = value;
+    cpu_arc_timer_update(env, timer);
+}
+
+/* Set the timer control bits. */
+static void cpu_arc_control_set(CPUARCState *env,
+                                uint32_t timer, uint32_t value)
+{
+    assert(timer == 1 || timer == 0);
+    bool unlocked = !qemu_mutex_iothread_locked();
+    if (unlocked) {
+        qemu_mutex_lock_iothread();
+    }
+    if ((env->timer[timer].T_Cntrl & TMR_IP) && !(value & TMR_IP)) {
+        qemu_irq_lower(env->irq[TIMER0_IRQ + (timer)]);
+    }
+    env->timer[timer].T_Cntrl = value & 0x1f;
+    if (unlocked) {
+        qemu_mutex_unlock_iothread();
+    }
+}
+
+/* Get The RTC count value. */
+static uint32_t arc_rtc_count_get(CPUARCState *env, bool lower)
+{
+    cpu_rtc_count_update(env);
+    return lower ? env->aux_rtc_low : env->aux_rtc_high;
+}
+
+/* Set the RTC control bits. */
+static void arc_rtc_ctrl_set(CPUARCState *env, uint32_t val)
+{
+    assert(env->stat.Uf == 0);
+
+    if (val & 0x02) {
+        env->aux_rtc_low = 0;
+        env->aux_rtc_high = 0;
+        env->last_clk_rtc = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+    if (!(val & 0x01)) {
+        timer_del(env->cpu_rtc);
+    }
+
+    /* Restart RTC, update last clock. */
+    if ((env->aux_rtc_ctrl & 0x01) == 0 && (val & 0x01)) {
+        env->last_clk_rtc = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+
+    env->aux_rtc_ctrl = 0xc0000000 | (val & 0x01);
+    cpu_rtc_update(env);
+}
+
+/* Init procedure, called in platform. */
+
+void
+cpu_arc_clock_init(ARCCPU *cpu)
+{
+    CPUARCState *env = &cpu->env;
+
+    if (env->timer_build & TB_T0) {
+        env->cpu_timer[0] =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, &arc_timer0_cb, env);
+    }
+
+    if (env->timer_build & TB_T1) {
+        env->cpu_timer[1] =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, &arc_timer1_cb, env);
+    }
+
+    if (env->timer_build & TB_RTC) {
+        env->cpu_rtc =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, &arc_rtc_cb, env);
+    }
+
+    env->timer[0].last_clk =
+        (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / T_PERIOD) * T_PERIOD;
+    env->timer[1].last_clk =
+        (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / T_PERIOD) * T_PERIOD;
+}
+
+void
+arc_initializeTIMER(ARCCPU *cpu)
+{
+    CPUARCState *env = &cpu->env;
+
+    /* FIXME! add default timer priorities. */
+    env->timer_build = 0x04 | (cpu->cfg.has_timer_0 ? TB_T0 : 0) |
+                       (cpu->cfg.has_timer_1 ? TB_T1 : 0) |
+                       (cpu->cfg.rtc_option ? TB_RTC : 0);
+}
+
+void
+arc_resetTIMER(ARCCPU *cpu)
+{
+    CPUARCState *env = &cpu->env;
+
+    if (env->timer_build & TB_T0) {
+        cpu_arc_count_reset(env, 0);
+    }
+
+    if (env->timer_build & TB_T1) {
+        cpu_arc_count_reset(env, 1);
+    }
+}
+
+/* Function implementation for reading/writing aux regs. */
+uint32_t
+aux_timer_get(const struct arc_aux_reg_detail *aux_reg_detail, void *data)
+{
+    CPUARCState *env = (CPUARCState *) data;
+
+    switch (aux_reg_detail->id) {
+    case AUX_ID_control0:
+        return env->timer[0].T_Cntrl;
+        break;
+
+    case AUX_ID_control1:
+        return env->timer[1].T_Cntrl;
+        break;
+
+    case AUX_ID_count0:
+        return cpu_arc_count_get(env, 0);
+        break;
+
+    case AUX_ID_count1:
+        return cpu_arc_count_get(env, 1);
+        break;
+
+    case AUX_ID_limit0:
+        return env->timer[0].T_Limit;
+        break;
+
+    case AUX_ID_limit1:
+        return env->timer[1].T_Limit;
+        break;
+
+    case AUX_ID_timer_build:
+        return env->timer_build;
+        break;
+
+    case AUX_ID_aux_rtc_low:
+        return arc_rtc_count_get(env, true);
+        break;
+
+    case AUX_ID_aux_rtc_high:
+        return arc_rtc_count_get(env, false);
+        break;
+
+    case AUX_ID_aux_rtc_ctrl:
+        return env->aux_rtc_ctrl;
+        break;
+
+    default:
+        break;
+    }
+    return 0;
+}
+
+void aux_timer_set(const struct arc_aux_reg_detail *aux_reg_detail,
+                   uint32_t val, void *data)
+{
+    CPUARCState *env = (CPUARCState *) data;
+
+    qemu_log_mask(LOG_UNIMP, "[TMRx] AUX[%s] <= 0x%08x\n",
+                  aux_reg_detail->name, val);
+    switch (aux_reg_detail->id) {
+    case AUX_ID_control0:
+        if (env->timer_build & TB_T0) {
+            cpu_arc_control_set(env, 0, val);
+        }
+        break;
+
+    case AUX_ID_control1:
+        if (env->timer_build & TB_T1) {
+            cpu_arc_control_set(env, 1, val);
+        }
+        break;
+
+    case AUX_ID_count0:
+        if (env->timer_build & TB_T0) {
+            cpu_arc_count_set(env, 0, val);
+        }
+        break;
+
+    case AUX_ID_count1:
+        if (env->timer_build & TB_T1) {
+            cpu_arc_count_set(env, 1, val);
+        }
+        break;
+
+    case AUX_ID_limit0:
+        cpu_arc_store_limit(env, 0, val);
+        break;
+
+    case AUX_ID_limit1:
+        cpu_arc_store_limit(env, 1, val);
+        break;
+
+    case AUX_ID_aux_rtc_ctrl:
+        arc_rtc_ctrl_set(env, val);
+        break;
+
+    default:
+        break;
+    }
+}
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/target/arc/timer.h b/target/arc/timer.h
new file mode 100644
index 0000000000..0bcc58fc1e
--- /dev/null
+++ b/target/arc/timer.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU ARC CPU-timer support
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef __ARC_TIMER_H__
+#define __ARC_TIMER_H__
+
+void arc_initializeTIMER(ARCCPU *);
+void arc_resetTIMER(ARCCPU *);
+
+void aux_timer_set(const struct arc_aux_reg_detail *, uint32_t, void *);
+uint32_t aux_timer_get(const struct arc_aux_reg_detail *, void *);
+
+#endif
-- 
2.20.1


