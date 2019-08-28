Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91874C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EC0217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekb03WIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EC0217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33iI-000675-L0
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G8-0003Wr-6L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G6-0000AR-5c
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:32 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33G5-00009y-Na
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:30 -0400
Received: by mail-pl1-x641.google.com with SMTP id m9so390610pls.8
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZPbSh9zJCU6tFB8sqkv7S5LslxkLSpT7ZOLVU6IYp00=;
 b=ekb03WIJpECk2/qIFh9O+7RE8shJjCiDjcwFSzkQDbLsmEut/DxTEoPuBd+FDCIUk/
 BiMhjpSFbd3ue5/xCMQjyAIoze8Z90CpkhpM6jlkf0Z4MwIXimVm6/mh26+HJdeYJWK9
 g3ejcbBopJQMpt3XibmsHRESKPmRQPjrQuDgO4Xhl3yNYNEHF3D1Zt7qfpQkTPA2Xavl
 ygzipBBBZo/Jl4G+kl+/0M4baog+Z18mdj6xhuIZXxRzUnu6JLrKGawffbhG7Hsxs9b+
 kjMBGHHBCc33AEdiPAWHw/7xWJggsJ7DrQyQ98A2TcpF5O4lQfxXr8QcvfnA6ESJFpeJ
 m3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZPbSh9zJCU6tFB8sqkv7S5LslxkLSpT7ZOLVU6IYp00=;
 b=ID7g0To6YutD14fpVsacxSXnvCn02nPL3t2FMmrIQyDL3WNzwm2+8HrswU7tzwa6sU
 y4BjqqIt7Q4fimwREx48Qs+JHd0BMSHrAsXX355GWDu3Kj5bRaURoCBInzKd5xpafNNG
 nEz6PevkJekZOHYDOYrau7R4xAZibex3Pnjrvke2qJhucK/XiRSzLSRAl71NWvrbED5O
 Q1SwiwLQmqnTnBP34fjnK/HznWgx6pVkogxnXvEe08MzZIm9OBfzd1F32/nYafwsBpsW
 jBmWTVGFyjaJD0KdRI1cK/BiY5ocs7MTwMSys8AlsbOv8ZHOIF8RqKS1FVApp1UgQ33l
 6TeQ==
X-Gm-Message-State: APjAAAVF0GNuSSFMHZ/530KcSwykXpQT0J2/76eElh4r90wI0A8pGtk7
 dCcoHfiZQ8vAL6aX+2nrNdeWNet3byU=
X-Google-Smtp-Source: APXvYqx7o3jc8bZEgg/+0ckrlp9GlIibgtOUbDa5DvQd2eXgV5Ob0PUk78iBBu7tViJ+0QVbiWRMYQ==
X-Received: by 2002:a17:902:d906:: with SMTP id
 c6mr5633124plz.13.1567019128062; 
 Wed, 28 Aug 2019 12:05:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:09 -0700
Message-Id: <20190828190456.30315-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 22/69] target/arm: Diagnose UNPREDICTABLE
 ldrex/strex cases
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 10ec976bd9..3f61916ff9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8886,6 +8886,18 @@ static bool op_strex(DisasContext *s, arg_STREX *a, TCGMemOp mop, bool rel)
 {
     TCGv_i32 addr;
 
+    /* We UNDEF for these UNPREDICTABLE cases.  */
+    if (a->rd == 15 || a->rn == 15 || a->rt == 15
+        || a->rd == a->rn || a->rd == a->rt
+        || (s->thumb && (a->rd == 13 || a->rt == 13))
+        || (mop == MO_64
+            && (a->rt2 == 15
+                || a->rd == a->rt2 || a->rt == a->rt2
+                || (s->thumb && a->rt2 == 13)))) {
+        unallocated_encoding(s);
+        return true;
+    }
+
     if (rel) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     }
@@ -8912,6 +8924,7 @@ static bool trans_STREXD_a32(DisasContext *s, arg_STREX *a)
     if (!ENABLE_ARCH_6K) {
         return false;
     }
+    /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rt & 1) {
         unallocated_encoding(s);
         return true;
@@ -8954,6 +8967,7 @@ static bool trans_STLEXD_a32(DisasContext *s, arg_STREX *a)
     if (!ENABLE_ARCH_8) {
         return false;
     }
+    /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rt & 1) {
         unallocated_encoding(s);
         return true;
@@ -8993,8 +9007,13 @@ static bool op_stl(DisasContext *s, arg_STL *a, TCGMemOp mop)
     if (!ENABLE_ARCH_8) {
         return false;
     }
-    addr = load_reg(s, a->rn);
+    /* We UNDEF for these UNPREDICTABLE cases.  */
+    if (a->rn == 15 || a->rt == 15) {
+        unallocated_encoding(s);
+        return true;
+    }
 
+    addr = load_reg(s, a->rn);
     tmp = load_reg(s, a->rt);
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     gen_aa32_st_i32(s, tmp, addr, get_mem_index(s), mop | s->be_data);
@@ -9024,6 +9043,16 @@ static bool op_ldrex(DisasContext *s, arg_LDREX *a, TCGMemOp mop, bool acq)
 {
     TCGv_i32 addr;
 
+    /* We UNDEF for these UNPREDICTABLE cases.  */
+    if (a->rn == 15 || a->rt == 15
+        || (s->thumb && a->rt == 13)
+        || (mop == MO_64
+            && (a->rt2 == 15 || a->rt == a->rt2
+                || (s->thumb && a->rt2 == 13)))) {
+        unallocated_encoding(s);
+        return true;
+    }
+
     addr = tcg_temp_local_new_i32();
     load_reg_var(s, addr, a->rn);
     tcg_gen_addi_i32(addr, addr, a->imm);
@@ -9050,6 +9079,7 @@ static bool trans_LDREXD_a32(DisasContext *s, arg_LDREX *a)
     if (!ENABLE_ARCH_6K) {
         return false;
     }
+    /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rt & 1) {
         unallocated_encoding(s);
         return true;
@@ -9092,6 +9122,7 @@ static bool trans_LDAEXD_a32(DisasContext *s, arg_LDREX *a)
     if (!ENABLE_ARCH_8) {
         return false;
     }
+    /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rt & 1) {
         unallocated_encoding(s);
         return true;
@@ -9131,8 +9162,13 @@ static bool op_lda(DisasContext *s, arg_LDA *a, TCGMemOp mop)
     if (!ENABLE_ARCH_8) {
         return false;
     }
-    addr = load_reg(s, a->rn);
+    /* We UNDEF for these UNPREDICTABLE cases.  */
+    if (a->rn == 15 || a->rt == 15) {
+        unallocated_encoding(s);
+        return true;
+    }
 
+    addr = load_reg(s, a->rn);
     tmp = tcg_temp_new_i32();
     gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s), mop | s->be_data);
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel);
-- 
2.17.1


