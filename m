Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0572DC28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75D3207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpobV34y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75D3207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haADO-0002bl-HW
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eP-0006xM-Eu
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eL-00024A-Le
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:09 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:42258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eJ-00022t-Me
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:03 -0400
Received: by mail-pg1-x529.google.com with SMTP id l19so1549231pgh.9
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ow1MEMVWXf9Je+K7dZgTbk7vuYFz6QMr1rua4/vPS8Y=;
 b=PpobV34ybgXIlghY9Cm6uOvHKFJn4Rjva2TTVpSgo7DFluH2xDU6lHZlDTjt4W55hV
 U7mNWqaOxsymKkets5KR0XJ6dFw53QkplAUjAGfpqBZlqXhIJHpjpLIFnSyelkLzVw3u
 Fvk0UdWKNPhQ5maDvReLeZyhUMLhHtly3PoxCNDOusOMd0/UHoERtVdCC75siST8V89Z
 V5LAFhNFo0y4JZsNnwgg4tHECIJZxXigMB8Q1QwS8n8hIjRZL+1lBIcIeZN1Xhg7rBS9
 v8HegWHqoSJ7mN+6iRNZgzMJPKNvJB+xvLL/3teJtiQ6jqThS86IpsuLiXhGHNDmOh6K
 3DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ow1MEMVWXf9Je+K7dZgTbk7vuYFz6QMr1rua4/vPS8Y=;
 b=XuVXQgOzaNtvtgJ8COJKW7iSKy5dTn5x98FZiuCXZx7DFOwAGo8vBP/oYp19UnZ3wx
 qxuZ8vyDoNmiksOeQOidEcW9VsCgNr+SWsnWrW/UQX8S4ncZoLiFsl8oSq+tpHTT7aTF
 G7VfOQ4+wh9rkK+TyaC4nOkJt/bT8YgIQvjhEnbdMLenAUvQUeBcN9NEDG3WZsr2xQTh
 HB9chOY1uqkWr0UhpjZxvGgt/X3TS2aaWLM+R3KUH6DEQ7PbLMgMSEfsfXUjbgjUZl3y
 Z9jPpcFUaNHugG7THC49WV1BUcYOLSBewj3onuLbU+kQFPpGs2Z/KEJ1Jtair435La6b
 b+DQ==
X-Gm-Message-State: APjAAAUEtjh1zVrwYS/hu7NEgOBHKsHd7Ty/ES5N/E7WHbxEh1Xe1UfT
 bLrTx2hIE3k9LxJzjw36pTcbXbSu6nY=
X-Google-Smtp-Source: APXvYqwzYXhu+Oz+mbbpdYlLMH9CuxqAeLcTQbnRtPtq28BZlofhyq8Rjt3B3vRGuM8v3JT41CdxMw==
X-Received: by 2002:a63:6685:: with SMTP id a127mr13493613pgc.22.1560132182028; 
 Sun, 09 Jun 2019 19:03:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.03.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:03:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:14 -0700
Message-Id: <20190610020218.9228-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: [Qemu-devel] [PULL 35/39] cpu: Move the softmmu tlb to
 CPUNegativeOffsetState
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have for some time had code within the tcg backends to
handle large positive offsets from env.  This move makes
sure that need not happen.  Indeed, we are able to assert
at build time that simple offsets suffice for all hosts.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h       | 11 ++++++++++
 include/exec/cpu-defs.h      | 20 +++++++++++-------
 tcg/aarch64/tcg-target.inc.c | 29 ++++++--------------------
 tcg/arm/tcg-target.inc.c     | 40 ++++++++----------------------------
 tcg/i386/tcg-target.inc.c    |  6 ++++--
 tcg/mips/tcg-target.inc.c    | 39 ++++++++---------------------------
 tcg/ppc/tcg-target.inc.c     | 30 ++++++++-------------------
 tcg/riscv/tcg-target.inc.c   | 31 +++++++---------------------
 tcg/s390/tcg-target.inc.c    | 11 +++++-----
 tcg/sparc/tcg-target.inc.c   | 32 +++++++++--------------------
 10 files changed, 83 insertions(+), 166 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 253dd1d9a5..f4fed7d82e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -429,4 +429,15 @@ static inline CPUNegativeOffsetState *cpu_neg(CPUState *cpu)
     return &arch_cpu->neg;
 }
 
+/**
+ * env_tlb(env)
+ * @env: The architecture environment
+ *
+ * Return the CPUTLB state associated with the environment.
+ */
+static inline CPUTLB *env_tlb(CPUArchState *env)
+{
+    return &env_neg(env)->tlb;
+}
+
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index c067994e5c..006f8db9cf 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -178,13 +178,14 @@ typedef struct CPUTLBDesc {
 
 /*
  * Data elements that are per MMU mode, accessed by the fast path.
+ * The structure is aligned to aid loading the pair with one insn.
  */
 typedef struct CPUTLBDescFast {
     /* Contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */
     uintptr_t mask;
     /* The array of tlb entries itself. */
     CPUTLBEntry *table;
-} CPUTLBDescFast;
+} CPUTLBDescFast QEMU_ALIGNED(2 * sizeof(void *));
 
 /*
  * Data elements that are shared between all MMU modes.
@@ -211,28 +212,33 @@ typedef struct CPUTLBCommon {
 /*
  * The entire softmmu tlb, for all MMU modes.
  * The meaning of each of the MMU modes is defined in the target code.
+ * Since this is placed within CPUNegativeOffsetState, the smallest
+ * negative offsets are at the end of the struct.
  */
 typedef struct CPUTLB {
-    CPUTLBDescFast f[NB_MMU_MODES];
-    CPUTLBDesc d[NB_MMU_MODES];
     CPUTLBCommon c;
+    CPUTLBDesc d[NB_MMU_MODES];
+    CPUTLBDescFast f[NB_MMU_MODES];
 } CPUTLB;
 
-/* There are target-specific members named "tlb".  This is temporary.  */
-#define CPU_COMMON    CPUTLB tlb_;
-#define env_tlb(ENV)  (&(ENV)->tlb_)
+/* This will be used by TCG backends to compute offsets.  */
+#define TLB_MASK_TABLE_OFS(IDX) \
+    ((int)offsetof(ArchCPU, neg.tlb.f[IDX]) - (int)offsetof(ArchCPU, env))
 
 #else
 
-#define CPU_COMMON  /* Nothing */
+typedef struct CPUTLB { } CPUTLB;
 
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
+#define CPU_COMMON  /* Nothing */
+
 /*
  * This structure must be placed in ArchCPU immedately
  * before CPUArchState, as a field named "neg".
  */
 typedef struct CPUNegativeOffsetState {
+    CPUTLB tlb;
     IcountDecr icount_decr;
 } CPUNegativeOffsetState;
 
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 90957593a3..57c297f9d7 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1637,9 +1637,9 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->label_ptr[0] = label_ptr;
 }
 
-/* We expect to use a 24-bit unsigned offset from ENV.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_.f[NB_MMU_MODES - 1].table)
-                  > 0xffffff);
+/* We expect to use a 7-bit scaled negative offset from ENV.  */
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -512);
 
 /* Load and compare a TLB entry, emitting the conditional jump to the
    slow path for the failure case, which will be patched later when finalizing
@@ -1649,8 +1649,9 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
                              tcg_insn_unit **label_ptr, int mem_index,
                              bool is_read)
 {
-    int mask_ofs = offsetof(CPUArchState, tlb_.f[mem_index].mask);
-    int table_ofs = offsetof(CPUArchState, tlb_.f[mem_index].table);
+    int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
+    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
+    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
     unsigned a_bits = get_alignment_bits(opc);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_mask = (1u << a_bits) - 1;
@@ -1659,24 +1660,6 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
     TCGType mask_type;
     uint64_t compare_mask;
 
-    if (table_ofs > 0xfff) {
-        int table_hi = table_ofs & ~0xfff;
-        int mask_hi = mask_ofs & ~0xfff;
-
-        table_base = TCG_REG_X1;
-        if (mask_hi == table_hi) {
-            mask_base = table_base;
-        } else if (mask_hi) {
-            mask_base = TCG_REG_X0;
-            tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64,
-                         mask_base, TCG_AREG0, mask_hi);
-        }
-        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64,
-                     table_base, TCG_AREG0, table_hi);
-        mask_ofs -= mask_hi;
-        table_ofs -= table_hi;
-    }
-
     mask_type = (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 38de6d59c7..b066e30f0e 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1220,9 +1220,9 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
 
 #define TLB_SHIFT	(CPU_TLB_ENTRY_BITS + CPU_TLB_BITS)
 
-/* We expect to use a 20-bit unsigned offset from ENV.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_.f[NB_MMU_MODES - 1].table)
-                  > 0xfffff);
+/* We expect to use an 9-bit sign-magnitude negative offset from ENV.  */
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -256);
 
 /* Load and compare a TLB entry, leaving the flags set.  Returns the register
    containing the addend of the tlb entry.  Clobbers R0, R1, R2, TMP.  */
@@ -1232,39 +1232,15 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 {
     int cmp_off = (is_load ? offsetof(CPUTLBEntry, addr_read)
                    : offsetof(CPUTLBEntry, addr_write));
-    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
-    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
-    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
+    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
+    int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
-    if (table_off > 0xfff) {
-        int mask_hi = mask_off & ~0xfff;
-        int table_hi = table_off & ~0xfff;
-        int rot;
-
-        table_base = TCG_REG_R2;
-        if (mask_hi == table_hi) {
-            mask_base = table_base;
-        } else if (mask_hi) {
-            mask_base = TCG_REG_TMP;
-            rot = encode_imm(mask_hi);
-            assert(rot >= 0);
-            tcg_out_dat_imm(s, COND_AL, ARITH_ADD, mask_base, TCG_AREG0,
-                            rotl(mask_hi, rot) | (rot << 7));
-        }
-        rot = encode_imm(table_hi);
-        assert(rot >= 0);
-        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, table_base, TCG_AREG0,
-                        rotl(table_hi, rot) | (rot << 7));
-
-        mask_off -= mask_hi;
-        table_off -= table_hi;
-    }
-
     /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP, mask_base, mask_off);
-    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R2, table_base, table_off);
+    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP, TCG_AREG0, mask_off);
+    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R2, TCG_AREG0, table_off);
 
     /* Extract the tlb index from the address into TMP.  */
     tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_TMP, TCG_REG_TMP, addrlo,
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5f5b886c04..6ddeebf4bc 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1730,10 +1730,12 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
                    TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
 
     tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, r0, TCG_AREG0,
-                         offsetof(CPUArchState, tlb_.f[mem_index].mask));
+                         TLB_MASK_TABLE_OFS(mem_index) +
+                         offsetof(CPUTLBDescFast, mask));
 
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r0, TCG_AREG0,
-                         offsetof(CPUArchState, tlb_.f[mem_index].table));
+                         TLB_MASK_TABLE_OFS(mem_index) +
+                         offsetof(CPUTLBDescFast, table));
 
     /* If the required alignment is at least as large as the access, simply
        copy the address and mask.  For lesser alignments, check that we don't
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index ef6633587e..41bff32fb4 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1202,6 +1202,10 @@ static int tcg_out_call_iarg_reg2(TCGContext *s, int i, TCGReg al, TCGReg ah)
     return i;
 }
 
+/* We expect to use a 16-bit negative offset from ENV.  */
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -32768);
+
 /*
  * Perform the tlb comparison operation.
  * The complete host address is placed in BASE.
@@ -1215,42 +1219,17 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
     int mem_index = get_mmuidx(oi);
-    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
-    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
+    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
+    int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     int add_off = offsetof(CPUTLBEntry, addend);
     int cmp_off = (is_load ? offsetof(CPUTLBEntry, addr_read)
                    : offsetof(CPUTLBEntry, addr_write));
-    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
     target_ulong mask;
 
-    if (table_off > 0x7fff) {
-        int mask_hi = mask_off - (int16_t)mask_off;
-        int table_hi = table_off - (int16_t)table_off;
-
-        table_base = TCG_TMP1;
-        if (likely(mask_hi == table_hi)) {
-            mask_base = table_base;
-            tcg_out_opc_imm(s, OPC_LUI, mask_base, TCG_REG_ZERO, mask_hi >> 16);
-            tcg_out_opc_reg(s, ALIAS_PADD, mask_base, mask_base, TCG_AREG0);
-            mask_off -= mask_hi;
-            table_off -= mask_hi;
-        } else {
-            if (mask_hi != 0) {
-                mask_base = TCG_TMP0;
-                tcg_out_opc_imm(s, OPC_LUI,
-                                mask_base, TCG_REG_ZERO, mask_hi >> 16);
-                tcg_out_opc_reg(s, ALIAS_PADD,
-                                mask_base, mask_base, TCG_AREG0);
-            }
-            table_off -= mask_off;
-            mask_off -= mask_hi;
-            tcg_out_opc_imm(s, ALIAS_PADDI, table_base, mask_base, mask_off);
-        }
-    }
-
     /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, mask_base, mask_off);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, table_base, table_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, TCG_AREG0, mask_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, TCG_AREG0, table_off);
 
     /* Extract the TLB index from the address into TMP3.  */
     tcg_out_opc_sa(s, ALIAS_TSRL, TCG_TMP3, addrl,
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index d69c18ac1e..852b8940fb 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1498,6 +1498,10 @@ static void * const qemu_st_helpers[16] = {
     [MO_BEQ]  = helper_be_stq_mmu,
 };
 
+/* We expect to use a 16-bit negative offset from ENV.  */
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -32768);
+
 /* Perform the TLB load and compare.  Places the result of the comparison
    in CR7, loads the addend of the TLB into R3, and returns the register
    containing the guest address (zero-extended into R4).  Clobbers R0 and R2. */
@@ -1510,31 +1514,15 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
         = (is_read
            ? offsetof(CPUTLBEntry, addr_read)
            : offsetof(CPUTLBEntry, addr_write));
-    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
-    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
-    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
+    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
+    int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
-    if (table_off > 0x7fff) {
-        int mask_hi = mask_off - (int16_t)mask_off;
-        int table_hi = table_off - (int16_t)table_off;
-
-        table_base = TCG_REG_R4;
-        if (mask_hi == table_hi) {
-            mask_base = table_base;
-        } else if (mask_hi) {
-            mask_base = TCG_REG_R3;
-            tcg_out32(s, ADDIS | TAI(mask_base, TCG_AREG0, mask_hi >> 16));
-        }
-        tcg_out32(s, ADDIS | TAI(table_base, TCG_AREG0, table_hi >> 16));
-        mask_off -= mask_hi;
-        table_off -= table_hi;
-    }
-
     /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R3, mask_base, mask_off);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R4, table_base, table_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R3, TCG_AREG0, mask_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R4, TCG_AREG0, table_off);
 
     /* Extract the page index, shifted into place for tlb index.  */
     if (TCG_TARGET_REG_BITS == 32) {
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 96c33bf621..1f0ae64aae 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -962,6 +962,10 @@ static void * const qemu_st_helpers[16] = {
 /* We don't support oversize guests */
 QEMU_BUILD_BUG_ON(TCG_TARGET_REG_BITS < TARGET_LONG_BITS);
 
+/* We expect to use a 12-bit negative offset from ENV.  */
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 11));
+
 static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit **label_ptr, bool is_load)
@@ -971,32 +975,11 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
     unsigned a_bits = get_alignment_bits(opc);
     tcg_target_long compare_mask;
     int mem_index = get_mmuidx(oi);
-    int mask_off, table_off;
+    int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
+    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
+    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
     TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
 
-    mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
-    table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
-    if (table_off > 0x7ff) {
-        int mask_hi = mask_off - sextreg(mask_off, 0, 12);
-        int table_hi = table_off - sextreg(table_off, 0, 12);
-
-        if (likely(mask_hi == table_hi)) {
-            mask_base = table_base = TCG_REG_TMP1;
-            tcg_out_opc_upper(s, OPC_LUI, mask_base, mask_hi);
-            tcg_out_opc_reg(s, OPC_ADD, mask_base, mask_base, TCG_AREG0);
-            mask_off -= mask_hi;
-            table_off -= mask_hi;
-        } else {
-            mask_base = TCG_REG_TMP0;
-            table_base = TCG_REG_TMP1;
-            tcg_out_opc_upper(s, OPC_LUI, mask_base, mask_hi);
-            tcg_out_opc_reg(s, OPC_ADD, mask_base, mask_base, TCG_AREG0);
-            table_off -= mask_off;
-            mask_off -= mask_hi;
-            tcg_out_opc_imm(s, OPC_ADDI, table_base, mask_base, mask_off);
-        }
-    }
-
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, mask_base, mask_off);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, table_base, table_off);
 
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 4d896d0b58..fe42939d98 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1538,9 +1538,9 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc, TCGReg data,
 #if defined(CONFIG_SOFTMMU)
 #include "tcg-ldst.inc.c"
 
-/* We're expecting to use a 20-bit signed offset on the tlb memory ops.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_.f[NB_MMU_MODES - 1].table)
-                  > 0x7ffff);
+/* We're expecting to use a 20-bit negative offset on the tlb memory ops.  */
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 19));
 
 /* Load and compare a TLB entry, leaving the flags set.  Loads the TLB
    addend into R2.  Returns a register with the santitized guest address.  */
@@ -1551,8 +1551,9 @@ static TCGReg tcg_out_tlb_read(TCGContext* s, TCGReg addr_reg, TCGMemOp opc,
     unsigned a_bits = get_alignment_bits(opc);
     unsigned s_mask = (1 << s_bits) - 1;
     unsigned a_mask = (1 << a_bits) - 1;
-    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
-    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
+    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
+    int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     int ofs, a_off;
     uint64_t tlb_mask;
 
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 066cb0e892..10b1cea63b 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1062,6 +1062,11 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 }
 
 #if defined(CONFIG_SOFTMMU)
+
+/* We expect to use a 13-bit negative offset from ENV.  */
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
+QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 12));
+
 /* Perform the TLB load and compare.
 
    Inputs:
@@ -1078,9 +1083,9 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addr, int mem_index,
                                TCGMemOp opc, int which)
 {
-    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
-    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
-    TCGReg base = TCG_AREG0;
+    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
+    int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     const TCGReg r0 = TCG_REG_O0;
     const TCGReg r1 = TCG_REG_O1;
     const TCGReg r2 = TCG_REG_O2;
@@ -1088,26 +1093,9 @@ static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addr, int mem_index,
     unsigned a_bits = get_alignment_bits(opc);
     tcg_target_long compare_mask;
 
-    if (!check_fit_i32(table_off, 13)) {
-        int table_hi;
-
-        base = r1;
-        if (table_off <= 2 * 0xfff) {
-            table_hi = 0xfff;
-            tcg_out_arithi(s, base, TCG_AREG0, table_hi, ARITH_ADD);
-        } else {
-            table_hi = table_off & ~0x3ff;
-            tcg_out_sethi(s, base, table_hi);
-            tcg_out_arith(s, base, TCG_AREG0, base, ARITH_ADD);
-        }
-        mask_off -= table_hi;
-        table_off -= table_hi;
-        tcg_debug_assert(check_fit_i32(mask_off, 13));
-    }
-
     /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, TCG_TYPE_PTR, r0, base, mask_off);
-    tcg_out_ld(s, TCG_TYPE_PTR, r1, base, table_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, r0, TCG_AREG0, mask_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, r1, TCG_AREG0, table_off);
 
     /* Extract the page index, shifted into place for tlb index.  */
     tcg_out_arithi(s, r2, addr, TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS,
-- 
2.17.1


