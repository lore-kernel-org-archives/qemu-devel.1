Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A4C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7106F20787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKFlDNLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7106F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE1Y-0007Pq-JN
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeW-0002Qk-77
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdx-0001Jh-CD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdw-0001Ix-RL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id d15so8192679wrx.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9oZilPgewRJ684vbSieo9Vj2e1homl+WLcJZxlPdvVo=;
 b=FKFlDNLHpj4vl4/sYIe/BGXnc70NInv6k0r+KHu7yRuph2O7Y2GssAaO028A08PEPC
 yUUOtAPb6rDYlBGYAbM2EA+ckQvNpEur19o1Vn/hs3t81oEr6Wcon3bi+enSLO5JC//E
 d6a5xAmg27sEhuEbbPLYj66AHGlGkhJY5Xphkx10ir+WDxOmW+E2wBmfemCT79gAvcpM
 afoUyRDBfxzmBTHsl7zQHGpNHGd/Qw+wkCgpZtUKfLhjO0/YB8kxaZoAmZPh8DZLUvJ1
 x7TJlTHvgvxUrhQtMbG9le+6dxEgPVHvPZlS/+7AmLqNBfudfFw0VuLHxwUQ5osCG6Yi
 MOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9oZilPgewRJ684vbSieo9Vj2e1homl+WLcJZxlPdvVo=;
 b=oMvxnQTcjAy7cjdpUk7KYqToboSaHyrq/4GHqvuVueNGMgye0BmQDTLO5+sBArWpnx
 QCs8+OwhhWn50FqTDD8QwJDJimqsqrZIBaDs0WQuAsPrJ/vEjnLArmBYd+xOr4k82o+L
 I/JifQz0DWiqYfCh+q7tLbWREWr0ZB8huHuwedEttEuOLH4OAGJocBqXuBX1m/mG4h+E
 HzkjHnREeZo7acdzOTF+h6wXVB/3Ibo1zh0K5HtYCiExtZKKj50eLMdhzW27kt1Kl5HJ
 BydvwSMxuWnCkZSgfFaRfZISJcE0RJ62Sg6rxjEU8RhUm8t1NeHhK2kCqkzaOHE/7a2r
 eGVA==
X-Gm-Message-State: AGi0PubeQjTbw/YZr0wZISjyw8/wTpgQmzNWT39I+GHhUj9VbT427mRi
 7uqUXZl0zRZKn7kBWlOEdQuoeQ==
X-Google-Smtp-Source: APiQypKKh8QyMsuhWHA2pBUTZd2EDFhxUpqb2l9zrsXPr4fGvkzBWqFFbu/lrhtjVrm4D4X/TVtQCw==
X-Received: by 2002:adf:df04:: with SMTP id y4mr5342394wrl.413.1588270239207; 
 Thu, 30 Apr 2020 11:10:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 26/36] target/arm: Convert Neon VQSHL, VRSHL,
 VQRSHL 3-reg-same insns to decodetree
Date: Thu, 30 Apr 2020 19:09:53 +0100
Message-Id: <20200430181003.21682-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VQSHL, VRSHL and VQRSHL insns in the 3-reg-same
group to decodetree. We have already implemented the size==0b11
case of these insns; this commit handles the remaining sizes.

TODO: find out from rth why decodetree insists on VSHL going
into the group...

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 93 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 23 ++------
 target/arm/neon-dp.decode       | 30 ++++++++---
 3 files changed, 120 insertions(+), 26 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index bdd5f33214e..084c78eea58 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1035,3 +1035,96 @@ DO_3SAME_32(VHADD, hadd)
 DO_3SAME_32(VHSUB, hsub)
 DO_3SAME_32(VRHADD, rhadd)
 DO_3SAME_32(VABD, abd)
+
+static bool do_3same_qs32(DisasContext *s, arg_3same *a, NeonGenTwoOpEnvFn *fn)
+{
+    /*
+     * Saturating shift operations handled elementwise 32 bits at a
+     * time which need to pass cpu_env to the helper and where the rn
+     * and rm operands are reversed from the usual do_3same() order.
+     */
+    TCGv_i32 tmp, tmp2;
+    int pass;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (a->size == 3) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        /* Note reversal of operand order */
+        tmp = neon_load_reg(a->vm, pass);
+        tmp2 = neon_load_reg(a->vn, pass);
+        fn(tmp, cpu_env, tmp, tmp2);
+        tcg_temp_free_i32(tmp2);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    return true;
+}
+
+/*
+ * Handling for shifts with sizes 8/16/32 bits. 64-bit shifts are
+ * covered by the *_S64_3s and *_U64_3s patterns and the grouping in
+ * the decode file means those functions are called first for
+ * size==0b11. Note that we must 'return false' here for the
+ * size==0b11 case rather than asserting, because where the 64-bit
+ * function has an UNDEF case and returns false the decoder will fall
+ * through to trying these functions.
+ */
+#define DO_3SAME_QS32(INSN, func)                                       \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        static NeonGenTwoOpEnvFn * const fns[] = {                      \
+            gen_helper_neon_##func##8,                                  \
+            gen_helper_neon_##func##16,                                 \
+            gen_helper_neon_##func##32,                                 \
+        };                                                              \
+        if (a->size > 2) {                                              \
+            return false;                                               \
+        }                                                               \
+        return do_3same_qs32(s, a, fns[a->size]);                       \
+    }
+
+DO_3SAME_QS32(VQSHL_S,qshl_s)
+DO_3SAME_QS32(VQSHL_U,qshl_u)
+DO_3SAME_QS32(VQRSHL_S,qrshl_s)
+DO_3SAME_QS32(VQRSHL_U,qrshl_u)
+
+#define DO_3SAME_SHIFT32(INSN, func) \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        static NeonGenTwoOpFn * const fns[] = {                         \
+            gen_helper_neon_##func##8,                                  \
+            gen_helper_neon_##func##16,                                 \
+            gen_helper_neon_##func##32,                                 \
+        };                                                              \
+        int rtmp;                                                       \
+        if (a->size > 2) {                                              \
+            return false;                                               \
+        }                                                               \
+        /* Shift operand order is reversed */                           \
+        rtmp = a->vn;                                                   \
+        a->vn = a->vm;                                                  \
+        a->vm = rtmp;                                                   \
+        return do_3same_32(s, a, fns[a->size]);                         \
+    }
+
+DO_3SAME_SHIFT32(VRSHL_S, rshl_s)
+DO_3SAME_SHIFT32(VRSHL_U, rshl_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 29301061ca5..4406fe54647 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4790,6 +4790,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VRHADD:
         case NEON_3R_VHSUB:
         case NEON_3R_VABD:
+        case NEON_3R_VQSHL:
+        case NEON_3R_VRSHL:
+        case NEON_3R_VQRSHL:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4800,17 +4803,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         pairwise = 0;
         switch (op) {
-        case NEON_3R_VQSHL:
-        case NEON_3R_VRSHL:
-        case NEON_3R_VQRSHL:
-            {
-                int rtmp;
-                /* Shift instruction operands are reversed.  */
-                rtmp = rn;
-                rn = rm;
-                rm = rtmp;
-            }
-            break;
         case NEON_3R_VPADD_VQRDMLAH:
         case NEON_3R_VPMAX:
         case NEON_3R_VPMIN:
@@ -4870,15 +4862,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VQSHL:
-            GEN_NEON_INTEGER_OP_ENV(qshl);
-            break;
-        case NEON_3R_VRSHL:
-            GEN_NEON_INTEGER_OP(rshl);
-            break;
-        case NEON_3R_VQRSHL:
-            GEN_NEON_INTEGER_OP_ENV(qrshl);
-            break;
         case NEON_3R_VABA:
             GEN_NEON_INTEGER_OP(abd);
             tcg_temp_free_i32(tmp2);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 4b15e52221b..ae442071ef1 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -80,12 +80,30 @@ VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same
 @3same_64        .... ... . . . 11 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=3
 
-VQSHL_S64_3s     1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_64
-VQSHL_U64_3s     1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_64
-VRSHL_S64_3s     1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_64
-VRSHL_U64_3s     1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_64
-VQRSHL_S64_3s    1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_64
-VQRSHL_U64_3s    1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_64
+{
+  VQSHL_S64_3s   1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_64
+  VQSHL_S_3s     1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same
+}
+{
+  VQSHL_U64_3s   1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_64
+  VQSHL_U_3s     1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same
+}
+{
+  VRSHL_S64_3s   1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_64
+  VRSHL_S_3s     1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same
+}
+{
+  VRSHL_U64_3s   1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_64
+  VRSHL_U_3s     1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same
+}
+{
+  VQRSHL_S64_3s  1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_64
+  VQRSHL_S_3s    1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same
+}
+{
+  VQRSHL_U64_3s  1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_64
+  VQRSHL_U_3s    1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same
+}
 
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
-- 
2.20.1


