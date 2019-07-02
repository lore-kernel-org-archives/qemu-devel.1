Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F194C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FDB2189E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HviwlAcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FDB2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiQ2I-0003b5-4a
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 17:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44616)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPui-0007hN-1A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPub-0003KA-61
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:02:04 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:33837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hiPuV-0002YY-Di
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:01:55 -0400
Received: by mail-qk1-x742.google.com with SMTP id t8so15620230qkt.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pYUeIuqAqsXlqnoux46b3NLeLXkyrZy2LsdauBiHh6s=;
 b=HviwlAcWWfIGpDU/lpldX/21InXtAG48j26EM4eFrebsK4hg2GIsN2ezrRZv8/FVUk
 gp6siO4V19MGrwQuefhVtwZAiWDShaI4JjWfcdBIcGvsyvru5di547U87HWR7FmQO53j
 PfNGJffvSBzqOeM19c1Qn57YuU9Hx20twkDJz3CDZ2JPjIrwycVTgGRGFLo0k/toNWaQ
 ZvsZwX3r7DMj44Dh3Y83cXXig1TwX/E4pA3xRr1Y5kWxx2dRmHNpnN92/kictwXCzgwy
 NYXKkPmZDjw/IWsvxGZ1y4vVMUQpFC+kvuiWgyoxDhNZzS9Bb4iqA3y4MI9RDAYxW6VQ
 obqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pYUeIuqAqsXlqnoux46b3NLeLXkyrZy2LsdauBiHh6s=;
 b=twDJyxyh96jKmUlHymkf9gMZui/jsWbgi6YXdabRbjc1Z7K+E7JQxFsC4rDVlXy/hw
 Mhr9oLnaQIltqRL3diY28RSFN3vzi+79HQuVUi9ckUAyI8Wx1K7rt6dBYxd82C+fMAM8
 wKO/uxzoLffE4Yeb49fEHpylxowzRY5//lK/ybA/geSvd/zFEVbLPEshOMRuQz3q9kIT
 xIwigAm7fQNulIZkcAzqjcU6XIudz7u/LUv2eFgh5I+Aprp+kPktmGFA+H4+JscB4kJq
 WM2qbRQZSilOCYMKmxeOByrLCjRZqBWgWrrj9g8V+d6J3Vulht8QEquWlBaY9z2swaET
 TTFA==
X-Gm-Message-State: APjAAAWgmVPQKfNwu48tpIME0GJLsla4Qd7lXYiarv6uCQhNOKcjQXw0
 5CbzXY415S+syOkFKy68pO5X2KGd
X-Google-Smtp-Source: APXvYqx7vE8yP2HwUX8jD3D/41ftKiocHiAJ7cknoYuvg5i9kp+ZemFT1tUNWkxELWMUG5KUhO8K9A==
X-Received: by 2002:ae9:ed4b:: with SMTP id c72mr27213866qkg.400.1562101251722; 
 Tue, 02 Jul 2019 14:00:51 -0700 (PDT)
Received: from vanderson-lmcad.HotSpot300 ([189.61.239.22])
 by smtp.googlemail.com with ESMTPSA id
 s127sm6770979qkd.107.2019.07.02.14.00.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 14:00:51 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:00:14 -0300
Message-Id: <20190702210017.4275-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702210017.4275-1-vandersonmr2@gmail.com>
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v3 3/6] accel/tcg: Collecting translation/code
 quality measurements
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

Filling other tb statistics such as number of times the
tb is compiled, its number of guest/host/IR instructions...

Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c |  14 +++++
 accel/tcg/translator.c    |   4 ++
 disas.c                   | 107 ++++++++++++++++++++++++++++++++++++++
 include/disas/disas.h     |   1 +
 tcg/tcg.c                 |   8 +++
 5 files changed, 134 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d05803a142..9ee7232bb8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1865,6 +1865,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     atomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
+    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && qemu_log_in_addr_range(tb->pc)) {
+        size_t code_size = gen_code_size;
+        if (tcg_ctx->data_gen_ptr) {
+            code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
+        }
+        qemu_log_lock();
+        atomic_set(&tb->tb_stats->code.num_host_inst,
+                    get_num_insts(tb->tc.ptr, code_size));
+        qemu_log_unlock();
+    }
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
@@ -1922,6 +1933,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     phys_page2 = -1;
     if ((pc & TARGET_PAGE_MASK) != virt_page2) {
         phys_page2 = get_page_addr_code(env, virt_page2);
+        if (tb->tb_stats) {
+            atomic_inc(&tb->tb_stats->translations.spanning);
+        }
     }
     /*
      * No explicit memory barrier is required -- tb_link_page() makes the
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index cc06070e7e..d2529ca97d 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -117,6 +117,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     db->tb->size = db->pc_next - db->pc_first;
     db->tb->icount = db->num_insns;
 
+    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && qemu_log_in_addr_range(tb->pc)) {
+        db->tb->tb_stats->code.num_guest_inst = db->num_insns;
+    }
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
diff --git a/disas.c b/disas.c
index 3e2bfa572b..f5ae9c009a 100644
--- a/disas.c
+++ b/disas.c
@@ -475,6 +475,113 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     }
 }
 
+
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
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 02a2680169..bd57bb642b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4072,6 +4072,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     atomic_set(&prof->la_time, prof->la_time + profile_getclock());
 #endif
 
+    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && qemu_log_in_addr_range(tb->pc)) {
+        int n = 0;
+        QTAILQ_FOREACH(op, &s->ops, link) {
+            n++;
+        }
+        tb->tb_stats->code.num_tcg_inst = n;
+    }
+
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
                  && qemu_log_in_addr_range(tb->pc))) {
-- 
2.22.0


