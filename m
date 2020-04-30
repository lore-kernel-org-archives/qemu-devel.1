Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0BC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E6F20836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6Apjhch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E6F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDqL-0002qr-L6
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeG-0001jG-7Q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdl-0001B1-1W
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdk-0001AH-Dg
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id z6so3080509wml.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ODnbszWwjBK2kHWFKFvRf6pWCWZZQ+15i6oZRBzn83c=;
 b=U6ApjhchLT36+BxwF054Y+zpHtq1Cjamu0kOzKeB5ipZ4ZtX+1Ad6qHRjJ1BzAtay+
 xosuFyh7FLQnyACmxheLNC+UPixDezUmqFFaZv4uFCNhpKR6DZ3Mzd8aP+1VlrYhwDf0
 gKHgSHCJSLwREtR4SXyQqwjpff0nJef+/185s97cnYlJU4JU8Lv3KsC6uKrNbUVRq5It
 B17+BSER9x39PVmm6pcx44smNv5a+KkvH3tA8YF7FUG7fIKN7Nko3ncuKol0l07NHkau
 s1SEg50EEyn28JRNTxorf/9kSGBO7kpbWJpgP9WA3W+c12oZi0riH8evHcnq9ntNGqO5
 6Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ODnbszWwjBK2kHWFKFvRf6pWCWZZQ+15i6oZRBzn83c=;
 b=rx2sRmcfCnYDRPx5JYLmWHhXIBVp/OK3LFiBDtLmcPnBN8F06uvkKOQs9AIBwxqjcJ
 sYLt7fpVIzWUV2j02OpNWkLgwULJh2ecIgoTXWUZABk4f9oGXLyFJuEnLM4hNc25hF+H
 DyJreWek0Gzspc/loqoyEnOCNBRzKiLMneHio+KvQalVGLHQHiPqpCv332l5vxten/Hh
 dFKeixB+1sQZIejgEve0IhFznHktFN9C7O6yWZgPxevUb8qHPXRVHvr49NfBeHv5HcL0
 rTrUTvqjbcxmImRuLcEprh51LjC4J5OnaK+zKajoci0i/0sFvoRzl8O+H5Z7HYPAakma
 KT4g==
X-Gm-Message-State: AGi0PubsaVxBSR83aMNn/P3Kj71o6L5sNthf1qI7IIWOWn6kxBRbGPwG
 nwkwyT9vEOSgq/QSKK3CtiO7/g==
X-Google-Smtp-Source: APiQypKeTKSfWzR9uEYwPHReSGAhEdnf+puTRL00mGMfBiM9yEAlKueBSL719Wo7ryGcYfM13MGm3Q==
X-Received: by 2002:a05:600c:2dcf:: with SMTP id
 e15mr4498414wmh.171.1588270227132; 
 Thu, 30 Apr 2020 11:10:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 16/36] target/arm: Convert Neon 3-reg-same VMAX/VMIN to
 decodetree
Date: Thu, 30 Apr 2020 19:09:43 +0100
Message-Id: <20200430181003.21682-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

Convert the Neon 3-reg-same VMAX and VMIN insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 14 ++++++++++++++
 target/arm/translate.c          | 21 ++-------------------
 target/arm/neon-dp.decode       |  5 +++++
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 507f0abe801..ab1740201c4 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -617,3 +617,17 @@ DO_3SAME(VEOR, tcg_gen_gvec_xor)
 DO_3SAME_BITSEL(VBSL, rd_ofs, rn_ofs, rm_ofs)
 DO_3SAME_BITSEL(VBIT, rm_ofs, rn_ofs, rd_ofs)
 DO_3SAME_BITSEL(VBIF, rm_ofs, rd_ofs, rn_ofs)
+
+#define DO_3SAME_NO_SZ_3(INSN, FUNC)                                    \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (a->size == 3) {                                             \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, FUNC);                                    \
+    }
+
+DO_3SAME_NO_SZ_3(VMAX_S, tcg_gen_gvec_smax)
+DO_3SAME_NO_SZ_3(VMAX_U, tcg_gen_gvec_umax)
+DO_3SAME_NO_SZ_3(VMIN_S, tcg_gen_gvec_smin)
+DO_3SAME_NO_SZ_3(VMIN_U, tcg_gen_gvec_umin)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a3eaf9a82b7..a22aee802a5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4899,25 +4899,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                              rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
             return 0;
 
-        case NEON_3R_VMAX:
-            if (u) {
-                tcg_gen_gvec_umax(size, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-            } else {
-                tcg_gen_gvec_smax(size, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-            }
-            return 0;
-        case NEON_3R_VMIN:
-            if (u) {
-                tcg_gen_gvec_umin(size, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-            } else {
-                tcg_gen_gvec_smin(size, rd_ofs, rn_ofs, rm_ofs,
-                                  vec_size, vec_size);
-            }
-            return 0;
-
         case NEON_3R_VSHL:
             /* Note the operation is vshl vd,vm,vn */
             tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
@@ -4926,6 +4907,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 
         case NEON_3R_VADD_VSUB:
         case NEON_3R_LOGIC:
+        case NEON_3R_VMAX:
+        case NEON_3R_VMIN:
             /* Already handled by decodetree */
             return 1;
         }
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index f62dbaa72d5..b721d39c7ba 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -54,5 +54,10 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
+VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
+VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
+VMIN_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 1 .... @3same
+
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
-- 
2.20.1


