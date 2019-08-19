Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A49CC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2291D214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uubnh2nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2291D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpte-0006Dn-Sn
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMQ-0002Fw-8l
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMO-0006RW-MP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMO-0006R9-Gk
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:40 -0400
Received: by mail-pf1-x441.google.com with SMTP id w16so1944043pfn.7
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MYM8dYqYPl4eqxjsUKYjeBmOOKaa2+t2xb+fej5q23g=;
 b=uubnh2nnslDD4Dn/VjckXQhvv20xcu4vVoTR0Rl15Vf1QQPPLibQOk5/FCa4PFZ5lI
 AXoHtsVsKRtjaQ3816MGgTBIgPc9sispVcSN4LL2k+dY8hJ8iE2IYzLuJN+Cvxl9cXW7
 hbQxWW63KjDfbZTvZhCxCVoaHoZa82nFClbtbIVFwzk+zALie1YIdKOMvGdwTUSdpD7y
 +L8Pk9VV/9r9bwNeA95XzK5K8zHVf1TXmN221+j0xEoB8+H7tH/vtrfkbI3VrsU3SIYS
 OquS4eY7tMCSVbIOhWeb/XbHBo65DovhA2D3iYIagJnET0Kf/Xg42h5ycZFS4XCTOxmr
 qz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MYM8dYqYPl4eqxjsUKYjeBmOOKaa2+t2xb+fej5q23g=;
 b=CfQF3CRXCGHdUkj7WT0jV+Bd0b83/1Rcqv/+FRKWUSrTORyWUBYva0UiWWnmK6fzWQ
 qfw3hkNqzW9l2/WBPyqGZdr+9V+5RhZzM9jOYkJIE+4uX0oYcFWI8Hx/Z4x8QBQ4exWK
 t2Rx8oYLfb6bPqk5wmUss5yi4Mig6Kx1vKI4yp1339OEh1CBcImPRRjBE4I7fnC2JLvr
 YajsnwKsGslHAtLQ9oOnKqmV4SJDY+wLegmaoZa+T5UsFT2Ftxa7t3hOkpVrpyDSnX8B
 FrddNttgkkBeJ3K8zgbLh6IUgktjNKZJftNEIT7WaGvxfcLGO1z1wRKVwrnjeXRxls1o
 YHZg==
X-Gm-Message-State: APjAAAUnN1dv0ipu/Nno2oYTyW4cGGZgd6ez6uoSQGubG44YGKMNq3eA
 oDu/Nt4aFkgUBV5dHE95w51PXmHsQNA=
X-Google-Smtp-Source: APXvYqzcWvdSC5XaTyyNDuZbVCilCF7CeTd5a5C12GZutOrv57i4e+P3k7AWqXfluReQ058ufTvrhQ==
X-Received: by 2002:a62:4ed1:: with SMTP id
 c200mr26227581pfb.218.1566250719254; 
 Mon, 19 Aug 2019 14:38:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:21 -0700
Message-Id: <20190819213755.26175-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 34/68] target/arm: Convert Clear-Exclusive,
 Barriers
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 122 +++++++++++++++--------------------
 target/arm/a32-uncond.decode |  10 +++
 target/arm/t32.decode        |  10 +++
 3 files changed, 73 insertions(+), 69 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e268c5168d..6489bbc09c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10038,6 +10038,58 @@ static bool trans_SRS(DisasContext *s, arg_SRS *a)
     return true;
 }
 
+/*
+ * Clear-Exclusive, Barriers
+ */
+
+static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
+{
+    if (!ENABLE_ARCH_6K) {
+        return false;
+    }
+    gen_clrex(s);
+    return true;
+}
+
+static bool trans_DSB(DisasContext *s, arg_DSB *a)
+{
+    if (!s->thumb && !ENABLE_ARCH_7) {
+        return false;
+    }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    return true;
+}
+
+static bool trans_DMB(DisasContext *s, arg_DMB *a)
+{
+    return trans_DSB(s, NULL);
+}
+
+static bool trans_ISB(DisasContext *s, arg_ISB *a)
+{
+    /*
+     * We need to break the TB after this insn to execute
+     * self-modifying code correctly and also to take
+     * any pending interrupts immediately.
+     */
+    gen_goto_tb(s, 0, s->base.pc_next);
+    return true;
+}
+
+static bool trans_SB(DisasContext *s, arg_SB *a)
+{
+    if (!dc_isar_feature(aa32_sb, s)) {
+        return false;
+    }
+    /*
+     * TODO: There is no speculation barrier opcode
+     * for TCG; MB and end the TB instead.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    gen_goto_tb(s, 0, s->base.pc_next);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10131,38 +10183,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 s->base.is_jmp = DISAS_UPDATE;
             }
             return;
-        } else if ((insn & 0x0fffff00) == 0x057ff000) {
-            switch ((insn >> 4) & 0xf) {
-            case 1: /* clrex */
-                ARCH(6K);
-                gen_clrex(s);
-                return;
-            case 4: /* dsb */
-            case 5: /* dmb */
-                ARCH(7);
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                return;
-            case 6: /* isb */
-                /* We need to break the TB after this insn to execute
-                 * self-modifying code correctly and also to take
-                 * any pending interrupts immediately.
-                 */
-                gen_goto_tb(s, 0, s->base.pc_next);
-                return;
-            case 7: /* sb */
-                if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
-                    goto illegal_op;
-                }
-                /*
-                 * TODO: There is no speculation barrier opcode
-                 * for TCG; MB and end the TB instead.
-                 */
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                gen_goto_tb(s, 0, s->base.pc_next);
-                return;
-            default:
-                goto illegal_op;
-            }
         } else if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -10623,43 +10643,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                             gen_set_psr_im(s, offset, 0, imm);
                         }
                         break;
-                    case 3: /* Special control operations.  */
-                        if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
-                            !arm_dc_feature(s, ARM_FEATURE_M)) {
-                            goto illegal_op;
-                        }
-                        op = (insn >> 4) & 0xf;
-                        switch (op) {
-                        case 2: /* clrex */
-                            gen_clrex(s);
-                            break;
-                        case 4: /* dsb */
-                        case 5: /* dmb */
-                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                            break;
-                        case 6: /* isb */
-                            /* We need to break the TB after this insn
-                             * to execute self-modifying code correctly
-                             * and also to take any pending interrupts
-                             * immediately.
-                             */
-                            gen_goto_tb(s, 0, s->base.pc_next);
-                            break;
-                        case 7: /* sb */
-                            if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
-                                goto illegal_op;
-                            }
-                            /*
-                             * TODO: There is no speculation barrier opcode
-                             * for TCG; MB and end the TB instead.
-                             */
-                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                            gen_goto_tb(s, 0, s->base.pc_next);
-                            break;
-                        default:
-                            goto illegal_op;
-                        }
-                        break;
+                    case 3: /* Special control operations, in decodetree */
                     case 4: /* bxj, in decodetree */
                         goto illegal_op;
                     case 5: /* Exception return.  */
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 3b961233e5..b077958cec 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -22,6 +22,7 @@
 # All of those that have a COND field in insn[31:28] are in a32.decode
 #
 
+&empty           !extern
 &i               !extern imm
 
 # Branch with Link and Exchange
@@ -37,3 +38,12 @@ BLX_i            1111 101 . ........................          &i imm=%imm24h
 
 RFE              1111 100 pu:2 0 w:1 1 rn:4 0000 1010 0000 0000   &rfe
 SRS              1111 110 pu:2 1 w:1 0 1101 0000 0101 000 mode:5  &srs
+
+# Clear-Exclusive, Barriers
+
+# QEMU does not require the option field for the barriers.
+CLREX            1111 0101 0111 1111 1111 0000 0001 1111
+DSB              1111 0101 0111 1111 1111 0000 0100 ----
+DMB              1111 0101 0111 1111 1111 0000 0101 ----
+ISB              1111 0101 0111 1111 1111 0000 0110 ----
+SB               1111 0101 0111 1111 1111 0000 0111 0000
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index c8a8aeceee..18c268e712 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -305,6 +305,16 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
       # of the space is "reserved hint, behaves as nop".
       NOP        1111 0011 1010 1111 1000 0000 ---- ----
     }
+
+    # Miscelaneous control
+    {
+      CLREX      1111 0011 1011 1111 1000 1111 0010 1111
+      DSB        1111 0011 1011 1111 1000 1111 0100 ----
+      DMB        1111 0011 1011 1111 1000 1111 0101 ----
+      ISB        1111 0011 1011 1111 1000 1111 0110 ----
+      SB         1111 0011 1011 1111 1000 1111 0111 0000
+    }
+
     # Note that the v7m insn overlaps both the normal and banked insn.
     {
       MRS_bank   1111 0011 111 r:1 .... 1000 rd:4   001. 0000  \
-- 
2.17.1


