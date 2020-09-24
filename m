Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB417C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F49D2145D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJA8LS+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F49D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG1S-0006PD-7Z
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0J-0004l8-9x
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:24:59 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0H-0005gu-Np
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:24:59 -0400
Received: by mail-pj1-x1043.google.com with SMTP id q4so731623pjh.5
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+zHwfpc8hHHaXFYBDv0TpetGN2biZLrhLJF6I/paWB4=;
 b=bJA8LS+ld2p05oAtq2Mp9VDFkcfxVU0KQmf7MF1ntoAEM7eu6FJcoHRMC2H74l6BkI
 e+3c6YyCRqreiExSVdew8b/sNa4Az/tCEqrAscKT7bHy6RTTj6YNzn/dYDXqXxGwGgPj
 HnIM2zxhlYi5L7eXRBO6qtZR00otICkuqdT5FzRE4yW3l7AJ9+YLKY4qzsz0aY02wZiz
 DGer8u/DIq5gjF6aMRXET6Vkj1jrdownvJYOQQp1CKzV7uxZ9FHzw+Sr3Z5zmqTYaKVg
 DcTXA0lXM8zIaSw7nJ5G3lywq5yjU/pfv/r48IuWuxqRRSjczu7TW7mZsKUoFakoHwzi
 n7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+zHwfpc8hHHaXFYBDv0TpetGN2biZLrhLJF6I/paWB4=;
 b=j0f++hHGXq/VyLX7/IONLg0BaFLFY5eTTLV1iynzxSmdCXrlC/FPZATXRWXgzWJsxj
 nR1v6g27lyDlPMtkyJOqr3AWarmWBOUDaCmeWdmQitwXIoFc9CWslFgbs4SNzECuYR8k
 pDbxKHGVdlB3Yr529X4oGU+Y/nQ2I7daJ92HcdoCxizfIoIcgHcvTfBBPoi2OYGEMt8k
 JIVk15J5v12HcqU6ONFhgV+C51em96RCohRYXZ1T2LeeQ3Hs9Hvm/pLby+n3An30L8y5
 ripDb05omoZXpCyTtvn2RsA/ubXtOw1jxCzxYALhc3PwH/cwveAenWlvEYFn2IZQTYvJ
 mLUg==
X-Gm-Message-State: AOAM531o54wohX5ox0dlAb2sOQ2SIVrhNKIS9vP8qvq5cbs81xUyZ1ak
 8qjio7se0Gyl5zgjQG1YgiNL21pHxdtrCA==
X-Google-Smtp-Source: ABdhPJwoawGiVmgUn/vEAopVNqaqZV/oKGxGovI0T3PU4vyuPnS7QZgNUwigDw2ZlRGDWytys4IJUA==
X-Received: by 2002:a17:902:d913:b029:d0:cbe1:e712 with SMTP id
 c19-20020a170902d913b02900d0cbe1e712mr2399368plz.32.1600910696119; 
 Wed, 23 Sep 2020 18:24:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:24:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] softfloat: Use mulu64 for mul64To128
Date: Wed, 23 Sep 2020 18:24:46 -0700
Message-Id: <20200924012453.659757-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924012453.659757-1-richard.henderson@linaro.org>
References: <20200924012453.659757-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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


