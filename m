Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1C0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB4622CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqHQQrXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB4622CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i347T-0000Jd-Nd
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H3-00044i-0T
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gz-0000nz-NQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:28 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gy-0000m7-Dy
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:25 -0400
Received: by mail-pl1-x641.google.com with SMTP id h3so394195pls.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ijHYxCUn6f0ZOEbuhhCiCPGi01F+vFhNmSbEgOS+/68=;
 b=vqHQQrXGPGevYm38GhQ67ZOa0a/PVes8aUV0mGiHniBhkDzKBG8RTmPdSixRXGGj8B
 nmjmF9+KOViNCTK6GYNRBv6pxQuVDh71NHSoxxdZllQK9BN1lbKcGjBQ3Y3g9SEqlThN
 S+MYgHJ7JWqVx/3D43TXqOz7JbhTfeS9N+amhptFeqqFSxZXRuAJe7jv5A92qHMLrc5J
 ySfzS00gkazwf2cXMq5fUEtiYvn6/KMAVALs5b3wCsCekfSau/kW40kqhCneXBr9woOx
 DozSFl3zj4z9M6WjMbArPFXLOTyChYQ9kvP3MlEze6r6mWm7x6PPGJx2PmI1eXSVQQo1
 F4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ijHYxCUn6f0ZOEbuhhCiCPGi01F+vFhNmSbEgOS+/68=;
 b=ahKqU9F7BOclZuLmbbuLxGuJwSxPJxVFVJjZ+VprZNGpVBJv/6ENQ1LGbXXbYpLuos
 /w3G/2OjYRwImDycm8UPJYDxencGsQ2UC+QVHyz/Iq8bl54OfU3QV0LKcZqK+G5b9+4J
 r3pyH65u40ewVwWGvcdoiCdkq5fpVC202YmRn6HaxnBYOQxdYj6Pzg8nm+bKyzG1Glct
 mdX3DpJr8F8/+ZDIkpGUNeKfxOicUMAdfSZahod6rtv10xfBTrWmKeI+s2mQzXLemMKR
 mFmsyJ1bIo20aLxtyryfxZsKkDYemMnT1jJPYcD7+81WddLUW4ccpuJMhBoPdZouRVL0
 4rTg==
X-Gm-Message-State: APjAAAWZ5HAOYqu/C2bA+QZezIBNSVdWl+bSkAf3MABG1ShD7HExnazw
 LhM47MgFH95wGU4qjODAXpOhInFwOx0=
X-Google-Smtp-Source: APXvYqygtfIv+SGMZvwX9jAcDcdTLzaRoFk0K9alxqK3kCoLIQ36fH+8wS9I5Nimdf9bNobyZQQL3w==
X-Received: by 2002:a17:902:74c7:: with SMTP id
 f7mr1749065plt.263.1567019181992; 
 Wed, 28 Aug 2019 12:06:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:52 -0700
Message-Id: <20190828190456.30315-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 65/69] target/arm: Convert T16,
 load (literal)
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
 target/arm/translate.c | 42 ++----------------------------------------
 target/arm/t16.decode  |  4 ++++
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index dd292b3042..fe9f7e4f42 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -963,14 +963,6 @@ static inline void gen_aa32_ld##SUFF(DisasContext *s, TCGv_i32 val,      \
                                      TCGv_i32 a32, int index)            \
 {                                                                        \
     gen_aa32_ld_i32(s, val, a32, index, OPC | s->be_data);               \
-}                                                                        \
-static inline void gen_aa32_ld##SUFF##_iss(DisasContext *s,              \
-                                           TCGv_i32 val,                 \
-                                           TCGv_i32 a32, int index,      \
-                                           ISSInfo issinfo)              \
-{                                                                        \
-    gen_aa32_ld##SUFF(s, val, a32, index);                               \
-    disas_set_da_iss(s, OPC, issinfo);                                   \
 }
 
 #define DO_GEN_ST(SUFF, OPC)                                             \
@@ -978,14 +970,6 @@ static inline void gen_aa32_st##SUFF(DisasContext *s, TCGv_i32 val,      \
                                      TCGv_i32 a32, int index)            \
 {                                                                        \
     gen_aa32_st_i32(s, val, a32, index, OPC | s->be_data);               \
-}                                                                        \
-static inline void gen_aa32_st##SUFF##_iss(DisasContext *s,              \
-                                           TCGv_i32 val,                 \
-                                           TCGv_i32 a32, int index,      \
-                                           ISSInfo issinfo)              \
-{                                                                        \
-    gen_aa32_st##SUFF(s, val, a32, index);                               \
-    disas_set_da_iss(s, OPC, issinfo | ISSIsWrite);                      \
 }
 
 static inline void gen_aa32_frob64(DisasContext *s, TCGv_i64 val)
@@ -1034,9 +1018,7 @@ static inline void gen_aa32_st64(DisasContext *s, TCGv_i64 val,
     gen_aa32_st_i64(s, val, a32, index, MO_Q | s->be_data);
 }
 
-DO_GEN_LD(8s, MO_SB)
 DO_GEN_LD(8u, MO_UB)
-DO_GEN_LD(16s, MO_SW)
 DO_GEN_LD(16u, MO_UW)
 DO_GEN_LD(32u, MO_UL)
 DO_GEN_ST(8, MO_UB)
@@ -10731,11 +10713,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, rd;
+    uint32_t val;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
-    TCGv_i32 addr;
 
     if (disas_t16(s, insn)) {
         return;
@@ -10745,26 +10726,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     switch (insn >> 12) {
     case 0: case 1: /* add/sub (3reg, 2reg imm), shift imm; in decodetree */
     case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
-        goto illegal_op;
-    case 4:
-        if (insn & (1 << 11)) {
-            rd = (insn >> 8) & 7;
-            /* load pc-relative.  Bit 1 of PC is ignored.  */
-            addr = add_reg_for_lit(s, 15, (insn & 0xff) * 4);
-            tmp = tcg_temp_new_i32();
-            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s),
-                               rd | ISSIs16Bit);
-            tcg_temp_free_i32(addr);
-            store_reg(s, rd, tmp);
-            break;
-        }
-
-        /*
-         * - Data-processing (two low registers), in decodetree
-         * - data processing extended, branch and exchange, in decodetree
-         */
-        goto illegal_op;
-
+    case 4: /* ldr lit, data proc (2reg), data proc ext, bx; in decodetree */
     case 5: /* load/store register offset, in decodetree */
     case 6: /* load/store word immediate offset, in decodetree */
     case 7: /* load/store byte immediate offset, in decodetree */
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 79a1d66d6c..0b4da411e0 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -113,6 +113,10 @@ LDRH_ri         10001 ..... ... ...             @ldst_ri_2
 STR_ri          10010 ... ........              @ldst_spec_i rn=13
 LDR_ri          10011 ... ........              @ldst_spec_i rn=13
 
+# Load (PC-relative)
+
+LDR_ri          01001 ... ........              @ldst_spec_i rn=15
+
 # Add PC/SP (immediate)
 
 ADR             10100 rd:3 ........             imm=%imm8_0x4
-- 
2.17.1


