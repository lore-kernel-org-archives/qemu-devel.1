Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5560C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9622067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/mUt4Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9622067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs8CR-00005p-PV
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55346)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hs8Bl-0007pe-8A
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hs8Bj-0003Q7-IM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:07:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hs8Bj-0003OA-90
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:07:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id s15so32611143wmj.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ru0uVFC6IiRmZ/DVA8Zz8x2lZ8Y/563+2G8UveOEwTk=;
 b=H/mUt4ZlT52Hyepi1NFxh+fRDn36pELhHAi3/oN8MTSvZrCJDRBYFbJ3RsZucM1Tjf
 zaFhlUffDh1O49yH+l6R/k8atHCqOlZsCnhjytie4yMjWiIlLJq0/EuxL8Lpa4AEnszB
 qEjEK2IyMfIjeoeE2vtTNE8hHtseCOiHoWQB1vA7ydMq96jJNVv8OPHDkCuZDJhGmi+q
 X/P4WwNmrPRjRaROjOZR0fghgADR7GbJwdaX/4fHZ8XsSkdT+zvWdSLgSum8la6h/Iz2
 pEgg/u2LGAKhoOAeT08WHl8xtMWIGmoFm+HMm3McF3O8dWalNKyZS712x6m26PY9LFYh
 cGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ru0uVFC6IiRmZ/DVA8Zz8x2lZ8Y/563+2G8UveOEwTk=;
 b=t7v7D6zL1nLRASjuhzw69znIf8Zd+URTjjq0Dad3oeHFcwPbfYUj+rqB5q/+DR2e0x
 sg8QOKh3WrINH3UvUKLk5uqTtzeDfFmOWY6atr/avDztuFLLyitVgKE2be4xNN3wX0lk
 6OKothk6YGuJrsFRqW5FtjAwut+7raCJ/xyWv2OQVt8f9/EFv8ckK0Z9IIDJNmU5e0Y2
 VT8MSNqGKy/Yr9BuuJ3p8nK+DB6fz/PqUbJfyvpXcA472WHZaPtBVA7kRwh6j7XIPHZ6
 N9PKL+dr6v5TmsrmAO3CbA7U3ve4kl/YROj7O0uwhxSo5J3gaRuuwyT3yzwE0zXDCucc
 PsiQ==
X-Gm-Message-State: APjAAAWH3kyjASRrGVK9WnOxovwUczQc3kHG9MkehIO068mX9I3DuQo6
 rSwjW/AREbGUe18FjPAUPb1AHw==
X-Google-Smtp-Source: APXvYqyIPbjXBy6CJvNnpeTNXG3vfK5fc4NcakaFwuVBXlxUE/IUI6pn3Z10i6NEZ9JDTHGuUQKakQ==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr70540624wmh.141.1564416469420; 
 Mon, 29 Jul 2019 09:07:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f3sm44986225wrt.56.2019.07.29.09.07.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 09:07:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6DBD61FF87;
 Mon, 29 Jul 2019 17:07:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 17:07:29 +0100
Message-Id: <20190729160729.19927-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [RFC PATCH] tcg: add annotations to dissembler output
 (RFC, HACK, PoC)
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
Cc: vandersonmr2@gmail.com, richard.henderson@linaro.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes it can be a bit tricky to line up the final host assembly
with the instructions being translated. This is made harder by the
fact disassembly is somewhat grafted into QEMU to support multiple
dissemblers.

Attempt to add more information to the output by:

  - tracking TCGNotes as we generate the code
  - using this to annotate lines of host disassembly

UNRESOLVED ISSUES:

We are duplicating some of the tracking done for INDEX_op_insn_start.
We should probably merge and have a common system that can be used
for:
  a) required stuff (insn bounderies, resolving registers on faults)
  b) nice debug info (which ops are loads/stores/splills)

The hacking in of extra info into the disassembly stream if fugly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c |  5 +++--
 disas.c                   | 17 +++++++++--------
 include/disas/disas.h     |  4 +++-
 include/exec/log.h        |  6 ++++--
 tcg/tcg.c                 | 39 ++++++++++++++++++++++++++++++++++++---
 tcg/tcg.h                 | 17 +++++++++++++++++
 6 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 0394e989d06..2f7ade495e2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1775,6 +1775,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
+    tcg_ctx->notes = g_array_set_size(tcg_ctx->notes, 0);
  tb_overflow:
 
 #ifdef CONFIG_PROFILER
@@ -1896,7 +1897,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             size_t data_size = gen_code_size - code_size;
             size_t i;
 
-            log_disas(tb->tc.ptr, code_size);
+            log_disas(tb->tc.ptr, code_size, tcg_ctx);
 
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
@@ -1910,7 +1911,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                 }
             }
         } else {
-            log_disas(tb->tc.ptr, gen_code_size);
+            log_disas(tb->tc.ptr, gen_code_size, tcg_ctx);
         }
         qemu_log("\n");
         qemu_log_flush();
diff --git a/disas.c b/disas.c
index c0f57284a43..edf4462846f 100644
--- a/disas.c
+++ b/disas.c
@@ -342,7 +342,7 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
 }
 
 /* Disassemble SIZE bytes at CODE for the host.  */
-static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
+static bool cap_disas_host(disassemble_info *info, void *code, size_t size, void *opaque)
 {
     csh handle;
     const uint8_t *cbuf;
@@ -359,6 +359,7 @@ static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
 
     while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
        cap_dump_insn(info, insn);
+       tcg_disas_annotation(stderr, opaque, pc);
     }
     if (size != 0) {
         (*info->fprintf_func)(info->stream,
@@ -416,7 +417,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
 #endif /* !CONFIG_USER_ONLY */
 #else
 # define cap_disas_target(i, p, s)  false
-# define cap_disas_host(i, p, s)  false
+# define cap_disas_host(i, p, s, o)  false
 # define cap_disas_monitor(i, p, c)  false
 #endif /* CONFIG_CAPSTONE */
 
@@ -462,7 +463,6 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     for (pc = code; size > 0; pc += count, size -= count) {
 	fprintf(out, "0x" TARGET_FMT_lx ":  ", pc);
 	count = s.info.print_insn(pc, &s.info);
-	fprintf(out, "\n");
 	if (count < 0)
 	    break;
         if (size < count) {
@@ -477,7 +477,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
 
 
 /* Disassemble this for me please... (debugging). */
-void disas(FILE *out, void *code, unsigned long size)
+void disas(FILE *out, void *code, unsigned long size, void *opaque)
 {
     uintptr_t pc;
     int count;
@@ -555,7 +555,7 @@ void disas(FILE *out, void *code, unsigned long size)
     print_insn = print_insn_hppa;
 #endif
 
-    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
+    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size, opaque)) {
         return;
     }
 
@@ -565,9 +565,10 @@ void disas(FILE *out, void *code, unsigned long size)
     for (pc = (uintptr_t)code; size > 0; pc += count, size -= count) {
         fprintf(out, "0x%08" PRIxPTR ":  ", pc);
         count = print_insn(pc, &s.info);
-	fprintf(out, "\n");
-	if (count < 0)
-	    break;
+        tcg_disas_annotation(out, opaque, pc);
+        fprintf(out, "\n");
+        if (count < 0)
+            break;
     }
 }
 
diff --git a/include/disas/disas.h b/include/disas/disas.h
index 15da511f49c..c2f75c759f1 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -5,8 +5,10 @@
 #ifdef NEED_CPU_H
 #include "cpu.h"
 
+void tcg_disas_annotation(FILE *out, void *opaque, uintptr_t pc);
+
 /* Disassemble this for me please... (debugging). */
-void disas(FILE *out, void *code, unsigned long size);
+void disas(FILE *out, void *code, unsigned long size, void *s);
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
                   target_ulong size);
 
diff --git a/include/exec/log.h b/include/exec/log.h
index de067f173b8..9fe239fa8c3 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -43,11 +43,13 @@ static inline void log_target_disas(CPUState *cpu, target_ulong start,
     target_disas(qemu_logfile, cpu, start, len);
 }
 
-static inline void log_disas(void *code, unsigned long size)
+static inline void log_disas(void *code, unsigned long size, void *s)
 {
-    disas(qemu_logfile, code, size);
+    disas(qemu_logfile, code, size, s);
 }
 
+void tcg_disas_annotation(FILE *out, void *opaque, uintptr_t pc);
+
 #if defined(CONFIG_USER_ONLY)
 /* page_dump() output to the log file: */
 static inline void log_page_dump(void)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 46b31a2f68b..301408ff511 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -781,6 +781,8 @@ void tcg_register_thread(void)
     g_assert(n < ms->smp.max_cpus);
     atomic_set(&tcg_ctxs[n], s);
 
+    s->notes = g_array_new(true, false, sizeof(TCGNote));
+
     tcg_ctx = s;
     qemu_mutex_lock(&region.lock);
     err = tcg_region_initial_alloc__locked(tcg_ctx);
@@ -977,6 +979,8 @@ void tcg_context_init(TCGContext *s)
         indirect_reg_alloc_order[i] = tcg_target_reg_alloc_order[i];
     }
 
+    s->notes = g_array_new(true, false, sizeof(TCGNote));
+
     tcg_ctx = s;
     /*
      * In user-mode we simply share the init context among threads, since we
@@ -1078,7 +1082,7 @@ void tcg_prologue_init(TCGContext *s)
             size_t data_size = prologue_size - code_size;
             size_t i;
 
-            log_disas(buf0, code_size);
+            log_disas(buf0, code_size, s);
 
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
@@ -1092,7 +1096,7 @@ void tcg_prologue_init(TCGContext *s)
                 }
             }
         } else {
-            log_disas(buf0, prologue_size);
+            log_disas(buf0, prologue_size, s);
         }
         qemu_log("\n");
         qemu_log_flush();
@@ -3124,6 +3128,10 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
             /* fallthrough */
 
         case TEMP_VAL_REG:
+        {
+            TCGNote n = { REGISTER_SPILL, s->code_ptr };
+            g_array_append_val(s->notes, n);
+            
             tcg_out_st(s, ts->type, ts->reg,
                        ts->mem_base->reg, ts->mem_offset);
 
@@ -3132,7 +3140,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
                 atomic_inc(&s->current_tb->tb_stats->code.spills);
             }
             break;
-
+        }
         case TEMP_VAL_MEM:
             break;
 
@@ -4133,6 +4141,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
             tcg_reg_alloc_dup(s, op);
             break;
         case INDEX_op_insn_start:
+        {
+            TCGNote n = { INSN_START, s->code_ptr };
+            g_array_append_val(s->notes, n);
             if (num_insns >= 0) {
                 size_t off = tcg_current_code_size(s);
                 s->gen_insn_end_off[num_insns] = off;
@@ -4150,6 +4161,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
                 s->gen_insn_data[num_insns][i] = a;
             }
             break;
+        }
         case INDEX_op_discard:
             temp_dead(s, arg_temp(op->args[0]));
             break;
@@ -4221,6 +4233,27 @@ void tcg_dump_info(void)
     dump_jit_profile_info(s);
 }
 
+void tcg_disas_annotation(FILE *out, void *opaque, uintptr_t pc)
+{
+    TCGContext *s = (TCGContext *) opaque;
+    int i;
+
+    for (i = 0; i < s->notes->len; i++) {
+        TCGNote *n = &g_array_index(s->notes, TCGNote, i);
+        if (n->start == (tcg_insn_unit *) pc) {
+            switch (n->e) {
+            case INSN_START:
+                fprintf(out, "\tinsn");
+                break;
+            case REGISTER_SPILL:
+                fprintf(out, "\tspill");
+                break;
+            }
+        }
+    }
+}
+
+
 #ifdef ELF_HOST_MACHINE
 /* In order to use this feature, the backend needs to do three things:
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 026a066b9a1..b4fcf7f7170 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -653,6 +653,21 @@ typedef struct TCGProfile {
     int64_t table_op_count[NB_OPS];
 } TCGProfile;
 
+/*
+ * TCGNote entries are used to track points in the outgoing instruction stream
+ * for better debug output.
+ */
+
+typedef enum {
+    INSN_START,
+    REGISTER_SPILL
+} TCGEvent;
+
+typedef struct {
+    TCGEvent e;
+    tcg_insn_unit *start;
+} TCGNote;
+
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
@@ -687,6 +702,8 @@ struct TCGContext {
     const TCGOpcode *vecop_list;
 #endif
 
+    GArray *notes;
+
     /* Code generation.  Note that we specifically do not use tcg_insn_unit
        here, because there's too much arithmetic throughout that relies
        on addition and subtraction working on bytes.  Rely on the GCC
-- 
2.20.1


