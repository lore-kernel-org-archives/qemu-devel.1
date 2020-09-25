Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32429C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A9E2311D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3ekjQ6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A9E2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpb2-00059p-JT
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWp-0000vX-VW
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:55 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:44608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWo-0005Qj-0K
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:55 -0400
Received: by mail-pg1-x52a.google.com with SMTP id 7so2840604pgm.11
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5Xncpr5K+BGk/N6uEu+J3gIdvJF6CZ9YQEmHEPvJu74=;
 b=S3ekjQ6aLH8wOrUE4kLcFniubnlsZLqpez/Uqxc2Z8e7wFAnrGsI0SYBoX2C8auwxQ
 iKSlL7szeEh5EpPZAg2vdbGohpr0DpzAAqiDdxcxgOlFiFRBBOxtSbWXaYFji7vBMGfB
 LAfsM+ncrbJP3Gzzh6Nu3hhZ54KkYs+crNaYOKVbAjATIo0lNVId/ekmRvruFjWQ9gJ1
 D2+HN6eYS5Mh04naQf6bG668FX+K9FwUChAdxLMdiBrPAanhiiAzN6n/U0RA4GcUCSOr
 cz7hs9pXIXWKfDCuVAhIH0LzsP6SjwL41W2h+jgNyBi6aWeE9FKRDiSSYHYGWLeOgh/O
 LA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Xncpr5K+BGk/N6uEu+J3gIdvJF6CZ9YQEmHEPvJu74=;
 b=M6/yYlR6RHnRzmffzwWggpDbOOSjVgnaTjvO2IGAdpehAt/ePkVKetbDDsWSv0hqe0
 Wx1O19oYF/uTLP5pfzYLuX1IsXZVzEckD00C2yCpAnrQ1dKeqBklQZzkZ4N8dugFUBxN
 vEOGduVGWpU3msXKIZQfDe5Pm9uI6F2tw5p/vb1bFVq9bGguueQDuVvjSBNM6Zd1B75B
 uOfZqcmwoHs5zCkniTtn0qMk1pgTeH0yswjEpPmAedQiTBKQl4lvZqwmF55IxvIjW4Wy
 SMiYuIoD8LguWiGq7dVf7BZ5ziLY60PVKHiJcvkiTN271oKT3Fx+GSsUq/4sdAYmyNgg
 KWGg==
X-Gm-Message-State: AOAM531tQuqhORGOx8WuWOH4l1z+wVlxfTPgVPJgIeawa2dkOua4W10F
 eV3m3jY3FDyUpjw2XvmsGi0UT6eoXA0f5w==
X-Google-Smtp-Source: ABdhPJxo1WOePL/GCL3Du4qDIOLKkYQVdJH1oQk6RGAc15uFYZ53FKy8mlVZJRcQA4izz6Fh8fW8EQ==
X-Received: by 2002:a62:178d:0:b029:13e:d13d:a0f8 with SMTP id
 135-20020a62178d0000b029013ed13da0f8mr4495253pfx.20.1601047251820; 
 Fri, 25 Sep 2020 08:20:51 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:20:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/10] softfloat: Use int128.h for some operations
Date: Fri, 25 Sep 2020 08:20:39 -0700
Message-Id: <20200925152047.709901-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use our Int128, which wraps the compiler's __int128_t,
instead of open-coding left shifts and arithmetic.
We'd need to extend Int128 to have unsigned operations
to replace more than these three.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 39 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 57845f8af0..95d88d05b8 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -84,6 +84,7 @@ this code that are retained.
 
 #include "fpu/softfloat-types.h"
 #include "qemu/host-utils.h"
+#include "qemu/int128.h"
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
@@ -352,13 +353,11 @@ static inline void shortShift128Left(uint64_t a0, uint64_t a1, int count,
 static inline void shift128Left(uint64_t a0, uint64_t a1, int count,
                                 uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    if (count < 64) {
-        *z1Ptr = a1 << count;
-        *z0Ptr = count == 0 ? a0 : (a0 << count) | (a1 >> (-count & 63));
-    } else {
-        *z1Ptr = 0;
-        *z0Ptr = a1 << (count - 64);
-    }
+    Int128 a = int128_make128(a1, a0);
+    Int128 z = int128_lshift(a, count);
+
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
@@ -405,15 +404,15 @@ static inline void
 *----------------------------------------------------------------------------*/
 
 static inline void
- add128(
-     uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1, uint64_t *z0Ptr, uint64_t *z1Ptr )
+add128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1,
+       uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    uint64_t z1;
-
-    z1 = a1 + b1;
-    *z1Ptr = z1;
-    *z0Ptr = a0 + b0 + ( z1 < a1 );
+    Int128 a = int128_make128(a1, a0);
+    Int128 b = int128_make128(b1, b0);
+    Int128 z = int128_add(a, b);
 
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
@@ -463,13 +462,15 @@ static inline void
 *----------------------------------------------------------------------------*/
 
 static inline void
- sub128(
-     uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1, uint64_t *z0Ptr, uint64_t *z1Ptr )
+sub128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1,
+       uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
+    Int128 a = int128_make128(a1, a0);
+    Int128 b = int128_make128(b1, b0);
+    Int128 z = int128_sub(a, b);
 
-    *z1Ptr = a1 - b1;
-    *z0Ptr = a0 - b0 - ( a1 < b1 );
-
+    *z0Ptr = int128_gethi(z);
+    *z1Ptr = int128_getlo(z);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.25.1


