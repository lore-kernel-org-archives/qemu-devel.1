Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A99C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27945206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8x2OyAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27945206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR469-0001az-7f
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR416-00016s-Sr
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR416-0001Hv-3T
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:32 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR415-0001Dn-MB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:31 -0400
Received: by mail-pf1-x441.google.com with SMTP id g30so226307pfr.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0V/ZRxEb6ePbby7wOatIf966jqiZTa7L3IUbLbPYLQI=;
 b=v8x2OyAj2X+c7gtEEZpQUohma0vesyS9VL1HD4gx9DKmB7DRdD5MXUAKgHenD0kZZW
 M78XhjMUuE8RjRWKD+hVp4mmUBIFSFFLEAKSyJXEnpHHL0WbJBH2FyKSK14/IWuMahlg
 wPIT6q2RqTbsFU8pU+1eCD+Tk5gUfnenId/libB20Ca283NFHJ3ecMYuMqb4MRt5KSP/
 y/bw0SAZHCTHKrlMZA5UaTbZyQnP7tAydxZDWfVR15SXvbB7oX1SECe5WEQSFrW1aSq/
 gkkHbuGgdMliVUX2zY21tPr/BKbhKcJvS/j9oohqXUT0N4px8Zc7WVlQhj+yOq5DIbp0
 Vo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0V/ZRxEb6ePbby7wOatIf966jqiZTa7L3IUbLbPYLQI=;
 b=BDjBLiITUmoC7Y9WnNRH5/lRfRIYPaesBDGLqBp8qEiT4A+u7oYACJNutqLFYzrHSO
 bSuz9pA944IpDj+M/xo5l7osH4ZP6bwGdpTu9KGzPl8d7kFKBaHUvaXbFVzr4EQEGY8i
 ON4c9gZX4Yh+u7FOmPgMZb1YVCJYRkM/przs1KkyakCpV6Jnf6018GCHDP3svxIgRRNL
 zdKWpBiEVTXUZJz27DXGA/Sh4JuK1bHGVDvOkUOoyd+xtUgADVlkZh7fFLVeIzMqBuPb
 t+BvZmURJiKwTdCrNwuHKrtAqRUkdq1MnJXx/COcgUGqOj/v/Mk3BK/9HHik1q7QXt90
 Oo8w==
X-Gm-Message-State: AGi0PuacTcMLIqHRdx9IsAqSnqOhz3rY2JaEOBXMDW1Fcobfim1YxQN1
 ywNGcRO2q/V15yIJfV8/rPu77K7Ori8=
X-Google-Smtp-Source: APiQypJb5Ujz13nOy8njuSv/ny7l5yAyi8QMTd42lAtiVSmt9qecSHlY/0LiDimYQSpEhyvlp4SwLg==
X-Received: by 2002:aa7:8e0a:: with SMTP id c10mr24588404pfr.114.1587518249892; 
 Tue, 21 Apr 2020 18:17:29 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/36] target/arm: Use tcg_gen_gvec_dup_imm
Date: Tue, 21 Apr 2020 18:16:50 -0700
Message-Id: <20200422011722.13287-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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

In a few cases, we're able to remove some manual replication.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 10 +++++-----
 target/arm/translate-sve.c | 12 +++++-------
 target/arm/translate.c     |  9 ++++++---
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7580e46367..095638e09a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -519,7 +519,7 @@ static void clear_vec_high(DisasContext *s, bool is_q, int rd)
         tcg_temp_free_i64(tcg_zero);
     }
     if (vsz > 16) {
-        tcg_gen_gvec_dup8i(ofs + 16, vsz - 16, vsz - 16, 0);
+        tcg_gen_gvec_dup_imm(MO_64, ofs + 16, vsz - 16, vsz - 16, 0);
     }
 }
 
@@ -7794,8 +7794,8 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
 
     if (!((cmode & 0x9) == 0x1 || (cmode & 0xd) == 0x9)) {
         /* MOVI or MVNI, with MVNI negation handled above.  */
-        tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), is_q ? 16 : 8,
-                            vec_full_reg_size(s), imm);
+        tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), is_q ? 16 : 8,
+                             vec_full_reg_size(s), imm);
     } else {
         /* ORR or BIC, with BIC negation to AND handled above.  */
         if (is_neg) {
@@ -10223,8 +10223,8 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         if (is_u) {
             if (shift == 8 << size) {
                 /* Shift count the same size as element size produces zero.  */
-                tcg_gen_gvec_dup8i(vec_full_reg_offset(s, rd),
-                                   is_q ? 16 : 8, vec_full_reg_size(s), 0);
+                tcg_gen_gvec_dup_imm(size, vec_full_reg_offset(s, rd),
+                                     is_q ? 16 : 8, vec_full_reg_size(s), 0);
             } else {
                 gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shri, size);
             }
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b35bad245e..6c8bda4e4c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -177,7 +177,7 @@ static bool do_mov_z(DisasContext *s, int rd, int rn)
 static void do_dupi_z(DisasContext *s, int rd, uint64_t word)
 {
     unsigned vsz = vec_full_reg_size(s);
-    tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), vsz, vsz, word);
+    tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), vsz, vsz, word);
 }
 
 /* Invoke a vector expander on two Pregs.  */
@@ -1453,7 +1453,7 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
         unsigned oprsz = size_for_gvec(setsz / 8);
 
         if (oprsz * 8 == setsz) {
-            tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
+            tcg_gen_gvec_dup_imm(MO_64, ofs, oprsz, maxsz, word);
             goto done;
         }
     }
@@ -2044,7 +2044,7 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
             unsigned nofs = vec_reg_offset(s, a->rn, index, esz);
             tcg_gen_gvec_dup_mem(esz, dofs, nofs, vsz, vsz);
         } else {
-            tcg_gen_gvec_dup64i(dofs, vsz, vsz, 0);
+            tcg_gen_gvec_dup_imm(esz, dofs, vsz, vsz, 0);
         }
     }
     return true;
@@ -3260,9 +3260,7 @@ static bool trans_FDUP(DisasContext *s, arg_FDUP *a)
 
         /* Decode the VFP immediate.  */
         imm = vfp_expand_imm(a->esz, a->imm);
-        imm = dup_const(a->esz, imm);
-
-        tcg_gen_gvec_dup64i(dofs, vsz, vsz, imm);
+        tcg_gen_gvec_dup_imm(a->esz, dofs, vsz, vsz, imm);
     }
     return true;
 }
@@ -3276,7 +3274,7 @@ static bool trans_DUP_i(DisasContext *s, arg_DUP_i *a)
         unsigned vsz = vec_full_reg_size(s);
         int dofs = vec_full_reg_offset(s, a->rd);
 
-        tcg_gen_gvec_dup64i(dofs, vsz, vsz, dup_const(a->esz, a->imm));
+        tcg_gen_gvec_dup_imm(a->esz, dofs, vsz, vsz, a->imm);
     }
     return true;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9f9f4e19e0..af4d3ff4c9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5386,7 +5386,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                           MIN(shift, (8 << size) - 1),
                                           vec_size, vec_size);
                     } else if (shift >= 8 << size) {
-                        tcg_gen_gvec_dup8i(rd_ofs, vec_size, vec_size, 0);
+                        tcg_gen_gvec_dup_imm(MO_8, rd_ofs, vec_size,
+                                             vec_size, 0);
                     } else {
                         tcg_gen_gvec_shri(size, rd_ofs, rm_ofs, shift,
                                           vec_size, vec_size);
@@ -5437,7 +5438,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                          * architecturally valid and results in zero.
                          */
                         if (shift >= 8 << size) {
-                            tcg_gen_gvec_dup8i(rd_ofs, vec_size, vec_size, 0);
+                            tcg_gen_gvec_dup_imm(size, rd_ofs,
+                                                 vec_size, vec_size, 0);
                         } else {
                             tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
                                               vec_size, vec_size);
@@ -5783,7 +5785,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     tcg_temp_free_i64(t64);
                 } else {
-                    tcg_gen_gvec_dup32i(reg_ofs, vec_size, vec_size, imm);
+                    tcg_gen_gvec_dup_imm(MO_32, reg_ofs, vec_size,
+                                         vec_size, imm);
                 }
             }
         }
-- 
2.20.1


