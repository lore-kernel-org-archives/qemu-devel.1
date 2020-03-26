Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F143BC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95602070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nW/dDWJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95602070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYoj-0004K2-W5
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKv-0007PR-7H
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKu-0001yJ-6k
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:41 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKt-0001xh-HP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:39 -0400
Received: by mail-qk1-x742.google.com with SMTP id d11so8194266qko.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SQwt3BlCMlkRrdpIoHWlR7VL+MoMENIbhHHtRYB6xLo=;
 b=nW/dDWJw0d+Y1YRC5HdCl/0BDPcFXbtoPb027+TPPp21NlY8jzSE9jKIJ7IwpUzz5h
 +SkWjk5ULt9mES8H66gBZLwrZ6TBHiGlUcj/79+qIvR4fCoZDIjHyLpiDtSVS/DqXetg
 n0ssIzkIFGlc51IfyHAZQuvcz+ZrtEHFH0FgfrD80UbXm+XIO5lhHUCzYEuGI5Ymc2HJ
 STuR+7LBgpD1wW6oyO2v31TzcusT+iLYmYYDEZxiPA6kIOFzVhgFihLCfStBnuJBjOxH
 1Xb741Gwpa9ZEQT5MLTYEC0D3YtARluZTVcitX9ItY82hw/9GFGih2a8m5RKXQ2VygVM
 HWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SQwt3BlCMlkRrdpIoHWlR7VL+MoMENIbhHHtRYB6xLo=;
 b=OV/OiJNcZFgwDua+0bsr58jlAsWFgPdLHgR/SI10E4PaED6j23UOpZWsCOvdncFfUj
 GA+FoFZv1WzMsMvKCiGgDpV4MWoZRorEhQNZWIj4yZBB9c8660aIVmUPbFrbKSd9QRsP
 ZvwNuNNe1vOWh3rchBhFLQTrS6jj32HtwTf2TfOYWU9cdCn4KF+US0U32J+AUFUA0GVV
 epTIu32VCdSLEfFsHEagPW16PTeFq+yZUysmL6XcTADcXloM3oBWdmts34WjIZCHTZeY
 aOkemLVQOgSEx7NLkCtChTBhKzfr2hLl7CE6FNYeDhxPbpsHTbwHknzFc4j+hSXEmDXc
 9X6A==
X-Gm-Message-State: ANhLgQ17Gmf8A6cFcxHf7HqXe2Pc00xVFzOtSw7OS4xRJ46glj/nxiIQ
 rlQxWecr5/IfyresKD4OLhtbEq8xjm0Anw==
X-Google-Smtp-Source: ADFU+vtnvbdwATvEoc09I7RzE9BEiNkWgxe/5wOhQ5x48PDfy5pQpR+vjwxNeQN8jcobmruGyM918g==
X-Received: by 2002:a37:4785:: with SMTP id u127mr1228692qka.135.1585251518391; 
 Thu, 26 Mar 2020 12:38:38 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:37 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 47/74] cris: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:29 -0400
Message-Id: <20200326193156.4322-48-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/cris/cpu.c    | 2 +-
 target/cris/helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index cff6b9eabf..6d7e266042 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -37,7 +37,7 @@ static void cris_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool cris_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 static void cris_cpu_reset(DeviceState *dev)
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b5159b8357..67946d9246 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -131,7 +131,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
-          cs->interrupt_request);
+          cpu_interrupt_request(cs));
 
     if (env->dslot) {
         /* CRISv10 never takes interrupts while in a delay-slot.  */
@@ -193,7 +193,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
-          cs->interrupt_request);
+          cpu_interrupt_request(cs));
 
     switch (cs->exception_index) {
     case EXCP_BREAK:
-- 
2.17.1


