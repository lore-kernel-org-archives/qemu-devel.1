Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F6C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5260206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzlDTfQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5260206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR48J-0005qQ-Rw
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41K-0001ZV-Vi
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41I-0001ng-JL
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:46 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41I-0001lj-5p
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:44 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ms17so163357pjb.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jnoGz1Jnxdfh+y+NorE/kRAs3qyr4Q4Rbpyv23cxSxY=;
 b=xzlDTfQHDWl9Yl7ipMplJS61jujecIZge+sbAyrqCY41SxvC17wz6gQpEyk3ZERa6A
 n361T43vn6yQVjP1aRlea0iHn6h8wcScNj1xE+4c+u+wFZMP1b2AWvSZkCUfrwakcO4i
 YtR2zOUWt5j8Bd4oXVNGBEH+uXRbTbHds6Qq34daqnGcCxN1fuo6bLTgFJXBbOVe6j6p
 KcK9g+OzUi6pS9PNZe/GF/zDB/0YEljmtb9fKMDkf5KR4RYsVI2cCKJIbm0gM1V8G5XT
 R/ZEuILsuZmc7FA6FK8J/SAW5J8e3/o4xsEpzqF8cs96XWWZERgr3ZrKmofvxmiezRTH
 Gm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jnoGz1Jnxdfh+y+NorE/kRAs3qyr4Q4Rbpyv23cxSxY=;
 b=YXC+D9SYlQPcYGI/L/74+SjJSjcvloQ0voZQA7MhIvtq0H416BUg3sUBbZGKdcyxw5
 ZLunb3z+HacLPEQZuDEEeHIS0Gi2q8KxGZasZ2FKvxKQd3ggCsFsNolz9MkuUvi/u2H4
 CzUJm1p20jXCfmp/S6oCQy8Iz6Hi3Nq85uuikocE1U9LSxz66eCf66eiale2mrrUe/mc
 I6PJWgntO3nIzQTrkEXjstDlmud4XWfrXjR8LujirZfIKtguNpzRrBjo+GWmIc2DhhCk
 RUTETKT+LSVBc4KcT01Kfd89Y/rLrovr8CR1Z+smakHyQRjdYG/jKc2MLWwoOgEhqxri
 A+Kg==
X-Gm-Message-State: AGi0PuZ+RscMzztc/CqOo/VkphXfeB6SsV6JJP6TEMAIfJEJ5R/P59qx
 1K6Iz9vgJsThex90SDh7Ciwyucd0u8I=
X-Google-Smtp-Source: APiQypJ/wfUhgQnHzC3y1opTWlTnuWD2a/OnBcsItV1xp5XwbiEDGQND0+M8TjxbOceJRpeaAeXLyQ==
X-Received: by 2002:a17:902:8e8b:: with SMTP id
 bg11mr22995354plb.139.1587518262405; 
 Tue, 21 Apr 2020 18:17:42 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/36] tcg: Use tcg_constant_{i32,
 vec} with tcg vec expanders
Date: Tue, 21 Apr 2020 18:17:00 -0700
Message-Id: <20200422011722.13287-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1042
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 63 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index f3927089a7..655b3ae32d 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -233,25 +233,17 @@ void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
     }
 }
 
-#define MO_REG  (TCG_TARGET_REG_BITS == 64 ? MO_64 : MO_32)
-
-static void do_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
-{
-    TCGTemp *rt = tcgv_vec_temp(r);
-    vec_gen_2(INDEX_op_dupi_vec, rt->base_type, vece, temp_arg(rt), a);
-}
-
 TCGv_vec tcg_const_zeros_vec(TCGType type)
 {
     TCGv_vec ret = tcg_temp_new_vec(type);
-    do_dupi_vec(ret, MO_REG, 0);
+    tcg_gen_mov_vec(ret, tcg_constant_vec(type, MO_8, 0));
     return ret;
 }
 
 TCGv_vec tcg_const_ones_vec(TCGType type)
 {
     TCGv_vec ret = tcg_temp_new_vec(type);
-    do_dupi_vec(ret, MO_REG, -1);
+    tcg_gen_mov_vec(ret, tcg_constant_vec(type, MO_8, -1));
     return ret;
 }
 
@@ -267,37 +259,50 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
     return tcg_const_ones_vec(t->base_type);
 }
 
-void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
+void tcg_gen_dupi_vec(unsigned vece, TCGv_vec dest, uint64_t val)
 {
-    if (TCG_TARGET_REG_BITS == 32 && a == deposit64(a, 32, 32, a)) {
-        do_dupi_vec(r, MO_32, a);
-    } else if (TCG_TARGET_REG_BITS == 64 || a == (uint64_t)(int32_t)a) {
-        do_dupi_vec(r, MO_64, a);
-    } else {
-        TCGv_i64 c = tcg_const_i64(a);
-        tcg_gen_dup_i64_vec(MO_64, r, c);
-        tcg_temp_free_i64(c);
+    TCGType type = tcgv_vec_temp(dest)->base_type;
+
+    /*
+     * For MO_64 constants that can't be represented in tcg_target_long,
+     * we must use INDEX_op_dup2_vec.
+     */
+    if (TCG_TARGET_REG_BITS == 32) {
+        val = dup_const(vece, val);
+        if (val != deposit64(val, 32, 32, val) &&
+            val != (uint64_t)(int32_t)val) {
+            uint32_t vl = extract64(val, 0, 32);
+            uint32_t vh = extract64(val, 32, 32);
+            TCGArg al = tcgv_i32_arg(tcg_constant_i32(vl));
+            TCGArg ah = tcgv_i32_arg(tcg_constant_i32(vh));
+            TCGArg di = tcgv_vec_arg(dest);
+
+            vec_gen_3(INDEX_op_dup2_vec, type, MO_64, di, al, ah);
+            return;
+        }
     }
+
+    tcg_gen_mov_vec(dest, tcg_constant_vec(type, vece, val));
 }
 
-void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup64i_vec(TCGv_vec dest, uint64_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_32, a));
+    tcg_gen_dupi_vec(MO_64, dest, val);
 }
 
-void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup32i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_16, a));
+    tcg_gen_dupi_vec(MO_32, dest, val);
 }
 
-void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup16i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_8, a));
+    tcg_gen_dupi_vec(MO_16, dest, val);
 }
 
-void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
+void tcg_gen_dup8i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(vece, a));
+    tcg_gen_dupi_vec(MO_8, dest, val);
 }
 
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
@@ -502,8 +507,8 @@ void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
             if (tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0) {
                 tcg_gen_sari_vec(vece, t, a, (8 << vece) - 1);
             } else {
-                do_dupi_vec(t, MO_REG, 0);
-                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a, t);
+                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a,
+                                tcg_constant_vec(type, vece, 0));
             }
             tcg_gen_xor_vec(vece, r, a, t);
             tcg_gen_sub_vec(vece, r, r, t);
-- 
2.20.1


