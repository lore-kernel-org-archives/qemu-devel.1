Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8B4C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C3E214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lt6jyPRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C3E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpdw-00087s-Qc
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMI-00023O-Tw
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMH-0006Mm-PH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:34 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMH-0006Lm-HE
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:33 -0400
Received: by mail-pg1-x543.google.com with SMTP id d1so1933236pgp.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cT5iUCtc/TpahCb9mQHDGpDMCKYLz7wFvW1IJP8R1rM=;
 b=Lt6jyPRXPkhYjZoDRfVNn+cQMWd2wYuXE5YkYeaJGJs2Ch45FXr200uR+MKGQR7bob
 R8NDvUDCFDCznJ49LSZ2RMNuoO8t7fgNy2C1k8rQvCgXdcuhEVfnwO7PHucoKQEZgaum
 n4ZOX1dbw1td4u9DkI43VzPI6NWtAlta2Ozboa18zo/6h+F1Tv4Nc2NMxMcjOkjwZMMK
 mE/zKVVKx4Jrv8l0bnVEwGxDPKULjBtvWxAnT6cXtvK1XPLs5/GFODlhATZURdarx2Gs
 Dj93p7LFEYhaq4hyu8eHK8GOYc7odqX2gViuVp1+2dy/im8rcTEFefrM/GAh6X/rBbOv
 ubnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cT5iUCtc/TpahCb9mQHDGpDMCKYLz7wFvW1IJP8R1rM=;
 b=mPmIkNcBpge74rIYzCGy/X+s4aavjG9AG6KXXEIxIt47VclaRXQieMmOT3LznahmVa
 d4NEDJSxktM43LQ7oXHJGdz+MXUfMofkWPzHI8bTUOOBdMD1ZpMBuyncsQfpdKGTgD5e
 2L+z/Z4xYIvkCTo3h4y8R6XKdpnsxW2uHIcOc16EBafLv3pf6EbwPRCfnIrj/dwQ7Krf
 +mecA8vhVe9rDDtizjKXn3Rw0/qGrmgdNW94bDwq6Hcta+qTlukLsqB0QXHdhDz71EP1
 NHDimJ9AqdLGJYO3nElQ3fovGD1NjRj/t0M60Ju5CJWvqvJjy/lUhtYzmLU3wpntPNIB
 dGNA==
X-Gm-Message-State: APjAAAU6KIOPR1U7D6mneMsc6klvML1Qfi73qHCUN8psORNB4ySHIQ40
 yZWRc+28/o3BzoBrsGXtLMvxoduDy6k=
X-Google-Smtp-Source: APXvYqzNx/G53Ww2bd4M4Kelw+Tb7DFpP8ZKBQuQccfTQt41YgvxxZKIMcYY8Eg3QMEVYMmexjvT3Q==
X-Received: by 2002:aa7:97aa:: with SMTP id d10mr26529772pfq.176.1566250712299; 
 Mon, 19 Aug 2019 14:38:32 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:15 -0700
Message-Id: <20190819213755.26175-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 28/68] target/arm: Diagnose writeback
 register in list for LDM for v7
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

Prior to v7, for the A32 encoding, this operation wrote an UNKNOWN
value back to the base register.  Starting in v7 this is UNPREDICTABLE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4451adbb97..29e2eae441 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9880,6 +9880,14 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a)
 
 static bool trans_LDM_a32(DisasContext *s, arg_ldst_block *a)
 {
+    /*
+     * Writeback register in register list is UNPREDICATABLE
+     * for ArchVersion() >= 7.  Prior to v7, A32 would write
+     * an UNKNOWN value to the base register.
+     */
+    if (ENABLE_ARCH_7 && a->w && (a->list & (1 << a->rn))) {
+        return false;
+    }
     return do_ldm(s, a);
 }
 
-- 
2.17.1


