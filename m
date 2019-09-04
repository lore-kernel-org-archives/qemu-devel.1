Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC097C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E0721883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zE+5ggMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E0721883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bPa-0008Me-9T
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0R-00053p-3s
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0N-0002gN-Jc
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0N-0002fT-24
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id r12so1751556pfh.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YVJNMt9WNTMYk7iugljb14Z8xnu973MKG4jgT87zBAI=;
 b=zE+5ggMyDItv5RLOwTGxaMpU5R9edQKlLUpI4TmDEP9t8/L/912WND2sA2e/a11WIX
 ax1xfsCxdV6GOf+MPTVwJBESzA6cYQkdvhXAvbqoZuJ3BrhMQ4vDcI5j7e8zL/Jkz1Uh
 KlIFvpdD4Ff/+iRItI9uiDDn4Kbup17ScSIYmk/BfdaoMgs4F2Yd42wjNzyqmZyQXum4
 GCI1ojgN6An+lwh4Qga3BqWDn5m6Io5kXuQqY8VYcmI5E+elVcV7j6W0EYHPIyfObQK4
 KzzvLAto1inJoJf4a4ZfA+C9WNCusXH5ckWYmK9BgRaoATqyX+B9L8Rh9VlK4w1Yh1S3
 9THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YVJNMt9WNTMYk7iugljb14Z8xnu973MKG4jgT87zBAI=;
 b=qzC9zvYXJ+wFrnK58fp1Mm4s5xZoaqvRULnu+XjvzllTeM+BNyAO7mHz+mLZSPU1po
 xKnPqU6yH72+hwx4916NNco4kR+TEyxAwQJKNa3hmvKmCM+3h5tc1hd7JJoKFnk5Yq/7
 T7DhYC8l0e3wRxl2sZpJn5I1d07rf4TJvGRxa2hovRVHmSj2cshA8UH4JhcFE3GJyU3P
 TKELybkqZlRh7zVHxVbnIBx1ns3+aAuZqYdGepDfH4h3Ha4TwGYoQHXdw8kaw638tAja
 Sg2ljVUz6vlZmnPdWFEHbHTRtVTLzTw3ROS9i59vHmQs3cHH7Pgt35JqdXVWTPPav8Pu
 43uQ==
X-Gm-Message-State: APjAAAVqOIl3gNBfJ5OfG+K73RZ3ZTttTgctal05wInY1pV6k2l6rR2F
 uCj3cfBbffYPeYCZI0hcLoJk/UyDc3Y=
X-Google-Smtp-Source: APXvYqyrKkGMPmbsHqV9gL5gV3h9idCGib7jQuAnRwO6Mi9+JTZl3rqnOAHxuSH9Xe+FQIetHLSkBA==
X-Received: by 2002:aa7:8556:: with SMTP id y22mr21006149pfn.252.1567625505594; 
 Wed, 04 Sep 2019 12:31:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:24 -0700
Message-Id: <20190904193059.26202-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 34/69] target/arm: Convert RFE and SRS
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
v4: Fix checkpatch failure in trans_RFE.
---
 target/arm/translate.c       | 144 +++++++++++++----------------------
 target/arm/a32-uncond.decode |   8 ++
 target/arm/t32.decode        |  12 +++
 3 files changed, 75 insertions(+), 89 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 208021181f..ca4873e514 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10093,16 +10093,65 @@ static bool trans_SVC(DisasContext *s, arg_SVC *a)
     return true;
 }
 
+/*
+ * Unconditional system instructions
+ */
+
+static bool trans_RFE(DisasContext *s, arg_RFE *a)
+{
+    static const int8_t pre_offset[4] = {
+        /* DA */ -4, /* IA */ 0, /* DB */ -8, /* IB */ 4
+    };
+    static const int8_t post_offset[4] = {
+        /* DA */ -8, /* IA */ 4, /* DB */ -4, /* IB */ 0
+    };
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
+    tcg_gen_addi_i32(addr, addr, pre_offset[a->pu]);
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
+        tcg_gen_addi_i32(addr, addr, post_offset[a->pu]);
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
@@ -10221,52 +10270,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -10429,7 +10432,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     uint32_t imm, offset;
     uint32_t rd, rn, rm, rs;
     TCGv_i32 tmp;
-    TCGv_i32 tmp2;
     TCGv_i32 addr;
     int op;
 
@@ -10573,44 +10575,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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


