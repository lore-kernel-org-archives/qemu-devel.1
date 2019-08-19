Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CE4C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643D2214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8oNyn9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643D2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpdZ-0007g1-1S
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMK-000265-G6
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMJ-0006Nu-0i
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:36 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMI-0006N6-O6
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:34 -0400
Received: by mail-pg1-x544.google.com with SMTP id k3so1921599pgb.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PE2YkC2uYnkrGF/f+RQwnN2RH8jlq2MEkPtJdHa8VHQ=;
 b=t8oNyn9ZZ3RCoFQiIKX4jSToehRsZPBSpTvpY9Z9O0ijBgjNpKVTXyQQZIj+0WQ1I9
 vNssbEbg6nKXjvsygAhI5ZFYDHFXOe/jw8E/zmSjoiCT3D6DbkmJ4SI65C+i5glaquEj
 exzjnem76xrCYZdKpZsexjc6bFARf8cGzp0Ys+IWQ4ZDKMUoDuTLzxjLI8XxjQg7Dn42
 yKjbV5ycXhFT1NOZUC1RmQa75ErVhGNizoUDdc0h4aJVW9h/kehjv0qgQYEsVChuRj/P
 e1hZc6hrr8YwFEFpq5wuuDR3YzMk2wA64D2E/2ta6lMlYUWOosLaFXvWmKHn/LUU9cbw
 3R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PE2YkC2uYnkrGF/f+RQwnN2RH8jlq2MEkPtJdHa8VHQ=;
 b=Mntx5l6WZZJc3V55U2SjLpD4yf9VtVXzSRn0cXCc5bty1YgreuVXxwuPJmUe8i2Xuz
 rfI0Jgw5TXDxhAoSWs1XU0Ms13/6tNOfnhDz341fGJGp+ToV5cNCyIn3SU8Qvmtg4c1E
 KpIkLkBoMbsLdl11Fc22uMIzbbDag0oSYC8fZu1H8QEyOMG9Uuj2afN8EGV7J0fjVeAH
 KYupepGBc/KtvZKsR/BPkF1YWhADDNUFT1YfDjA3hzibQdqVbhjaoUI8MZ/Vm7UjDber
 ffVPrEfS3fRXJycFWdqPRAnvDL/VEv4lQKY6e/6hHdA14qr9BFc+mLS3IAq3pGeqdFlk
 inrw==
X-Gm-Message-State: APjAAAVukD9mKDTPKCsh8DZmgd8AAmvkTy3tyeZIYxV6cZJm/mJwLiXH
 pyCIyZzvNbTNzjKU8BhE4AbrY6nqEXw=
X-Google-Smtp-Source: APXvYqxgALNgiwL5LxxNgNOjY3hpHYZNCkpg62IU22V2zRzmwICq2jve7P0gWxDoK0UpD2P8UXDpPQ==
X-Received: by 2002:a62:1703:: with SMTP id 3mr22426920pfx.118.1566250713399; 
 Mon, 19 Aug 2019 14:38:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:16 -0700
Message-Id: <20190819213755.26175-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v2 29/68] target/arm: Diagnose too few
 registers in list for LDM/STM
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

This has been a TODO item for quite a while.  The minimum bit
count for A32 and T16 is 1, and for T32 is 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 29e2eae441..1792bb7abd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9733,7 +9733,7 @@ static void op_addr_block_post(DisasContext *s, arg_ldst_block *a,
     }
 }
 
-static bool op_stm(DisasContext *s, arg_ldst_block *a)
+static bool op_stm(DisasContext *s, arg_ldst_block *a, int min_n)
 {
     int i, j, n, list, mem_idx;
     bool user = a->u;
@@ -9749,7 +9749,9 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a)
 
     list = a->list;
     n = ctpop16(list);
-    /* TODO: test invalid n == 0 case */
+    if (n < min_n) {
+        return false;
+    }
 
     addr = op_addr_block_pre(s, a, n);
     mem_idx = get_mem_index(s);
@@ -9782,7 +9784,8 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a)
 
 static bool trans_STM(DisasContext *s, arg_ldst_block *a)
 {
-    return op_stm(s, a);
+    /* BitCount(list) < 1 is UNPREDICTABLE */
+    return op_stm(s, a, 1);
 }
 
 static bool trans_STM_t32(DisasContext *s, arg_ldst_block *a)
@@ -9791,10 +9794,11 @@ static bool trans_STM_t32(DisasContext *s, arg_ldst_block *a)
     if (a->w && (a->list & (1 << a->rn))) {
         return false;
     }
-    return op_stm(s, a);
+    /* BitCount(list) < 2 is UNPREDICTABLE */
+    return op_stm(s, a, 2);
 }
 
-static bool do_ldm(DisasContext *s, arg_ldst_block *a)
+static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
 {
     int i, j, n, list, mem_idx;
     bool loaded_base;
@@ -9821,7 +9825,9 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a)
 
     list = a->list;
     n = ctpop16(list);
-    /* TODO: test invalid n == 0 case */
+    if (n < min_n) {
+        return false;
+    }
 
     addr = op_addr_block_pre(s, a, n);
     mem_idx = get_mem_index(s);
@@ -9888,7 +9894,8 @@ static bool trans_LDM_a32(DisasContext *s, arg_ldst_block *a)
     if (ENABLE_ARCH_7 && a->w && (a->list & (1 << a->rn))) {
         return false;
     }
-    return do_ldm(s, a);
+    /* BitCount(list) < 1 is UNPREDICTABLE */
+    return do_ldm(s, a, 1);
 }
 
 static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
@@ -9897,7 +9904,8 @@ static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
     if (a->w && (a->list & (1 << a->rn))) {
         return false;
     }
-    return do_ldm(s, a);
+    /* BitCount(list) < 2 is UNPREDICTABLE */
+    return do_ldm(s, a, 2);
 }
 
 /*
-- 
2.17.1


