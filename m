Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB7CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575BF21883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xo4CiaJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575BF21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bMm-0003zi-Vc
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b08-0004cd-Re
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b06-0002QL-O9
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:32 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b06-0002Pp-EV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id y22so8276700pfr.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w4KLvtnzbGeNcUZz918DD9xSWUWeMSJ2fRY4zLuIN7M=;
 b=Xo4CiaJ2viHwnNykF9aQFpzgH/WazLxvqgaLL1+oZC9xYBHkAoGfSLdhKqdU92db2G
 OyoM71AXfDwwIUU4xwwVxyC19ZJxx4sxtO4PlWLRsCgM4RVSolrIcNtdErudmyq3QOAd
 q/LYCPMFrUXthM2djMOmsTJ1s0GTQuBMoF33XS55pYcvk5OwGwbASVDQ5nigjNXLuplu
 PX25wihAvAdArplzvZiBjWz3NrBu8ZFuSqgqJxiILNo/AWV3SsPB5OxsbGAsD9pXV0j5
 uQsibc81/wpocRqBua9h4qwXlxufykJzhkq8ykQ15CI6w/IKC2nxVvCFEyWCCedmPdh0
 dW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w4KLvtnzbGeNcUZz918DD9xSWUWeMSJ2fRY4zLuIN7M=;
 b=KCXMyN1M8u+00hdcPDv2Z0DNP+y1BLUzFapqN67Q/WtAyIH6KCv5yVzcmUaJU+B+ln
 PpkuFvYerRoUFtJgebi4YKo7vmXf5a75kljc5Jjo3ppMzuk035p580CSbZaIKWOa6jta
 wlujYK4QEc6FoSqS/jl3gyiFH+GChagkkht5tWLdx3szceWRNtwJtP2/WMqZfOSWwHuS
 hvQR0WvQ7hFzCRRgKtSZyNp/Nz4WTxEJ5c7yrsswJ5ry306si/DDV435YOdUwpT2EtjG
 Le9Xg3D2+nDc5hY0K2VrDxenASWSb0mItZtec7SNYDDWQn+vcpJZEwWuj8c3krER/oJY
 EvyQ==
X-Gm-Message-State: APjAAAWnsFc1JX2TSrdF6g4NuQgBpVWDitCXF7sNLaykqGs1nqakWmFy
 lQ1hM2XMSkyB2lvseilAvv1vVt89Sks=
X-Google-Smtp-Source: APXvYqx3SzPP2IxI/lCtnKHBikx7qIT/taVd1nwO4Jv7aVG/nO+lPyW1zlgl1mSl/zfYL810B81n7g==
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr36313870pgq.130.1567625488997; 
 Wed, 04 Sep 2019 12:31:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:12 -0700
Message-Id: <20190904193059.26202-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 22/69] target/arm: Diagnose UNPREDICTABLE
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ec80c9cbbc..9338873a4a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8912,6 +8912,18 @@ static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
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
@@ -8938,6 +8950,7 @@ static bool trans_STREXD_a32(DisasContext *s, arg_STREX *a)
     if (!ENABLE_ARCH_6K) {
         return false;
     }
+    /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rt & 1) {
         unallocated_encoding(s);
         return true;
@@ -8980,6 +8993,7 @@ static bool trans_STLEXD_a32(DisasContext *s, arg_STREX *a)
     if (!ENABLE_ARCH_8) {
         return false;
     }
+    /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rt & 1) {
         unallocated_encoding(s);
         return true;
@@ -9019,8 +9033,13 @@ static bool op_stl(DisasContext *s, arg_STL *a, MemOp mop)
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
@@ -9050,6 +9069,16 @@ static bool op_ldrex(DisasContext *s, arg_LDREX *a, MemOp mop, bool acq)
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
@@ -9076,6 +9105,7 @@ static bool trans_LDREXD_a32(DisasContext *s, arg_LDREX *a)
     if (!ENABLE_ARCH_6K) {
         return false;
     }
+    /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rt & 1) {
         unallocated_encoding(s);
         return true;
@@ -9118,6 +9148,7 @@ static bool trans_LDAEXD_a32(DisasContext *s, arg_LDREX *a)
     if (!ENABLE_ARCH_8) {
         return false;
     }
+    /* We UNDEF for these UNPREDICTABLE cases.  */
     if (a->rt & 1) {
         unallocated_encoding(s);
         return true;
@@ -9157,8 +9188,13 @@ static bool op_lda(DisasContext *s, arg_LDA *a, MemOp mop)
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


