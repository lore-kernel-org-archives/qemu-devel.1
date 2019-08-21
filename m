Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298CEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59752332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7RkWlQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59752332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Uo9-0007s5-Jx
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR4-0000lK-NM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR3-00078l-DT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:14 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:43602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UR3-00074c-80
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:13 -0400
Received: by mail-yw1-xc43.google.com with SMTP id n205so1228448ywb.10
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kid9rscQIJb9t8FEV+oHIuiy5oBbxmvCzn1qBeeyM5E=;
 b=i7RkWlQ+HXBTVTAIS3qN+A0xa07EGCcxFZ9VRGjQjdZkTS2rgCKi3G3PtRzNvVo/9Y
 8OKZ60VXm/wtvD4SFiaHDsRcUhhuyFFlOOz4FQp+i2sJiIN3FQFimRpHPKUWBAelaE5K
 cuhM3pHExMXO6abEZUcX1VuTBLDKZK7MJYRN+WfbJNbrc6M1Nt5R/xxhcsTUNejQhMHj
 iSmatuUmYOUt5HTXPkamoS4Gr+2lGZJG1bWYLoi7mTvjqF0CB0esvSYGsq0Xxshi93xv
 s9kB3gqRP6rEHxaa0/+p0gJGaauotuWr6C0TVSWd1z26lCKtH/ArHWjQMBP+1Rt7uFvB
 6knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kid9rscQIJb9t8FEV+oHIuiy5oBbxmvCzn1qBeeyM5E=;
 b=Rs+/9ndickvNaRAaKcwTjE40QaxWXotGNaDWjZm5ROnVADCxKDxDJ8uMbtm8KUIK+m
 jgVwc+3JFD826W0IkIg3JbyeGKli0TUo83lmX6zhTbqbnTBbAQrKb15B9+JI7cU2LdZi
 NPt1WbDST8Yu1+4BQ4Y6CA5+62i6hJJZb4eiAWVQRB6pnDFAdZgnB7eK80KsE21Lh5w3
 Dk5svzwebBeSAnotWaENWVxLFaAcsvcuImHAbP5K4DDCnHBuyi6R2q4hpZaFqIf+zR/m
 x5DIpSY6/jABOxDUVs9hpXmUZVoGDJTo0e7ogJhNrHRr/2y4TmxV6dP7Sxv3FlYRnWKI
 Uldg==
X-Gm-Message-State: APjAAAW+amof7TUDFZQrytV/sNUn0GbPIUCYw7hFlWF0/qs3jsfqEwXi
 kuR+vQwgM+ucFLDmPcCV13q1/z6A
X-Google-Smtp-Source: APXvYqwZlPJj4y0RI8WzUypmEV+XEYrHGh73D3ltf2PZRPRRo+0BNRyhzQeDWoQ7jMEsa4zCO6UDJg==
X-Received: by 2002:a81:2e84:: with SMTP id
 u126mr24490087ywu.398.1566408609312; 
 Wed, 21 Aug 2019 10:30:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:08 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:44 -0400
Message-Id: <20190821172951.15333-9-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v4 08/75] target/i386: make variable b1
 const
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable b1 does not change value once assigned. Make this fact
explicit by marking it const.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 62cce20735..3be869a8e3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3042,7 +3042,7 @@ static const struct SSEOpHelper_eppi sse_op_table7[256] = {
 
 static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 {
-    int b1, op1_offset, op2_offset, is_xmm, val;
+    int op1_offset, op2_offset, is_xmm, val;
     int modrm, mod, rm, reg;
     SSEFunc_0_epp sse_fn_epp;
     SSEFunc_0_eppi sse_fn_eppi;
@@ -3051,14 +3051,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     TCGMemOp ot;
 
     b &= 0xff;
-    if (s->prefix & PREFIX_DATA)
-        b1 = 1;
-    else if (s->prefix & PREFIX_REPZ)
-        b1 = 2;
-    else if (s->prefix & PREFIX_REPNZ)
-        b1 = 3;
-    else
-        b1 = 0;
+    const int b1 =
+        s->prefix & PREFIX_DATA ? 1
+        : s->prefix & PREFIX_REPZ ? 2
+        : s->prefix & PREFIX_REPNZ ? 3
+        : 0;
     sse_fn_epp = sse_op_table1[b][b1];
     if (!sse_fn_epp) {
         goto unknown_op;
-- 
2.20.1


