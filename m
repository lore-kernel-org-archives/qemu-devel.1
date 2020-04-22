Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2987C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BFD20575
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxHEjOz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BFD20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4Hh-0004gC-Sp
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41V-0001ug-4Z
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41U-0002QF-G6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41U-0002MS-2H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id d17so271014pgo.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5EBqK+tM4Y7xOqKxuEa+KWDMy/xyFBtPmoMR4ACbhCI=;
 b=vxHEjOz2VHNcE9YolzHgmb1xH8+6SS/2ofhzlSZfuM7MpSORAgQ7oDwBy28Q6ulOQb
 GTh5cVPjnKD4V2VfCSa9O6Ljau8b0M/ANKo+GVyTK2b1mTXSG5giynlknK7R+u7d7feI
 M+wHWt8TBrQ4B+Vc6PM5vetiUwPOeKxJyTf6VITYlcCkgJtKWXxmr6HB5DQC8+Z4X+IM
 eJHnmI1WX+vyiKyVDn0H7qvAJA/Q2Gft3i5MuYKTmgCx20Vj80Hnvlz6VF0GD/MHTAMh
 F/1rx0p15KZ94FUAWIbVzhlbCmWhzH7ekMWobazJz3urAu5uZCH7H0F6HDav1SBJXOKf
 SiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5EBqK+tM4Y7xOqKxuEa+KWDMy/xyFBtPmoMR4ACbhCI=;
 b=PbBXlSmx4EAsvoKq2z8KmZjFt4mUkaPC7igyWZkJus55PEocoazosoduwahxiCedW6
 L+wTjsz2yPOQ99/Uc4+QXm6peWOu6xwTeYfMSHHiS2f9RQVSLVqC5VQzQWDcSigFCSDD
 wMfwuX/6m5hbRdjCX1mgBwDwg9tQQlZT+qnSHEZfrvJ41eppni82ZJ+gmxH+Gt7EKxNy
 XHxCmkKRpblOYxJH1eZTtFdRwNKW+jlEBXWoqclHx/Yd8ey+MMiSbe7UTcGJ+/zSq/Lk
 s8bjnv6TtWbhIOGw3VA4vpbybFVR6P4xMBNqZbma+zre6289eotZouTiAWwWojqQkDi4
 KLFg==
X-Gm-Message-State: AGi0PuYLSy74T/kmWHrz4V3U6Ci9CoVesMvWIb2bbVoPppNuWUMs+32A
 cjh7E8+tC/sLoSMO51TkWytCgIjhSY0=
X-Google-Smtp-Source: APiQypLOzn6urxICh+Jdho0+9zuPDEzVwNDJMdgkyN46vPIowIpDoRgSmcwcnR72ms8gbBaklvkUfg==
X-Received: by 2002:a63:fc45:: with SMTP id r5mr22421412pgk.440.1587518274422; 
 Tue, 21 Apr 2020 18:17:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 24/36] tcg/i386: Use tcg_constant_vec with tcg vec expanders
Date: Tue, 21 Apr 2020 18:17:10 -0700
Message-Id: <20200422011722.13287-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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


