Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A23C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B3E22501
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2nsgtmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B3E22501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2FY-0001Ex-Uu
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B8-0004v6-D5
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B7-0005lw-6A
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2B6-0005l4-W9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id w8so3870347plq.5
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TMW87VFE4aaAyrSbIdPCRdi4/pYOXWGaazKqSKeXpbw=;
 b=J2nsgtmPn7O7GLLpoThqsZ/VHa3QUECjSVzu1gMkiASuSuQDUeXPHrPkBZTvFh41Fa
 hs9yuJH81IDxT8XgbyuwK4B1gziMu+Yq9/3+AUQ00xD/3HEqvQvFOuQE/LFAL144UfSk
 Db0SmRO3cQH29mUJVtZ/cyL3aFBT1bmXo90+rjo6IbOOfMpPNbI5GeiRXplcmN5dq3gU
 YOHTcWQAWsaW7/East5MPMZ3cbr7bEESYgxRKcj0j0tIZJdoDjMa0jRxGMF7+qIFzNtK
 yWD2dKq3p5Bm91TYMxeju81r3nCZ2YtrOjIMPWqi1BI94imk4uRkJ1laGNtPFN+6PqXP
 aoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TMW87VFE4aaAyrSbIdPCRdi4/pYOXWGaazKqSKeXpbw=;
 b=r5oVmQR6r490GzxaDX1K4A6RtnX93s7IsbAVL/S2sAYKMepux2m/osirPh8mC9k3u3
 ziJfFXLSJk3UyruvufLoGoChf74rgwChJEhths8zc0wyNnnCwlYyfyTxeP0fQBnuxT+Q
 0SbId0PsNZW3qCcRPZSiZxmpzGllQ1kLglyx5rgcrXi6J1zOLoiYH+yFcLPwoEC+6HwG
 BSw7gU7++p9z8+B0ojWvVs8/8gKsBX0h+mFg/whD0EnaZ+69S7i7wkwG3Sak5aA58aFU
 7+yq0rCtzNArHilBnIGJXlNgCeRTjzl585sMR1bwD0FAk+GYmJ0kqPfy+GNPgICB5gEc
 6j9A==
X-Gm-Message-State: APjAAAXuRjfjtPup9wCb+Q90IrJur7X9tDZe7I9Vw/9AoxSyq3ef47OL
 AhUAD8RqL6mYQvzWTGsi+N+CTQpGnyY=
X-Google-Smtp-Source: APXvYqxBicyedOkSiIvbrK/WQWNOR16mrc7jSRHGVMGosn13GSd4OdsSWc1pDs1ooZvdm12nd2LV2w==
X-Received: by 2002:a17:902:6b02:: with SMTP id
 o2mr22102443plk.302.1569874911637; 
 Mon, 30 Sep 2019 13:21:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 19/22] tcg/ppc: Update vector support for v2.07 FP
Date: Mon, 30 Sep 2019 13:21:22 -0700
Message-Id: <20190930202125.21064-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These new instructions are conditional on MSR.FP when TX=0 and
MSR.VEC when TX=1.  Since we only care about the Altivec registers,
and force TX=1, we can consider these to be Altivec instructions.
Since Altivec is true for any use of vector types, we only need
test have_isa_2_07.

This includes moves to and from the integer registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 6321e0767f..840464aab5 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -586,6 +586,11 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define XXPERMDI   (OPCD(60) | (10 << 3) | 7)  /* v2.06, force ax=bx=tx=1 */
 #define XXSEL      (OPCD(60) | (3 << 4) | 0xf) /* v2.06, force ax=bx=cx=tx=1 */
 
+#define MFVSRD     (XO31(51) | 1)   /* v2.07, force sx=1 */
+#define MFVSRWZ    (XO31(115) | 1)  /* v2.07, force sx=1 */
+#define MTVSRD     (XO31(179) | 1)  /* v2.07, force tx=1 */
+#define MTVSRWZ    (XO31(243) | 1)  /* v2.07, force tx=1 */
+
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
 #define RA(r) ((r)<<16)
@@ -715,12 +720,27 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         /* fallthru */
     case TCG_TYPE_I32:
-        if (ret < TCG_REG_V0 && arg < TCG_REG_V0) {
-            tcg_out32(s, OR | SAB(arg, ret, arg));
-            break;
-        } else if (ret < TCG_REG_V0 || arg < TCG_REG_V0) {
-            /* Altivec does not support vector/integer moves.  */
-            return false;
+        if (ret < TCG_REG_V0) {
+            if (arg < TCG_REG_V0) {
+                tcg_out32(s, OR | SAB(arg, ret, arg));
+                break;
+            } else if (have_isa_2_07) {
+                tcg_out32(s, (type == TCG_TYPE_I32 ? MFVSRWZ : MFVSRD)
+                          | VRT(arg) | RA(ret));
+                break;
+            } else {
+                /* Altivec does not support vector->integer moves.  */
+                return false;
+            }
+        } else if (arg < TCG_REG_V0) {
+            if (have_isa_2_07) {
+                tcg_out32(s, (type == TCG_TYPE_I32 ? MTVSRWZ : MTVSRD)
+                          | VRT(ret) | RA(arg));
+                break;
+            } else {
+                /* Altivec does not support integer->vector moves.  */
+                return false;
+            }
         }
         /* fallthru */
     case TCG_TYPE_V64:
-- 
2.17.1


