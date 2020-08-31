Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7ADC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A463206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1vuf/U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A463206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmO4-0003Lq-L8
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmK1-0003ZK-Ue
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:17 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:36769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmK0-0005v8-4w
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:17 -0400
Received: by mail-pg1-x52b.google.com with SMTP id p37so838928pgl.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y/1nd0STg2fwgw26kyAhRI4aPsi6vfmi/pGgkxdn03M=;
 b=n1vuf/U5ni04Q+LoL1Hy2Wn5aaLaSkl0Xhvn/5vGuCQydpiG9ZYV3ddHpEG/b6g5Pg
 pKcmX7X3Lp9KTrT3Sva5GDXPxIQGgwebYwe+qMqORprUa1iNdZ/PdZjmtREFx6PJaIo0
 hfrP52U8N6+M5VVgu2bLFF/Xu/6bFV60raMk3Xq+LkCGpGD2IDFJrrik6T7brsWIPk4u
 r6S+ETykmKC3fWfWsjbSj9dRQiR3iOcRxqTJGs7Jd/foy8OpJtUPOiEImPleLJXEttxO
 9T/XX+bDOBG+f5yiltbxtHFWABHeGJfa8smZ+BQM6pimRdMc08Z3bA2zIiybx6jaYnGl
 MT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y/1nd0STg2fwgw26kyAhRI4aPsi6vfmi/pGgkxdn03M=;
 b=Nm3MjMqgOlF67NG27Lb0Fv0mHFhMzndptwuNUS9eCWxMb3D0tZ12hn9MTLc97Ibog2
 MP0iq1u18A6fOv3qk0P6G5dCH5hiYLhkYTa/3/ySS3qdIbK6vlXgPH8nOEqg6pqkK2mU
 WfqR+QcysGpz0SwZvp2GFVDvgXOXLZjhJRYVC0KznbunphJ8tJi5K9DCKrMcTzSR9GT5
 HklYJZe9ICZljq3QzvC0UXF8RYNyskCPh8fT7J0TTZmwkiHWdgFMkM5tj/5hBhrJeT5e
 prDQloGra9zlPlsZWSf4oahWBwUuKEr7D0OlvJQFN7p+W5CYM1227xpeya2i/0hwI/B+
 uMdQ==
X-Gm-Message-State: AOAM530avmMLeXjXqYgwEtjA5sZHU5GpPVoLXcbwoHIUXHJvyfJrSA+Y
 Tj3BbWhNSOR4m0ak+XzDexQ/E/CLsz6WKA==
X-Google-Smtp-Source: ABdhPJzWJlfmnepN315d70ORP76t5oWrrWc2Ti57U1jhkaRuZBOr9PkuCUMseXTXkNrWfv3OiHU6CQ==
X-Received: by 2002:a62:8309:: with SMTP id h9mr1695633pfe.104.1598889974376; 
 Mon, 31 Aug 2020 09:06:14 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/76] target/microblaze: Split out EAR from env->sregs
Date: Mon, 31 Aug 2020 09:04:52 -0700
Message-Id: <20200831160601.833692-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Continue eliminating the sregs array in favor of individual members.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 1 +
 target/microblaze/gdbstub.c   | 4 ++--
 target/microblaze/helper.c    | 6 +++---
 target/microblaze/op_helper.c | 8 ++++----
 target/microblaze/translate.c | 6 ++++--
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 36de61d9f9..c9035b410e 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -238,6 +238,7 @@ struct CPUMBState {
     uint32_t regs[32];
     uint64_t pc;
     uint64_t msr;
+    uint64_t ear;
     uint64_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index e4c4936a7a..e33a613efe 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -65,7 +65,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->msr;
         break;
     case GDB_EAR:
-        val = env->sregs[SR_EAR];
+        val = env->ear;
         break;
     case GDB_ESR:
         val = env->sregs[SR_ESR];
@@ -121,7 +121,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->msr = tmp;
         break;
     case GDB_EAR:
-        env->sregs[SR_EAR] = tmp;
+        env->ear = tmp;
         break;
     case GDB_ESR:
         env->sregs[SR_ESR] = tmp;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a18314540f..afe9634781 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -85,7 +85,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "mmu=%d miss v=%" VADDR_PRIx "\n",
                   mmu_idx, address);
 
-    env->sregs[SR_EAR] = address;
+    env->ear = address;
     switch (lu.err) {
     case ERR_PROT:
         env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 17 : 16;
@@ -145,7 +145,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             qemu_log_mask(CPU_LOG_INT,
                           "hw exception at pc=%" PRIx64 " ear=%" PRIx64 " "
                           "esr=%" PRIx64 " iflags=%x\n",
-                          env->pc, env->sregs[SR_EAR],
+                          env->pc, env->ear,
                           env->sregs[SR_ESR], env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->iflags &= ~(IMM_FLAG | D_FLAG);
@@ -188,7 +188,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             qemu_log_mask(CPU_LOG_INT,
                           "exception at pc=%" PRIx64 " ear=%" PRIx64 " "
                           "iflags=%x\n",
-                          env->pc, env->sregs[SR_EAR], env->iflags);
+                          env->pc, env->ear, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->iflags &= ~(IMM_FLAG | D_FLAG);
             env->pc = cpu->cfg.base_vectors + 0x20;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 3668382d36..5bacd29663 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -78,7 +78,7 @@ void helper_debug(CPUMBState *env)
     qemu_log("PC=%" PRIx64 "\n", env->pc);
     qemu_log("rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
              "debug[%x] imm=%x iflags=%x\n",
-             env->msr, env->sregs[SR_ESR], env->sregs[SR_EAR],
+             env->msr, env->sregs[SR_ESR], env->ear,
              env->debug, env->imm, env->iflags);
     qemu_log("btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
@@ -431,7 +431,7 @@ void helper_memalign(CPUMBState *env, target_ulong addr,
                           "unaligned access addr=" TARGET_FMT_lx
                           " mask=%x, wr=%d dr=r%d\n",
                           addr, mask, wr, dr);
-            env->sregs[SR_EAR] = addr;
+            env->ear = addr;
             env->sregs[SR_ESR] = ESR_EC_UNALIGNED_DATA | (wr << 10) \
                                  | (dr & 31) << 5;
             if (mask == 3) {
@@ -450,7 +450,7 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
         qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
                       TARGET_FMT_lx " %x %x\n",
                       addr, env->slr, env->shr);
-        env->sregs[SR_EAR] = addr;
+        env->ear = addr;
         env->sregs[SR_ESR] = ESR_EC_STACKPROT;
         helper_raise_exception(env, EXCP_HW_EXCP);
     }
@@ -488,7 +488,7 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
         return;
     }
 
-    env->sregs[SR_EAR] = addr;
+    env->ear = addr;
     if (access_type == MMU_INST_FETCH) {
         if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
             env->sregs[SR_ESR] = ESR_EC_INSN_BUS;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9f2dcd82cd..62747b02f3 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1809,7 +1809,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
                  "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
                  "rbtr=%" PRIx64 "\n",
-                 env->msr, env->sregs[SR_ESR], env->sregs[SR_EAR],
+                 env->msr, env->sregs[SR_ESR], env->ear,
                  env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
                  env->sregs[SR_BTR]);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
@@ -1873,8 +1873,10 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, pc), "rpc");
     cpu_SR[SR_MSR] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, msr), "rmsr");
+    cpu_SR[SR_EAR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
 
-    for (i = SR_MSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
+    for (i = SR_EAR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
         cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
-- 
2.25.1


