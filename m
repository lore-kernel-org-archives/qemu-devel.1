Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2178EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C4F2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfO/9XcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C4F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIom-0005Xe-4a
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIc0-0004N3-UN
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:37423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbx-0001rz-NV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id 13so3813623pfy.4
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kH58hAvJQddV+gmkJiQg38KIE2g2nGM8vibdHYkRrZc=;
 b=HfO/9XcB4uWJwX4YQdTwAr8b0aqlxs7EGkF5NdDiEENE/ENIsVnYWjJef5K1gGuCBf
 WGDb8PF4mqZ4yp4/lwG/y3Vqof0VFxF8GO6V7OTS1DsGuhBgZPLWWKdXSlrb2na608Hs
 IonnmbHaobxGGlokTe47h3YET9OfyQWCUPJOJRXDAfpRLMoBW/vE/RMVZmQUzB34HuWK
 N2GFDEsB9doGfH1yrmY8qKdbxaNXyNCTJUqoXOWvv8n/f6KUEvn4J/rQ8kOr3QcPSdTH
 KTCE19Udi1k82LwjfmGsuoyzvj7cdw05H2oCMlMesBtpOOO71AYUwVD3Tyv2A2IALf/1
 OQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kH58hAvJQddV+gmkJiQg38KIE2g2nGM8vibdHYkRrZc=;
 b=qLdLzc38Ts71l8OU/TetaHIG8lLv5KxO1PIu+1r5+3AE99Kmns7r0tJuLlAz76xnDN
 R7cTwfOnP4NUR7iEh99jZr8xZvxxjinL+niFp/Ono1AYr7eZ+nL2SxHIbuHFfINsvacr
 LlTYG07BsgBgYipBABcdz/4qZwU7wkcYYP1aRaOIUsuuEXIMmP3/pFsaK4PVug0f0wAl
 wiRZjcmCCTaJzlOCVGNkBzI+P/WpP3vgkgyCSDmY0sYvq6iG+9DgYXlINd76bdH5oJ2P
 zheqpUbFzs3VXIMtBKX86kwJ6KL+TTiAD1bw5jDkGeVD5Q4DoOU7ARENWh7kB22tZpCX
 cdWg==
X-Gm-Message-State: AOAM531yPs5h6dptdj9gyNkE8QGZ865w5lEiJuuLgZx5HtDQxtLHutQ1
 4Z6chz2VSAj5zDLEOx7+00nMCX3zMVEaKQ==
X-Google-Smtp-Source: ABdhPJxIN3X4Fakvn/arv07f26A4a2S1Jgo89ARkXO75tN2GD+rxz1uEHNlxJJoyM7VpAz2FpGdmKw==
X-Received: by 2002:a65:6883:: with SMTP id e3mr5900352pgt.38.1604018983799;
 Thu, 29 Oct 2020 17:49:43 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/19] tcg: Return the rx mirror of TranslationBlock from
 exit_tb
Date: Thu, 29 Oct 2020 17:49:17 -0700
Message-Id: <20201030004921.721096-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This produces a small pc-relative displacement within the
generated code to the TB structure that preceeds it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 35 ++++++++++++++++++++++-------------
 tcg/tcg-op.c         | 13 ++++++++++++-
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4af3faba80..f3d17f28d0 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -144,12 +144,13 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 #endif /* CONFIG USER ONLY */
 
 /* Execute a TB, and fix up the CPU state afterwards if necessary */
-static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
+static inline TranslationBlock *cpu_tb_exec(CPUState *cpu,
+                                            TranslationBlock *itb,
+                                            int *tb_exit)
 {
     CPUArchState *env = cpu->env_ptr;
     uintptr_t ret;
     TranslationBlock *last_tb;
-    int tb_exit;
     const void *tb_ptr = itb->tc.ptr;
 
     qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
@@ -177,11 +178,20 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
 
     ret = tcg_qemu_tb_exec(env, tb_ptr);
     cpu->can_do_io = 1;
-    last_tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
-    tb_exit = ret & TB_EXIT_MASK;
-    trace_exec_tb_exit(last_tb, tb_exit);
+    /*
+     * TODO: Delay swapping back to the read-write mirror of the TB
+     * until we actually need to modify the TB.  The read-only copy,
+     * coming from the rx mirror, shares the same host TLB entry as
+     * the code that executed the exit_tb opcode that arrived here.
+     * If we insist on touching both the RX and the RW pages, we
+     * double the host TLB pressure.
+     */
+    last_tb = tcg_mirror_rx_to_rw((void *)(ret & ~TB_EXIT_MASK));
+    *tb_exit = ret & TB_EXIT_MASK;
 
-    if (tb_exit > TB_EXIT_IDX1) {
+    trace_exec_tb_exit(last_tb, *tb_exit);
+
+    if (*tb_exit > TB_EXIT_IDX1) {
         /* We didn't start executing this TB (eg because the instruction
          * counter hit zero); we must restore the guest PC to the address
          * of the start of the TB.
@@ -199,7 +209,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
             cc->set_pc(cpu, last_tb->pc);
         }
     }
-    return ret;
+    return last_tb;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -210,6 +220,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 {
     TranslationBlock *tb;
     uint32_t cflags = curr_cflags() | CF_NOCACHE;
+    int tb_exit;
 
     if (ignore_icount) {
         cflags &= ~CF_USE_ICOUNT;
@@ -227,7 +238,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
     /* execute the generated code */
     trace_exec_tb_nocache(tb, tb->pc);
-    cpu_tb_exec(cpu, tb);
+    cpu_tb_exec(cpu, tb, &tb_exit);
 
     mmap_lock();
     tb_phys_invalidate(tb, -1);
@@ -244,6 +255,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t flags;
     uint32_t cflags = 1;
     uint32_t cf_mask = cflags & CF_HASH_MASK;
+    int tb_exit;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
         start_exclusive();
@@ -260,7 +272,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         cc->cpu_exec_enter(cpu);
         /* execute the generated code */
         trace_exec_tb(tb, pc);
-        cpu_tb_exec(cpu, tb);
+        cpu_tb_exec(cpu, tb, &tb_exit);
         cc->cpu_exec_exit(cpu);
     } else {
         /*
@@ -653,13 +665,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
                                     TranslationBlock **last_tb, int *tb_exit)
 {
-    uintptr_t ret;
     int32_t insns_left;
 
     trace_exec_tb(tb, tb->pc);
-    ret = cpu_tb_exec(cpu, tb);
-    tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
-    *tb_exit = ret & TB_EXIT_MASK;
+    tb = cpu_tb_exec(cpu, tb, tb_exit);
     if (*tb_exit != TB_EXIT_REQUESTED) {
         *last_tb = tb;
         return;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e3dc0cb4cb..f0d22de3de 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2666,7 +2666,18 @@ void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg)
 
 void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
 {
-    uintptr_t val = (uintptr_t)tb + idx;
+    /*
+     * Let the jit code return the read-only version of the
+     * TranslationBlock, so that we minimize the pc-relative
+     * distance of the address of the exit_tb code to TB.
+     * This will improve utilization of pc-relative address loads.
+     *
+     * TODO: Move this to translator_loop, so that all const
+     * TranslationBlock pointers refer to read-only memory.
+     * This requires coordination with targets that do not use
+     * the translator_loop.
+     */
+    uintptr_t val = (uintptr_t)tcg_mirror_rw_to_rx((void *)tb) + idx;
 
     if (tb == NULL) {
         tcg_debug_assert(idx == 0);
-- 
2.25.1


