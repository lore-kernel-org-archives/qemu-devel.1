Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77130C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1D42064A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nM108mhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1D42064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33ow-0004GN-UP
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GP-0003kd-Ll
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GG-0000HK-PR
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:47 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GG-0000Gb-HV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:40 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so217321pgj.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dyqbVPM8CjlhxJ0X4xzBIRTbITeZE2k+cAo7OEV0NYI=;
 b=nM108mhTAFLMCQZzRhGWwJFZu4vA3lBzqsS11J9rBTKL6CWPJwNYfNDVLZpUgVUaNf
 g46PIvwCYzyuRwgZXxWYaXIw8i8jyTt4jGt4+jA3dl/Yd03I8LNImepT9MS3iWgy1cG1
 znXbl+1iZBcwUzA4OyzGASFb5OooQ8Po+YOCpGGW6Mw3aeaPJQuhwVnKpWcwibRudX60
 tXcvMism++6U9zFIW8gV98lCejnrq0JAdkV5hl1n00VMnVQ6d2uISsrbqJYBY/MQZWfF
 wquqidmWhX2gcaMEDd0YF9pn2r1WrZ2yV/9dZ6ZFtTso3NaeU49MNsEFlWVe/D8y86++
 oosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dyqbVPM8CjlhxJ0X4xzBIRTbITeZE2k+cAo7OEV0NYI=;
 b=qYT3KXvUHnLxUewTZaDDPwxgG/THnIOKDYfwWRHrXHvpsOTAi8lt+YpTtEYadvFOdl
 fYPxBPKqP+H8YAf8zuHEMMpG9qPQfnxMhYKXGpnYpctlreBFnR0nv2n5Zzw5VykbUHmK
 tG4BwX+1PhP2G23KggNB1dUvDuDI/m3r9TEEBAy9QHnFdOCYagcai+W+6otefH8kiE1E
 QdK64A1Waloy0QYMB6mJZHRK1BJ0MzdzAhwLlVEzPcD58OUZ1rPBlhl2mZp8l8NzzkL/
 9z4YkBsc7rpB45d0RiMNqfgozs+pJr5xzgnVnGM8lvx2fNfDlaSF8XxZEDRI4Kwqg414
 zWsw==
X-Gm-Message-State: APjAAAVFYoyTNSsfKI/KMnL1gtF5V3dzZe0zUXbXa8DurVGVBFnmY5SX
 yXE3yJuF4/P2KtQXxEuA6P1v4qDoWSc=
X-Google-Smtp-Source: APXvYqz1S4pKePYAozfdPqeya8sXsIsTrZX5dcfG9QC00QI/yf4P/AgsIhtyBl+mM3+hCdBBrT+4Og==
X-Received: by 2002:a63:d30f:: with SMTP id b15mr4699713pgg.341.1567019139008; 
 Wed, 28 Aug 2019 12:05:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:17 -0700
Message-Id: <20190828190456.30315-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 30/69] target/arm: Diagnose too few
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 529660eb35..bfc4508321 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9813,7 +9813,7 @@ static void op_addr_block_post(DisasContext *s, arg_ldst_block *a,
     }
 }
 
-static bool op_stm(DisasContext *s, arg_ldst_block *a)
+static bool op_stm(DisasContext *s, arg_ldst_block *a, int min_n)
 {
     int i, j, n, list, mem_idx;
     bool user = a->u;
@@ -9830,7 +9830,10 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a)
 
     list = a->list;
     n = ctpop16(list);
-    /* TODO: test invalid n == 0 case */
+    if (n < min_n) {
+        unallocated_encoding(s);
+        return true;
+    }
 
     addr = op_addr_block_pre(s, a, n);
     mem_idx = get_mem_index(s);
@@ -9863,7 +9866,8 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a)
 
 static bool trans_STM(DisasContext *s, arg_ldst_block *a)
 {
-    return op_stm(s, a);
+    /* BitCount(list) < 1 is UNPREDICTABLE */
+    return op_stm(s, a, 1);
 }
 
 static bool trans_STM_t32(DisasContext *s, arg_ldst_block *a)
@@ -9873,10 +9877,11 @@ static bool trans_STM_t32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
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
@@ -9905,7 +9910,10 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a)
 
     list = a->list;
     n = ctpop16(list);
-    /* TODO: test invalid n == 0 case */
+    if (n < min_n) {
+        unallocated_encoding(s);
+        return true;
+    }
 
     addr = op_addr_block_pre(s, a, n);
     mem_idx = get_mem_index(s);
@@ -9973,7 +9981,8 @@ static bool trans_LDM_a32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
     }
-    return do_ldm(s, a);
+    /* BitCount(list) < 1 is UNPREDICTABLE */
+    return do_ldm(s, a, 1);
 }
 
 static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
@@ -9983,7 +9992,8 @@ static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
     }
-    return do_ldm(s, a);
+    /* BitCount(list) < 2 is UNPREDICTABLE */
+    return do_ldm(s, a, 2);
 }
 
 /*
-- 
2.17.1


