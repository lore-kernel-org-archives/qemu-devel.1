Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E41CC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B687206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dF+G9V1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B687206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR43y-0006Ot-8m
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR414-00013c-3s
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR413-00018G-Ge
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:29 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR413-00012Q-23
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:29 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a22so152442pjk.5
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dOnBBGhmkNTpQUIqTasvNhE2MTWW7gI0dB3WMtwwkiQ=;
 b=dF+G9V1jvI1961CjsImzyiM4/+mpSq1Jo0LdN4EHEONWL9h7ryuY4v5BjOICv1C1ZF
 fbuDzsj02QPNAQEHhCaXhdJg4FuXrxp/Rf2fH+yHlM43Q5aBkdabtnNr7HE8ZXPr4eKR
 6r06QCyFMKSSLNhzD8Omk2CzPJL1nEdT3nWCJNaxYwztpTWelf93qh+OzF4E5lkZ3nsX
 FclFMN5OWC6U6QuE9LnwxMQ02peErI81z5DgzaBhfjt9nMfOnjK4fL7dKsr/inDdOlGj
 wwzfMO03hIJE7ObY+cALNXhFFRGK/8/DHAVx4/IqbDpquPiKO//GdqlYmKvpqtL4Bq2X
 34LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dOnBBGhmkNTpQUIqTasvNhE2MTWW7gI0dB3WMtwwkiQ=;
 b=YTp89ikorjTAObCtPjTIzgvs+Dvft2s8A/pCJeB2uh3gynDD32z1TFiGI7X6vIlYnx
 i0NbOPD9XouF45PGjvbHtI3SVUASXS8ZcuX5TSFbSL0tc7rRdo3wbtOZjBpbXEBhAFnt
 MIPZn23Rg+5ZfRtlloUlKubD52jpH8frHlGk8kMGWHAJ4SYYp+a62DrYBS6GMusRGGKv
 xvrREBYd1LifsrJ84FuvDxAqK/ONS7L50tLenOMJgkNo94Yuyco665JeHAGG7eLzeeQU
 yS0Ez9S3c8fFUD7yTEpZb5wfu/O4s97mN9w0SAExI52m5fJ3viVpJmwySKtmrjcBHJXf
 xNfQ==
X-Gm-Message-State: AGi0PuZ1GRVsMKK4+bvc40X8viDan/k9/MXz1DXSRq/M0WqDvGoaRvNH
 pGMYShs9WqAECE35kN34AIx7dwhyoiM=
X-Google-Smtp-Source: APiQypInyHJhpdChdkB6VKjrD4itentCi9nK2kta4NZzhL5kYPYHdofDsKNTQIrtrNvFyd88jM6pFw==
X-Received: by 2002:a17:90a:f995:: with SMTP id
 cq21mr8699807pjb.56.1587518247266; 
 Tue, 21 Apr 2020 18:17:27 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/36] target/s390x: Use tcg_gen_gvec_dup_imm
Date: Tue, 21 Apr 2020 18:16:48 -0700
Message-Id: <20200422011722.13287-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: alex.bennee@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The gen_gvec_dupi switch is unnecessary with the new function.
Replace it with a local gen_gvec_dup_imm that takes care of the
register to offset conversion and length arguments.

Drop zero_vec and use use gen_gvec_dup_imm with 0.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate_vx.inc.c | 41 +++++++--------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 24558cce80..12347f8a03 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -231,8 +231,8 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
 #define gen_gvec_mov(v1, v2) \
     tcg_gen_gvec_mov(0, vec_full_reg_offset(v1), vec_full_reg_offset(v2), 16, \
                      16)
-#define gen_gvec_dup64i(v1, c) \
-    tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
+#define gen_gvec_dup_imm(es, v1, c) \
+    tcg_gen_gvec_dup_imm(es, vec_full_reg_offset(v1), 16, 16, c);
 #define gen_gvec_fn_2(fn, es, v1, v2) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                       16, 16)
@@ -316,31 +316,6 @@ static void gen_gvec128_4_i64(gen_gvec128_4_i64_fn fn, uint8_t d, uint8_t a,
         tcg_temp_free_i64(cl);
 }
 
-static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
-{
-    switch (es) {
-    case ES_8:
-        tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, c);
-        break;
-    case ES_16:
-        tcg_gen_gvec_dup16i(vec_full_reg_offset(reg), 16, 16, c);
-        break;
-    case ES_32:
-        tcg_gen_gvec_dup32i(vec_full_reg_offset(reg), 16, 16, c);
-        break;
-    case ES_64:
-        gen_gvec_dup64i(reg, c);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void zero_vec(uint8_t reg)
-{
-    tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, 0);
-}
-
 static void gen_addi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i64 ah,
                           uint64_t b)
 {
@@ -396,8 +371,8 @@ static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
          * Masks for both 64 bit elements of the vector are the same.
          * Trust tcg to produce a good constant loading.
          */
-        gen_gvec_dup64i(get_field(s, v1),
-                        generate_byte_mask(i2 & 0xff));
+        gen_gvec_dup_imm(ES_64, get_field(s, v1),
+                         generate_byte_mask(i2 & 0xff));
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
 
@@ -432,7 +407,7 @@ static DisasJumpType op_vgm(DisasContext *s, DisasOps *o)
         }
     }
 
-    gen_gvec_dupi(es, get_field(s, v1), mask);
+    gen_gvec_dup_imm(es, get_field(s, v1), mask);
     return DISAS_NEXT;
 }
 
@@ -585,7 +560,7 @@ static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
 
     t = tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TE | es);
-    zero_vec(get_field(s, v1));
+    gen_gvec_dup_imm(es, get_field(s, v1), 0);
     write_vec_element_i64(t, get_field(s, v1), enr, es);
     tcg_temp_free_i64(t);
     return DISAS_NEXT;
@@ -892,7 +867,7 @@ static DisasJumpType op_vrepi(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    gen_gvec_dupi(es, get_field(s, v1), data);
+    gen_gvec_dup_imm(es, get_field(s, v1), data);
     return DISAS_NEXT;
 }
 
@@ -1372,7 +1347,7 @@ static DisasJumpType op_vcksm(DisasContext *s, DisasOps *o)
         read_vec_element_i32(tmp, get_field(s, v2), i, ES_32);
         tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);
     }
-    zero_vec(get_field(s, v1));
+    gen_gvec_dup_imm(ES_32, get_field(s, v1), 0);
     write_vec_element_i32(sum, get_field(s, v1), 1, ES_32);
 
     tcg_temp_free_i32(tmp);
-- 
2.20.1


