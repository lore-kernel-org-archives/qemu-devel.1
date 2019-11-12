Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9904C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6494A2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIrENS0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6494A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXkn-0001n2-94
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iUXgb-0005wc-RZ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iUXgZ-0002HF-T4
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:29 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iUXgZ-0002GN-KG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:27 -0500
Received: by mail-pl1-x642.google.com with SMTP id o9so9494196plk.6
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GwPq1Qca8RGQ3ydBovwN5c5co2avpQegml3r4iKJ+Bc=;
 b=gIrENS0FYh/rPYimt+1DErYTQ3w5nUqSj2q6VC0JLKNkw88NTNsZIceBk1iBlB8g7r
 XY08q3HjJhco+NmaRp/7aCbXgJOz9JZvrxHS6sec9mXGlTHE8xUEp/h2E3dKa4Sw7Saw
 9H8wO6U0T8kPmL6rDwmqqWEEw/To3WcbbgCcoNQMNTPcb3iklS1IjdsAVjar881ptXLj
 fVm9fbiFdzNqhG5DoP4Eh1DJ57bdxYMvupRnR0H73PxWtz4UJXUTYbFik8f6My+MmwlZ
 tWN84geJIJgpunh81Bey5tYCAvzLao7jEEX6NlOY5ozZrgbK/qSeeeUtJ2Ozr4v48wiQ
 pBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GwPq1Qca8RGQ3ydBovwN5c5co2avpQegml3r4iKJ+Bc=;
 b=lV2GspZlW2VNoUUzVRRZnfSQwkBBktK3qdQ8Ovzay5328Ft0wub6UkVObixYSyOEXg
 ng1YUqbyiicHHwZ/iULSROzs38YMlaUN/WpkWIg/p4ftyB9HZ3pSTHtLyeCxARwsN4YP
 3uT2NIeaCm6NTqEh7nH+ddPCT6VMamLcBlI1vMIVg2Up+Sc6RV4Ll51p7h3oz0hQOI3h
 ISsKt3FKcOGM1BPS6ZnXmTqkeiY6WsxHlsT44+T4D8ob98XYRSCW/uxSLMosXckCVGwi
 uM4rGPCvmLG7NGyaMbKksgIaFWC3raCrh1LYQKv/mRBkNORvuO8Q+DP8htFZhS6Z567p
 Qm3w==
X-Gm-Message-State: APjAAAVt3Skl6I8dpn3Ky3ztajKweM8FTu5IHNSorityfkILelRF4P/c
 g8SN02nuJvhVX+tyzcsyyqmssThQAbY=
X-Google-Smtp-Source: APXvYqxiQR0W2Y4l/XaHOoFKF0WYW+tlOFZiKiTGAk8OaFjw3iuShcGX806ECur0BrlyBrCh6Kg1iQ==
X-Received: by 2002:a17:902:6b0c:: with SMTP id
 o12mr4942422plk.173.1573570945877; 
 Tue, 12 Nov 2019 07:02:25 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id a3sm8235511pfo.71.2019.11.12.07.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 07:02:25 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/5] qemu_log_lock/unlock now preserves the qemu_logfile
 handle.
Date: Tue, 12 Nov 2019 10:01:02 -0500
Message-Id: <20191112150105.2498-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112150105.2498-1-robert.foley@linaro.org>
References: <20191112150105.2498-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_log_lock() now returns a handle and qemu_log_unlock() receives a
handle to unlock.  This allows for changing the handle during logging
and ensures the lock() and unlock() are for the same file.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
v1
    - Moved this up in the patch sequence to be
      before adding RCU for qemu_logfile.
---
 include/qemu/log.h            |  9 ++++++---
 accel/tcg/cpu-exec.c          |  4 ++--
 accel/tcg/translate-all.c     |  4 ++--
 accel/tcg/translator.c        |  4 ++--
 exec.c                        |  4 ++--
 hw/net/can/can_sja1000.c      |  4 ++--
 net/can/can_socketcan.c       |  5 ++---
 target/cris/translate.c       |  4 ++--
 target/i386/translate.c       |  5 +++--
 target/lm32/translate.c       |  4 ++--
 target/microblaze/translate.c |  4 ++--
 target/nios2/translate.c      |  4 ++--
 target/tilegx/translate.c     |  7 ++++---
 target/unicore32/translate.c  |  4 ++--
 tcg/tcg.c                     | 16 ++++++++--------
 15 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index a91105b2ad..a7c5b01571 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -53,14 +53,17 @@ static inline bool qemu_log_separate(void)
  * qemu_loglevel is never set when qemu_logfile is unset.
  */
 
-static inline void qemu_log_lock(void)
+static inline FILE *qemu_log_lock(void)
 {
     qemu_flockfile(qemu_logfile);
+    return logfile->fd;
 }
 
-static inline void qemu_log_unlock(void)
+static inline void qemu_log_unlock(FILE *fd)
 {
-    qemu_funlockfile(qemu_logfile);
+    if (fd) {
+        qemu_funlockfile(fd);
+    }
 }
 
 /* Logging functions: */
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 8a6ffad40c..29bfacd4f8 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -76,8 +76,7 @@ QEMU_BUILD_BUG_ON(offsetof(qemu_can_frame, data)
 static void can_host_socketcan_display_msg(struct qemu_can_frame *msg)
 {
     int i;
-
-    qemu_log_lock();
+    FILE *logfile = qemu_log_lock();
     qemu_log("[cansocketcan]: %03X [%01d] %s %s",
              msg->can_id & QEMU_CAN_EFF_MASK,
              msg->can_dlc,
@@ -89,7 +88,7 @@ static void can_host_socketcan_display_msg(struct qemu_can_frame *msg)
     }
     qemu_log("\n");
     qemu_log_flush();
-    qemu_log_unlock();
+    qemu_log_unlock(logfile);
 }
 
 static void can_host_socketcan_read(void *opaque)
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c01f59c743..62068d10c3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -156,7 +156,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
 #if defined(DEBUG_DISAS)
     if (qemu_loglevel_mask(CPU_LOG_TB_CPU)
         && qemu_log_in_addr_range(itb->pc)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         int flags = 0;
         if (qemu_loglevel_mask(CPU_LOG_TB_FPU)) {
             flags |= CPU_DUMP_FPU;
@@ -165,7 +165,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
         flags |= CPU_DUMP_CCOP;
 #endif
         log_cpu_state(cpu, flags);
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif /* DEBUG_DISAS */
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9f48da9472..bb325a2bc4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1804,7 +1804,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("OUT: [size=%d]\n", gen_code_size);
         if (tcg_ctx->data_gen_ptr) {
             size_t code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
@@ -1829,7 +1829,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         }
         qemu_log("\n");
         qemu_log_flush();
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index f977682be7..603d17ff83 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -138,11 +138,11 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("----------------\n");
         ops->disas_log(db, cpu);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 }
diff --git a/exec.c b/exec.c
index ffdb518535..c994a00f10 100644
--- a/exec.c
+++ b/exec.c
@@ -1223,13 +1223,13 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     fprintf(stderr, "\n");
     cpu_dump_state(cpu, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
     if (qemu_log_separate()) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("qemu: fatal: ");
         qemu_log_vprintf(fmt, ap2);
         qemu_log("\n");
         log_cpu_state(cpu, CPU_DUMP_FPU | CPU_DUMP_CCOP);
         qemu_log_flush();
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
         qemu_log_close();
     }
     va_end(ap2);
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 1f81341554..39c78faf9b 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -247,8 +247,8 @@ int can_sja_accept_filter(CanSJA1000State *s,
 static void can_display_msg(const char *prefix, const qemu_can_frame *msg)
 {
     int i;
+    FILE *logfile = qemu_log_lock();
 
-    qemu_log_lock();
     qemu_log("%s%03X [%01d] %s %s",
              prefix,
              msg->can_id & QEMU_CAN_EFF_MASK,
@@ -261,7 +261,7 @@ static void can_display_msg(const char *prefix, const qemu_can_frame *msg)
     }
     qemu_log("\n");
     qemu_log_flush();
-    qemu_log_unlock();
+    qemu_log_unlock(logfile);
 }
 
 static void buff2frame_pel(const uint8_t *buff, qemu_can_frame *frame)
diff --git a/target/cris/translate.c b/target/cris/translate.c
index e752bd0609..cb57516a44 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3273,11 +3273,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #if !DISAS_CRIS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("--------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 #endif
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 77e932d827..7c99ef1385 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2502,14 +2502,15 @@ static void gen_unknown_opcode(CPUX86State *env, DisasContext *s)
     gen_illegal_opcode(s);
 
     if (qemu_loglevel_mask(LOG_UNIMP)) {
+        FILE *logfile = qemu_log_lock();
         target_ulong pc = s->pc_start, end = s->pc;
-        qemu_log_lock();
+
         qemu_log("ILLOPC: " TARGET_FMT_lx ":", pc);
         for (; pc < end; ++pc) {
             qemu_log(" %02x", cpu_ldub_code(env, pc));
         }
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 }
 
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 778cae1e81..73db9654d6 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1137,10 +1137,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("\n");
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 761f535357..cc1ad15656 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1766,10 +1766,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #if !SIM_COMPAT
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("--------------\n");
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 #endif
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e17656e66f..82107bf270 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -892,11 +892,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(tb->pc)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(tb->pc));
         log_target_disas(cs, tb->pc, dc->pc - tb->pc);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 }
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index 68dd4aa2d8..fd406f4f71 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2377,6 +2377,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     uint64_t pc_start = tb->pc;
     uint64_t page_start = pc_start & TARGET_PAGE_MASK;
     int num_insns = 0;
+    FILE *logfile = NULL;
 
     dc->pc = pc_start;
     dc->mmuidx = 0;
@@ -2388,7 +2389,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     dc->zero = NULL;
 
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
-        qemu_log_lock();
+        logfile = qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
     }
     gen_tb_start(tb);
@@ -2418,9 +2419,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     tb->size = dc->pc - pc_start;
     tb->icount = num_insns;
 
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
+    if (logfile) {
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 }
 
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 0e01f35856..0f6891b8aa 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1994,12 +1994,12 @@ done_generating:
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
         log_target_disas(cs, pc_start, dc->pc - pc_start);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
     tb->size = dc->pc - pc_start;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5475d49ed1..0511266d85 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1085,7 +1085,7 @@ void tcg_prologue_init(TCGContext *s)
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("PROLOGUE: [size=%zu]\n", prologue_size);
         if (s->data_gen_ptr) {
             size_t code_size = s->data_gen_ptr - buf0;
@@ -1110,7 +1110,7 @@ void tcg_prologue_init(TCGContext *s)
         }
         qemu_log("\n");
         qemu_log_flush();
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 
@@ -4041,11 +4041,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
                  && qemu_log_in_addr_range(tb->pc))) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("OP:\n");
         tcg_dump_ops(s, false);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 
@@ -4086,11 +4086,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef DEBUG_DISAS
         if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_IND)
                      && qemu_log_in_addr_range(tb->pc))) {
-            qemu_log_lock();
+            FILE *logfile = qemu_log_lock();
             qemu_log("OP before indirect lowering:\n");
             tcg_dump_ops(s, false);
             qemu_log("\n");
-            qemu_log_unlock();
+            qemu_log_unlock(logfile);
         }
 #endif
         /* Replace indirect temps with direct temps.  */
@@ -4107,11 +4107,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
                  && qemu_log_in_addr_range(tb->pc))) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("OP after optimization and liveness analysis:\n");
         tcg_dump_ops(s, true);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 
-- 
2.17.1


