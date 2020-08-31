Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD3C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9811E2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vf4684yX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9811E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmb5-0006k2-NI
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL5-00064A-4n
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:23 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:42313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL3-00067s-7E
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:22 -0400
Received: by mail-pf1-x431.google.com with SMTP id 17so805031pfw.9
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vu1hIGTjP3FaAqDu3kt28iRiwFfoFLPJO2tReGgCbQ0=;
 b=vf4684yXjoEp4Rlw8+sEjTEpJrsRipmc1z+DNoK+eV+7SaJ/aPM6NTNnwir3KHGHm0
 Zv/EWJ93sQ2irWqjDr2fV1kyVXI5mIGgogcunhAbQtJqWOM+uGB4emzzjgcOKWQUcn18
 iLJg+kkgBT2fP6xWj9Kr3vTZ2WncjWZznapYRgNiPFmuHm8b38M5KCLJRLSCl2r12/C1
 5dhHJua8lDuQStUPiXu+1bxehSOTL34iscMx8GP3H7Eyk9ilMM/R/OXbaSo8o9UZaiB6
 CbHO54RbFmK4o2LbVOyHmQmpaTIT0tKDhy/AQFID5JC0lnS+fMZpk+pE9OZGYOcEz9uQ
 v3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vu1hIGTjP3FaAqDu3kt28iRiwFfoFLPJO2tReGgCbQ0=;
 b=qyW9E7WTTuDZXU3XpS7rMlVoE8/a3fhlGdxc2Gr6/VpB/xECnfuKM0EA8nq2bSHH5T
 d+KVPZXxpW5gwhKHUgQZw+J1CpNP/eJ6YHUE9ROTuEHe0wd54/jTjeWoXnULApkc6pPI
 Smy+A65G/EmBpTfFA2BU3JUSA9TkJ0lCZlpUrH0qwvI42ErPK2k2ePXdA+XEFqaNi6az
 0Ob0776YQm9XTy/dBcuc1VZML3c1lLXXIpio0hYYgbduBb/GOAHteNfHa2esQG1ecqlJ
 SOg9vapgMl3CT0tFG27HORIyomVUknD5cVEBsbcKI5X/Kc6BzxOqo7W4j+4pxlvZIIfK
 KxXg==
X-Gm-Message-State: AOAM530mgXjKpn2PjVU3PLPBHST7JiXCU8NLLGoDp9KnhhwKaiK+JxGl
 LP4ogReeVKMqHI7FfBsjrZPJqhwDJNdwCA==
X-Google-Smtp-Source: ABdhPJwE7NchIvq0jsJOILeIHw1ljSw3uIOcGRf205iFDj0RLEBnryVzUBp+ByixOuV/3ItfmKWvCw==
X-Received: by 2002:a05:6a00:1509:: with SMTP id
 q9mr1819413pfu.24.1598890039557; 
 Mon, 31 Aug 2020 09:07:19 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/76] target/microblaze: Fix no-op mb_cpu_transaction_failed
Date: Mon, 31 Aug 2020 09:05:41 -0700
Message-Id: <20200831160601.833692-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not call cpu_restore_state when no exception will be
delivered.  This can lead to inconsistent cpu state.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reported-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/op_helper.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index a99c467364..e6dcc79243 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -419,32 +419,33 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                int mmu_idx, MemTxAttrs attrs,
                                MemTxResult response, uintptr_t retaddr)
 {
-    MicroBlazeCPU *cpu;
-    CPUMBState *env;
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    CPUMBState *env = &cpu->env;
+
     qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
                   " physaddr 0x" TARGET_FMT_plx " size %d access type %s\n",
                   addr, physaddr, size,
                   access_type == MMU_INST_FETCH ? "INST_FETCH" :
                   (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
-    cpu = MICROBLAZE_CPU(cs);
-    env = &cpu->env;
 
-    cpu_restore_state(cs, retaddr, true);
     if (!(env->msr & MSR_EE)) {
         return;
     }
 
-    env->ear = addr;
     if (access_type == MMU_INST_FETCH) {
-        if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
-            env->esr = ESR_EC_INSN_BUS;
-            helper_raise_exception(env, EXCP_HW_EXCP);
+        if (!cpu->cfg.iopb_bus_exception) {
+            return;
         }
+        env->esr = ESR_EC_INSN_BUS;
     } else {
-        if ((env->pvr.regs[2] & PVR2_DOPB_BUS_EXC_MASK)) {
-            env->esr = ESR_EC_DATA_BUS;
-            helper_raise_exception(env, EXCP_HW_EXCP);
+        if (!cpu->cfg.dopb_bus_exception) {
+            return;
         }
+        env->esr = ESR_EC_DATA_BUS;
     }
+
+    env->ear = addr;
+    cs->exception_index = EXCP_HW_EXCP;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 #endif
-- 
2.25.1


