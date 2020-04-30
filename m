Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B35C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B812620836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uz2VaYgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B812620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDrP-0004c5-Rm
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeJ-0001rW-BM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdo-0001EV-QJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdo-0001CD-6F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id c12so3037301wrp.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZvVAov9v/saeGj1TRG90d3M5driRZEcd+V+CZGCG07U=;
 b=uz2VaYgPa5e8B4bbG09HGE+xceI0LorGT7Q6MgWFKFnXJQgmmfrecmagLFa54hw89o
 pGwGLInk630VlvxEqr9KlkHqAUA5Q/xTFs4hXx0v/HAZN0OF4FyH204TTUn0cM0qW6Ln
 RrHIzUgEGLsjojUJlExgTeA5KH/TlMm++2CtEwQnPbdenfutg/314yzs/4MfdzTWzOh2
 PeNYcrJyovW1Mm1Xv87YsO7SzYm3siNRg9a6mGWG/pFRGjNpdi4gcABs1avthfexn70O
 qPa6kcWIU1xwsmxWbPYaV0Dr9vYuN0Iul8+blQEOn51AtbwQSZ0WvsUAjx2CnecRuwXM
 jfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZvVAov9v/saeGj1TRG90d3M5driRZEcd+V+CZGCG07U=;
 b=jIXTav2ea9HuS4KxxpLSiRlFaexTlVNtPBl3LKCrEum3tQu154lprWXqw0a8cFYHye
 8Qx2MOxZxeKN6LQQMnLp7Mo2mMRK9lwcduosDXZRRc/1R5dGFxzu9Pa7PqLwf0fEGnWV
 9cN1g107DBrCwAXZsuP9+LFsOtvXGcDflcrTm1wlpSd6VMYm7AxV1N11AUMTPtm5HKRy
 Ws1ILddhnS0Uxm9KVz7mZdFVgQNQUheBfeaYcauCL8qhMJAuA9L3SqnlZgJqs1+ddZ3b
 ztsot6rQQGe7JER5fAptl9axJLMEDcn1CjKgyS7gHffzEGMWdspy+5ap+UxdJFQDLHCW
 gJaQ==
X-Gm-Message-State: AGi0PuZyIUnuittAhFNRILP7sjckei0w/IeJ0NyG7jjzhwBj3LOZfK8e
 GcZ5V5+Wap5IEJhaPIFq1NPEE6T2RsL/TQ==
X-Google-Smtp-Source: APiQypIWVuM+oQnSyjpOp2YHC9xL8vICE4iNQBz9Y7Rfyzja5v1Yp3etQBt1xqBe3vUewv9qLE66eg==
X-Received: by 2002:a5d:654f:: with SMTP id z15mr5487863wrv.338.1588270230633; 
 Thu, 30 Apr 2020 11:10:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 19/36] target/arm: Convert Neon 3-reg-same VMUL, VMLA, VMLS,
 VSHL to decodetree
Date: Thu, 30 Apr 2020 19:09:46 +0100
Message-Id: <20200430181003.21682-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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

Convert the Neon VMUL, VMLA, VMLS and VSHL insns in the
3-reg-same grouping to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 44 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 28 +++------------------
 target/arm/neon-dp.decode       |  9 +++++++
 3 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 854ab70cd79..50b77b6d714 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -631,6 +631,7 @@ DO_3SAME_NO_SZ_3(VMAX_S, tcg_gen_gvec_smax)
 DO_3SAME_NO_SZ_3(VMAX_U, tcg_gen_gvec_umax)
 DO_3SAME_NO_SZ_3(VMIN_S, tcg_gen_gvec_smin)
 DO_3SAME_NO_SZ_3(VMIN_U, tcg_gen_gvec_umin)
+DO_3SAME_NO_SZ_3(VMUL, tcg_gen_gvec_mul)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -668,3 +669,46 @@ DO_3SAME_GVEC4(VQADD_S, sqadd_op)
 DO_3SAME_GVEC4(VQADD_U, uqadd_op)
 DO_3SAME_GVEC4(VQSUB_S, sqsub_op)
 DO_3SAME_GVEC4(VQSUB_U, uqsub_op)
+
+static void gen_VMUL_p_3s(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                           uint32_t rm_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz,
+                       0, gen_helper_gvec_pmul_b);
+}
+
+static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
+{
+    if (a->size != 0) {
+        return false;
+    }
+    return do_3same(s, a, gen_VMUL_p_3s);
+}
+
+#define DO_3SAME_GVEC3_NO_SZ_3(INSN, OPARRAY)                           \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,                          \
+                       oprsz, maxsz, &OPARRAY[vece]);                   \
+    }                                                                   \
+    DO_3SAME_NO_SZ_3(INSN, gen_##INSN##_3s)
+
+
+DO_3SAME_GVEC3_NO_SZ_3(VMLA, mla_op)
+DO_3SAME_GVEC3_NO_SZ_3(VMLS, mls_op)
+
+#define DO_3SAME_GVEC3_SHIFT(INSN, OPARRAY)                             \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        /* Note the operation is vshl vd,vm,vn */                       \
+        tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs,                          \
+                       oprsz, maxsz, &OPARRAY[vece]);                   \
+    }                                                                   \
+    DO_3SAME(INSN, gen_##INSN##_3s)
+
+DO_3SAME_GVEC3_SHIFT(VSHL_S, sshl_op)
+DO_3SAME_GVEC3_SHIFT(VSHL_U, ushl_op)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 538e4be8f1b..ad60b7190f9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4848,31 +4848,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 1;
 
-        case NEON_3R_VMUL: /* VMUL */
-            if (u) {
-                /* Polynomial case allows only P8.  */
-                if (size != 0) {
-                    return 1;
-                }
-                tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
-                                   0, gen_helper_gvec_pmul_b);
-            } else {
-                tcg_gen_gvec_mul(size, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-            }
-            return 0;
-
-        case NEON_3R_VML: /* VMLA, VMLS */
-            tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
-                           u ? &mls_op[size] : &mla_op[size]);
-            return 0;
-
-        case NEON_3R_VSHL:
-            /* Note the operation is vshl vd,vm,vn */
-            tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
-                           u ? &ushl_op[size] : &sshl_op[size]);
-            return 0;
-
         case NEON_3R_VADD_VSUB:
         case NEON_3R_LOGIC:
         case NEON_3R_VMAX:
@@ -4882,6 +4857,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VCGE:
         case NEON_3R_VQADD:
         case NEON_3R_VQSUB:
+        case NEON_3R_VMUL:
+        case NEON_3R_VML:
+        case NEON_3R_VSHL:
             /* Already handled by decodetree */
             return 1;
         }
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ab59b349aaa..ec3a92fe753 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -65,6 +65,9 @@ VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
 VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
 VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 
+VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same
+VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same
+
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
 VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
@@ -75,3 +78,9 @@ VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
 
 VTST_3s          1111 001 0 0 . .. .... .... 1000 . . . 1 .... @3same
 VCEQ_3s          1111 001 1 0 . .. .... .... 1000 . . . 1 .... @3same
+
+VMLA_3s          1111 001 0 0 . .. .... .... 1001 . . . 0 .... @3same
+VMLS_3s          1111 001 1 0 . .. .... .... 1001 . . . 0 .... @3same
+
+VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
+VMUL_p_3s        1111 001 1 0 . .. .... .... 1001 . . . 1 .... @3same
-- 
2.20.1


