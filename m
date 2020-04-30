Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A3C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D042920836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQODx0fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D042920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDv1-00038P-Vj
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeE-0001gK-ME
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdk-0001Ai-VW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdk-00017o-BB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id e26so2975678wmk.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QSstU/hy0hxmLdJnSbMYcJkvE1JZD3c/6g24zzTlD3s=;
 b=TQODx0fzZx7rChF7QmAN+Rd3oDdcTFGVkhZZ/JA8lPtRyG1DUaOu2W+7ZdKSEdCFBi
 chkyZmPawfF7ps3EqcFQ0ivSUI1GXal0Qwt/i/Fh22nufp/4GUIHtIxI/OAi3KEUIKA1
 Qf/ZI+OIAnixnyc/j8XCr7BgGpXg8s2pJMKkrH1qQwL+I2yY0E2+96P2tcM20rmfOSYI
 Xpfj9su896J5OtvE3dcz3dwCBBFtSa9Op0hXc7mklMF6D7M62FEuGG+D3yMJdzTaZzEF
 URGp7QJQT+KhQYDyvH8rRjhau95lFdsDIN8MB5hrkRHVIUDvtX4prhhGIk7MoTVsYqaH
 CB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QSstU/hy0hxmLdJnSbMYcJkvE1JZD3c/6g24zzTlD3s=;
 b=NqTSTI3pF7IM8TS0hrnyLuD+FIYtcxyj0d2ZNPohulh/MLq9/QCK+9pON1fvA6CNFz
 /JZn6wsTBWcHKz7adtI0dowrtT7sQvMJc9AlMWcDGrjrMV3afhd85Fp4zpjxhXpCzEK8
 5PNYfjV472AHvvbBNgF+H3BusNeXly42MlhOD8c2Z7y850yTLSrKp2mpBS3Bifn5YdAz
 uLEKQvzIfkkSf7scWnUsvESxEq7SeXRQEsqKLWP4YyVNIPJzXfTyfw8qVXY2X45ZwU2Y
 HRfbbdiU6dZRgglJrMW495gDR0OuIHz0B/iGMda4Y+mIP8mwrf+/j0e5qimglzvBA2bf
 DzBg==
X-Gm-Message-State: AGi0PuaZsU6UYEUJ3kf/GBzAmU/hefKHnzDpTYq5oFI+EWNabV6rNvkW
 gE8iiZAcyy04682dzE1B+UkzyQ==
X-Google-Smtp-Source: APiQypINHTRXqpOWnkkCVLPzO9Pxwt4w0QZnRVkbrWs3EfgxNIMg+QFu15j4n1/4jZynKQOCx4Y0bw==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr4244076wmc.22.1588270225441; 
 Thu, 30 Apr 2020 11:10:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 15/36] target/arm: Convert Neon 3-reg-same logic ops to
 decodetree
Date: Thu, 30 Apr 2020 19:09:42 +0100
Message-Id: <20200430181003.21682-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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

Convert the Neon logic ops in the 3-reg-same grouping to decodetree.
Note that for the logic ops the 'size' field forms part of their
decode and the actual operations are always bitwise.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 19 +++++++++++++++++
 target/arm/translate.c          | 38 +--------------------------------
 target/arm/neon-dp.decode       | 12 +++++++++++
 3 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index bd9e697b3e2..507f0abe801 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -598,3 +598,22 @@ static bool do_3same(DisasContext *s, arg_3same *a, GVecGen3Fn fn)
 
 DO_3SAME(VADD, tcg_gen_gvec_add)
 DO_3SAME(VSUB, tcg_gen_gvec_sub)
+DO_3SAME(VAND, tcg_gen_gvec_and)
+DO_3SAME(VBIC, tcg_gen_gvec_andc)
+DO_3SAME(VORR, tcg_gen_gvec_or)
+DO_3SAME(VORN, tcg_gen_gvec_orc)
+DO_3SAME(VEOR, tcg_gen_gvec_xor)
+
+/* These insns are all gvec_bitsel but with the inputs in various orders. */
+#define DO_3SAME_BITSEL(INSN, O1, O2, O3)                               \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        tcg_gen_gvec_bitsel(vece, rd_ofs, O1, O2, O3, oprsz, maxsz);    \
+    }                                                                   \
+    DO_3SAME(INSN, gen_##INSN##_3s)
+
+DO_3SAME_BITSEL(VBSL, rd_ofs, rn_ofs, rm_ofs)
+DO_3SAME_BITSEL(VBIT, rm_ofs, rn_ofs, rd_ofs)
+DO_3SAME_BITSEL(VBIF, rm_ofs, rd_ofs, rn_ofs)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 81a0df78e40..a3eaf9a82b7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4848,43 +4848,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 1;
 
-        case NEON_3R_LOGIC: /* Logic ops.  */
-            switch ((u << 2) | size) {
-            case 0: /* VAND */
-                tcg_gen_gvec_and(0, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-                break;
-            case 1: /* VBIC */
-                tcg_gen_gvec_andc(0, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-                break;
-            case 2: /* VORR */
-                tcg_gen_gvec_or(0, rd_ofs, rn_ofs, rm_ofs,
-                                vec_size, vec_size);
-                break;
-            case 3: /* VORN */
-                tcg_gen_gvec_orc(0, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-                break;
-            case 4: /* VEOR */
-                tcg_gen_gvec_xor(0, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-                break;
-            case 5: /* VBSL */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rd_ofs, rn_ofs, rm_ofs,
-                                    vec_size, vec_size);
-                break;
-            case 6: /* VBIT */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rn_ofs, rd_ofs,
-                                    vec_size, vec_size);
-                break;
-            case 7: /* VBIF */
-                tcg_gen_gvec_bitsel(MO_8, rd_ofs, rm_ofs, rd_ofs, rn_ofs,
-                                    vec_size, vec_size);
-                break;
-            }
-            return 0;
-
         case NEON_3R_VQADD:
             tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                            rn_ofs, rm_ofs, vec_size, vec_size,
@@ -4962,6 +4925,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 0;
 
         case NEON_3R_VADD_VSUB:
+        case NEON_3R_LOGIC:
             /* Already handled by decodetree */
             return 1;
         }
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index a61b1e88476..f62dbaa72d5 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -42,5 +42,17 @@
 @3same           .... ... . . . size:2 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
+@3same_logic     .... ... . . . .. .... .... .... . q:1 .. .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0
+
+VAND_3s          1111 001 0 0 . 00 .... .... 0001 ... 1 .... @3same_logic
+VBIC_3s          1111 001 0 0 . 01 .... .... 0001 ... 1 .... @3same_logic
+VORR_3s          1111 001 0 0 . 10 .... .... 0001 ... 1 .... @3same_logic
+VORN_3s          1111 001 0 0 . 11 .... .... 0001 ... 1 .... @3same_logic
+VEOR_3s          1111 001 1 0 . 00 .... .... 0001 ... 1 .... @3same_logic
+VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
+VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
+VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
+
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
-- 
2.20.1


