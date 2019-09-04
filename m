Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85321C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC9D21883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAdwaEa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC9D21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bSH-0002VU-Ac
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0O-00050O-ON
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0K-0002dF-6K
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:48 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:42288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0J-0002c1-OO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:43 -0400
Received: by mail-pg1-x531.google.com with SMTP id p3so11767158pgb.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ctDcPeje2HRWgMe1VT5hCwuGlGkqYpgPECSd4XI9r2U=;
 b=hAdwaEa5el4i2o3bqPrNHFBJyTwXkxQEO0dIXUA2klF0fGkyV4ChEQ7m0OwLffNmBc
 IDMlhu9qmJfKFTNU4VPNDRmKXzPkRYGuTtRV+utGtKhl4SmzoSWinhxstj9C7IOQ/l73
 AJNNjDnVf3pkvQ69xueMAzV0VLeVtJSWi6IaLhJjbZ+hkdw16hc/OlOVn4MuQzyUbvBo
 7Ha4x3IuXWJXz9+3DYdyaqTe7ql343O6j9IXGGSqOtxaEkRKSVP01sGqJ7Q3SxtEZ121
 34bfHPpfXKIyGiFfABTpEpiMrvEHtVo34V4tpJH0qBbogQYYfdST41N0Pln3+g6khotM
 Oy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ctDcPeje2HRWgMe1VT5hCwuGlGkqYpgPECSd4XI9r2U=;
 b=CiOc+19Zbb/csa0vsLe4t/XEm54KG9t7tAw4pINVIOY9RHvQJxtigzXt8hsRemnM7f
 7UHOz19VMpbC+zZjKK6toCUplmAszudeGGO/RRwdWg1QrsknyNB9SLTPCQSiLmHM/T/4
 oeVHmmRbze0v6oBGCKsvOsAYwvE+gDFEZmsDPV0/BXsOoFCcQfo6V6LR3CL6Gid+uC5a
 lN1H6/cPh+Ol/lALVTHJT3UqIwGXEtxiBuRBeCHQHc11uwTeAJxlVyim/skMzjr6Y3Pq
 25euIFPz5gUlS/V7hatMn7GEQjZcR+IVTGVOj8xNXK+TtV/vBXzVPkGeKgoLN/9OOXgq
 yXjw==
X-Gm-Message-State: APjAAAU/OFJl1L7SACyX8tzos7mbsNE3mXCi0Tw/Z37ygGRe9k7DfWs6
 TesoQYB1h0ruBqorHbEQyMz7SddOQJ8=
X-Google-Smtp-Source: APXvYqzV7gmRYYUaRUJywbYsDZCtxZGKJp9ZqBwNloI2tNnijXKNG5AkI8NJIwTVQjjROCyLjS21hg==
X-Received: by 2002:a63:6f8f:: with SMTP id k137mr36322906pgc.90.1567625502117; 
 Wed, 04 Sep 2019 12:31:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:22 -0700
Message-Id: <20190904193059.26202-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
Subject: [Qemu-devel] [PATCH v4 32/69] target/arm: Convert B, BL,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 133 +++++++++++++++--------------------
 target/arm/a32-uncond.decode |   8 +++
 target/arm/a32.decode        |   8 +++
 target/arm/t32.decode        |  81 ++++++++++++---------
 4 files changed, 123 insertions(+), 107 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d0fc916ff9..72e4708e61 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7545,6 +7545,14 @@ static int t32_expandimm_imm(DisasContext *s, int x)
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
  */
@@ -10030,13 +10038,56 @@ static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
     return do_ldm(s, a, 2);
 }
 
+/*
+ * Branch, branch with link
+ */
+
+static bool trans_B(DisasContext *s, arg_i *a)
+{
+    gen_jmp(s, read_pc(s) + a->imm);
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
+        unallocated_encoding(s);
+        return true;
+    }
+    arm_skip_unless(s, a->cond);
+    gen_jmp(s, read_pc(s) + a->imm);
+    return true;
+}
+
+static bool trans_BL(DisasContext *s, arg_i *a)
+{
+    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | s->thumb);
+    gen_jmp(s, read_pc(s) + a->imm);
+    return true;
+}
+
+static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
+{
+    /* For A32, ARCH(5) is checked near the start of the uncond block. */
+    if (s->thumb && (a->imm & 2)) {
+        return false;
+    }
+    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | s->thumb);
+    gen_bx_im(s, (read_pc(s) & ~3) + a->imm + !s->thumb);
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
@@ -10204,21 +10255,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             gen_rfe(s, tmp, tmp2);
             return;
-        } else if ((insn & 0x0e000000) == 0x0a000000) {
-            /* branch link and change to thumb (blx <offset>) */
-            int32_t offset;
-
-            tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, s->base.pc_next);
-            store_reg(s, 14, tmp);
-            /* Sign-extend the 24-bit offset */
-            offset = (((int32_t)insn) << 8) >> 8;
-            val = read_pc(s);
-            /* offset * 4 + bit24 * 2 + (thumb bit) */
-            val += (offset << 2) | ((insn >> 23) & 2) | 1;
-            /* protected by ARCH(5); above, near the start of uncond block */
-            gen_bx_im(s, val);
-            return;
         } else if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -10310,23 +10346,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
-                    tcg_gen_movi_i32(tmp, s->base.pc_next);
-                    store_reg(s, 14, tmp);
-                }
-                offset = sextract32(insn << 2, 0, 26);
-                gen_jmp(s, read_pc(s) + offset);
-            }
-            break;
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
         case 0xc:
         case 0xd:
         case 0xe:
@@ -10693,32 +10716,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
-                    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
-                }
-
-                offset += read_pc(s);
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
@@ -10804,24 +10803,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
-                gen_jmp(s, read_pc(s) + offset);
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
index 1267a689e2..62c6f8562e 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -520,3 +520,11 @@ SMMLSR           .... 0111 0101 .... .... .... 1111 ....      @rdamn
 
 STM              ---- 100 b:1 i:1 u:1 w:1 0 rn:4 list:16   &ldst_block
 LDM_a32          ---- 100 b:1 i:1 u:1 w:1 1 rn:4 list:16   &ldst_block
+
+# Branch, branch with link
+
+%imm26           0:s24  !function=times_4
+@branch          ---- .... ........................           &i imm=%imm26
+
+B                .... 1010 ........................           @branch
+BL               .... 1011 ........................           @branch
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index f1e2b934f8..ebc92f2c28 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -284,47 +284,55 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
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
-    # The distinction between the two only matters for Hyp mode.
-    ERET         1111 0011 1101 1110 1000 1111 0000 0000
-    SUB_rri      1111 0011 1101 1110 1000 1111 imm:8 \
+      MSR_reg    1111 0011 100 r:1 rn:4 1000 mask:4 0000 0000  &msr_reg
+      MSR_v7m    1111 0011 100 0   rn:4 1000 mask:2 00 sysm:8
+    }
+    BXJ          1111 0011 1100 rm:4 1000 1111 0000 0000      &r
+    {
+      # At v6T2, this is the T5 encoding of SUBS PC, LR, #IMM, and works as for
+      # every other encoding of SUBS.  With v7VE, IMM=0 is redefined as ERET.
+      # The distinction between the two only matters for Hyp mode.
+      ERET       1111 0011 1101 1110 1000 1111 0000 0000
+      SUB_rri    1111 0011 1101 1110 1000 1111 imm:8 \
                  &s_rri_rot rot=0 s=1 rd=15 rn=14
-  }
-  SMC            1111 0111 1111 imm:4 1000 0000 0000 0000     &i
-  HVC            1111 0111 1110 ....  1000 .... .... ....     \
+    }
+    SMC          1111 0111 1111 imm:4 1000 0000 0000 0000     &i
+    HVC          1111 0111 1110 ....  1000 .... .... ....     \
                  &i imm=%imm16_16_0
-  UDF            1111 0111 1111 ---- 1010 ---- ---- ----
+    UDF          1111 0111 1111 ----  1010 ---- ---- ----
+  }
+  B_cond_thumb   1111 0. cond:4 ...... 10.0 ............      &ci imm=%imm21
 }
 
 # Load/store (register, immediate, literal)
@@ -573,3 +581,12 @@ STM_t32          1110 1000 10.0 .... ................         @ldstm i=1 b=0
 STM_t32          1110 1001 00.0 .... ................         @ldstm i=0 b=1
 LDM_t32          1110 1000 10.1 .... ................         @ldstm i=1 b=0
 LDM_t32          1110 1001 00.1 .... ................         @ldstm i=0 b=1
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


