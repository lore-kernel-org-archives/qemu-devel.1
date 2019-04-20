Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F05BC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0702D21479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhEfVSiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0702D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38241 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkjG-0002vG-4A
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:48:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWt-0000Es-Tg
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWs-0008PV-H3
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWs-0008OZ-B5
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:18 -0400
Received: by mail-pg1-x541.google.com with SMTP id 85so3602807pgc.3
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4wzV6OFZGlF90Lzl5pNsHL4DyaHrlHsg3fnJ58nfXjc=;
	b=mhEfVSiF1e0kyBao6RH+J09n3EDKdVTvtKnA4cJZQ7Q966kmY3L6wQ2SPOe/emq8Aw
	Ew728XxBgwAhKFisVtLLjAkKBw1/WniOaRq6T1zMCTxcmJOpPHPyVi8C72YTAe4W5hsc
	Owxw8tQs+uQpMtqpSdKM6Sh1N8DK/fThtBPiqfJkr/Ce8+FwkY9KoJ4RQUPyJBWGwyPN
	6bPQv7IHw2cKYtLdMYBthFlWWdKEn71+xPRzYbwPMMfY1hEdFA1zZ/RrsVJcnZbbOoz9
	4W5qPAEsk8i6G2rh9sQvjB7vLgh0KjTCxZZEix1VvnbcTowQXVDwGP56fXvYhk+RG8Bl
	zkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4wzV6OFZGlF90Lzl5pNsHL4DyaHrlHsg3fnJ58nfXjc=;
	b=WlGtOYDv3sgqhRqp3nnU0ijG+YG7iJ6/Cg3qCAJSkV2WLpJ9UU4CZD8EKA30cQYl7F
	Tbgzk7U6Cib+wCaOVHBvakiDzmFQGo6SM2XgsckuuWEwPE5nCvcrZegme/VQulgG0Toa
	tvXz5D6cHhClvuC4Ru8S36fp/eNbAtAjNDHG7c3yWtAu/zPA2QEgN6JdIGWolJvtDB1z
	rKNF/0c8xBexgpWJHGEO8vjkunWIzJCUvJxeh9J8KA0oHsIGoFQrMl0xLJouq4KeeQJx
	Z/yBI8kCBeBQoT7uO+qm5EKJ3QkoYFRcmdUmImnJe5xt8u8jIVnLN0cFi8xI9bLjeYRb
	t0Yg==
X-Gm-Message-State: APjAAAUzz9HIRv+/XZ3LKkcuYHWFWfAgNX4/vYyseqpUq8zbg+dstoUD
	03InwYGw09Gvlp5NEfLWyWXyixAKbwg=
X-Google-Smtp-Source: APXvYqx56eWui2Ql/qN2F3dbUvO/064yJ9CKXvUcXpGW9Kq1y3DBI4lSrN5QCDKjklEZSV5ouwshFA==
X-Received: by 2002:a63:e818:: with SMTP id s24mr8150779pgh.190.1555745717133; 
	Sat, 20 Apr 2019 00:35:17 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:23 -1000
Message-Id: <20190420073442.7488-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 19/38] tcg: Add support for integer absolute
 value
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073423.oXR3oWMK-JuV4wZCNYJiWa4pnwQiIMgSL0284yc0faE@z>

Remove a function of the same name from target/arm/.
Use a branchless implementation of abs that gcc uses for x86.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h           |  5 +++++
 target/arm/translate.c | 10 ----------
 tcg/tcg-op.c           | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 472b73cb38..660fe205d0 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -335,6 +335,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 
 static inline void tcg_gen_discard_i32(TCGv_i32 arg)
 {
@@ -534,6 +535,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 
 #if TCG_TARGET_REG_BITS == 64
 static inline void tcg_gen_discard_i64(TCGv_i64 arg)
@@ -973,6 +975,7 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
@@ -1019,6 +1022,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_addi_tl tcg_gen_addi_i64
 #define tcg_gen_sub_tl tcg_gen_sub_i64
 #define tcg_gen_neg_tl tcg_gen_neg_i64
+#define tcg_gen_abs_tl tcg_gen_abs_i64
 #define tcg_gen_subfi_tl tcg_gen_subfi_i64
 #define tcg_gen_subi_tl tcg_gen_subi_i64
 #define tcg_gen_and_tl tcg_gen_and_i64
@@ -1131,6 +1135,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_addi_tl tcg_gen_addi_i32
 #define tcg_gen_sub_tl tcg_gen_sub_i32
 #define tcg_gen_neg_tl tcg_gen_neg_i32
+#define tcg_gen_abs_tl tcg_gen_abs_i32
 #define tcg_gen_subfi_tl tcg_gen_subfi_i32
 #define tcg_gen_subi_tl tcg_gen_subi_i32
 #define tcg_gen_and_tl tcg_gen_and_i32
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 83a008e945..721171794d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -603,16 +603,6 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
     tcg_temp_free_i32(tmp1);
 }
 
-static void tcg_gen_abs_i32(TCGv_i32 dest, TCGv_i32 src)
-{
-    TCGv_i32 c0 = tcg_const_i32(0);
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_neg_i32(tmp, src);
-    tcg_gen_movcond_i32(TCG_COND_GT, dest, src, c0, src, tmp);
-    tcg_temp_free_i32(c0);
-    tcg_temp_free_i32(tmp);
-}
-
 static void shifter_out_im(TCGv_i32 var, int shift)
 {
     if (shift == 0) {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a00d1df37e..0ac291f1c4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1091,6 +1091,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
 }
 
+void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sari_i32(t, a, 31);
+    tcg_gen_xor_i32(ret, a, t);
+    tcg_gen_sub_i32(ret, ret, t);
+    tcg_temp_free_i32(t);
+}
+
 /* 64-bit ops */
 
 #if TCG_TARGET_REG_BITS == 32
@@ -2548,6 +2558,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
 }
 
+void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sari_i64(t, a, 63);
+    tcg_gen_xor_i64(ret, a, t);
+    tcg_gen_sub_i64(ret, ret, t);
+    tcg_temp_free_i64(t);
+}
+
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.17.1


