Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE387C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D97521842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/SL5nhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D97521842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4W0-0000GL-NV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NJ-0004dq-Le
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NF-0000PC-P2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:38747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NF-0000Ik-Fo
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:21 -0400
Received: by mail-pl1-x62a.google.com with SMTP id az7so25001957plb.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V+9sEjvD/MeB+TtFs8ZOx130uH8wMAavrP8D396SPq0=;
 b=f/SL5nhg6EpaND6So2WRj2YgErez5hqgIJwID9peBtD1SXLkj/xgmGHbHMRBRWwtbw
 RXSDPacY9aDCUPgz+ZPoHHyB1WQ1nSpguwemwoaVm0YpppCWDB/uyCnvT16ivzwZAXrg
 0F+weck/PPdUkDvSwiYlEmDj+NOgeODZEF35YXUXjta9WU0/2h1RKhu63jWfcrr187oT
 UdKB3U7F/G0wuNIoqX5Gs0tORHs3Y0l9X1s0su4mUvM9/Ru6Lr2Lz0MEM64vTaS3d7TR
 ccL6ftirSUdGNfpvi3+cJAoLeMJIckHd4zyVB61VkqyAdLWIqcVvSp+9xyMAOYKmAJRK
 HgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V+9sEjvD/MeB+TtFs8ZOx130uH8wMAavrP8D396SPq0=;
 b=VAYDUtRP14FpabVPUmPMj+OLYOwGcfqECODdrRMmAOnMAiPhhJFXq0zK24bbc3BPdh
 CGliNabA+yXLN50oAnriO0LG0jo7RwmJv74AsqtmRf8VfJYneCLD6Keh3F1PPFqnuIJl
 aYF61DdaUfh7fVKbo4OZzQZzPoRPVSWQbzBK/L5jAYsaSPFXdMJmZ6zfqIBwlR98pVqJ
 soj0RtmsFVjeJKH5Yl2mhFAShc3jYjns1g8JjEeIAeG442KW9sYxalxX9uF7vZLj6ogo
 k1XFlJtrtfBcWxjuubYOYcwgQz/E8a4x0RaMaFnB+gUvN01a68zaVX7kdzJbz2HmDkzK
 clXA==
X-Gm-Message-State: APjAAAVvjpNK0C2UGjT6Qt9NtNKJkxR1e5sd0OWxw8AZ9f1fricWhicC
 RiVT8M3xF6gGX5MUQBsU4oOZrsuAicM=
X-Google-Smtp-Source: APXvYqzKE9SgLj4rI1iePRQcTTspfaxyV03RZQkrCBTPopmYkLnl24HmiUcSUDt89rKWKXwLc6zMyg==
X-Received: by 2002:a17:902:7781:: with SMTP id
 o1mr97579752pll.205.1564163474983; 
 Fri, 26 Jul 2019 10:51:14 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:59 -0700
Message-Id: <20190726175032.6769-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PATCH 34/67] target/arm: Convert CPS (privileged)
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
 target/arm/translate.c       | 87 +++++++++++++++---------------------
 target/arm/a32-uncond.decode |  3 ++
 target/arm/t32.decode        |  3 ++
 3 files changed, 42 insertions(+), 51 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 797e8f7344..8dbe189df7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10049,6 +10049,40 @@ static bool trans_SRS(DisasContext *s, arg_SRS *a)
     return true;
 }
 
+static bool trans_CPS(DisasContext *s, arg_CPS *a)
+{
+    uint32_t mask, val;
+
+    if (IS_USER(s)) {
+        /* Implemented as NOP in user mode.  */
+        return true;
+    }
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
@@ -10220,31 +10254,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -10350,7 +10359,6 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t imm, offset;
     uint32_t rd, rn, rm, rs;
     TCGv_i32 tmp;
     TCGv_i32 addr;
@@ -10631,31 +10639,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
                     case 5: /* eret, in decodetree */
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index b077958cec..eb1c55b330 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -35,9 +35,12 @@ BLX_i            1111 101 . ........................          &i imm=%imm24h
 
 &rfe             rn w pu
 &srs             mode w pu
+&cps             mode imod M A I F
 
 RFE              1111 100 pu:2 0 w:1 1 rn:4 0000 1010 0000 0000   &rfe
 SRS              1111 110 pu:2 1 w:1 0 1101 0000 0101 000 mode:5  &srs
+CPS              1111 0001 0000 imod:2 M:1 0 0000 000 A:1 I:1 F:1 0 mode:5 \
+                 &cps
 
 # Clear-Exclusive, Barriers
 
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 9fe1500fe0..f8d8660466 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -44,6 +44,7 @@
 &bfi             !extern rd rn lsb msb
 &sat             !extern rd rn satimm imm sh
 &pkh             !extern rd rn rm imm tb
+&cps             !extern mode imod M A I F
 
 # Data-processing (register-shifted register)
 
@@ -340,6 +341,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
     SMC          1111 0111 1111 imm:4 1000 0000 0000 0000     &i
     HVC          1111 0111 1110 .... 1000 .... .... ....      \
                  &i imm=%imm16_16_0
+    CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
+                 &cps
     UDF          1111 0111 1111 ----  1010 ---- ---- ----
   }
   B_cond_thumb   1111 0. cond:4 ...... 10.0 ............      &ci imm=%imm21
-- 
2.17.1


