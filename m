Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C27DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF88206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFr2h946"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF88206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIwD-0006ag-1t
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtISB-00030n-5C
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:11 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS9-000190-4T
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:10 -0400
Received: by mail-pl1-x642.google.com with SMTP id d10so6735611pll.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R+lITptw5fn9ER442LKhdifOCNEK9wzAb+CMXJ6Z8J0=;
 b=hFr2h946Mn3DofozNRLT1dqTvkdpq5fl9gwPRUtY/kZILdv/ayrU58n2NtucYFRGTx
 GaaldW7p4AdhL0EVeZgli37Y4GKwMUpD15jOBLTS8HQfj/sxyKRX3ra2YEAu+PwKw8hP
 4XWSOMCE6NnE2gbacF9uu38WJlzibVbdRjNISVgP0WAZd+EJrFHWETlIvq7pTZBUXcyO
 EepXQJraYo/fR3eZz8uAUVfaml63VdZaHCYOZXfeBGhsPCB/PkOeWXoT4tGc36g/h1tw
 PBlYsdOvTm6zXI9d+bhqU1M7NBB5xB4fxZmNqCC2rk+4QNLrXtjb9NKeELKP9ZtBdCgq
 TlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R+lITptw5fn9ER442LKhdifOCNEK9wzAb+CMXJ6Z8J0=;
 b=ovvTMu9dOguqmU2rp5KKtLmAdIQAN0ZzFNXNKWvD08q1/hXLw15g3z0C9ThiW5ucr0
 eMY1A8t9Rd/ySNzZz/2a9wfOjOAQYJZkueT4UbYiAgf9k0uII7cd+nnPqem5/ijpzbIJ
 KIpJM8GtQU0nI0FRBBz3idZ1CqmHwaTHVv4ewP312mWz7++bKTiwrllgkxdcqNVtNev4
 swxzsz0Og2OjnhDF44OTjHIPwGhckbquSoo+wNSfYVvyjZxvIBRHa1zeKWJg7ApkRmAt
 vQf0vsgc9Fr4YpRlyOxD1TFOQ4DKfvSdvw8opfTnkeVuaX7kW2G1vMSJ1sbUscZqd3PL
 FU8Q==
X-Gm-Message-State: AOAM533fGBrFmalhjlEk2YhEwbTJ0iM6VsJtnHDFzzysfumgTHHVKA4N
 81RkJbj+mF9N0HlahdjpssHk06uu
X-Google-Smtp-Source: ABdhPJz1K1eiOaOTLhy2jITUX0ZXy6VAApYSy8z0zU9TsyEYJ/xSBdO4Uitfd5CkMVNoyp1pVXPbSg==
X-Received: by 2002:a17:902:a515:: with SMTP id
 s21mr44802343plq.192.1594246927752; 
 Wed, 08 Jul 2020 15:22:07 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:22:07 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/21] tests/tcg/xtensa: update test_lsc for DFPU
Date: Wed,  8 Jul 2020 15:20:56 -0700
Message-Id: <20200708222101.24568-17-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DFPU doesn't have pre-increment FP load/store opcodes, it has
post-increment opcodes instead. Test increment opcodes present in the
current config.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_lsc.S | 47 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/tests/tcg/xtensa/test_lsc.S b/tests/tcg/xtensa/test_lsc.S
index 0578bf19e72e..9d59c1815a9e 100644
--- a/tests/tcg/xtensa/test_lsc.S
+++ b/tests/tcg/xtensa/test_lsc.S
@@ -1,4 +1,5 @@
 #include "macros.inc"
+#include "fpu.h"
 
 test_suite lsc
 
@@ -9,9 +10,14 @@ test lsi
     wsr     a2, cpenable
 
     movi    a2, 1f
-    lsi     f0, a2, 0
     lsi     f1, a2, 4
+#if DFPU
+    lsi     f2, a2, 8
+    lsip    f0, a2, 8
+#else
+    lsi     f0, a2, 0
     lsiu    f2, a2, 8
+#endif
     movi    a3, 1f + 8
     assert  eq, a2, a3
     rfr     a2, f0
@@ -34,13 +40,18 @@ test ssi
     movi    a2, 1f
     movi    a3, 0x40800000
     wfr     f3, a3
-    ssi     f3, a2, 0
     movi    a3, 0x40a00000
     wfr     f4, a3
-    ssi     f4, a2, 4
     movi    a3, 0x40c00000
     wfr     f5, a3
+    ssi     f4, a2, 4
+#if DFPU
+    ssi     f5, a2, 8
+    ssip    f3, a2, 8
+#else
+    ssi     f3, a2, 0
     ssiu    f5, a2, 8
+#endif
     movi    a3, 1f + 8
     assert  eq, a2, a3
     l32i    a4, a2, -8
@@ -62,11 +73,16 @@ test_end
 test lsx
     movi    a2, 1f
     movi    a3, 0
+    movi    a4, 4
+    movi    a5, 8
+    lsx     f7, a2, a4
+#if DFPU
+    lsx     f8, a2, a5
+    lsxp    f6, a2, a5
+#else
     lsx     f6, a2, a3
-    movi    a3, 4
-    lsx     f7, a2, a3
-    movi    a3, 8
-    lsxu    f8, a2, a3
+    lsxu    f8, a2, a5
+#endif
     movi    a3, 1f + 8
     assert  eq, a2, a3
     rfr     a2, f6
@@ -87,18 +103,23 @@ test_end
 
 test ssx
     movi    a2, 1f
-    movi    a3, 0
     movi    a4, 0x41200000
     wfr     f9, a4
-    ssx     f9, a2, a3
-    movi    a3, 4
     movi    a4, 0x41300000
     wfr     f10, a4
-    ssx     f10, a2, a3
-    movi    a3, 8
     movi    a4, 0x41400000
     wfr     f11, a4
-    ssxu    f11, a2, a3
+    movi    a3, 0
+    movi    a4, 4
+    movi    a5, 8
+    ssx     f10, a2, a4
+#if DFPU
+    ssx     f11, a2, a5
+    ssxp    f9, a2, a5
+#else
+    ssx     f9, a2, a3
+    ssxu    f11, a2, a5
+#endif
     movi    a3, 1f + 8
     assert  eq, a2, a3
     l32i    a4, a2, -8
-- 
2.20.1


