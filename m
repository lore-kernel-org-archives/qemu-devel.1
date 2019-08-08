Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2209FC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E227A2173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6D/k8pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E227A2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvp1N-0003MR-6a
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozO-0006xA-JI
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozN-0001E8-Ma
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:22 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvozN-0001By-HO
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:21 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so44619955pgp.12
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=otP5Jhfl1E+0A9Fm71GI7ndCATRFA/GRNsznhHQJJms=;
 b=U6D/k8pueOnINcKO96ewDohrHmZ87S9SdidjRs0w8n/eTVuJGDAiOHNgUnmrhpiRGP
 0RIQ+LDvf7kDPtG6QBd+2OR7P7aVhpmAJm1A9BzZva7KSutWjNwzR7MWyitBzJhsjiLo
 X4svsBqMWpGXLlwgsher8u03wIP7xwcPPX6ncHlWCqt5mOJxoa1zDYxx2G98g8eqD1Hd
 5jm/663k6yxKiDdxjUlRLuYS9gY8yz8rLibCJJtwasI703ZrQZLhM3HvycsF2Jj4LORs
 jbul/lBhoawVT4/LLWTCCSiubqe/G71gIiHi0TwqMGKsTKjxB/2FLh+Nqu/vrV5CasZC
 qVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=otP5Jhfl1E+0A9Fm71GI7ndCATRFA/GRNsznhHQJJms=;
 b=T/WNZ73Y0J3vSsJwAWlTUF1jeh0rBJuZ7cktHML0HUi9/b8quV7G6kGSKOfd9OO+rO
 v+KxynhPeM2aymmQo1i0qgzk8MNB2iun35hb2aFZ7N3fxvQUbSF2Jq5EeTM1io8SIpxT
 LBGgNI6bqtRUOVXtz/0sncGvy4RuFgtF+/wpFDcHJZZEoysvKXje1z+Gvy2VvFNZ6hEw
 0qFpL5V7po/RxkqQXL6bRjoKJ8glKzI9V/NnVkc/2zibALNR0EO03InjKXo+KnC0jGg3
 cmMMXCiWkG+2rhefjJ01zRlKBW0bosvRCpyz+wOQuwH6zBLrxYjyc52DuKZMaSdFj6cX
 08VA==
X-Gm-Message-State: APjAAAUNCFncZGa9hIma6qbyoxcrrZ6I/rLrtFSSe367uSjNQsjUIEdO
 kGa+ZL0QDimAxumALSLH/fiIgmxusWY=
X-Google-Smtp-Source: APXvYqyPwcefWh1KAjv0oTHqMKVFP2QPZMVO8kBz9MlGRum/pKAPadR0Ir5VT8VtqIlLZNzZcvW4cQ==
X-Received: by 2002:a17:90a:2008:: with SMTP id n8mr5763309pjc.4.1565295979981; 
 Thu, 08 Aug 2019 13:26:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm2850146pjk.13.2019.08.08.13.26.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 13:26:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 13:26:10 -0700
Message-Id: <20190808202616.13782-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808202616.13782-1-richard.henderson@linaro.org>
References: <20190808202616.13782-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 1/7] target/arm: Use tcg_gen_extract_i32 for
 shifter_out_im
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

Extract is a compact combination of shift + and.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 846052acea..43e005d191 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -620,14 +620,7 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 
 static void shifter_out_im(TCGv_i32 var, int shift)
 {
-    if (shift == 0) {
-        tcg_gen_andi_i32(cpu_CF, var, 1);
-    } else {
-        tcg_gen_shri_i32(cpu_CF, var, shift);
-        if (shift != 31) {
-            tcg_gen_andi_i32(cpu_CF, cpu_CF, 1);
-        }
-    }
+    tcg_gen_extract_i32(cpu_CF, var, shift, 1);
 }
 
 /* Shift by immediate.  Includes special handling for shift == 0.  */
-- 
2.17.1


