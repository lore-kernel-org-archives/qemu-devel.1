Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E218C38A2F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1C620776
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPXdQ/4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1C620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqHc-0004ga-4b
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBj-00049X-VU
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBg-0004zJ-BI
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:43395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBf-0004vy-W7
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id z6so2205213plk.10
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3L4RfFRSjz+k9D2woCHu0bThFj4aBhRBA4gE0EtRBC4=;
 b=cPXdQ/4cZcZoxVW0RsoSCQZy4AA2HLmTYKJRsqzDgALQa6wQG3qCV+c5qGWgrBloSu
 UO/NGmfpRt5LeV/6MhnL94wyDzAAMIs/3keM3+UCztFrC8R52CTJuv14cQg+UFw+LvFN
 3m2NLUk6bM/QizfExogWsNM//i6y/PB+aLaL3nMvnWl0I91SeqjAD5vjL+JSxR9z2YA4
 j55LQLsHCiQNB4uYhtXY+nqWQcLuJRsIIMtBVJc4G1JojhQCaA+0ylpQa8vwwDlFARk4
 DWj/zHdQkwqfyszIl1KM5XYGD8eaNWFFgr+DOsMTl2o9naXy1ZUX1xj6IWCHyAMrIEC7
 jIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3L4RfFRSjz+k9D2woCHu0bThFj4aBhRBA4gE0EtRBC4=;
 b=LrWCgm8/JO3TI0e2mfbxSzkZRh633bGHE3JH1xM+7yWFAYWwiPeGZxdiAfjD6jqUtA
 ncKdyyjHfwJdQolfhMQpkMQyPjN6c11jQ6tw+1XnFQ3bZbq4NGhC3oD2F9VNSqfRnxtg
 YLj3q0F4/ci8HP1jOH4Qa1tqwTe0Gc9llqEiicqPHPGprtgWgvIqIbHaOM9PBA0TfaK2
 v2gMuNopCjrmdGasYaepCo5Oqj1NBW8MEqOa9URaumXuo9cwtTlJKIfVH9Dern6uMOrO
 mAeOqEE7mjf1TKoa1vH5HZcVSlOHV68GM78u3bcf6t+pltb8G/tbrSJbaJ8Q3MD5s2T4
 4P5A==
X-Gm-Message-State: AGi0PuZb7kkGjQQRMugcVKZftmdtuxs8/0e7jw8qR4CHLLhg10qnMVU+
 K7LRfXpZtFvn9grlnmzQdUohTvtTBkg=
X-Google-Smtp-Source: APiQypKbJoZ7wAWkIkFZBa0ZO9kZ86SelkHOoZCDm/KNckZrP6Vt+zVF+qMXdPEBtvafAkqYcWQo1g==
X-Received: by 2002:a17:90a:32ea:: with SMTP id
 l97mr11043527pjb.50.1587226762164; 
 Sat, 18 Apr 2020 09:19:22 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/16] tcg: Use tcg_constant_{i32,i64} with tcg int expanders
Date: Sat, 18 Apr 2020 09:19:02 -0700
Message-Id: <20200418161914.4387-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418161914.4387-1-richard.henderson@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
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
 include/tcg/tcg-op.h |  13 +--
 tcg/tcg-op.c         | 216 ++++++++++++++++++++-----------------------
 2 files changed, 100 insertions(+), 129 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 230db6e022..11ed9192f7 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -271,6 +271,7 @@ void tcg_gen_mb(TCGBar);
 
 /* 32 bit ops */
 
+void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -349,11 +350,6 @@ static inline void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-static inline void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-{
-    tcg_gen_op2i_i32(INDEX_op_movi_i32, ret, arg);
-}
-
 static inline void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2,
                                     tcg_target_long offset)
 {
@@ -467,6 +463,7 @@ static inline void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 /* 64 bit ops */
 
+void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
@@ -550,11 +547,6 @@ static inline void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-static inline void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_op2i_i64(INDEX_op_movi_i64, ret, arg);
-}
-
 static inline void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2,
                                     tcg_target_long offset)
 {
@@ -698,7 +690,6 @@ static inline void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_discard_i64(TCGv_i64 arg);
 void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e2e25ebf7d..07eb661a07 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -104,15 +104,18 @@ void tcg_gen_mb(TCGBar mb_type)
 
 /* 32 bit ops */
 
+void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
+{
+    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
+}
+
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_add_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -122,9 +125,7 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
         /* Don't recurse with tcg_gen_neg_i32.  */
         tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg2);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg1);
-        tcg_gen_sub_i32(ret, t0, arg2);
-        tcg_temp_free_i32(t0);
+        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
     }
 }
 
@@ -134,15 +135,12 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_sub_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    TCGv_i32 t0;
     /* Some cases can be optimized here.  */
     switch (arg2) {
     case 0:
@@ -165,9 +163,8 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
         }
         break;
     }
-    t0 = tcg_const_i32(arg2);
-    tcg_gen_and_i32(ret, arg1, t0);
-    tcg_temp_free_i32(t0);
+
+    tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -178,9 +175,7 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -193,9 +188,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
         /* Don't recurse with tcg_gen_not_i32.  */
         tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_xor_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -205,9 +198,7 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_shl_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -217,9 +208,7 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_shr_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -229,9 +218,7 @@ void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_sar_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -250,9 +237,7 @@ void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_brcond_i32(cond, arg1, t0, l);
-        tcg_temp_free_i32(t0);
+        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
     }
 }
 
@@ -271,9 +256,7 @@ void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
-    TCGv_i32 t0 = tcg_const_i32(arg2);
-    tcg_gen_setcond_i32(cond, ret, arg1, t0);
-    tcg_temp_free_i32(t0);
+    tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -283,9 +266,7 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     } else if (is_power_of_2(arg2)) {
         tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_mul_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -433,9 +414,7 @@ void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
-    TCGv_i32 t = tcg_const_i32(arg2);
-    tcg_gen_clz_i32(ret, arg1, t);
-    tcg_temp_free_i32(t);
+    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
@@ -468,10 +447,9 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
             tcg_gen_clzi_i32(t, t, 32);
             tcg_gen_xori_i32(t, t, 31);
         }
-        z = tcg_const_i32(0);
+        z = tcg_constant_i32(0);
         tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
         tcg_temp_free_i32(t);
-        tcg_temp_free_i32(z);
     } else {
         gen_helper_ctz_i32(ret, arg1, arg2);
     }
@@ -487,9 +465,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
         tcg_gen_ctpop_i32(ret, t);
         tcg_temp_free_i32(t);
     } else {
-        TCGv_i32 t = tcg_const_i32(arg2);
-        tcg_gen_ctz_i32(ret, arg1, t);
-        tcg_temp_free_i32(t);
+        tcg_gen_ctz_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -547,9 +523,7 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else if (TCG_TARGET_HAS_rot_i32) {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_rotl_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_rotl_i32(ret, arg1, tcg_constant_i32(arg2));
     } else {
         TCGv_i32 t0, t1;
         t0 = tcg_temp_new_i32();
@@ -653,9 +627,8 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
     } else if (TCG_TARGET_HAS_deposit_i32
                && TCG_TARGET_deposit_i32_valid(ofs, len)) {
-        TCGv_i32 zero = tcg_const_i32(0);
+        TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
-        tcg_temp_free_i32(zero);
     } else {
         /* To help two-operand hosts we prefer to zero-extend first,
            which allows ARG to stay live.  */
@@ -1052,7 +1025,7 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
     } else {
         TCGv_i32 t0 = tcg_temp_new_i32();
         TCGv_i32 t1 = tcg_temp_new_i32();
-        TCGv_i32 t2 = tcg_const_i32(0x00ff00ff);
+        TCGv_i32 t2 = tcg_constant_i32(0x00ff00ff);
 
                                         /* arg = abcd */
         tcg_gen_shri_i32(t0, arg, 8);   /*  t0 = .abc */
@@ -1067,7 +1040,6 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-        tcg_temp_free_i32(t2);
     }
 }
 
@@ -1237,6 +1209,14 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t0);
     tcg_temp_free_i32(t1);
 }
+
+#else
+
+void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
+{
+    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
+}
+
 #endif /* TCG_TARGET_REG_SIZE == 32 */
 
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
@@ -1244,10 +1224,12 @@ void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_add_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >> 32));
     }
 }
 
@@ -1256,10 +1238,12 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     if (arg1 == 0 && TCG_TARGET_HAS_neg_i64) {
         /* Don't recurse with tcg_gen_neg_i64.  */
         tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg2);
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg1);
-        tcg_gen_sub_i64(ret, t0, arg2);
-        tcg_temp_free_i64(t0);
+        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                         tcg_constant_i32(arg1), tcg_constant_i32(arg1 >> 32),
+                         TCGV_LOW(arg2), TCGV_HIGH(arg2));
     }
 }
 
@@ -1268,17 +1252,17 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_sub_i64(ret, arg1, tcg_constant_i64(arg2));
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >> 32));
     }
 }
 
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    TCGv_i64 t0;
-
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_andi_i32(TCGV_LOW(ret), TCGV_LOW(arg1), arg2);
         tcg_gen_andi_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), arg2 >> 32);
@@ -1313,9 +1297,8 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
         }
         break;
     }
-    t0 = tcg_const_i64(arg2);
-    tcg_gen_and_i64(ret, arg1, t0);
-    tcg_temp_free_i64(t0);
+
+    tcg_gen_and_i64(ret, arg1, tcg_constant_i64(arg2));
 }
 
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
@@ -1331,9 +1314,7 @@ void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1351,9 +1332,7 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
         /* Don't recurse with tcg_gen_not_i64.  */
         tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_xor_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1415,9 +1394,7 @@ void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_shl_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1429,9 +1406,7 @@ void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_shr_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1443,9 +1418,7 @@ void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_sar_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1468,12 +1441,17 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
 {
-    if (cond == TCG_COND_ALWAYS) {
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
+    } else if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_brcond_i64(cond, arg1, t0, l);
-        tcg_temp_free_i64(t0);
+        l->refs++;
+        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
+                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                          tcg_constant_i32(arg2),
+                          tcg_constant_i32(arg2 >> 32),
+                          cond, label_arg(l));
     }
 }
 
@@ -1499,9 +1477,19 @@ void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-    TCGv_i64 t0 = tcg_const_i64(arg2);
-    tcg_gen_setcond_i64(cond, ret, arg1, t0);
-    tcg_temp_free_i64(t0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
+    } else if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi_i64(ret, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi_i64(ret, 0);
+    } else {
+        tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
+                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                         tcg_constant_i32(arg2),
+                         tcg_constant_i32(arg2 >> 32), cond);
+        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    }
 }
 
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
@@ -1690,7 +1678,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg)
     } else {
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
-        TCGv_i64 t2 = tcg_const_i64(0x00ff00ff);
+        TCGv_i64 t2 = tcg_constant_i64(0x00ff00ff);
 
                                         /* arg = ....abcd */
         tcg_gen_shri_i64(t0, arg, 8);   /*  t0 = .....abc */
@@ -1706,7 +1694,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg)
 
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
     }
 }
 
@@ -1850,16 +1837,16 @@ void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
     if (TCG_TARGET_REG_BITS == 32
         && TCG_TARGET_HAS_clz_i32
         && arg2 <= 0xffffffffu) {
-        TCGv_i32 t = tcg_const_i32((uint32_t)arg2 - 32);
-        tcg_gen_clz_i32(t, TCGV_LOW(arg1), t);
+        TCGv_i32 t = tcg_temp_new_i32();
+        tcg_gen_clzi_i32(t, TCGV_LOW(arg1), arg2 - 32);
         tcg_gen_addi_i32(t, t, 32);
         tcg_gen_clz_i32(TCGV_LOW(ret), TCGV_HIGH(arg1), t);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         tcg_temp_free_i32(t);
     } else {
-        TCGv_i64 t = tcg_const_i64(arg2);
-        tcg_gen_clz_i64(ret, arg1, t);
-        tcg_temp_free_i64(t);
+        TCGv_i64 t0 = tcg_const_i64(arg2);
+        tcg_gen_clz_i64(ret, arg1, t0);
+        tcg_temp_free_i64(t0);
     }
 }
 
@@ -1881,7 +1868,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
             tcg_gen_clzi_i64(t, t, 64);
             tcg_gen_xori_i64(t, t, 63);
         }
-        z = tcg_const_i64(0);
+        z = tcg_constant_i64(0);
         tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
         tcg_temp_free_i64(t);
         tcg_temp_free_i64(z);
@@ -1895,8 +1882,8 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
     if (TCG_TARGET_REG_BITS == 32
         && TCG_TARGET_HAS_ctz_i32
         && arg2 <= 0xffffffffu) {
-        TCGv_i32 t32 = tcg_const_i32((uint32_t)arg2 - 32);
-        tcg_gen_ctz_i32(t32, TCGV_HIGH(arg1), t32);
+        TCGv_i32 t32 = tcg_temp_new_i32();
+        tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
         tcg_gen_addi_i32(t32, t32, 32);
         tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1911,9 +1898,9 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
         tcg_gen_ctpop_i64(ret, t);
         tcg_temp_free_i64(t);
     } else {
-        TCGv_i64 t64 = tcg_const_i64(arg2);
-        tcg_gen_ctz_i64(ret, arg1, t64);
-        tcg_temp_free_i64(t64);
+        TCGv_i64 t0 = tcg_const_i64(arg2);
+        tcg_gen_ctz_i64(ret, arg1, t0);
+        tcg_temp_free_i64(t0);
     }
 }
 
@@ -1969,9 +1956,7 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (TCG_TARGET_HAS_rot_i64) {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_rotl_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_rotl_i64(ret, arg1, tcg_constant_i64(arg2));
     } else {
         TCGv_i64 t0, t1;
         t0 = tcg_temp_new_i64();
@@ -2089,9 +2074,8 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
     } else if (TCG_TARGET_HAS_deposit_i64
                && TCG_TARGET_deposit_i64_valid(ofs, len)) {
-        TCGv_i64 zero = tcg_const_i64(0);
+        TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
-        tcg_temp_free_i64(zero);
     } else {
         if (TCG_TARGET_REG_BITS == 32) {
             if (ofs >= 32) {
@@ -3102,9 +3086,8 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
 
 #ifdef CONFIG_SOFTMMU
         {
-            TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-            gen(retv, cpu_env, addr, cmpv, newv, oi);
-            tcg_temp_free_i32(oi);
+            TCGMemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
+            gen(retv, cpu_env, addr, cmpv, newv, tcg_constant_i32(oi));
         }
 #else
         gen(retv, cpu_env, addr, cmpv, newv);
@@ -3147,9 +3130,8 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 
 #ifdef CONFIG_SOFTMMU
         {
-            TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop, idx));
-            gen(retv, cpu_env, addr, cmpv, newv, oi);
-            tcg_temp_free_i32(oi);
+            TCGMemOpIdx oi = make_memop_idx(memop, idx);
+            gen(retv, cpu_env, addr, cmpv, newv, tcg_constant_i32(oi));
         }
 #else
         gen(retv, cpu_env, addr, cmpv, newv);
@@ -3210,9 +3192,8 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
 
 #ifdef CONFIG_SOFTMMU
     {
-        TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-        gen(ret, cpu_env, addr, val, oi);
-        tcg_temp_free_i32(oi);
+        TCGMemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
+        gen(ret, cpu_env, addr, val, tcg_constant_i32(oi));
     }
 #else
     gen(ret, cpu_env, addr, val);
@@ -3255,9 +3236,8 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
 
 #ifdef CONFIG_SOFTMMU
         {
-            TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-            gen(ret, cpu_env, addr, val, oi);
-            tcg_temp_free_i32(oi);
+            TCGMemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
+            gen(ret, cpu_env, addr, val, tcg_constant_i32(oi));
         }
 #else
         gen(ret, cpu_env, addr, val);
-- 
2.20.1


