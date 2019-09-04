Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60701C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC42208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7HnLA4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC42208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5c5K-000205-9c
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b17-0005eO-85
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b15-0003Pz-At
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:33 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b14-0003La-EJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id d10so7224056pgo.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xM5PgyYOOv0mxKWZUoslajtfwKtehkeOEG0dCYT++iA=;
 b=J7HnLA4gZUweUgFUA/RP2tEKRY1pTK13ZQ/cKyGZH6pVy6DKYVfSv1xmX4zSblG+Wr
 hNWjdAK55jiBqAAkoMxKpeJrRlXJ4Ej/zqriMJuP7bZENW2VEnfzV39ck1WReKJYKrEO
 2zmKsid0O0dLnaIkWTWoiDWQhVUDW6ianfo7tjW3Gy3CD4zOR0tfqJs10Cv6lLdnYQHo
 L7f5T0L8FBTsN4Ni6HHPMOBtGQQPlNvZFDHX/FHR95BhUpoPh26EQt/f70QtBrKnsY66
 0IJt1GgoIvu4olQ37vU2D+G/oLdcm2wnYbTOy7HBEUx4kKG+lyjwJyoIjfoDYM3edMPB
 pi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xM5PgyYOOv0mxKWZUoslajtfwKtehkeOEG0dCYT++iA=;
 b=HU+D/gVHw817gRHtf3KdlIhns5x2UGvIEwj0+FVnajUrWnlW4UNjIHNHEmyzEtfD5G
 KlwGCxsJ1v2WzocyboffLAfOXq4+1qNU4XPKDKOsjfk/EtmNM/R3wIF1EnFr3OmoNAPC
 1gaZIOyWIQzTGKJKJpBombDtWc51VNIvPsJ9NBeoVGGGJZB8CX0fl0fU+EpzkO6ZF1KL
 VIYzXRd727l+l+7VREub8/z0QZ3dI6LoMnxuY/WvkNJab2RZHq6LiVdQ8F80j75tvbV9
 cMnII7Lb9nj8btQQzxiMIelGlhWwMWtSdCQoYDdBi2WvT9MV/2fyxYkmBkkLxJhff+fP
 Qzaw==
X-Gm-Message-State: APjAAAV+lqgJJBomLDXD+TnbGYiCi8AUanGD6MTk3Vrc5zOfO5/T4acw
 BHJzW4gY2+H9n970O+sy2b7KnRvDMHw=
X-Google-Smtp-Source: APXvYqz3kXLjg2n7yv6ve/YFHdz1itiHOiyVbAX1/DbzGUDReO6ib6HcyKWL7pAP90DtPMg+2MvF+A==
X-Received: by 2002:a63:6d6:: with SMTP id 205mr37640948pgg.262.1567625546919; 
 Wed, 04 Sep 2019 12:32:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:58 -0700
Message-Id: <20190904193059.26202-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v4 68/69] target/arm: Clean up disas_thumb_insn
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

Now that everything is converted, remove the rest of
the legacy decode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a99a5c2eef..2412dde631 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10770,32 +10770,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    if (disas_t16(s, insn)) {
-        return;
+    if (!disas_t16(s, insn)) {
+        unallocated_encoding(s);
     }
-    /* fall back to legacy decoder */
-
-    switch (insn >> 12) {
-    case 0: case 1: /* add/sub (3reg, 2reg imm), shift imm; in decodetree */
-    case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
-    case 4: /* ldr lit, data proc (2reg), data proc ext, bx; in decodetree */
-    case 5: /* load/store register offset, in decodetree */
-    case 6: /* load/store word immediate offset, in decodetree */
-    case 7: /* load/store byte immediate offset, in decodetree */
-    case 8: /* load/store halfword immediate offset, in decodetree */
-    case 9: /* load/store from stack, in decodetree */
-    case 10: /* add PC/SP (immediate), in decodetree */
-    case 11: /* misc, in decodetree */
-    case 12: /* load/store multiple, in decodetree */
-    case 13: /* conditional branch or swi, in decodetree */
-    case 14:
-    case 15:
-        /* branches, in decodetree */
-        goto illegal_op;
-    }
-    return;
-illegal_op:
-    unallocated_encoding(s);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.17.1


