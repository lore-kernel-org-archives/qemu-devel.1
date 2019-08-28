Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E45C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189A72189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueJY2T8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189A72189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i340x-0001B2-Jm
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gw-00040i-Gj
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gu-0000kV-73
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:22 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gs-0000hm-6h
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:18 -0400
Received: by mail-pl1-x641.google.com with SMTP id d3so411862plr.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HN5caKoOORxiigixHNAW+6u13INbJ94cJ6ViPIOo+M0=;
 b=ueJY2T8d/n0lymoCa2wSKjX+q7S6okwtey5AQiz8K8aKHYfFa7SYGJJMa0k64KrFfr
 rdIEygtubUsh7sdtrIPmyJrBSyh49urZ7g0WL39rbet6tQninGFvnsbhDrZRJeErmVKI
 yaVmDFD2zuMID2qrYM0a0CnWdG9RHO0ziPdkzhGItNSGX+0rKPSWFZUDkmPyW6qthDjo
 VBMbcLuQ48204BRESN39RS7uSXAY5QRttsTR5WIlEo7MY/OP/wdz7BVqu9zi0qGtYECV
 Jqk00zpvCrP1Lv9IhsboavwdHrea3M81tEt9kLHGKxtZJsNNgDxJnfXtx7K/Dxy1kLST
 xyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HN5caKoOORxiigixHNAW+6u13INbJ94cJ6ViPIOo+M0=;
 b=G+Z6Zha0HikOBJK6jQpPNeTh6w4sC/e05RIIucLiVln3qL0f1d5PtWkvYWKX1rcyzZ
 AMeU68RZAxpXhQ5nYmGXAnVwUM91mppMaeh7VV91eMcgGGS5suQw1qPx3qsrvAAOjLcB
 qftltiD5zP2KxKWTOgu//72uBabSOYXfjLATPIhS/CNOvHG4c57TC14p2RPXiO7z6b80
 tNEqyzUb+oCWaeg/r7cQSPs+jdg+6OdbUBiTTn79HgH1VsJ12uFIEn5qDmtQZQnD5Mdw
 z9q5AGguwStAyY4ZFTz8byK5LbJoOgC68nvpantCSVadzxssqimNc/GlvQCjsBVWdF/9
 xpHg==
X-Gm-Message-State: APjAAAX6QfOMDAYeBydQhZcDQAkbz18OZocquK95rzO84sLOrz3qSLKq
 y1dIm1UrNNqMedhhSobHpPtUfnwlrW4=
X-Google-Smtp-Source: APXvYqwEN+FSg8IeBVjfQvHTkAjeVQsYaOCi2ITksVhCKkiYiY9bxqokI5dzpEPeACZuavOooQL/wg==
X-Received: by 2002:a17:902:b191:: with SMTP id
 s17mr5975793plr.121.1567019174831; 
 Wed, 28 Aug 2019 12:06:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:46 -0700
Message-Id: <20190828190456.30315-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 59/69] target/arm: Convert T16, nop hints
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c |  3 +--
 target/arm/t16.decode  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ec5b095bd1..1bbfea8ea4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10868,8 +10868,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
         case 15: /* IT, nop-hint.  */
             if ((insn & 0xf) == 0) {
-                gen_nop_hint(s, (insn >> 4) & 0xf);
-                break;
+                goto illegal_op; /* nop hint, in decodetree */
             }
             /*
              * IT (If-Then)
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 19a442b894..5829b9a58c 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -19,6 +19,7 @@
 # This file is processed by scripts/decodetree.py
 #
 
+&empty           !extern
 &s_rrr_shi       !extern s rd rn rm shim shty
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
@@ -204,3 +205,19 @@ SETEND          1011 0110 010 1 E:1 000         &setend
 REV             1011 1010 00 ... ...            @rdm
 REV16           1011 1010 01 ... ...            @rdm
 REVSH           1011 1010 11 ... ...            @rdm
+
+# Hints
+
+{
+  YIELD         1011 1111 0001 0000
+  WFE           1011 1111 0010 0000
+  WFI           1011 1111 0011 0000
+
+  # TODO: Implement SEV, SEVL; may help SMP performance.
+  # SEV         1011 1111 0100 0000
+  # SEVL        1011 1111 0101 0000
+
+  # The canonical nop has the second nibble as 0000, but the whole of the
+  # rest of the space is a reserved hint, behaves as nop.
+  NOP           1011 1111 ---- 0000
+}
-- 
2.17.1


