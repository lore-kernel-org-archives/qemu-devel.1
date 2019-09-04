Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85541C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BBB21883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkZkgncC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BBB21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bXu-0008LS-3i
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0T-00057A-Em
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0P-0002is-S4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:53 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0P-0002ht-Fi
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id q10so8854499pfl.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mFp920jQZpixU7k16+FPmF8mjjZjYKv6xPjZ8lwU3rc=;
 b=WkZkgncCy1bCptYA67zENFoWSR6EsbMHBSOm/4l4vmYZWsGkyhX+AezDUcKEGUKAxR
 rsWehwFYif1ijPQU49lwTABy4XfyMpxDIAP8IVbwQPvrZFVtzU1AEVDuAAnjevtc9WCR
 oUjDuioklvnUFzKkRC6faVr9E2bw98VR9/yClw1NUbrtlyI6BTMqWW6Z1deYV6BbE9hn
 2c+kgFha0xDt2mSBK0NWSn7UjttxqCvfwhWEt5qe2ItzZAQ6XvWWIiEyFIvV+o4DjhdH
 l0uaQAVWQRoa/7QHM6aPcjOoOsehsqTcw2qDkPeuAlo7t4Juimak4oaOGqnFgESg6Rcj
 WxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mFp920jQZpixU7k16+FPmF8mjjZjYKv6xPjZ8lwU3rc=;
 b=fpUxUaHltn2zeYLtciyIabiuecLGdxoYzcPev1losRIh4U/jqynetxD9spLniYsdhi
 GNRvpzyBEMuUrKkj0HhHf8hlH42JgPlwIxMUvfMqs1kBgAQ2DNTPy5kJ51+g4myQX0eI
 RPapBO/X9b6Ge0/T291Jnxb+JUwlakHWZa+jeSmp/RObzLGfhU5jmLU4+kWuYrP48ctY
 TZ426J9JsPL9QpkQc+XTca00ORw3tLQkcNlYg18TPsLZseAhc7rmWEoieIbcVbDSPgZr
 EergT8gKtyvMSxuHJPjwjBMruhtAOTeOtqlNc02oG9TKXKUgzoZaGOz4tv3ila5LkKU2
 x2qg==
X-Gm-Message-State: APjAAAWnD99p7c1Ax6ArV2qYFIMUoVHIcuAxLc9zA90Fo5/fGQtkRXlL
 ZoZwG5S8xJr22TUAjXWHRvWDy7SUeQE=
X-Google-Smtp-Source: APXvYqzgZiwXgnqkD175o64aPLxv789WlGHi0PHvjp25fzYlL2O2Xwm51LGhRfGrXWptnQc4kXYGGA==
X-Received: by 2002:a62:1d8a:: with SMTP id
 d132mr48056973pfd.187.1567625508165; 
 Wed, 04 Sep 2019 12:31:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:26 -0700
Message-Id: <20190904193059.26202-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 36/69] target/arm: Convert CPS (privileged)
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
v3: Reject for m-profile; add TODO for unpredictable arguments.
    Sort the T32 decode adjacent to the hint space.
---
 target/arm/translate.c       | 91 ++++++++++++++++--------------------
 target/arm/a32-uncond.decode |  3 ++
 target/arm/t32.decode        |  5 ++
 3 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 364b51c2a6..664ea281f8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10145,6 +10145,44 @@ static bool trans_SRS(DisasContext *s, arg_SRS *a)
     return true;
 }
 
+static bool trans_CPS(DisasContext *s, arg_CPS *a)
+{
+    uint32_t mask, val;
+
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    if (IS_USER(s)) {
+        /* Implemented as NOP in user mode.  */
+        return true;
+    }
+    /* TODO: There are quite a lot of UNPREDICTABLE argument combinations. */
+
+    mask = val = 0;
+    if (a->imod & 2) {
+        if (a->A) {
+            mask |= CPSR_A;
+        }
+        if (a->I) {
+            mask |= CPSR_I;
+        }
+        if (a->F) {
+            mask |= CPSR_F;
+        }
+        if (a->imod & 1) {
+            val |= mask;
+        }
+    }
+    if (a->M) {
+        mask |= CPSR_M;
+        val |= a->mode;
+    }
+    if (mask) {
+        gen_set_psr_im(s, mask, 0, val);
+    }
+    return true;
+}
+
 /*
  * Clear-Exclusive, Barriers
  */
@@ -10321,31 +10359,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             ARCH(5TE);
         } else if ((insn & 0x0f000010) == 0x0e000010) {
             /* Additional coprocessor register transfer.  */
-        } else if ((insn & 0x0ff10020) == 0x01000000) {
-            uint32_t mask;
-            uint32_t val;
-            /* cps (privileged) */
-            if (IS_USER(s))
-                return;
-            mask = val = 0;
-            if (insn & (1 << 19)) {
-                if (insn & (1 << 8))
-                    mask |= CPSR_A;
-                if (insn & (1 << 7))
-                    mask |= CPSR_I;
-                if (insn & (1 << 6))
-                    mask |= CPSR_F;
-                if (insn & (1 << 18))
-                    val |= mask;
-            }
-            if (insn & (1 << 17)) {
-                mask |= CPSR_M;
-                val |= (insn & 0x1f);
-            }
-            if (mask) {
-                gen_set_psr_im(s, mask, 0, val);
-            }
-            return;
         }
         goto illegal_op;
     }
@@ -10454,7 +10467,6 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t imm, offset;
     uint32_t rd, rn, rm, rs;
     TCGv_i32 tmp;
     TCGv_i32 addr;
@@ -10730,31 +10742,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     case 0: /* msr cpsr, in decodetree  */
                     case 1: /* msr spsr, in decodetree  */
                         goto illegal_op;
-                    case 2: /* cps, nop-hint.  */
-                        /* nop hints in decodetree */
-                        /* Implemented as NOP in user mode.  */
-                        if (IS_USER(s))
-                            break;
-                        offset = 0;
-                        imm = 0;
-                        if (insn & (1 << 10)) {
-                            if (insn & (1 << 7))
-                                offset |= CPSR_A;
-                            if (insn & (1 << 6))
-                                offset |= CPSR_I;
-                            if (insn & (1 << 5))
-                                offset |= CPSR_F;
-                            if (insn & (1 << 9))
-                                imm = CPSR_A | CPSR_I | CPSR_F;
-                        }
-                        if (insn & (1 << 8)) {
-                            offset |= 0x1f;
-                            imm |= (insn & 0x1f);
-                        }
-                        if (offset) {
-                            gen_set_psr_im(s, offset, 0, imm);
-                        }
-                        break;
+                    case 2: /* cps, nop-hint, in decodetree */
+                        goto illegal_op;
                     case 3: /* Special control operations, in decodetree */
                     case 4: /* bxj, in decodetree */
                         goto illegal_op;
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index c7e9df8030..de611e8aff 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -35,9 +35,12 @@ BLX_i            1111 101 . ........................          &i imm=%imm24h
 
 &rfe             rn w pu
 &srs             mode w pu
+&cps             mode imod M A I F
 
 RFE              1111 100 pu:2 0 w:1 1 rn:4 0000 1010 0000 0000   &rfe
 SRS              1111 100 pu:2 1 w:1 0 1101 0000 0101 000 mode:5  &srs
+CPS              1111 0001 0000 imod:2 M:1 0 0000 000 A:1 I:1 F:1 0 mode:5 \
+                 &cps
 
 # Clear-Exclusive, Barriers
 
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 63bca82575..11a9a2ef58 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -44,6 +44,7 @@
 &bfi             !extern rd rn lsb msb
 &sat             !extern rd rn satimm imm sh
 &pkh             !extern rd rn rm imm tb
+&cps             !extern mode imod M A I F
 
 # Data-processing (register)
 
@@ -306,6 +307,10 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
       NOP        1111 0011 1010 1111 1000 0000 ---- ----
     }
 
+    # If imod == '00' && M == '0' then SEE "Hint instructions", above.
+    CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
+                 &cps
+
     # Miscellaneous control
     {
       CLREX      1111 0011 1011 1111 1000 1111 0010 1111
-- 
2.17.1


