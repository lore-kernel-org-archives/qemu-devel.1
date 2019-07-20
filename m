Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3CDC7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709A621849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnTqnoCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709A621849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hodmz-00081s-A6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmT-0006Ol-GU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmR-0006FY-LJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:21 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:36099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hodmR-0006FN-Gb
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:19 -0400
Received: by mail-qt1-x841.google.com with SMTP id z4so32994472qtc.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V1lTskQu2zUcLJY13Z+UKjgEzrIiCZS/QwXCxp5t2nw=;
 b=PnTqnoCRDmKdQp0msIZ4HnFzDl3vPryMYhi6TNtXnwvPuI2QpnWH3HowqvjcIQmhmh
 xolkiGwZmuiMUYieXYwH+lK4VW/LUKr3cL910DjAn7i5JdPf4XoI31m87riBYHt7M7WR
 bMpviEEeEcMzdZ6HeF0oLacT4xha43NL7OOrQSZPzCt/ld2W4EuNfZ7VSGQNZT4ZdXUS
 gutJmbld29AQ2sDidv0cktUccrBuolLcFw6mwP85bR0vYGMjm0P0HEPaqQJk1DGDrFnP
 czvYUVOUKg3XxMHs+eTTWlap8OgfmJw5xNEy4jvbTLbab5NHDcAjM83Gg3fioGOhawLk
 Fh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V1lTskQu2zUcLJY13Z+UKjgEzrIiCZS/QwXCxp5t2nw=;
 b=ahvTu9QStrYmOoFg8Bz0x6kenB9d+1bbOgqvW/EbVmV6A4A3cpabevGBUJtKmzFT1X
 Z+dX0z8cE1QOwwYC3qQtwIo4aVxqbWqHOUxRUgmjqrh7bs2zE3z/Oc6mj9qRW68hbqUK
 o72me6g2/jONwdJIqoOgIcGRcBgWAdW4V/f0R6phbmjYZSgNq+dV22cFhmJ8YYLzBWQC
 Z+ecMj7IjbZJoP7KBc2Hv/NqQBn3kPfSMQbh4KVngtd1QOIbd1OywcZ610wkPFLFWbQ3
 J0akYIssRLrUrkeSbrufprCDgUEQJtUABZeQ2xPFXbfDLGtoJka5lRW25pDkl83/Xum5
 cCoA==
X-Gm-Message-State: APjAAAXMxZf0w0u3RexDgTvcL7oaMkDtUrCJUBERGKs85ITIBYCG2iLA
 pR6zD82/3++sKXMnhirHA0vRMM2K
X-Google-Smtp-Source: APXvYqzosHD8Owj4EaWQLwfTptU43Xn1gZHoSSfbFdqbxeHBMDS0rKZtA0czKTOpPUXL9Wbln62nQg==
X-Received: by 2002:aed:33e6:: with SMTP id v93mr40172341qtd.157.1563584598635; 
 Fri, 19 Jul 2019 18:03:18 -0700 (PDT)
Received: from vanderson-lmcad.domain.name ([177.137.96.41])
 by smtp.googlemail.com with ESMTPSA id g10sm13405115qki.37.2019.07.19.18.03.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:03:18 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 22:02:31 -0300
Message-Id: <20190720010235.32444-4-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720010235.32444-1-vandersonmr2@gmail.com>
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v4 3/7] accel: collecting JIT statistics
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a TB has a TBS (TBStatistics) with the TB_JIT_STATS
enabled then we collect statistics of its translation
processes and code translation. To collect the number
of host instructions we used a modified version of the
disas function to pass through the whole code without
printing anything (fake_fprintf) but counting the number
of instructions.

Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c |  18 +++++++
 accel/tcg/translator.c    |   5 ++
 disas.c                   | 108 ++++++++++++++++++++++++++++++++++++++
 include/disas/disas.h     |   1 +
 include/exec/tb-stats.h   |  14 +++++
 include/qemu/log.h        |   1 +
 tcg/tcg.c                 |  23 ++++++++
 tcg/tcg.h                 |   2 +
 8 files changed, 172 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7497dae508..3a47ac6f2c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1793,6 +1793,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             }
         }
 
+        if (flag & TB_JIT_STATS) {
+            tb->tb_stats->stats_enabled |= TB_JIT_STATS;
+            atomic_inc(&tb->tb_stats->translations.total);
+        }
     } else {
         tb->tb_stats = NULL;
     }
@@ -1870,6 +1874,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     atomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        size_t code_size = gen_code_size;
+        if (tcg_ctx->data_gen_ptr) {
+            code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
+        }
+
+        atomic_add(&tb->tb_stats->code.num_host_inst,
+                    get_num_insts(tb->tc.ptr, code_size));
+    }
+
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
@@ -1927,6 +1942,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     phys_page2 = -1;
     if ((pc & TARGET_PAGE_MASK) != virt_page2) {
         phys_page2 = get_page_addr_code(env, virt_page2);
+        if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+            atomic_inc(&tb->tb_stats->translations.spanning);
+        }
     }
     /*
      * No explicit memory barrier is required -- tb_link_page() makes the
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 396a11e828..03c00bdb1b 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -117,6 +117,11 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     db->tb->size = db->pc_next - db->pc_first;
     db->tb->icount = db->num_insns;
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        atomic_add(&db->tb->tb_stats->code.num_guest_inst, db->num_insns);
+    }
+
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
diff --git a/disas.c b/disas.c
index 3e2bfa572b..5dec754992 100644
--- a/disas.c
+++ b/disas.c
@@ -475,6 +475,114 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     }
 }
 
+static int fprintf_fake(struct _IO_FILE *a, const char *b, ...)
+{
+    return 1;
+}
+
+/*
+ * This is a work around to get the number of host instructions with
+ * a small effort. It reuses the disas function with a fake printf to
+ * print nothing but count the number of instructions.
+ *
+ */
+unsigned get_num_insts(void *code, unsigned long size)
+{
+    uintptr_t pc;
+    int count;
+    CPUDebug s;
+    int (*print_insn)(bfd_vma pc, disassemble_info *info) = NULL;
+
+    INIT_DISASSEMBLE_INFO(s.info, NULL, fprintf_fake);
+    s.info.print_address_func = generic_print_host_address;
+
+    s.info.buffer = code;
+    s.info.buffer_vma = (uintptr_t)code;
+    s.info.buffer_length = size;
+    s.info.cap_arch = -1;
+    s.info.cap_mode = 0;
+    s.info.cap_insn_unit = 4;
+    s.info.cap_insn_split = 4;
+
+#ifdef HOST_WORDS_BIGENDIAN
+    s.info.endian = BFD_ENDIAN_BIG;
+#else
+    s.info.endian = BFD_ENDIAN_LITTLE;
+#endif
+#if defined(CONFIG_TCG_INTERPRETER)
+    print_insn = print_insn_tci;
+#elif defined(__i386__)
+    s.info.mach = bfd_mach_i386_i386;
+    print_insn = print_insn_i386;
+    s.info.cap_arch = CS_ARCH_X86;
+    s.info.cap_mode = CS_MODE_32;
+    s.info.cap_insn_unit = 1;
+    s.info.cap_insn_split = 8;
+#elif defined(__x86_64__)
+    s.info.mach = bfd_mach_x86_64;
+    print_insn = print_insn_i386;
+    s.info.cap_arch = CS_ARCH_X86;
+    s.info.cap_mode = CS_MODE_64;
+    s.info.cap_insn_unit = 1;
+    s.info.cap_insn_split = 8;
+#elif defined(_ARCH_PPC)
+    s.info.disassembler_options = (char *)"any";
+    print_insn = print_insn_ppc;
+    s.info.cap_arch = CS_ARCH_PPC;
+# ifdef _ARCH_PPC64
+    s.info.cap_mode = CS_MODE_64;
+# endif
+#elif defined(__riscv) && defined(CONFIG_RISCV_DIS)
+#if defined(_ILP32) || (__riscv_xlen == 32)
+    print_insn = print_insn_riscv32;
+#elif defined(_LP64)
+    print_insn = print_insn_riscv64;
+#else
+#error unsupported RISC-V ABI
+#endif
+#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
+    print_insn = print_insn_arm_a64;
+    s.info.cap_arch = CS_ARCH_ARM64;
+#elif defined(__alpha__)
+    print_insn = print_insn_alpha;
+#elif defined(__sparc__)
+    print_insn = print_insn_sparc;
+    s.info.mach = bfd_mach_sparc_v9b;
+#elif defined(__arm__)
+    print_insn = print_insn_arm;
+    s.info.cap_arch = CS_ARCH_ARM;
+    /* TCG only generates code for arm mode.  */
+#elif defined(__MIPSEB__)
+    print_insn = print_insn_big_mips;
+#elif defined(__MIPSEL__)
+    print_insn = print_insn_little_mips;
+#elif defined(__m68k__)
+    print_insn = print_insn_m68k;
+#elif defined(__s390__)
+    print_insn = print_insn_s390;
+#elif defined(__hppa__)
+    print_insn = print_insn_hppa;
+#endif
+
+    if (print_insn == NULL) {
+        print_insn = print_insn_od_host;
+    }
+
+    s.info.fprintf_func = fprintf_fake;
+    unsigned num_insts = 0;
+    for (pc = (uintptr_t)code; size > 0; pc += count, size -= count) {
+        num_insts++;
+        count = print_insn(pc, &s.info);
+        if (count < 0) {
+            break;
+        }
+    }
+    return num_insts;
+}
+
+
+
+
 /* Disassemble this for me please... (debugging). */
 void disas(FILE *out, void *code, unsigned long size)
 {
diff --git a/include/disas/disas.h b/include/disas/disas.h
index 15da511f49..9797ae7cfa 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -7,6 +7,7 @@
 
 /* Disassemble this for me please... (debugging). */
 void disas(FILE *out, void *code, unsigned long size);
+unsigned get_num_insts(void *code, unsigned long size);
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
                   target_ulong size);
 
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index ee1e8de0d3..6584b78c4a 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -33,6 +33,20 @@ struct TBStatistics {
         unsigned long total;
         unsigned long atomic;
     } executions;
+
+    struct {
+        unsigned num_guest_inst;
+        unsigned num_host_inst;
+        unsigned num_tcg_ops;
+        unsigned num_tcg_ops_opt;
+        unsigned spills;
+    } code;
+
+    struct {
+        unsigned long total;
+        unsigned long uncached;
+        unsigned long spanning;
+    } translations;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
diff --git a/include/qemu/log.h b/include/qemu/log.h
index b213411836..8cdfc268ca 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -131,6 +131,7 @@ void qemu_log_close(void);
 
 #define TB_NOTHING    0
 #define TB_EXEC_STATS (1 << 1)
+#define TB_JIT_STATS  (1 << 2)
 
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index be2c33c400..446e3d1708 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3126,6 +3126,11 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
         case TEMP_VAL_REG:
             tcg_out_st(s, ts->type, ts->reg,
                        ts->mem_base->reg, ts->mem_offset);
+
+            /* Count number of spills */
+            if (tb_stats_enabled(s->current_tb, TB_JIT_STATS)) {
+                atomic_inc(&s->current_tb->tb_stats->code.spills);
+            }
             break;
 
         case TEMP_VAL_MEM:
@@ -3997,6 +4002,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     int i, num_insns;
     TCGOp *op;
 
+    s->current_tb = tb;
+
 #ifdef CONFIG_PROFILER
     {
         int n = 0;
@@ -4028,6 +4035,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        int n = 0;
+        QTAILQ_FOREACH(op, &s->ops, link) {
+            n++;
+        }
+        atomic_add(&tb->tb_stats->code.num_tcg_ops, n);
+    }
+
 #ifdef CONFIG_DEBUG_TCG
     /* Ensure all labels referenced have been emitted.  */
     {
@@ -4094,6 +4109,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        int n = 0;
+        QTAILQ_FOREACH(op, &s->ops, link) {
+            n++;
+        }
+        atomic_add(&tb->tb_stats->code.num_tcg_ops_opt, n);
+    }
+
     tcg_reg_alloc_start(s);
 
     s->code_buf = tb->tc.ptr;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b411e17a28..bf6f3bcba3 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -738,6 +738,8 @@ struct TCGContext {
 
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
+
+    TranslationBlock *current_tb;
 };
 
 extern TCGContext tcg_init_ctx;
-- 
2.22.0


