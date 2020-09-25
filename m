Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1224C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B8F2311D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEY7d/Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B8F2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpaI-000478-4P
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWo-0000sj-K7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:54 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWm-0005QV-Kz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:54 -0400
Received: by mail-pf1-x444.google.com with SMTP id k8so3530132pfk.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=23xCfoE1xB51TMKAcRj/+leExlJ4p0flEWY8kvOZXBg=;
 b=yEY7d/Jh675fzi/SDdmzpnwMkTkfycAww8HTpKGPyjkvl2Ryh9TZlCw15NXKfQW3vS
 0JGNCLNKrxmUGSJhj791ibHdc/fMaXucxeMiTDH5qAH9C95tOUQy2MkIt/+ZAsZXZCdW
 DWrpVKRuWK1DyDTpX1ZcHo/ALL0K97tsfEHE/gui2SzICFynEMN0IgGMmS8HhF9BTkUF
 mQY3QLoan3bHAME5DAg2COPZhgQUZ7TkkRJnoCSKJO/kHj9uB7IVlohjjkzb30MBr06c
 w6m0+VGdwRFCuiLprG0+BFoumQ4NmFHglH/JgsDAcBLXXNSDsw2I9xeU8SXH+1/vd8qp
 DjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=23xCfoE1xB51TMKAcRj/+leExlJ4p0flEWY8kvOZXBg=;
 b=tORAuRwj21RQjnRWIHvesEQvo87wvqZMxy2ThNgCwo3loA034nHHmHyrhE9Qu8C4oK
 QtSfSdAEW2o3FTGmKPt4Xjx8e+tIQll681h0aBB7Ad08POGqPfwYjpEi4eJf9Uu4PWjp
 PEueCbdrpcpJNV1YzlnTYfounW5fSyoqycXFk71FhGmAHS0n2RR880BH214n0XY+zMIu
 Bi6V0f80qlYBgtdcCFH/r2sMS+2hPWlqBYedtfU4qLSRUS9/rEyqj3MsLBFPeItLGjzS
 UvWBeoiYbM1x7x6ISXY8o5LgCPq5wABefdWmdhYQOcTpNR6IrrtwnOrfk3bjNw/aFB7x
 8yiw==
X-Gm-Message-State: AOAM530tf9MtYJR/VSHjg3/c8sqkgpHyn8VafPJIu2uM7alYZQBW8+ke
 f9NNvE2DfbqmyF5DcxJ+pYU2s7r7MmbkIg==
X-Google-Smtp-Source: ABdhPJy5YuCDp9N5S0BQH1PUq7UITmnPPXKjm5yjQHt9ltc21EOSwOScpkMQEUe6nb4/lVIBRCSHYQ==
X-Received: by 2002:a63:d512:: with SMTP id c18mr422925pgg.387.1601047250524; 
 Fri, 25 Sep 2020 08:20:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:20:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/10] softfloat: Use mulu64 for mul64To128
Date: Fri, 25 Sep 2020 08:20:38 -0700
Message-Id: <20200925152047.709901-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

Via host-utils.h, we use a host widening multiply for
64-bit hosts, and a common subroutine for 32-bit hosts.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index a35ec2893a..57845f8af0 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -83,6 +83,7 @@ this code that are retained.
 #define FPU_SOFTFLOAT_MACROS_H
 
 #include "fpu/softfloat-types.h"
+#include "qemu/host-utils.h"
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
@@ -515,27 +516,10 @@ static inline void
 | `z0Ptr' and `z1Ptr'.
 *----------------------------------------------------------------------------*/
 
-static inline void mul64To128( uint64_t a, uint64_t b, uint64_t *z0Ptr, uint64_t *z1Ptr )
+static inline void
+mul64To128(uint64_t a, uint64_t b, uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    uint32_t aHigh, aLow, bHigh, bLow;
-    uint64_t z0, zMiddleA, zMiddleB, z1;
-
-    aLow = a;
-    aHigh = a>>32;
-    bLow = b;
-    bHigh = b>>32;
-    z1 = ( (uint64_t) aLow ) * bLow;
-    zMiddleA = ( (uint64_t) aLow ) * bHigh;
-    zMiddleB = ( (uint64_t) aHigh ) * bLow;
-    z0 = ( (uint64_t) aHigh ) * bHigh;
-    zMiddleA += zMiddleB;
-    z0 += ( ( (uint64_t) ( zMiddleA < zMiddleB ) )<<32 ) + ( zMiddleA>>32 );
-    zMiddleA <<= 32;
-    z1 += zMiddleA;
-    z0 += ( z1 < zMiddleA );
-    *z1Ptr = z1;
-    *z0Ptr = z0;
-
+    mulu64(z1Ptr, z0Ptr, a, b);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.25.1


