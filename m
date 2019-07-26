Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC27C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD0121842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTYGwF+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD0121842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42433 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Sp-0003ka-SX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58000)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4N2-0003U0-Cc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mz-0008Nf-NL
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:07 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Ms-00081d-FA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:05 -0400
Received: by mail-pg1-x543.google.com with SMTP id u17so25110612pgi.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yeeH2D/Nsh9oAvCAiY/tPwxLxmb7stM68Oiu9y5meMM=;
 b=YTYGwF+pR7Ljd40OJHMptB6C2AK62uTb9fNiZMUNXgx1OxfnPs/VS4x/x0bAYdgKjk
 +WSzyaxlT6CiM/29cFZxOqLkGhqYFIkIo72hpyRyvbyd/L4YAnm6+BbnDVoEiL2dYj1N
 eetePY7PWshCWWxv9i5ud4uH5TsSAczA6T0cnpYKosnDF3h4sah1h2azvYlagij0i8Uy
 vUXnXhac3xquLb4VAZDtl5GadryG+PwAmhwc6T/yPZMo1sFgGv5PuUpyEXKLoW4jJIHi
 pt3M/GEPi5FFs17dzCqsXYTSB7mytqRBTAon19m+YRXH60ghPxqGVgmKcbsmcdnSD6ds
 PIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yeeH2D/Nsh9oAvCAiY/tPwxLxmb7stM68Oiu9y5meMM=;
 b=cQ++LI1zFHFI79Uy94vRzrMUBVUc2SBjz39UoeA9FSGBmdA9VxVqjjG7X5OfYsIMpK
 ++gD0BwBbuYV3BEOkF8hUrAzuHU4GSovog8AHYFndn7Jg4Rsx8hPNu7a+OaVRYK9L4x3
 PwD0T749lTb+095zLksuNzPKtsKXvquznhn2jQOaOJBH+XXZTK1oMto4zXheHt17wUyC
 YGaAqHf4XhHqip78ylMA3h9SxS28HbEac55PMjHVFLEa5BOLJC5SxlFFaXbNPO/Ry4nq
 7WCPcL4NQpJ1k0sxz7R9HAg1HkCPlZXm8SDLcXKP7TSQbX3QYYaI+9REcwMYL/AYpIW2
 xNoQ==
X-Gm-Message-State: APjAAAVuczhivrwHGRk2I4Uhkg2RMDAcbKzABkNwX/m+6ruXrHFYxJBJ
 xXSb0gqlDR8QjPcabgYBuFPuB5bhOdg=
X-Google-Smtp-Source: APXvYqyzINb9Ora3Xp430WlLRB9wdad1YG7GqowYVibNTcCii9bHB5HG7XoP0MkAMQpyjsdW3ghjSQ==
X-Received: by 2002:aa7:9481:: with SMTP id z1mr23635241pfk.92.1564163456219; 
 Fri, 26 Jul 2019 10:50:56 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:44 -0700
Message-Id: <20190726175032.6769-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 19/67] target/arm: Convert Cyclic Redundancy
 Check
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
 target/arm/translate.c | 121 +++++++++++++++++++----------------------
 target/arm/a32.decode  |   9 +++
 target/arm/t32.decode  |   7 +++
 3 files changed, 72 insertions(+), 65 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fa0c048b38..ed7041d0e4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8362,6 +8362,57 @@ static bool trans_MSR_imm(DisasContext *s, arg_MSR_imm *a)
     return true;
 }
 
+/*
+ * Cyclic Redundancy Check
+ */
+
+static bool op_crc32(DisasContext *s, arg_rrr *a, bool c, TCGMemOp sz)
+{
+    TCGv_i32 t1, t2, t3;
+
+    if (!dc_isar_feature(aa32_crc32, s)) {
+        return false;
+    }
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    switch (sz) {
+    case MO_8:
+        gen_uxtb(t2);
+        break;
+    case MO_16:
+        gen_uxth(t2);
+        break;
+    case MO_32:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    t3 = tcg_const_i32(1 << sz);
+    if (c) {
+        gen_helper_crc32c(t1, t1, t2, t3);
+    } else {
+        gen_helper_crc32(t1, t1, t2, t3);
+    }
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t3);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+#define DO_CRC32(NAME, c, sz) \
+static bool trans_##NAME(DisasContext *s, arg_rrr *a)  \
+    { return op_crc32(s, a, c, sz); }
+
+DO_CRC32(CRC32B, false, MO_8)
+DO_CRC32(CRC32H, false, MO_16)
+DO_CRC32(CRC32W, false, MO_32)
+DO_CRC32(CRC32CB, true, MO_8)
+DO_CRC32(CRC32CH, true, MO_16)
+DO_CRC32(CRC32CW, true, MO_32)
+
+#undef DO_CRC32
+
 /*
  * Miscellaneous instructions
  */
@@ -8774,39 +8825,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             gen_bx(s, tmp);
             break;
         case 0x4:
-        {
-            /* crc32/crc32c */
-            uint32_t c = extract32(insn, 8, 4);
-
-            /* Check this CPU supports ARMv8 CRC instructions.
-             * op1 == 3 is UNPREDICTABLE but handle as UNDEFINED.
-             * Bits 8, 10 and 11 should be zero.
-             */
-            if (!dc_isar_feature(aa32_crc32, s) || op1 == 0x3 || (c & 0xd) != 0) {
-                goto illegal_op;
-            }
-
-            rn = extract32(insn, 16, 4);
-            rd = extract32(insn, 12, 4);
-
-            tmp = load_reg(s, rn);
-            tmp2 = load_reg(s, rm);
-            if (op1 == 0) {
-                tcg_gen_andi_i32(tmp2, tmp2, 0xff);
-            } else if (op1 == 1) {
-                tcg_gen_andi_i32(tmp2, tmp2, 0xffff);
-            }
-            tmp3 = tcg_const_i32(1 << op1);
-            if (c & 0x2) {
-                gen_helper_crc32c(tmp, tmp, tmp2, tmp3);
-            } else {
-                gen_helper_crc32(tmp, tmp, tmp2, tmp3);
-            }
-            tcg_temp_free_i32(tmp2);
-            tcg_temp_free_i32(tmp3);
-            store_reg(s, rd, tmp);
-            break;
-        }
+            /* crc32 */
+            /* All done in decodetree.  Illegal ops reach here.  */
+            goto illegal_op;
         case 0x5:
             /* Saturating addition and subtraction.  */
             /* All done in decodetree.  Reach here for illegal ops.  */
@@ -10256,16 +10277,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         goto illegal_op;
                     }
                     break;
-                case 0x20: /* crc32/crc32c */
+                case 0x20: /* crc32/crc32c, in decodetree */
                 case 0x21:
                 case 0x22:
                 case 0x28:
                 case 0x29:
                 case 0x2a:
-                    if (!dc_isar_feature(aa32_crc32, s)) {
-                        goto illegal_op;
-                    }
-                    break;
+                    goto illegal_op;
                 default:
                     goto illegal_op;
                 }
@@ -10294,33 +10312,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 case 0x18: /* clz */
                     tcg_gen_clzi_i32(tmp, tmp, 32);
                     break;
-                case 0x20:
-                case 0x21:
-                case 0x22:
-                case 0x28:
-                case 0x29:
-                case 0x2a:
-                {
-                    /* crc32/crc32c */
-                    uint32_t sz = op & 0x3;
-                    uint32_t c = op & 0x8;
-
-                    tmp2 = load_reg(s, rm);
-                    if (sz == 0) {
-                        tcg_gen_andi_i32(tmp2, tmp2, 0xff);
-                    } else if (sz == 1) {
-                        tcg_gen_andi_i32(tmp2, tmp2, 0xffff);
-                    }
-                    tmp3 = tcg_const_i32(1 << sz);
-                    if (c) {
-                        gen_helper_crc32c(tmp, tmp, tmp2, tmp3);
-                    } else {
-                        gen_helper_crc32(tmp, tmp, tmp2, tmp3);
-                    }
-                    tcg_temp_free_i32(tmp2);
-                    tcg_temp_free_i32(tmp3);
-                    break;
-                }
                 default:
                     g_assert_not_reached();
                 }
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 50449fa8ec..5751e615cd 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -182,6 +182,15 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
 }
 MSR_imm          .... 0011 0110 .... 1111 .... .... ....      @msr_i r=1
 
+# Cyclic Redundancy Check
+
+CRC32B           .... 0001 0000 .... .... 0000 0100 ....      @rndm
+CRC32H           .... 0001 0010 .... .... 0000 0100 ....      @rndm
+CRC32W           .... 0001 0100 .... .... 0000 0100 ....      @rndm
+CRC32CB          .... 0001 0000 .... .... 0010 0100 ....      @rndm
+CRC32CH          .... 0001 0010 .... .... 0010 0100 ....      @rndm
+CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
+
 # Miscellaneous instructions
 
 %sysm            8:1 16:4
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 40a2c520c1..30971787d4 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -172,6 +172,13 @@ QSUB             1111 1010 1000 .... 1111 .... 1010 ....      @rndm
 QDADD            1111 1010 1000 .... 1111 .... 1001 ....      @rndm
 QDSUB            1111 1010 1000 .... 1111 .... 1011 ....      @rndm
 
+CRC32B           1111 1010 1100 .... 1111 .... 1000 ....      @rndm
+CRC32H           1111 1010 1100 .... 1111 .... 1001 ....      @rndm
+CRC32W           1111 1010 1100 .... 1111 .... 1010 ....      @rndm
+CRC32CB          1111 1010 1101 .... 1111 .... 1000 ....      @rndm
+CRC32CH          1111 1010 1101 .... 1111 .... 1001 ....      @rndm
+CRC32CW          1111 1010 1101 .... 1111 .... 1010 ....      @rndm
+
 # Branches and miscellaneous control
 
 %msr_sysm        4:1 8:4
-- 
2.17.1


