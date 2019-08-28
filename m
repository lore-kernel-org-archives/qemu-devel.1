Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519E3C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050C420856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6mVM36H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050C420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33wf-0003m7-Je
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GV-0003of-AS
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GT-0000PF-1g
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:55 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GS-0000JH-Ki
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id w16so386330pfn.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=34LoZAdS2gtCHWez6TvCJj37+KovuRDH5DtlgNazQ6w=;
 b=u6mVM36HxXa6wugMJsSdKsXKJxuRaiXRxnYiIXOJOxlpdC5lvcMFrIpXUj/xsI0S3h
 DKpmREXDwNBezxjRxrRVvKma8L9WKNzvZCRDy39VJQHhaBCz1I1Yv/qT1HbyP1V9bkxl
 Mv8jrBeyGW9kvtdCezC/t2/CH9F4AVrlNMtfiP2OlS4XXNRy/6bywSX8Vhsryl4muyOD
 ByXHzfNpCGPkZN6Xq8axMHHNBn+pFjg04/eO2qP1xsV9I07eCBg5hV/zSd2DZXhuX9g/
 NqSv0glqnKRiT9dljgTBDp+8JAaI2Iaj1DWGP+Apd8D7oydnHYFhGA3ErMSVTmeQpRf2
 Nk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=34LoZAdS2gtCHWez6TvCJj37+KovuRDH5DtlgNazQ6w=;
 b=JVBrTbvu2Kk7dzjzctFfsIlDa+ig2MGR+dIjpE4IsoKEkAEavLQ1yy+STHpveVpLUq
 gY/4vZIAqro6Q6Rb9NsR+wzCVhR5/SYLuF53oa7bkVVJjDOkr9WaV3RRiWrzWP/V3vZR
 wnIOiSuqbXSLZc9OHn7s3MEopl9TPozJDYMCK6wz1/5+/ibbqyQhFe2/R/zCUHSS+12h
 PnGSAbX83/NHqNIeWVq+xCaKClYKdPxP3qhvLZo7Z9pa+49HVTaGcDOd2vMZFzgUQUMR
 n6r7HfEiHKmtdFkCgF5mbO2/WNnM+lhUJO/sosRnaMFeCOHYcecHOnKWSVN8v5V5ihsK
 ivRQ==
X-Gm-Message-State: APjAAAUjUCM0m/DOZ5WAqxvU5a7sUnB/fZ1/S8lMFdNPWILavRygbHxz
 Y1SOf2tdA4/pdW3Q9VlRJcmMMar5eI0=
X-Google-Smtp-Source: APXvYqyQTVnfAlTVpo/HGBxPNEBBRvz1cE/2zrDdH6lMWVcoJ2T4ZCYz3xxAWAnnnNDjbIbK/JEiHg==
X-Received: by 2002:a63:e602:: with SMTP id g2mr4786330pgh.224.1567019143477; 
 Wed, 28 Aug 2019 12:05:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:21 -0700
Message-Id: <20190828190456.30315-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 34/69] target/arm: Convert RFE and SRS
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
v3: Fix SRS decode; reject RFE and SRS for m-profile.
---
 target/arm/translate.c       | 154 +++++++++++++++--------------------
 target/arm/a32-uncond.decode |   8 ++
 target/arm/t32.decode        |  12 +++
 3 files changed, 85 insertions(+), 89 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index eb4384618c..46e3f946d5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10060,16 +10060,75 @@ static bool trans_SVC(DisasContext *s, arg_SVC *a)
     return true;
 }
 
+/*
+ * Unconditional system instructions
+ */
+
+static bool trans_RFE(DisasContext *s, arg_RFE *a)
+{
+    int32_t offset;
+    TCGv_i32 addr, t1, t2;
+
+    if (!ENABLE_ARCH_6 || arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    if (IS_USER(s)) {
+        unallocated_encoding(s);
+        return true;
+    }
+
+    addr = load_reg(s, a->rn);
+
+    switch (a->pu) {
+    case 0: offset = -4; break; /* DA */
+    case 1: offset =  0; break; /* IA */
+    case 2: offset = -8; break; /* DB */
+    case 3: offset =  4; break; /* IB */
+    default:
+        g_assert_not_reached();
+    }
+    tcg_gen_addi_i32(addr, addr, offset);
+
+    /* Load PC into tmp and CPSR into tmp2.  */
+    t1 = tcg_temp_new_i32();
+    gen_aa32_ld32u(s, t1, addr, get_mem_index(s));
+    tcg_gen_addi_i32(addr, addr, 4);
+    t2 = tcg_temp_new_i32();
+    gen_aa32_ld32u(s, t2, addr, get_mem_index(s));
+
+    if (a->w) {
+        /* Base writeback.  */
+        switch (a->pu) {
+        case 0: offset = -8; break;
+        case 1: offset =  4; break;
+        case 2: offset = -4; break;
+        case 3: offset =  0; break;
+        }
+        tcg_gen_addi_i32(addr, addr, offset);
+        store_reg(s, a->rn, addr);
+    } else {
+        tcg_temp_free_i32(addr);
+    }
+    gen_rfe(s, t1, t2);
+    return true;
+}
+
+static bool trans_SRS(DisasContext *s, arg_SRS *a)
+{
+    if (!ENABLE_ARCH_6 || arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    gen_srs(s, a->mode, a->pu, a->w);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
 
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
-    unsigned int cond, op1, i, rn;
-    TCGv_i32 tmp;
-    TCGv_i32 tmp2;
-    TCGv_i32 addr;
+    unsigned int cond, op1;
 
     /* M variants do not implement ARM mode; this must raise the INVSTATE
      * UsageFault exception.
@@ -10188,52 +10247,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             default:
                 goto illegal_op;
             }
-        } else if ((insn & 0x0e5fffe0) == 0x084d0500) {
-            /* srs */
-            ARCH(6);
-            gen_srs(s, (insn & 0x1f), (insn >> 23) & 3, insn & (1 << 21));
-            return;
-        } else if ((insn & 0x0e50ffe0) == 0x08100a00) {
-            /* rfe */
-            int32_t offset;
-            if (IS_USER(s))
-                goto illegal_op;
-            ARCH(6);
-            rn = (insn >> 16) & 0xf;
-            addr = load_reg(s, rn);
-            i = (insn >> 23) & 3;
-            switch (i) {
-            case 0: offset = -4; break; /* DA */
-            case 1: offset = 0; break; /* IA */
-            case 2: offset = -8; break; /* DB */
-            case 3: offset = 4; break; /* IB */
-            default: abort();
-            }
-            if (offset)
-                tcg_gen_addi_i32(addr, addr, offset);
-            /* Load PC into tmp and CPSR into tmp2.  */
-            tmp = tcg_temp_new_i32();
-            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-            tcg_gen_addi_i32(addr, addr, 4);
-            tmp2 = tcg_temp_new_i32();
-            gen_aa32_ld32u(s, tmp2, addr, get_mem_index(s));
-            if (insn & (1 << 21)) {
-                /* Base writeback.  */
-                switch (i) {
-                case 0: offset = -8; break;
-                case 1: offset = 4; break;
-                case 2: offset = -4; break;
-                case 3: offset = 0; break;
-                default: abort();
-                }
-                if (offset)
-                    tcg_gen_addi_i32(addr, addr, offset);
-                store_reg(s, rn, addr);
-            } else {
-                tcg_temp_free_i32(addr);
-            }
-            gen_rfe(s, tmp, tmp2);
-            return;
         } else if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -10396,7 +10409,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     uint32_t imm, offset;
     uint32_t rd, rn, rm, rs;
     TCGv_i32 tmp;
-    TCGv_i32 tmp2;
     TCGv_i32 addr;
     int op;
 
@@ -10540,44 +10552,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 goto illegal_op;
             }
         } else {
-            /* Load/store multiple, RFE, SRS.  */
-            if (((insn >> 23) & 1) == ((insn >> 24) & 1)) {
-                /* RFE, SRS: not available in user mode or on M profile */
-                if (IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_M)) {
-                    goto illegal_op;
-                }
-                if (insn & (1 << 20)) {
-                    /* rfe */
-                    addr = load_reg(s, rn);
-                    if ((insn & (1 << 24)) == 0)
-                        tcg_gen_addi_i32(addr, addr, -8);
-                    /* Load PC into tmp and CPSR into tmp2.  */
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    tcg_gen_addi_i32(addr, addr, 4);
-                    tmp2 = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp2, addr, get_mem_index(s));
-                    if (insn & (1 << 21)) {
-                        /* Base writeback.  */
-                        if (insn & (1 << 24)) {
-                            tcg_gen_addi_i32(addr, addr, 4);
-                        } else {
-                            tcg_gen_addi_i32(addr, addr, -4);
-                        }
-                        store_reg(s, rn, addr);
-                    } else {
-                        tcg_temp_free_i32(addr);
-                    }
-                    gen_rfe(s, tmp, tmp2);
-                } else {
-                    /* srs */
-                    gen_srs(s, (insn & 0x1f), (insn & (1 << 24)) ? 1 : 2,
-                            insn & (1 << 21));
-                }
-            } else {
-                /* Load/store multiple, in decodetree */
-                goto illegal_op;
-            }
+            /* Load/store multiple, RFE, SRS, in decodetree */
+            goto illegal_op;
         }
         break;
     case 5:
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 573ac2cf8e..64548a93e2 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -29,3 +29,11 @@
 %imm24h          0:s24 24:1 !function=times_2
 
 BLX_i            1111 101 . ........................          &i imm=%imm24h
+
+# System Instructions
+
+&rfe             rn w pu
+&srs             mode w pu
+
+RFE              1111 100 pu:2 0 w:1 1 rn:4 0000 1010 0000 0000   &rfe
+SRS              1111 100 pu:2 1 w:1 0 1101 0000 0101 000 mode:5  &srs
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index ebc92f2c28..c8a8aeceee 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -582,6 +582,18 @@ STM_t32          1110 1001 00.0 .... ................         @ldstm i=0 b=1
 LDM_t32          1110 1000 10.1 .... ................         @ldstm i=1 b=0
 LDM_t32          1110 1001 00.1 .... ................         @ldstm i=0 b=1
 
+&rfe             !extern rn w pu
+@rfe             .... .... .. w:1 . rn:4 ................     &rfe
+
+RFE              1110 1000 00.1 .... 1100000000000000         @rfe pu=2
+RFE              1110 1001 10.1 .... 1100000000000000         @rfe pu=1
+
+&srs             !extern mode w pu
+@srs             .... .... .. w:1 . .... ........... mode:5   &srs
+
+SRS              1110 1000 00.0 1101 1100 0000 000. ....      @srs pu=2
+SRS              1110 1001 10.0 1101 1100 0000 000. ....      @srs pu=1
+
 # Branches
 
 %imm24           26:s1 13:1 11:1 16:10 0:11 !function=t32_branch24
-- 
2.17.1


