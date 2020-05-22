Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA0AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F46205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKBhHXlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F46205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc95w-0003nF-3J
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc955-0001uX-Dz
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc954-0006R5-Ad
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id n5so10106220wmd.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CjpjYzXmKdCTpUVLpvmz68eKh1IW7CdbECnjZ+5X3Wo=;
 b=uKBhHXlLm1iB5TA2KhlizWoN/3upLqc4aWP72TSLn4IH8IhLLZgzDJR1Uo3dKgP11C
 nXCWlDixG3oklk/sLryWj+wv1vCtPqfW4D6sqhWDLYLoGmYYm0f7LhoI8DiH8AOec8Qb
 LdCw3j5ivCVpohkVhF3XTr9ThW5VK8pLBytYtYevMYlpXIePeTJ8RETOnTHFlr2F7tRN
 5rSXG+HOub0usT9dDuSklSd3be2fMZrflCs4IDHQ+0NJfQa5CTfoLmztgQt0d0zETWII
 pW+pLp3jfD2VY3AVaD0rxrr/KM/B9Z/fxspaHm+jBTrvRLGeu/XOTpQ58ZWL5nq/Nwmp
 PfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CjpjYzXmKdCTpUVLpvmz68eKh1IW7CdbECnjZ+5X3Wo=;
 b=HA3+X0oluefu/xk39cl10fAIxB9fOhiocuSKh3amHQvZMfx2QgTRpuGaizrPMqDls3
 qKM3A2Hsk5oi6LynWOJK7STkRKvB4ihshTe3mQwyOHytAmviGvZVzP33AnrGd8JGk8OY
 fags0dM4ekh9CDslV6iGhnzT94gHusZUzn3EWbQEv8WRquWI2JDP/29KCRWY1EgM1aFz
 dhrwUMHYDoxESjFKq8NSpAeUPLx9QIB3xZvwdleJ7IRY537ANksX9AKKRvDVnqRHYApW
 eK79lyJyYOc+yk/AaZTXqK2sn5YdgqHPj9TAa/hnoUl1PkYdlEKFJOeoq1unJ8O6LgL8
 TXog==
X-Gm-Message-State: AOAM531FWb63zoSkkxNOkvQDlZO92gcPpIqXhI9NxQwPBwjpZbHPNv/h
 kcuUIXYOCBcz3mRQeooq0Duu7g==
X-Google-Smtp-Source: ABdhPJyfmxs6izlBPG7AoYie7JpKrTWxBbIEZVQhzbMO+IGEqcMOPV1t5EuJv7MNvfD8tUoPPzswtQ==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr13585234wmb.123.1590159324939; 
 Fri, 22 May 2020 07:55:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y8sm1100561wmc.37.2020.05.22.07.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:55:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] target/arm: Convert Neon VSHR 2-reg-shift insns to
 decodetree
Date: Fri, 22 May 2020 15:55:13 +0100
Message-Id: <20200522145520.6778-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522145520.6778-1-peter.maydell@linaro.org>
References: <20200522145520.6778-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Convert the VSHR 2-reg-shift insns to decodetree.

Note that unlike the legacy decoder, we present the right shift
amount to the trans_ function as a positive integer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       | 25 ++++++++++++++++++++
 target/arm/translate-neon.inc.c | 41 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 21 +----------------
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 4bd305e7ea0..cd3a8f936d7 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -206,6 +206,21 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 ######################################################################
 &2reg_shift vm vd q shift size
 
+# Right shifts are encoded as N - shift, where N is the element size in bits.
+%neon_rshift_i6  16:6 !function=rsub_64
+%neon_rshift_i5  16:5 !function=rsub_32
+%neon_rshift_i4  16:4 !function=rsub_16
+%neon_rshift_i3  16:3 !function=rsub_8
+
+@2reg_shr_d      .... ... . . . ......  .... .... 1 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=3 shift=%neon_rshift_i6
+@2reg_shr_s      .... ... . . . 1 ..... .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=2 shift=%neon_rshift_i5
+@2reg_shr_h      .... ... . . . 01 .... .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=1 shift=%neon_rshift_i4
+@2reg_shr_b      .... ... . . . 001 ... .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=0 shift=%neon_rshift_i3
+
 @2reg_shl_d      .... ... . . . shift:6      .... .... 1 q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=3
 @2reg_shl_s      .... ... . . . 1 shift:5    .... .... 0 q:1 . . .... \
@@ -215,6 +230,16 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 @2reg_shl_b      .... ... . . . 001 shift:3  .... .... 0 q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=0
 
+VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_d
+VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_s
+VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_h
+VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_b
+
+VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_d
+VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_s
+VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_h
+VSHR_U_2sh       1111 001 1 1 . ...... .... 0000 . . . 1 .... @2reg_shr_b
+
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_d
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_s
 VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_h
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 305213fe6d9..0475696835f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -31,6 +31,24 @@ static inline int plus1(DisasContext *s, int x)
     return x + 1;
 }
 
+static inline int rsub_64(DisasContext *s, int x)
+{
+    return 64 - x;
+}
+
+static inline int rsub_32(DisasContext *s, int x)
+{
+    return 32 - x;
+}
+static inline int rsub_16(DisasContext *s, int x)
+{
+    return 16 - x;
+}
+static inline int rsub_8(DisasContext *s, int x)
+{
+    return 8 - x;
+}
+
 /* Include the generated Neon decoder */
 #include "decode-neon-dp.inc.c"
 #include "decode-neon-ls.inc.c"
@@ -1348,3 +1366,26 @@ static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 
 DO_2SH(VSHL, tcg_gen_gvec_shli)
 DO_2SH(VSLI, gen_gvec_sli)
+
+static bool trans_VSHR_S_2sh(DisasContext *s, arg_2reg_shift *a)
+{
+    /* Signed shift out of range results in all-sign-bits */
+    a->shift = MIN(a->shift, (8 << a->size) - 1);
+    return do_vector_2sh(s, a, tcg_gen_gvec_sari);
+}
+
+static void gen_zero_rd_2sh(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                            int64_t shift, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_dup_imm(vece, rd_ofs, oprsz, maxsz, 0);
+}
+
+static bool trans_VSHR_U_2sh(DisasContext *s, arg_2reg_shift *a)
+{
+    /* Shift out of range is architecturally valid and results in zero. */
+    if (a->shift >= (8 << a->size)) {
+        return do_vector_2sh(s, a, gen_zero_rd_2sh);
+    } else {
+        return do_vector_2sh(s, a, tcg_gen_gvec_shri);
+    }
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d0a4a08f6d9..f2ccab1b21c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5296,6 +5296,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             op = (insn >> 8) & 0xf;
 
             switch (op) {
+            case 0: /* VSHR */
             case 5: /* VSHL, VSLI */
                 return 1; /* handled by decodetree */
             default:
@@ -5330,26 +5331,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
 
                 switch (op) {
-                case 0:  /* VSHR */
-                    /* Right shift comes here negative.  */
-                    shift = -shift;
-                    /* Shifts larger than the element size are architecturally
-                     * valid.  Unsigned results in all zeros; signed results
-                     * in all sign bits.
-                     */
-                    if (!u) {
-                        tcg_gen_gvec_sari(size, rd_ofs, rm_ofs,
-                                          MIN(shift, (8 << size) - 1),
-                                          vec_size, vec_size);
-                    } else if (shift >= 8 << size) {
-                        tcg_gen_gvec_dup_imm(MO_8, rd_ofs, vec_size,
-                                             vec_size, 0);
-                    } else {
-                        tcg_gen_gvec_shri(size, rd_ofs, rm_ofs, shift,
-                                          vec_size, vec_size);
-                    }
-                    return 0;
-
                 case 1:  /* VSRA */
                     /* Right shift comes here negative.  */
                     shift = -shift;
-- 
2.20.1


