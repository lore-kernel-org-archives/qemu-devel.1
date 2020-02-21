Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC83C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2F82073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQNFbY16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2F82073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58SC-0006Gq-Mi
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582s-0008RX-Fw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582q-0003vt-9K
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:42 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582q-0003uq-1q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:40 -0500
Received: by mail-wm1-x335.google.com with SMTP id p17so1779882wma.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qNihTLJediBrpCJBoB3GKxR0uHRMJ0laKIeFV/sWBeE=;
 b=MQNFbY16pR61Fbjdgajdp8bn+FGLccb/PkMZWosIdY4SAadvddq0jIdAPHDKdDy+Ql
 v7Gtlem7iRujBC/wKzSY28U7cYtJ7CbLldih9Zdp1piKVtnLoGO75YbzHoT/CDC5UEbc
 0d/oJRFrbKGAxk6E5k9LEOzx5ak8pv5NAZl+/9AxRZJ0c1rma2VUWin2qU/tXrdECyWF
 QPJYErNG97d4Og9fRDEdIiMgCj2nYOEwAMjuEvncDQU+a7PdunvlGQGrmQEoFegO6BG9
 csZkDAl/9w8pnPAh/drWm/0ebXF2SeHQSqFSlFm8OTuqCdsQmgq+dwBOkIyCmFIFVKvF
 0Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qNihTLJediBrpCJBoB3GKxR0uHRMJ0laKIeFV/sWBeE=;
 b=FbzFj8ZvdyDCRIbPrzExBs6+vSFNxZt057YIFHWNmgTpKX9gCOXtef+pYzIM5OSBOd
 WXaVcbQWeHR4cfcKqrBjIwHhqeN00uGIbs191ZDlFUKc7exjYeHLTOWNxDGk2tHCRmAC
 OK8ZFWqa1VJXlt4zPJhuME6ndsSfY9f03zX+1mcJKGOHBY5PFmh0j5GXz+Mq1AyMv8+B
 KCMz0IlDZLLfSA9qLcoljKlGVYOcn0Q9taLOd+mmhgy4I6wT/zMEIzyPQay3ptcFy9mB
 S4uA5TAgCJzXqUEtrULRho+GPjGZYjOqL/lUtX5H0u3AWCHgk63IsJKqg/o+s5GjjY6Q
 msVw==
X-Gm-Message-State: APjAAAUBdOsKmHiDgG4HCmF6jtqHldNm11GinNBTjDSkOCXUlIW9m3ef
 7bv24z80F+J1Aq2HbZU/7PrGx9dpkdAWGA==
X-Google-Smtp-Source: APXvYqx5egBCnPoTjWD6En80pTQKzB770C5vu20n5DldSuDJ7IhqZB7tabP5lZR0LhOmETT2K4Y1EQ==
X-Received: by 2002:a1c:2093:: with SMTP id g141mr3778986wmg.142.1582290518683; 
 Fri, 21 Feb 2020 05:08:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/52] target/arm: Set MVFR0.FPSP for ARMv5 cpus
Date: Fri, 21 Feb 2020 13:07:34 +0000
Message-Id: <20200221130740.7583-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We are going to convert FEATURE tests to ISAR tests,
so FPSP needs to be set for these cpus, like we have
already for FPDP.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214181547.21408-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8085268a539..2eadf4dcb8b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1872,10 +1872,11 @@ static void arm926_initfn(Object *obj)
      */
     cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
     /*
-     * Similarly, we need to set MVFR0 fields to enable double precision
-     * and short vector support even though ARMv5 doesn't have this register.
+     * Similarly, we need to set MVFR0 fields to enable vfp and short vector
+     * support even though ARMv5 doesn't have this register.
      */
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
 }
 
@@ -1914,10 +1915,11 @@ static void arm1026_initfn(Object *obj)
      */
     cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
     /*
-     * Similarly, we need to set MVFR0 fields to enable double precision
-     * and short vector support even though ARMv5 doesn't have this register.
+     * Similarly, we need to set MVFR0 fields to enable vfp and short vector
+     * support even though ARMv5 doesn't have this register.
      */
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
     cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
 
     {
-- 
2.20.1


