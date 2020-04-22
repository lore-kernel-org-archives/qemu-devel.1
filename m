Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907AAC54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580D820575
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r86d0Dmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580D820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4IR-0005qP-G8
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41n-0002I8-06
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41f-0002oI-C2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:14 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41e-0002h5-Qi
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:06 -0400
Received: by mail-pf1-x443.google.com with SMTP id p25so207375pfn.11
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L2VIIPBcFhefaaeb1Q87he02SCE4/igfBVPGh/qdnUE=;
 b=r86d0DmpfGkrDFRAwkPOEeSsmzFzzYLyfwmIflpiBomt1FmWv0Pbl14B7GxULytcVe
 qmb+B24AHKP/poi5IqABhSB5XLHSYaMBv4mfa4+0gE71iqZoRCLvpBfiDS9HyC7Nv7Pi
 cKFNDIIuumA1DeBM5OzXhk90fYPjRruchgq0WFSWCVQtY3PuRgC/us717HvSchifX0tj
 XiZ4SzX8gc55rOFyKw7Od3Rv35/WzWFW7VNspkPjoyj2TSXqKtzup/6XCuVShZNBZllO
 6JaewWMP/DeWu5MFFCsYpQzyONskDpdiKBBpdhDJ7XghCCQYv1Z9jSmZN9FsISpDdRdt
 rrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L2VIIPBcFhefaaeb1Q87he02SCE4/igfBVPGh/qdnUE=;
 b=pcZUzTKY2ArmwacYrrU+hJxojgkf/IFQRGU/ZXNN85JAbvDrGywKOr3mdwxk+wQDNi
 kLTEoNoLrAXTY7b/ESSm3JWqkzcWf0WDi2ww6mgk44vhCYfe3W8uDgjHnjrcAogUg45e
 9K9KTt4HCUJnMlq752I3h/9F+zLjfsOz6g8omcCgGSDHSUTA8yuIPdp2o0K+KDe24JXa
 aSrWBKEirP7wywxQlT5+4x5LEhdVzjFlumHHnFT6YXNEqmmJaDfPZHPNa9dtx6xjMNUr
 GjN5WvJE2xjcoJkCV4Xrpt8fD/MgLypRzogqfRQgM7sDdxRkyiYR0itfopxVhQu9kPnB
 V2zQ==
X-Gm-Message-State: AGi0PubE/PrjIn7afeympBH1h0dAMjziKXBUqUuFEayl3hy/UAcpLJj8
 Yz/OjkARTCe23lU7F4L/I8cEcwt76CQ=
X-Google-Smtp-Source: APiQypKUY5AQ3x4AVpCudDKsCsZzBuQVf7BojNs3xSeaNGDI+MEAfOqqV0zBQhQUYGi0qpJ7zZ8OTg==
X-Received: by 2002:a65:6250:: with SMTP id q16mr24880006pgv.9.1587518283899; 
 Tue, 21 Apr 2020 18:18:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:18:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 32/36] tcg/i386: Implement INDEX_op_rotl[is]_vec
Date: Tue, 21 Apr 2020 18:17:18 -0700
Message-Id: <20200422011722.13287-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must continue the special casing of 8-bit elements and the
other element sizes are trivially implemented with shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 85 +++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index deace219d2..6039ae4fc6 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3255,6 +3255,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
     case INDEX_op_sars_vec:
+    case INDEX_op_rotls_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3293,6 +3294,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
         return 1;
+    case INDEX_op_rotli_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return -1;
@@ -3316,6 +3318,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
+    case INDEX_op_rotls_vec:
         return vece >= MO_16;
     case INDEX_op_sars_vec:
         return vece >= MO_16 && vece <= MO_32;
@@ -3353,7 +3356,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static void expand_vec_shi(TCGType type, unsigned vece, bool shr,
+static void expand_vec_shi(TCGType type, unsigned vece, TCGOpcode opc,
                            TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
     TCGv_vec t1, t2;
@@ -3363,26 +3366,31 @@ static void expand_vec_shi(TCGType type, unsigned vece, bool shr,
     t1 = tcg_temp_new_vec(type);
     t2 = tcg_temp_new_vec(type);
 
-    /* Unpack to W, shift, and repack.  Tricky bits:
-       (1) Use punpck*bw x,x to produce DDCCBBAA,
-           i.e. duplicate in other half of the 16-bit lane.
-       (2) For right-shift, add 8 so that the high half of
-           the lane becomes zero.  For left-shift, we must
-           shift up and down again.
-       (3) Step 2 leaves high half zero such that PACKUSWB
-           (pack with unsigned saturation) does not modify
-           the quantity.  */
+    /*
+     * Unpack to W, shift, and repack.  Tricky bits:
+     * (1) Use punpck*bw x,x to produce DDCCBBAA,
+     *     i.e. duplicate in other half of the 16-bit lane.
+     * (2) For right-shift, add 8 so that the high half of the lane
+     *     becomes zero.  For left-shift, and left-rotate, we must
+     *     shift up and down again.
+     * (3) Step 2 leaves high half zero such that PACKUSWB
+     *     (pack with unsigned saturation) does not modify
+     *     the quantity.
+     */
     vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
               tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
     vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
               tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
 
-    if (shr) {
-        tcg_gen_shri_vec(MO_16, t1, t1, imm + 8);
-        tcg_gen_shri_vec(MO_16, t2, t2, imm + 8);
+    if (opc != INDEX_op_rotli_vec) {
+        imm += 8;
+    }
+    if (opc == INDEX_op_shri_vec) {
+        tcg_gen_shri_vec(MO_16, t1, t1, imm);
+        tcg_gen_shri_vec(MO_16, t2, t2, imm);
     } else {
-        tcg_gen_shli_vec(MO_16, t1, t1, imm + 8);
-        tcg_gen_shli_vec(MO_16, t2, t2, imm + 8);
+        tcg_gen_shli_vec(MO_16, t1, t1, imm);
+        tcg_gen_shli_vec(MO_16, t2, t2, imm);
         tcg_gen_shri_vec(MO_16, t1, t1, 8);
         tcg_gen_shri_vec(MO_16, t2, t2, 8);
     }
@@ -3449,6 +3457,43 @@ static void expand_vec_sari(TCGType type, unsigned vece,
     }
 }
 
+static void expand_vec_rotli(TCGType type, unsigned vece,
+                             TCGv_vec v0, TCGv_vec v1, TCGArg imm)
+{
+    TCGv_vec t;
+
+    if (vece == MO_8) {
+        expand_vec_shi(type, vece, INDEX_op_rotli_vec, v0, v1, imm);
+        return;
+    }
+
+    t = tcg_temp_new_vec(type);
+    tcg_gen_shli_vec(vece, t, v1, imm);
+    tcg_gen_shri_vec(vece, v0, v1, (8 << vece) - imm);
+    tcg_gen_or_vec(vece, v0, v0, t);
+    tcg_temp_free_vec(t);
+}
+
+static void expand_vec_rotls(TCGType type, unsigned vece,
+                             TCGv_vec v0, TCGv_vec v1, TCGv_i32 lsh)
+{
+    TCGv_i32 rsh;
+    TCGv_vec t;
+
+    tcg_debug_assert(vece != MO_8);
+
+    t = tcg_temp_new_vec(type);
+    rsh = tcg_temp_new_i32();
+
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_andi_i32(rsh, rsh, (8 << vece) - 1);
+    tcg_gen_shls_vec(vece, t, v1, lsh);
+    tcg_gen_shrs_vec(vece, v0, v1, rsh);
+    tcg_gen_or_vec(vece, v0, v0, t);
+    tcg_temp_free_vec(t);
+    tcg_temp_free_i32(rsh);
+}
+
 static void expand_vec_mul(TCGType type, unsigned vece,
                            TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
 {
@@ -3658,13 +3703,21 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     switch (opc) {
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
-        expand_vec_shi(type, vece, opc == INDEX_op_shri_vec, v0, v1, a2);
+        expand_vec_shi(type, vece, opc, v0, v1, a2);
         break;
 
     case INDEX_op_sari_vec:
         expand_vec_sari(type, vece, v0, v1, a2);
         break;
 
+    case INDEX_op_rotli_vec:
+        expand_vec_rotli(type, vece, v0, v1, a2);
+        break;
+
+    case INDEX_op_rotls_vec:
+        expand_vec_rotls(type, vece, v0, v1, temp_tcgv_i32(arg_temp(a2)));
+        break;
+
     case INDEX_op_mul_vec:
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_mul(type, vece, v0, v1, v2);
-- 
2.20.1


