Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55145C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D47C2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9ub4gFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D47C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33Yh-0005Fw-2d
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G3-0003NY-9H
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G0-0008UP-Cf
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33G0-0008TA-5u
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:24 -0400
Received: by mail-pf1-x444.google.com with SMTP id o70so392086pfg.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QCVrNyP4aQ0jX7CvYJg0KqtkiSJELZNM0Q5/bhu0tlI=;
 b=L9ub4gFlnNTqqoViMGHLAPW95jwbeBVCJHQKC9zmbl44JbKBUXlk+U//kLRnbD7ueb
 MKFRR9CgFUJkuzs9ndYooe9WfLqDKc51fPjs0R3ilQ8W4cdGCRpsrv/7XB8SlAouY11T
 htYvPnUyfPdrj5g/IuBSu9s9Y4MtpvfDH9ghirN5LqjEbpSFyTj5X6AL71QeYO6VDBUY
 1uTrGJWgsY+2TidYV6c19vgxUBdclHrQY2glQZaTYdS6gmggWl2a10i5tbNmHQc+Q7y+
 YNOc9WIZPjtHUbTbt9OelhWuIOsa6E1JcGs78sZu6RAFwXeDCZoLbb8Glijh750CMWfD
 yRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QCVrNyP4aQ0jX7CvYJg0KqtkiSJELZNM0Q5/bhu0tlI=;
 b=t0vY/HC7u6kOZutaW1Y+qE4KTC36wLNP4Cj27FERKG+jXZ6LASpMPbzYQM+FOxor2q
 xjdCHfCle6HFZrcgBAC7w7/vanyvPicIJD+rsCDOQamNVFXsExsf5gOMz5RaBiQYVSIJ
 /txM4OSZTeI7nq9xu5ycODTI9OPU//LukppxCrtAtmS6EocIc4blRn9PsueNIrVP0fKS
 QxbQyriPkNvI9gfApUU5Pl7Ey5CamFJwBrYF6AL0B3GMpCCbhm9F3J2VakVOu8zasFjI
 GRJO24fcdpFFh/p41JIxS99z5k/j3njn0SUliXoQTwXV43isZOLj1544jG2PVOfTvfns
 +HhA==
X-Gm-Message-State: APjAAAX+I1uTvmLJtE2VnDLYDoE67eYnCZg3m3jaiZE1lUXojysScKNr
 +1X9s8tdp+sMEcUtvJ139CwxhGPPfgA=
X-Google-Smtp-Source: APXvYqwiZ+NvHZReUAqRyp3P3GxdXs6Xq2kT29kecjwWXeJIOUuozlMU8CvVjm6OY4XLPyjALmFgnA==
X-Received: by 2002:a17:90a:342d:: with SMTP id
 o42mr5916292pjb.27.1567019121835; 
 Wed, 28 Aug 2019 12:05:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:04 -0700
Message-Id: <20190828190456.30315-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 17/69] target/arm: Convert ERET
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use unallocated_encoding for IS_USER check.
---
 target/arm/translate.c | 62 ++++++++++++++++--------------------------
 target/arm/a32.decode  |  2 ++
 target/arm/t32.decode  |  8 ++++++
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c285d4f882..203b6160da 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8477,6 +8477,27 @@ static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
     return true;
 }
 
+static bool trans_ERET(DisasContext *s, arg_ERET *a)
+{
+    TCGv_i32 tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V7VE)) {
+        return false;
+    }
+    if (IS_USER(s)) {
+        unallocated_encoding(s);
+        return true;
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
@@ -8771,29 +8792,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -10586,24 +10588,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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


