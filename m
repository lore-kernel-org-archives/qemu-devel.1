Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB492053B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIZQrwjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB492053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33ZU-0006G1-DL
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fy-0003H6-7r
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fw-0008RD-Jv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:22 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fw-0008Qf-DJ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:20 -0400
Received: by mail-pg1-x543.google.com with SMTP id w10so216880pgj.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4BlHSKKgCoxdyyhEVII1opm34EFeT9rrl5mK0jjuq2M=;
 b=dIZQrwjTiTx3SgRVTJH6mdPA656tRn1XAECyK8OETWjgX/qUooFw5ZDQuExf4DWy+Q
 O7uAlZBLKivbgGj12tFuvEEIqt0QVWTAwtsrs0Jgb5ZyE6zXf6MeznN6BXUIcJshBRcU
 6WbL5Z5hTMXfBodpynZUp6xN8zoWPoy1Y7OP97YkL1EmM5nYmibpZ2X3XAwprHZPj5Eq
 GXOWs2wH81oviaF6/DFlrkWv50t9XGQPA50Lq60X3sd5NuPK02uxwDi9Bu8bCPF9hNrw
 jaZOaW9npr3/lR2lDwLRVN7Vs9Hkmwu0fq70/qATGN8Zp/riTWFQRJYZRN1ficm5IpoZ
 pozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4BlHSKKgCoxdyyhEVII1opm34EFeT9rrl5mK0jjuq2M=;
 b=Cvl6QCXTX3qJjQ20gsyTM96qGsqtMvxzVyEHpdO6UQXcG2kVz/t+BB6/ab2un2t62w
 ArJcEO2WJZVx+fx9oSb/flHNs4czliohW/BWojIWy3D/56Rfk1pHHzfINHMcFj/8r4cT
 eHiLTJ9//w7TlZIGk8MZ4euWo/14iKcJKX3pgHVFFa1DR7UWEvKz6vSrq182jijxTvH1
 WBf1BDVSYVtniNT8NJk5Y9NIZIeT1bbbXQf9uSol9R7ykbD9f9odsu/ds3qvE9Vo8tDA
 iMCzBODAiuBG12r8Qrmvp7G8Y8oTN9rJYBTettMiTLhgfLfedfgl3VfTgxivLYKtKFoH
 eLpQ==
X-Gm-Message-State: APjAAAVGS2KbLRC53sjbH90pf05OeAOw26QmcRx8I9FvTwWNl3kQxkoP
 FbZeMQr3DFvnLF10R2AAI/VaaA2uspM=
X-Google-Smtp-Source: APXvYqxKHDSXXYpv3YJuY7m7kVqRAxmPZ39mVcI5otPpjd4OurkWhPc62CkvHWi+lrSHibO1nq4gkw==
X-Received: by 2002:aa7:908b:: with SMTP id i11mr4165351pfa.199.1567019119118; 
 Wed, 28 Aug 2019 12:05:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:02 -0700
Message-Id: <20190828190456.30315-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 15/69] target/arm: Convert BX, BXJ,
 BLX (register)
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
 target/arm/translate.c | 78 ++++++++++++++++++++----------------------
 target/arm/a32.decode  |  7 ++++
 target/arm/t32.decode  |  2 ++
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c2420ff45e..d60e859624 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8432,6 +8432,38 @@ static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
     return true;
 }
 
+static bool trans_BX(DisasContext *s, arg_BX *a)
+{
+    if (!ENABLE_ARCH_4T) {
+        return false;
+    }
+    gen_bx(s, load_reg(s, a->rm));
+    return true;
+}
+
+static bool trans_BXJ(DisasContext *s, arg_BXJ *a)
+{
+    if (!ENABLE_ARCH_5J || arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    /* Trivial implementation equivalent to bx.  */
+    gen_bx(s, load_reg(s, a->rm));
+    return true;
+}
+
+static bool trans_BLX_r(DisasContext *s, arg_BLX_r *a)
+{
+    TCGv_i32 tmp;
+
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    tmp = load_reg(s, a->rm);
+    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | s->thumb);
+    gen_bx(s, tmp);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8721,12 +8753,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* All done in decodetree.  Illegal ops already signalled.  */
             g_assert_not_reached();
         case 0x1:
-            if (op1 == 1) {
-                /* branch/exchange thumb (bx).  */
-                ARCH(4T);
-                tmp = load_reg(s, rm);
-                gen_bx(s, tmp);
-            } else if (op1 == 3) {
+            if (op1 == 3) {
                 /* clz */
                 ARCH(5);
                 rd = (insn >> 12) & 0xf;
@@ -8737,30 +8764,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 goto illegal_op;
             }
             break;
-        case 0x2:
-            if (op1 == 1) {
-                ARCH(5J); /* bxj */
-                /* Trivial implementation equivalent to bx.  */
-                tmp = load_reg(s, rm);
-                gen_bx(s, tmp);
-            } else {
-                goto illegal_op;
-            }
-            break;
-        case 0x3:
-            if (op1 != 1)
-              goto illegal_op;
-
-            ARCH(5);
-            /* branch link/exchange thumb (blx) */
-            tmp = load_reg(s, rm);
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->base.pc_next);
-            store_reg(s, 14, tmp2);
-            gen_bx(s, tmp);
-            break;
-        case 0x4:
-            /* crc32 */
+        case 0x2: /* bxj */
+        case 0x3: /* blx */
+        case 0x4: /* crc32 */
             /* All done in decodetree.  Illegal ops reach here.  */
             goto illegal_op;
         case 0x5:
@@ -10578,16 +10584,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                             goto illegal_op;
                         }
                         break;
-                    case 4: /* bxj */
-                        /* Trivial implementation equivalent to bx.
-                         * This instruction doesn't exist at all for M-profile.
-                         */
-                        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                            goto illegal_op;
-                        }
-                        tmp = load_reg(s, rn);
-                        gen_bx(s, tmp);
-                        break;
+                    case 4: /* bxj, in decodetree */
+                        goto illegal_op;
                     case 5: /* Exception return.  */
                         if (IS_USER(s)) {
                             goto illegal_op;
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index a8ef435b15..6cb9c16e2f 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -29,6 +29,7 @@
 &s_rrrr          s rd rn rm ra
 &rrrr            rd rn rm ra
 &rrr             rd rn rm
+&r               rm
 &msr_reg         rn r mask
 &mrs_reg         rd r
 &msr_bank        rn r sysm
@@ -195,8 +196,14 @@ CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
 
 %sysm            8:1 16:4
 
+@rm              ---- .... .... .... .... .... .... rm:4      &r
+
 MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
 MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
 
 MRS_reg          ---- 0001 0 r:1 00 1111   rd:4 0000 0000 0000  &mrs_reg
 MSR_reg          ---- 0001 0 r:1 10 mask:4 1111 0000 0000 rn:4  &msr_reg
+
+BX               .... 0001 0010 1111 1111 1111 0001 ....      @rm
+BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
+BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 261db100ff..337706ebbe 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -26,6 +26,7 @@
 &s_rrrr          !extern s rd rn rm ra
 &rrrr            !extern rd rn rm ra
 &rrr             !extern rd rn rm
+&r               !extern rm
 &msr_reg         !extern rn r mask
 &mrs_reg         !extern rd r
 &msr_bank        !extern rn r sysm
@@ -211,4 +212,5 @@ CRC32CW          1111 1010 1101 .... 1111 .... 1010 ....      @rndm
     MSR_reg      1111 0011 100 r:1 rn:4 1000 mask:4 0000 0000  &msr_reg
     MSR_v7m      1111 0011 100 0   rn:4 1000 mask:2 00 sysm:8
   }
+  BXJ            1111 0011 1100 rm:4 1000 1111 0000 0000      &r
 }
-- 
2.17.1


