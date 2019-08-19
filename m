Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97716C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6123B214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPkzu9Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6123B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzphp-0005Z2-0D
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpM5-0001g5-FA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpM4-0006Ag-7G
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:21 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpM4-0006AF-1x
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:20 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so1920460pgp.12
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=e+H++wAKyA1U/1YuB/2iGYEbH8KDD+Sy3cPPJBo/ztc=;
 b=BPkzu9VfHA0Ug4azqB6MlZseOF0rAlCUSH8Px+FcrOi8fOeuOGf48r1VdhRxbQrBac
 MHNwfmkgnVPfgJ0BBh/vKM9MjGSxmKf+BaHOlZt5gRE9iRGaBM5u1mAIqmPSaHh0+P3Q
 E4OonWZBWMd1POO7e/n+BI3adVKNLj1Uj+EBVmqzA54TnUMzyMZnMHeIE3lVixtLT0E0
 zjfHRvgxAJGf6xBfxtjl4oWNcPQv4uvfp57O/maBfDItlA8sXfezcKPYb0kbvdrnxIOw
 SWtQcU0K88cNCHhyjxm8YJSFi6bL/0xR23Id5p4ZL3O04/WL5LTfDl+MJ6prBQFtxJgu
 7DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=e+H++wAKyA1U/1YuB/2iGYEbH8KDD+Sy3cPPJBo/ztc=;
 b=NAdGE4U5MLhB+3kgbLIS404VZR09tIdt/5hpxGnyE/CsFE4WJQsRvi5Zck7+eQq9j/
 fdwn5HfOTOy8GNCyDHe+BnlgSMi4U6MHsiAPfKBFEP0Vy1oCp4eyPVLrdKS997GgFkLZ
 En3EjsR0tynbqtYVbQolgLeVMGWP8OiwwDCCVULdApU8mx64/DKo3EJbTcqjMQ8TRy4Q
 9bLe4s8dnuvR8dapaf8e0SKArJ9Vg/gNI1GELVMq60XcepnmwYZlr6aOBzylClY7eye7
 duIywZgXjKszwJqSLQGraN9cM1XfIxlm/I1RGMYGDRM6Qu/x0TdyJtyPLuFnjHGbl5VI
 y8pg==
X-Gm-Message-State: APjAAAXv4qT1VpTtwLvOMgGvM9cmlqycFUVimU+PIp2gIW8XvDfD0Hzc
 WsLJbXr6wckCKdc2NAZ1Z+49iZrWLBQ=
X-Google-Smtp-Source: APXvYqxoMwe+U6OcO/POIzp4JGKmrYnUVLKe0+FYnUY4AjVmOtVCdANM+lQeutFyM3c2frgIXKn5Vw==
X-Received: by 2002:a65:654d:: with SMTP id a13mr21542136pgw.196.1566250698650; 
 Mon, 19 Aug 2019 14:38:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:04 -0700
Message-Id: <20190819213755.26175-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 17/68] target/arm: Convert ERET
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

Pass the T5 encoding of SUBS PC, LR, #IMM through the normal SUBS path
to make it clear exactly what's happening -- we hit ALUExceptionReturn
along that path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 58 ++++++++++++++----------------------------
 target/arm/a32.decode  |  2 ++
 target/arm/t32.decode  |  8 ++++++
 3 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f0fa5253b6..cb7b35489f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8474,6 +8474,23 @@ static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
     return true;
 }
 
+static bool trans_ERET(DisasContext *s, arg_ERET *a)
+{
+    TCGv_i32 tmp;
+
+    if (IS_USER(s) || !arm_dc_feature(s, ARM_FEATURE_V7VE)) {
+        return false;
+    }
+    if (s->current_el == 2) {
+        /* ERET from Hyp uses ELR_Hyp, not LR */
+        tmp = load_cpu_field(elr_el[2]);
+    } else {
+        tmp = load_reg(s, 14);
+    }
+    gen_exception_return(s, tmp);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8768,29 +8785,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x4: /* crc32 */
             /* All done in decodetree.  Illegal ops reach here.  */
             goto illegal_op;
-        case 0x5:
-            /* Saturating addition and subtraction.  */
+        case 0x5: /* Saturating addition and subtraction.  */
+        case 0x6: /* ERET */
             /* All done in decodetree.  Reach here for illegal ops.  */
             goto illegal_op;
-        case 0x6: /* ERET */
-            if (op1 != 3) {
-                goto illegal_op;
-            }
-            if (!arm_dc_feature(s, ARM_FEATURE_V7VE)) {
-                goto illegal_op;
-            }
-            if ((insn & 0x000fff0f) != 0x0000000e) {
-                /* UNPREDICTABLE; we choose to UNDEF */
-                goto illegal_op;
-            }
-
-            if (s->current_el == 2) {
-                tmp = load_cpu_field(elr_el[2]);
-            } else {
-                tmp = load_reg(s, 14);
-            }
-            gen_exception_return(s, tmp);
-            break;
         case 7:
         {
             int imm16 = extract32(insn, 0, 4) | (extract32(insn, 8, 12) << 4);
@@ -10586,24 +10584,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     case 4: /* bxj, in decodetree */
                         goto illegal_op;
                     case 5: /* Exception return.  */
-                        if (IS_USER(s)) {
-                            goto illegal_op;
-                        }
-                        if (rn != 14 || rd != 15) {
-                            goto illegal_op;
-                        }
-                        if (s->current_el == 2) {
-                            /* ERET from Hyp uses ELR_Hyp, not LR */
-                            if (insn & 0xff) {
-                                goto illegal_op;
-                            }
-                            tmp = load_cpu_field(elr_el[2]);
-                        } else {
-                            tmp = load_reg(s, rn);
-                            tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
-                        }
-                        gen_exception_return(s, tmp);
-                        break;
                     case 6: /* MRS, in decodetree */
                     case 7: /* MSR, in decodetree */
                         goto illegal_op;
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 182f2b6725..52a66dd1d5 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -211,3 +211,5 @@ BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
 BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
 
 CLZ              .... 0001 0110 1111 .... 1111 0001 ....      @rdm
+
+ERET             ---- 0001 0110 0000 0000 0000 0110 1110
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 67724efe4b..6236d28b99 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -218,4 +218,12 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
     MSR_v7m      1111 0011 100 0   rn:4 1000 mask:2 00 sysm:8
   }
   BXJ            1111 0011 1100 rm:4 1000 1111 0000 0000      &r
+  {
+    # At v6T2, this is the T5 encoding of SUBS PC, LR, #IMM, and works as for
+    # every other encoding of SUBS.  With v7VE, IMM=0 is redefined as ERET.
+    # The distinction between the two only matters for Hyp mode.
+    ERET         1111 0011 1101 1110 1000 1111 0000 0000
+    SUB_rri      1111 0011 1101 1110 1000 1111 imm:8 \
+                 &s_rri_rot rot=0 s=1 rd=15 rn=14
+  }
 }
-- 
2.17.1


