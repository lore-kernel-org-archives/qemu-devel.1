Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D70BC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1547B22CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kK8uVJsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1547B22CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq9Z-00057d-7b
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMt-0002pM-9d
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMs-0006t7-8q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMs-0006sZ-3q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:10 -0400
Received: by mail-pf1-x441.google.com with SMTP id q139so1934324pfc.13
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JUuR6qD1PO3BvQ9lvZTub8abynQZibA90MasCzAeg3k=;
 b=kK8uVJsIVRdJcdeeBbE7un71lp4z2dtG1Q+15hPBwwYRGcr8hm5Vil9e2O5fV0aMt3
 n/oD+Hvi2Squ6jcTgWWbVDZl9bODPlfvJxa0bpK0y8l1zmDPy/T2rxR3tF66GNKdcQp3
 8m27hZJNWVHrTTiQgQxmBTNw/+c0Vmgj0EOxPhDxfuFj5WVzbPg9qVxh1LtLx0ugJwGh
 GIqsiNUpM3So2ojmT2ebgBDuqBaZf4FMrFi/pZITgGIa0+NhPCh0VcEjrAGrJxcR1JEO
 FGTXRAg+JeLOcGjuYANIW8GPt7kVHc7brJOsUyif4E9dcftKsDZ8bWedOzcDKNZw05hx
 N3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JUuR6qD1PO3BvQ9lvZTub8abynQZibA90MasCzAeg3k=;
 b=r1dhttS+7bK4ehoZTqgZyjpK1+vGQO++0E6S9PeJCnO/X9mEt4f6rHR3Ko53E/t2kn
 bbhcW3ZPbOzqMmZIFwbABo7PMcdZq83F+x+iC+weR+z6RK7Q6411rhlaS4WHVJgYPULu
 pLFXJHblESuRo33Y7+9yAVIwHCET1YToA65tVdHvZketCnagJvLHq9ciYPyWYyvjZLF8
 yhMKcirRfpfTEOAaSp1rTy+mC5NQvimVh0SUVGxs8TBiVjCZFfn9L/ZvBqpcf5F6Ekxi
 IlC+2qs1t6WoOwUC6cmUdJ4wxB9t9EBcbD67syblZVK+gUrKCr0Dqdf4HjG4ljSHJwEI
 PgOg==
X-Gm-Message-State: APjAAAUiKGtwTBk80pV9KEexrD18RxifpScdccKTiS2zgcUfBZ0fjoxV
 ayVYbd/Dk0Z/1mY0mUg6VU862sQTRzc=
X-Google-Smtp-Source: APXvYqzV0wI0tQm4HPyXJB5Y5I5tSOvZyGR7Ytb947wV3BKOHWin5Xp2jeRFD0mZHxJ+kBKABTg1Og==
X-Received: by 2002:a17:90a:a78b:: with SMTP id
 f11mr23431921pjq.16.1566250748527; 
 Mon, 19 Aug 2019 14:39:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:45 -0700
Message-Id: <20190819213755.26175-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 58/68] target/arm: Convert T16, nop hints
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c |  3 +--
 target/arm/t16.decode  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 176cba2992..67f0202d29 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10769,8 +10769,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 
         case 15: /* IT, nop-hint.  */
             if ((insn & 0xf) == 0) {
-                gen_nop_hint(s, (insn >> 4) & 0xf);
-                break;
+                goto illegal_op; /* nop hint, in decodetree */
             }
             /*
              * IT (If-Then)
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index ec21be7ef0..d5b046d105 100644
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


