Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8071C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D55B20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsBbrh29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D55B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYN2-0003F0-NY
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK2-0006Ae-Iq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK1-0001Pn-ER
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:46 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:33122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYK1-0001PI-Ag
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:45 -0400
Received: by mail-qt1-x842.google.com with SMTP id c14so6572427qtp.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MXpQV9EpBjzND01X5ptnGqVZfb5b+aXFoE3ZFX11iS4=;
 b=CsBbrh29KtnEN++gMhFFDxPTM1Lu0CcAYVnK0Qd3yVSIdNdIgBKXrYyuaYXvRpojG5
 HOmFY7HQHye9HMFCIJrBMJb6yoUZ8A0miqXpmW14gsHK8dfo4d2aQQHzsKs+5Kx4Y8mD
 sE542r/jsugMbZK/QAtZVjXA2JwDoZLx/K38Rbu5in8NulOkEzebVcfyRs+n7jJFQkHC
 4J6bpvsPNcKoWFgxQoo0H2qL4WihF59qJ39hkU8olzyFd3CLWRSdZYLCV5hA3oQz6mzl
 BgVvqdoh+X0AUgro9iDYsPxZ/UIyyYfCcfDQmwB/8AaCrXsNk29kWoIyaSwozji4njOM
 pxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MXpQV9EpBjzND01X5ptnGqVZfb5b+aXFoE3ZFX11iS4=;
 b=IuIdCCbxRqxRxnHRswWlaw2qn3CxzyPiHeZtpKE3rhDrpBK46bEwaDvdBwgwlIjGa2
 J1MzaxpheeVLRH8SToOTyvbjxPwXm1UgCZkqWzufbDcYkYjWJfrwilJqy01WdV0mTRl3
 spq6MKUCj96lTHsPtHxtyVd4RgBtoKshVvDJ0p+5IyFxbTj2U/tRRiuNvAlaE5rpGN1F
 eCpBMdNC+UCjGeFtju9pRmlF0HpEdJ9e/DbvXl3f0UTzV/heK2jd3xFIxs7UMJF4IBnK
 lZlSDiAiiDVhXd6hiDO/e5XDIf1O4IuHGw4OvaSEmnywrwX8T9G00vQdkMWIoAMOpJ+b
 eYzw==
X-Gm-Message-State: ANhLgQ3kNvp5xfJVfw0OqZuOfJDOZg75Wwa5PIB6PxAOABHZRwyVDnSr
 zDEqwq/0H4fpn+zKnbFwvhRbGSGjg69kiQ==
X-Google-Smtp-Source: ADFU+vuAh3uYAloF1osiCx1Y2Dv79zQ8IHi8/khwKCWdsYRCHahDkcShe05ihlRdlr5tzLqubEisWA==
X-Received: by 2002:ac8:7684:: with SMTP id g4mr10303802qtr.339.1585251464500; 
 Thu, 26 Mar 2020 12:37:44 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:43 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 09/74] ppc: convert to helper_cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:51 -0400
Message-Id: <20200326193156.4322-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, qemu-ppc@nongnu.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/ppc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b207fb5386..ff1ac82320 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1595,8 +1595,7 @@ GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
 static void gen_pause(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(0);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
 
     /* Stop translation, this gives other CPUs a chance to run */
@@ -3602,8 +3601,7 @@ static void gen_sync(DisasContext *ctx)
 static void gen_wait(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(1);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
     /* Stop translation, as the CPU is supposed to sleep from now */
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-- 
2.17.1


