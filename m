Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678D2C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374F920776
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W60N9OXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374F920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqPe-0007GK-CT
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBy-0004Tm-CP
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBu-0005fd-Og
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:42 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBu-0005cM-Is
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:38 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ms17so2475909pjb.0
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5EBqK+tM4Y7xOqKxuEa+KWDMy/xyFBtPmoMR4ACbhCI=;
 b=W60N9OXyx7ub7eJyM6bNMuEhCl6l5tLDnpMR/1B83NV2xQ15N/khrf8GRbS9c7kAOP
 SnHLL2pAMA1tQJk7Txz4oTRtTRUjFUE8UbF2bI9S9vanG29MWPichT2dBGuJOG8r7SjV
 n+94X+EfZ2OkpP9kWh819zzVK72hJB+G1/0PTIJ9b0MVT5lE6/M3brK7Dc/lFmcsG0LI
 l8+Xu7KY+fYuuVO/ju8ZybhM0aIFGhGJAy9XPVACk0apDMSMQK7vD8mXCAWCjLkLKHtw
 gO1QixRXeqoIHOI8AiJeftPQFXqnYPIzFF33Yn9lrR/xrJJ08L+xEDkHtTc2Len0WqUR
 7hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5EBqK+tM4Y7xOqKxuEa+KWDMy/xyFBtPmoMR4ACbhCI=;
 b=FhfDn00R0xEmcbgOkLqnPgBm3O+iXHEt4uySpzQc46CPf8eE02TE6JBj9/kvceoaHw
 9umA0QzXoauwBSo4ONN6jwza8UrhaOIKlV29NkxRhyw4DgYO7zFm7eOousIVVWaPQzIb
 hTAFxptNKsnPS1jHVaM3Fj44BTp/TKsnI/i2FyRdK+YrQX3RRxhg61DJ0pBIzRGhx2Wr
 AVsgKWAlFm9Z+nluBYAydE0dav0ZivHcpbwBM6g7MSy7rMgKlztTR/CIW31s8qU+V/3H
 rpJazSLxflXrf0G6LmG/qnjfMstN3yOc53a1d89kL63dof0qSplBDsPs/tydgDWduG0U
 09jg==
X-Gm-Message-State: AGi0PuZiRb2sgHywTV9Pr7rWG0v/SADn7ufc4e1iwkFyhjaHEFjPI9V2
 7a2rlpZPxurmcimjy+O896EN6DE8QUU=
X-Google-Smtp-Source: APiQypI9gwFPFD1q5Uexmfg96tGkmilqa5C46uvcfLp6PRk7nD2IiUX0QRifYSxz4iPE0E8uPZKVDg==
X-Received: by 2002:a17:902:a40e:: with SMTP id
 p14mr8406466plq.297.1587226776818; 
 Sat, 18 Apr 2020 09:19:36 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] tcg/i386: Use tcg_constant_vec with tcg vec expanders
Date: Sat, 18 Apr 2020 09:19:13 -0700
Message-Id: <20200418161914.4387-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418161914.4387-1-richard.henderson@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 9cb627d6eb..deace219d2 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3452,7 +3452,7 @@ static void expand_vec_sari(TCGType type, unsigned vece,
 static void expand_vec_mul(TCGType type, unsigned vece,
                            TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
 {
-    TCGv_vec t1, t2, t3, t4;
+    TCGv_vec t1, t2, t3, t4, zero;
 
     tcg_debug_assert(vece == MO_8);
 
@@ -3470,11 +3470,11 @@ static void expand_vec_mul(TCGType type, unsigned vece,
     case TCG_TYPE_V64:
         t1 = tcg_temp_new_vec(TCG_TYPE_V128);
         t2 = tcg_temp_new_vec(TCG_TYPE_V128);
-        tcg_gen_dup16i_vec(t2, 0);
+        zero = tcg_constant_vec(TCG_TYPE_V128, MO_8, 0);
         vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
-                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t2));
+                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(zero));
         vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
-                  tcgv_vec_arg(t2), tcgv_vec_arg(t2), tcgv_vec_arg(v2));
+                  tcgv_vec_arg(t2), tcgv_vec_arg(zero), tcgv_vec_arg(v2));
         tcg_gen_mul_vec(MO_16, t1, t1, t2);
         tcg_gen_shri_vec(MO_16, t1, t1, 8);
         vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
@@ -3489,15 +3489,15 @@ static void expand_vec_mul(TCGType type, unsigned vece,
         t2 = tcg_temp_new_vec(type);
         t3 = tcg_temp_new_vec(type);
         t4 = tcg_temp_new_vec(type);
-        tcg_gen_dup16i_vec(t4, 0);
+        zero = tcg_constant_vec(TCG_TYPE_V128, MO_8, 0);
         vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
-                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
+                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(zero));
         vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
-                  tcgv_vec_arg(t2), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
+                  tcgv_vec_arg(t2), tcgv_vec_arg(zero), tcgv_vec_arg(v2));
         vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
-                  tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
+                  tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(zero));
         vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
-                  tcgv_vec_arg(t4), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
+                  tcgv_vec_arg(t4), tcgv_vec_arg(zero), tcgv_vec_arg(v2));
         tcg_gen_mul_vec(MO_16, t1, t1, t2);
         tcg_gen_mul_vec(MO_16, t3, t3, t4);
         tcg_gen_shri_vec(MO_16, t1, t1, 8);
@@ -3525,7 +3525,7 @@ static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
         NEED_UMIN = 8,
         NEED_UMAX = 16,
     };
-    TCGv_vec t1, t2;
+    TCGv_vec t1, t2, t3;
     uint8_t fixup;
 
     switch (cond) {
@@ -3596,9 +3596,9 @@ static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
     } else if (fixup & NEED_BIAS) {
         t1 = tcg_temp_new_vec(type);
         t2 = tcg_temp_new_vec(type);
-        tcg_gen_dupi_vec(vece, t2, 1ull << ((8 << vece) - 1));
-        tcg_gen_sub_vec(vece, t1, v1, t2);
-        tcg_gen_sub_vec(vece, t2, v2, t2);
+        t3 = tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
+        tcg_gen_sub_vec(vece, t1, v1, t3);
+        tcg_gen_sub_vec(vece, t2, v2, t3);
         v1 = t1;
         v2 = t2;
         cond = tcg_signed_cond(cond);
-- 
2.20.1


