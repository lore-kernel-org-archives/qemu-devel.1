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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EBCC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9413A22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J82OWh3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9413A22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UkD-0001UM-DX
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR5-0000lp-07
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR3-00078f-Cn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:14 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:34112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UR3-00075p-7H
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:13 -0400
Received: by mail-yb1-xb41.google.com with SMTP id u68so1355983ybg.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iu3ZFqMy8y3ADU+zLNpdk/MYmfeKvllPrPbfuoyaSFk=;
 b=J82OWh3i0K29+MdsNTPBIEJWBx8aPxI2+eQpOexizCcEi8qWlOZHBtHvdZR5hm0Q5O
 7wLRq6Jsyhw86tqfZayi/iweA3IUhMrnjE3bzJoJ50EA17/nyBW22ggY8fDobSQoHQuE
 Gi5EaSyjeWwym/pljej7IY9YBw9xSfY9Mxxy8icO7G/dygq0pUFiynUM5Gg9AAkhPu+n
 62zLMs+WoSj+SIOaXDGbxtDORB6JDX2ThAbcVVRwCKSeJ7n6k2hVHgv/Iki1YkOWGM7H
 zXtWgPw6fyTM18qTNGQ9dOdhNPMD/Lp8XrdnjsFKhnLSWorkH0IWd/FqiYeNwbycCWOx
 XfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iu3ZFqMy8y3ADU+zLNpdk/MYmfeKvllPrPbfuoyaSFk=;
 b=GbzWtZYyYP3Bk5fB+L0h/Yt8VBUUL7o3ZNZGWeHWsHw08EN5ccwcGlWtCepSgPY9mV
 ng03tMdGVNddTE+Yf0KA9WeB1WrdfbrG45cpEZ4Rred28kXJ+mRwzhpVYqSTUkVYXU36
 xbPgI1dhW2JJIr45sPAIz/K7C4/1h963WfhUYZavEcaf9MkfVuSs+PNuV+1QP3w1asqi
 tPfHUIDKm/S0C7VUuEIEEQX60H1ItMyKhO8VYu1g0zPdnLf/wG7Ze3ee7KhK88lQ3FLR
 riagjIQ8ZvvPnkVpqSds8ro7GBUPbBD/EE/QJeU/pzDr+8bqgGcO6HO510E29HzIDwUK
 duFQ==
X-Gm-Message-State: APjAAAXbcqHjrLBPN90KXv4bBYw81/GILNkHKoQNA1ymQ68FpfpJ9xv4
 Y8BHxlKCAbK9CInsAxXk5geqRvwi
X-Google-Smtp-Source: APXvYqxlIw0hRr0pUVrlumsNppjaJ0zkpNs70UJeJQOcbVvlrmde1gKMtjW+lMym3NPnC1osQwSJaw==
X-Received: by 2002:a5b:cc2:: with SMTP id e2mr23823891ybr.288.1566408610199; 
 Wed, 21 Aug 2019 10:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:09 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:45 -0400
Message-Id: <20190821172951.15333-10-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 09/75] target/i386: make variable is_xmm
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

The variable is_xmm does not change value after assignment, so make
this fact explicit by marking it const.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3be869a8e3..44ad55f9ee 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3042,7 +3042,7 @@ static const struct SSEOpHelper_eppi sse_op_table7[256] = {
 
 static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 {
-    int op1_offset, op2_offset, is_xmm, val;
+    int op1_offset, op2_offset, val;
     int modrm, mod, rm, reg;
     SSEFunc_0_epp sse_fn_epp;
     SSEFunc_0_eppi sse_fn_eppi;
@@ -3056,20 +3056,15 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
         : s->prefix & PREFIX_REPZ ? 2
         : s->prefix & PREFIX_REPNZ ? 3
         : 0;
+    const int is_xmm =
+        (0x10 <= b && b <= 0x5f)
+        || b == 0xc6
+        || b == 0xc2
+        || !!b1;
     sse_fn_epp = sse_op_table1[b][b1];
     if (!sse_fn_epp) {
         goto unknown_op;
     }
-    if ((b <= 0x5f && b >= 0x10) || b == 0xc6 || b == 0xc2) {
-        is_xmm = 1;
-    } else {
-        if (b1 == 0) {
-            /* MMX case */
-            is_xmm = 0;
-        } else {
-            is_xmm = 1;
-        }
-    }
     /* simple MMX/SSE operation */
     if (s->flags & HF_TS_MASK) {
         gen_exception(s, EXCP07_PREX);
-- 
2.20.1


