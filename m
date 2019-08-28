Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F9C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F18208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBgsO1/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F18208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33cs-0001hr-6p
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G4-0003Qd-G8
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G1-0008Vc-6B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33G0-0008U0-O1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:24 -0400
Received: by mail-pg1-x541.google.com with SMTP id p3so210587pgb.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M4p7h/i/Z1XZ25OuZSRZK70uUr5w+EGNQy0NQKl5v38=;
 b=DBgsO1/xWzgPpKNvrbG+YB3HQ4JL62aYAPH+viDgSpAf8VLn0Hmybnp7Q4hGMd2R1d
 Vy1kibEJdR9rtiKYrkr3iD9xBEuT0RAv1Z8VGUUEidmeSdEgy8HhYlvX6EvMKt4xCWTI
 md5hSQIOwO9c3wAc4bA4gEWKBqEt31AQM3miIANLGY24Kt7Vc97ecx/xVtBUYpTsYfCl
 +jwHKBt5opkh2vvacJ/xg1ic+++cPUKUFWG4/MQ1EHQxaZL8UifQV2GxHtL8uO60JZhr
 C8Hwh9v42qHzLEat7EoFdrfs2f3zsJhZrccGTjdkv667+xWJHY3KG3D8Odf58lRP68xk
 TVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M4p7h/i/Z1XZ25OuZSRZK70uUr5w+EGNQy0NQKl5v38=;
 b=A0+Cj6jgSBqk1wD3gDqU7OUF2p5/zfD688ky/cQV2VkqZFVXfBIFvN6NqT3q+W7j4L
 Q459fN1tMIONu8l+3HZRgOdjQTH9C+Hxn4D7237plHOb+/EIMu1qWyyS4Zmf0VCA7Yaj
 LjzLnvXj4vQN8dKAVh+tV3is2KmnzUpA5RWyXvmnviwDC1fJrqrciZ1O3rroEX7i4snG
 FPaUzErzapW1ETNgvUlxOlodZtZXavg3p9pDooYDCo1oH3A3NFNoZ06O0QC+xiSX75en
 arUz91ubDWcr7Qtoh32Rpn+lWMv+tH+yCYY3ablhpwwFY6eYZZ5LochHK8Lrhbp4rYwK
 xX9Q==
X-Gm-Message-State: APjAAAUWEVbtFNHEeOFYitWHe3Zja5DWaEB5OOsR86hgBd8Kk9YfnqMm
 bBrOXxY4EsL8RVhgX5vXG3nVd7vkSW4=
X-Google-Smtp-Source: APXvYqzN+e/5c+9N5Wjrn6GgzH99rmyRWRjKrMDuWtoDykAaACpqHMnbOo0okSJg0HOx8EmVB1thfQ==
X-Received: by 2002:a63:2043:: with SMTP id r3mr4797328pgm.311.1567019123045; 
 Wed, 28 Aug 2019 12:05:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:05 -0700
Message-Id: <20190828190456.30315-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 18/69] target/arm: Convert the rest of A32
 Miscelaneous instructions
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
v3: Call unallocated_encoding for IS_USER.
---
 target/arm/translate.c | 127 +++++++++++++++--------------------------
 target/arm/a32.decode  |   8 +++
 target/arm/t32.decode  |   5 ++
 3 files changed, 58 insertions(+), 82 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 203b6160da..ad4b3c55c6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8498,6 +8498,47 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
     return true;
 }
 
+static bool trans_HLT(DisasContext *s, arg_HLT *a)
+{
+    gen_hlt(s, a->imm);
+    return true;
+}
+
+static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
+{
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+    return true;
+}
+
+static bool trans_HVC(DisasContext *s, arg_HVC *a)
+{
+    if (!ENABLE_ARCH_7 || arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    if (IS_USER(s)) {
+        unallocated_encoding(s);
+    } else {
+        gen_hvc(s, a->imm);
+    }
+    return true;
+}
+
+static bool trans_SMC(DisasContext *s, arg_SMC *a)
+{
+    if (!ENABLE_ARCH_6K || arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    if (IS_USER(s)) {
+        unallocated_encoding(s);
+    } else {
+        gen_smc(s);
+    }
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8778,68 +8819,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     } else if ((insn & 0x0f900000) == 0x01000000
                && (insn & 0x00000090) != 0x00000090) {
         /* miscellaneous instructions */
-        op1 = (insn >> 21) & 3;
-        sh = (insn >> 4) & 0xf;
-        rm = insn & 0xf;
-        switch (sh) {
-        case 0x0:
-            /* MSR/MRS (banked/register) */
-            /* All done in decodetree.  Illegal ops already signalled.  */
-            g_assert_not_reached();
-        case 0x1: /* bx, clz */
-        case 0x2: /* bxj */
-        case 0x3: /* blx */
-        case 0x4: /* crc32 */
-            /* All done in decodetree.  Illegal ops reach here.  */
-            goto illegal_op;
-        case 0x5: /* Saturating addition and subtraction.  */
-        case 0x6: /* ERET */
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
-        case 7:
-        {
-            int imm16 = extract32(insn, 0, 4) | (extract32(insn, 8, 12) << 4);
-            switch (op1) {
-            case 0:
-                /* HLT */
-                gen_hlt(s, imm16);
-                break;
-            case 1:
-                /* bkpt */
-                ARCH(5);
-                gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm16, false));
-                break;
-            case 2:
-                /* Hypervisor call (v7) */
-                ARCH(7);
-                if (IS_USER(s)) {
-                    goto illegal_op;
-                }
-                gen_hvc(s, imm16);
-                break;
-            case 3:
-                /* Secure monitor call (v6+) */
-                ARCH(6K);
-                if (IS_USER(s)) {
-                    goto illegal_op;
-                }
-                gen_smc(s);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            break;
-        }
-        case 0x8:
-        case 0xa:
-        case 0xc:
-        case 0xe:
-            /* Halfword multiply and multiply accumulate.  */
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
-        default:
-            goto illegal_op;
-        }
+        /* All done in decodetree.  Illegal ops reach here.  */
+        goto illegal_op;
     } else if (((insn & 0x0e000000) == 0 &&
                 (insn & 0x00000090) != 0x90) ||
                ((insn & 0x0e000000) == (1 << 25))) {
@@ -10497,26 +10478,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     goto illegal_op;
 
                 if (insn & (1 << 26)) {
-                    if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                        goto illegal_op;
-                    }
-                    if (!(insn & (1 << 20))) {
-                        /* Hypervisor call (v7) */
-                        int imm16 = extract32(insn, 16, 4) << 12
-                            | extract32(insn, 0, 12);
-                        ARCH(7);
-                        if (IS_USER(s)) {
-                            goto illegal_op;
-                        }
-                        gen_hvc(s, imm16);
-                    } else {
-                        /* Secure monitor call (v6+) */
-                        ARCH(6K);
-                        if (IS_USER(s)) {
-                            goto illegal_op;
-                        }
-                        gen_smc(s);
-                    }
+                    /* hvc, smc, in decodetree */
+                    goto illegal_op;
                 } else {
                     op = (insn >> 20) & 7;
                     switch (op) {
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 52a66dd1d5..c7f156be6d 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -31,6 +31,7 @@
 &rrr             rd rn rm
 &rr              rd rm
 &r               rm
+&i               imm
 &msr_reg         rn r mask
 &mrs_reg         rd r
 &msr_bank        rn r sysm
@@ -196,9 +197,11 @@ CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
 # Miscellaneous instructions
 
 %sysm            8:1 16:4
+%imm16_8_0       8:12 0:4
 
 @rm              ---- .... .... .... .... .... .... rm:4      &r
 @rdm             ---- .... .... .... rd:4 .... .... rm:4      &rr
+@i16             ---- .... .... .... .... .... .... ....      &i imm=%imm16_8_0
 
 MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
 MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
@@ -213,3 +216,8 @@ BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
 CLZ              .... 0001 0110 1111 .... 1111 0001 ....      @rdm
 
 ERET             ---- 0001 0110 0000 0000 0000 0110 1110
+
+HLT              .... 0001 0000 .... .... .... 0111 ....      @i16
+BKPT             .... 0001 0010 .... .... .... 0111 ....      @i16
+HVC              .... 0001 0100 .... .... .... 0111 ....      @i16
+SMC              ---- 0001 0110 0000 0000 0000 0111 imm:4     &i
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 6236d28b99..5116c6165a 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -28,6 +28,7 @@
 &rrr             !extern rd rn rm
 &rr              !extern rd rm
 &r               !extern rm
+&i               !extern imm
 &msr_reg         !extern rn r mask
 &mrs_reg         !extern rd r
 &msr_bank        !extern rn r sysm
@@ -189,6 +190,7 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
 
 %msr_sysm        4:1 8:4
 %mrs_sysm        4:1 16:4
+%imm16_16_0      16:4 0:12
 
 {
   {
@@ -226,4 +228,7 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
     SUB_rri      1111 0011 1101 1110 1000 1111 imm:8 \
                  &s_rri_rot rot=0 s=1 rd=15 rn=14
   }
+  SMC            1111 0111 1111 imm:4 1000 0000 0000 0000     &i
+  HVC            1111 0111 1110 ....  1000 .... .... ....     \
+                 &i imm=%imm16_16_0
 }
-- 
2.17.1


