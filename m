Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D3C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CCA21842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stx/yXoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CCA21842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4UL-0001rG-K1
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58336)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NE-0004S9-P6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4N9-0000Gm-P2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:35370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4N6-00009K-KD
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id w24so25024574plp.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7sC4AygPV0WiIiwW7lCQ39zt4aUcLjG0l/PxVVeDVwI=;
 b=stx/yXoyHZ3qDZvCGIPUin9oj3MOK/oGTPWca+rQBpB0cNtFHgXl68TGZR7fjyDJFB
 S5CJkeG8u+Pklt1yK4igGZeOU67cohmKyAvb5SUS9SBLj5Du23soFupaLJlGcvw2r7v5
 X9ZXxUexHTvaMv8MNyf8GCwLmHASuKHmDam2WbJimRoaMIOgxq8rjcDqRgoA8Xmk/kOH
 4Wk1HV0ZGbRQENsL3i1pze0Je4Nq95jswr4eryZMzkTj8ZRbCnJvvsKhcbGj9hVnz49i
 U7330NdIHkPkrlbRp4VJfswIlA9MRtoNV5YZc6U4RT8RQ1zyHzwtTN767H5fEmz3p/9Q
 pgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7sC4AygPV0WiIiwW7lCQ39zt4aUcLjG0l/PxVVeDVwI=;
 b=FMNxglvU3RScUtzEOfkV/WM4VxFWWNZG+UjXrGW6NAbrpTBPqCjbPKCRbFFdeJ+Xj5
 d7MGCYiUpc7j89R7aCJ93InxvlNr8UvIa2oodUfpSd22FJRRRf+DEJ3p+1qGnyqspjG9
 vNveTFtPB9NVA9q0H8ZupTSXpoBTNDBvZqhuDfk+Z8F/x4fFZCDY0rX9BKpeBw4OHuQ6
 qGUdDX94E8iyzUsRb5NxxmVBmo27+RQPZw/cESpOQd1D26VAQ7RNq4skyGyWKVCav5ur
 wVzuWA0NcJE27zwhu8uc5NC7fi1rbhAR/EXYBcz0cG+p2urLXWRvxZ8l2u8iicqaZDQE
 5/Aw==
X-Gm-Message-State: APjAAAVYWCviVtiyTaH3jbJRn0cvVQPFc1PceVTEYQlmWbFeBDwf021r
 JQqD1fgA3aALEh+R+KUDangn39TKL+g=
X-Google-Smtp-Source: APXvYqyhGj4eyLgXH2TzyHDk/UyomJyvZFxLiE5YflrL+69O55yVMz/5zPFPIU+6s7TSmqcNLFXWBA==
X-Received: by 2002:a17:902:100a:: with SMTP id
 b10mr56845250pla.338.1564163470135; 
 Fri, 26 Jul 2019 10:51:10 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:55 -0700
Message-Id: <20190726175032.6769-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: [Qemu-devel] [PATCH 30/67] target/arm: Convert B, BL,
 BLX (immediate)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 134 +++++++++++++++--------------------
 target/arm/a32-uncond.decode |   8 +++
 target/arm/a32.decode        |   8 +++
 target/arm/t32.decode        |  79 +++++++++++++--------
 4 files changed, 122 insertions(+), 107 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 33daf70d5d..3f14e5c7f3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7582,6 +7582,14 @@ static int t32_expandimm_imm(DisasContext *s, int x)
     return imm;
 }
 
+static int t32_branch24(DisasContext *s, int x)
+{
+    /* Convert J1:J2 at x[22:21] to I2:I1, which involves I=J^~S.  */
+    x ^= !(x < 0) * (3 << 21);
+    /* Append the final zero.  */
+    return x << 1;
+}
+
 /*
  * Include the generated decoders.
  * Note that the T32 decoder reuses some of the trans_* functions
@@ -9928,13 +9936,56 @@ static bool trans_LDM(DisasContext *s, arg_ldst_block *a)
     return true;
 }
 
+/*
+ * Branch, branch with link
+ */
+
+static bool trans_B(DisasContext *s, arg_i *a)
+{
+    gen_jmp(s, s->pc_read + a->imm);
+    return true;
+}
+
+static bool trans_B_cond_thumb(DisasContext *s, arg_ci *a)
+{
+    /* This has cond from encoding, required to be outside IT block.  */
+    if (a->cond >= 0xe) {
+        return false;
+    }
+    if (s->condexec_mask) {
+        gen_illegal_op(s);
+        return true;
+    }
+    arm_skip_unless(s, a->cond);
+    gen_jmp(s, s->pc_read + a->imm);
+    return true;
+}
+
+static bool trans_BL(DisasContext *s, arg_i *a)
+{
+    tcg_gen_movi_i32(cpu_R[14], s->pc | s->thumb);
+    gen_jmp(s, s->pc_read + a->imm);
+    return true;
+}
+
+static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
+{
+    /* For A32, ARCH(5) is checked near the start of the uncond block. */
+    if (s->thumb && (a->imm & 2)) {
+        return false;
+    }
+    tcg_gen_movi_i32(cpu_R[14], s->pc | s->thumb);
+    gen_bx_im(s, (s->pc_read & ~3) + a->imm + !s->thumb);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
 
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
-    unsigned int cond, val, op1, i, rn;
+    unsigned int cond, op1, i, rn;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 addr;
@@ -10102,21 +10153,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             gen_rfe(s, tmp, tmp2);
             return;
-        } else if ((insn & 0x0e000000) == 0x0a000000) {
-            /* branch link and change to thumb (blx <offset>) */
-            int32_t offset;
-
-            tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, s->pc);
-            store_reg(s, 14, tmp);
-            /* Sign-extend the 24-bit offset */
-            offset = (((int32_t)insn) << 8) >> 8;
-            val = s->pc_read;
-            /* offset * 4 + bit24 * 2 + (thumb bit) */
-            val += (offset << 2) | ((insn >> 23) & 2) | 1;
-            /* protected by ARCH(5); above, near the start of uncond block */
-            gen_bx_im(s, val);
-            return;
         } else if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -10205,24 +10241,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x7:
         case 0x08:
         case 0x09:
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
         case 0xa:
         case 0xb:
-            {
-                int32_t offset;
-
-                /* branch (and link) */
-                if (insn & (1 << 24)) {
-                    tmp = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp, s->pc);
-                    store_reg(s, 14, tmp);
-                }
-                offset = sextract32(insn << 2, 0, 26);
-                val = s->pc_read + offset;
-                gen_jmp(s, val);
-            }
-            break;
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
         case 0xc:
         case 0xd:
         case 0xe:
@@ -10594,32 +10616,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         if (insn & (1 << 15)) {
             /* Branches, misc control.  */
             if (insn & 0x5000) {
-                /* Unconditional branch.  */
-                /* signextend(hw1[10:0]) -> offset[:12].  */
-                offset = ((int32_t)insn << 5) >> 9 & ~(int32_t)0xfff;
-                /* hw1[10:0] -> offset[11:1].  */
-                offset |= (insn & 0x7ff) << 1;
-                /* (~hw2[13, 11] ^ offset[24]) -> offset[23,22]
-                   offset[24:22] already have the same value because of the
-                   sign extension above.  */
-                offset ^= ((~insn) & (1 << 13)) << 10;
-                offset ^= ((~insn) & (1 << 11)) << 11;
-
-                if (insn & (1 << 14)) {
-                    /* Branch and link.  */
-                    tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
-                }
-
-                offset += s->pc_read;
-                if (insn & (1 << 12)) {
-                    /* b/bl */
-                    gen_jmp(s, offset);
-                } else {
-                    /* blx */
-                    offset &= ~(uint32_t)2;
-                    /* thumb2 bx, no need to check */
-                    gen_bx_im(s, offset);
-                }
+                /* Unconditional branch, in decodetree */
+                goto illegal_op;
             } else if (((insn >> 23) & 7) == 7) {
                 /* Misc control */
                 if (insn & (1 << 13))
@@ -10704,24 +10702,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     }
                 }
             } else {
-                /* Conditional branch.  */
-                op = (insn >> 22) & 0xf;
-                /* Generate a conditional jump to next instruction.  */
-                arm_skip_unless(s, op);
-
-                /* offset[11:1] = insn[10:0] */
-                offset = (insn & 0x7ff) << 1;
-                /* offset[17:12] = insn[21:16].  */
-                offset |= (insn & 0x003f0000) >> 4;
-                /* offset[31:20] = insn[26].  */
-                offset |= ((int32_t)((insn << 5) & 0x80000000)) >> 11;
-                /* offset[18] = insn[13].  */
-                offset |= (insn & (1 << 13)) << 5;
-                /* offset[19] = insn[11].  */
-                offset |= (insn & (1 << 11)) << 8;
-
-                /* jump to the offset */
-                gen_jmp(s, s->pc_read + offset);
+                /* Conditional branch, in decodetree */
+                goto illegal_op;
             }
         } else {
             /*
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 8dee26d3b6..573ac2cf8e 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -21,3 +21,11 @@
 # All insns that have 0xf in insn[31:28] are decoded here.
 # All of those that have a COND field in insn[31:28] are in a32.decode
 #
+
+&i               !extern imm
+
+# Branch with Link and Exchange
+
+%imm24h          0:s24 24:1 !function=times_2
+
+BLX_i            1111 101 . ........................          &i imm=%imm24h
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 96c47aaf2a..f0f0f50c4e 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -520,3 +520,11 @@ SMMLSR           .... 0111 0101 .... .... .... 1111 ....      @rdamn
 
 STM              ---- 100 b:1 i:1 u:1 w:1 0 rn:4 list:16   &ldst_block
 LDM              ---- 100 b:1 i:1 u:1 w:1 1 rn:4 list:16   &ldst_block
+
+# Branch, branch with link
+
+%imm26           0:s24  !function=times_4
+@branch          ---- .... ........................           &i imm=%imm26
+
+B                .... 1010 ........................           @branch
+BL               .... 1011 ........................           @branch
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 3ab82c0962..ab7d7ba100 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -285,46 +285,54 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
 %msr_sysm        4:1 8:4
 %mrs_sysm        4:1 16:4
 %imm16_16_0      16:4 0:12
+%imm21           26:s1 11:1 13:1 16:6 0:11 !function=times_2
+&ci              cond imm
 
 {
+  # Group insn[25:23] = 111, which is cond=111x for the branch below,
+  # or unconditional, which would be illegal for the branch.
   {
-    YIELD        1111 0011 1010 1111 1000 0000 0000 0001
-    WFE          1111 0011 1010 1111 1000 0000 0000 0010
-    WFI          1111 0011 1010 1111 1000 0000 0000 0011
+    # Hints
+    {
+      YIELD      1111 0011 1010 1111 1000 0000 0000 0001
+      WFE        1111 0011 1010 1111 1000 0000 0000 0010
+      WFI        1111 0011 1010 1111 1000 0000 0000 0011
 
-    # TODO: Implement SEV, SEVL; may help SMP performance.
-    # SEV        1111 0011 1010 1111 1000 0000 0000 0100
-    # SEVL       1111 0011 1010 1111 1000 0000 0000 0101
+      # TODO: Implement SEV, SEVL; may help SMP performance.
+      # SEV      1111 0011 1010 1111 1000 0000 0000 0100
+      # SEVL     1111 0011 1010 1111 1000 0000 0000 0101
 
-    # The canonical nop ends in 0000 0000, but the whole rest
-    # of the space is "reserved hint, behaves as nop".
-    NOP          1111 0011 1010 1111 1000 0000 ---- ----
-  }
-  # Note that the v7m insn overlaps both the normal and banked insn.
-  {
-    MRS_bank     1111 0011 111 r:1 .... 1000 rd:4   001. 0000  \
+      # The canonical nop ends in 0000 0000, but the whole rest
+      # of the space is "reserved hint, behaves as nop".
+      NOP        1111 0011 1010 1111 1000 0000 ---- ----
+    }
+    # Note that the v7m insn overlaps both the normal and banked insn.
+    {
+      MRS_bank   1111 0011 111 r:1 .... 1000 rd:4   001. 0000  \
                  &mrs_bank sysm=%mrs_sysm
-    MRS_reg      1111 0011 111 r:1 1111 1000 rd:4   0000 0000  &mrs_reg
-    MRS_v7m      1111 0011 111 0   1111 1000 rd:4   sysm:8
-  }
-  {
-    MSR_bank     1111 0011 100 r:1 rn:4 1000 ....   001. 0000  \
+      MRS_reg    1111 0011 111 r:1 1111 1000 rd:4   0000 0000  &mrs_reg
+      MRS_v7m    1111 0011 111 0   1111 1000 rd:4   sysm:8
+    }
+    {
+      MSR_bank   1111 0011 100 r:1 rn:4 1000 ....   001. 0000  \
                  &msr_bank sysm=%msr_sysm
-    MSR_reg      1111 0011 100 r:1 rn:4 1000 mask:4 0000 0000  &msr_reg
-    MSR_v7m      1111 0011 100 0   rn:4 1000 mask:2 00 sysm:8
-  }
-  BXJ            1111 0011 1100 rm:4 1000 1111 0000 0000      &r
-  {
-    # At v6T2, this is the T5 encoding of SUBS PC, LR, #IMM, and works as for
-    # every other encoding of SUBS.  With v7VE, IMM=0 is redefined as ERET.
-    ERET         1111 0011 1101 1110 1000 1111 0000 0000
-    SUB_rri      1111 0011 1101 1110 1000 1111 imm:8          \
+      MSR_reg    1111 0011 100 r:1 rn:4 1000 mask:4 0000 0000  &msr_reg
+      MSR_v7m    1111 0011 100 0   rn:4 1000 mask:2 00 sysm:8
+    }
+    BXJ          1111 0011 1100 rm:4 1000 1111 0000 0000      &r
+    {
+      # At v6T2, this is the T5 encoding of SUBS PC, LR, #IMM, and works as for
+      # every other encoding of SUBS.  With v7VE, IMM=0 is redefined as ERET.
+      ERET       1111 0011 1101 1110 1000 1111 0000 0000
+      SUB_rri    1111 0011 1101 1110 1000 1111 imm:8          \
                  &s_rri_rot rot=0 s=1 rd=15 rn=14
-  }
-  SMC            1111 0111 1111 imm:4 1000 0000 0000 0000     &i
-  HVC            1111 0111 1110 .... 1000 .... .... ....      \
+    }
+    SMC          1111 0111 1111 imm:4 1000 0000 0000 0000     &i
+    HVC          1111 0111 1110 .... 1000 .... .... ....      \
                  &i imm=%imm16_16_0
-  UDF            1111 0111 1111 ---- 1010 ---- ---- ----
+    UDF          1111 0111 1111 ----  1010 ---- ---- ----
+  }
+  B_cond_thumb   1111 0. cond:4 ...... 10.0 ............      &ci imm=%imm21
 }
 
 # Load/store (register, immediate, literal)
@@ -573,3 +581,12 @@ STM              1110 1000 10.0 .... ................         @ldstm i=1 b=0
 STM              1110 1001 00.0 .... ................         @ldstm i=0 b=1
 LDM              1110 1000 10.1 .... ................         @ldstm i=1 b=0
 LDM              1110 1001 00.1 .... ................         @ldstm i=0 b=1
+
+# Branches
+
+%imm24           26:s1 13:1 11:1 16:10 0:11 !function=t32_branch24
+@branch24        ................................             &i imm=%imm24
+
+B                1111 0. .......... 10.1 ............         @branch24
+BL               1111 0. .......... 11.1 ............         @branch24
+BLX_i            1111 0. .......... 11.0 ............         @branch24
-- 
2.17.1


