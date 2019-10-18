Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6368DCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCFA222C6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3evIrKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCFA222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTJy-0001mA-Rp
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLTIJ-0000BD-30
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLTIH-0002iJ-Qe
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:31:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLTIH-0002gj-Ja
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:31:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id b9so6534462wrs.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M/re3SutNLZ5EZ1/qaqbg2V+z7g6WDXA7WOt1KwyO2M=;
 b=E3evIrKVfb6VrDkAdbWiUVhX3s2jIKvEViOPVwEssmNHw6sfxVOFYEpVasdjy+Br0X
 itZen4j1ZzInbcWg1zkoO6gdOaiO918AXKi4bBC4YCFA/ooPd3hLsoTdtRDttKdSA+aj
 O3HzOfiOEfHdrbzqiTwfS2WxEgIc7FWZjFnvjI5HSyfHl05x+D8cO/sntPG/Hkc2CQQE
 hUiyS73w/YTLENmo3hz0zDZ+KSUvYXA6JMcT28UONktKbAnErs+v6QHUmNiclznDlLSc
 2TxhjIgUROg7cNdwKTJcgUpbETg686qFvuTtzGyKILibtc9t7zC8OPm/rs3tbzxV6IpD
 NowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M/re3SutNLZ5EZ1/qaqbg2V+z7g6WDXA7WOt1KwyO2M=;
 b=bKaDVdvZ7x3rbW7jGoQKkgwnuKNkhRCPSXwPFFcBsBLs0/QILyX9KQNCOnxKtPNuua
 GCDLda7/ue3yZtwj07Coj0mbIBno2N9YaPgsbnFDuX9sBuATjpetGGoj0mgHF/01rlxq
 GZ3MGa/Be8gH6K/lZnwwbTGVp+u7HKVowvjMPTUdz+RuikJ1JkKq8/76V/yvL8vWin97
 9Ln7AQdI6WoQs9SMBAso+x2d7yp/pv0qW66e9xTJYJtci0TWVELM1e/cz3Ltde7jY/Cq
 C/ElKrFdJdmn7jIiQEQjqKFAY6g0cFGsA+HZAyfjmmA+gXnTERANRA/EwtSVlFgloAKc
 tBbg==
X-Gm-Message-State: APjAAAXXo4SO8h0Wn72xTvug6+shOHcU1L1SM6Cn2e1ErUL2J9ITI4Nu
 pEbSq16Es+9oYa+WNiQxjFYWhA==
X-Google-Smtp-Source: APXvYqwQFM/bV7E9o7GF8b9y808ZUuX/067kGQxiGwou0V8k/OJijC/RZAi4n/zyKilRcGxTSjqglQ==
X-Received: by 2002:adf:e8c6:: with SMTP id k6mr8170164wrn.78.1571409111850;
 Fri, 18 Oct 2019 07:31:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm5537915wma.15.2019.10.18.07.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 07:31:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/timer/exynos4210_mct: Initialize ptimer before starting it
Date: Fri, 18 Oct 2019 15:31:49 +0100
Message-Id: <20191018143149.9216-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

When booting a recent Linux kernel, the qemu message "Timer with delta
zero, disabling" is seen, apparently because a ptimer is started before
being initialized.  Fix the problem by initializing the offending ptimer
before starting it.

The bug is effectively harmless in the old QEMUBH setup
because the sequence of events is:
 * the delta zero means the timer expires immediately
 * ptimer_reload() arranges for exynos4210_gfrc_event() to be called
 * ptimer_reload() notices the zero delta and disables the timer
 * later, the QEMUBH runs, and exynos4210_gfrc_event() correctly
   configures the timer and restarts it

In the new transaction based API the bug is still harmless,
but differences of when the callback function runs mean the
message is not printed any more:
 * ptimer_run() does nothing as it's inside a transaction block
 * ptimer_transaction_commit() sees it has work to do and
   calls ptimer_reload()
 * the zero delta means the timer expires immediately
 * ptimer_reload() calls exynos4210_gfrc_event() directly
 * exynos4210_gfrc_event() configures the timer
 * the delta is no longer zero so ptimer_reload() doesn't complain
   (the zero-delta test is after the trigger-callback in
   the ptimer_reload() function)

Regardless, the behaviour here was not intentional, and we should
just program the ptimer correctly to start with.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[PMM: Expansion/clarification of the commit message:
 the message is about a zero delta, not a zero period;
 added detail to the commit message of the analysis of what
 is happening and why the kernel boots even with the message;
 added note that the message goes away with the new ptimer API]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Philippe pointed me at this bugfix from Guenter. At one point
in my working on the ptimer API changes I thought this bugfix
would be necessary as a prerequisite, but in fact the issue
was in my ptimer changes, and it just happened that fixing
the MCT bug was a workaround for my bug. Even though the
ptimer API changes actually coincidentally now suppress the
annoying message about a zero delta, the behaviour is definitely
not intentional, and since I spent the time working through the
analysis of what was actually going on here I don't want
to waste it :-)
---
 hw/timer/exynos4210_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 72257584145..944120aea59 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1254,7 +1254,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         /* Start FRC if transition from disabled to enabled */
         if ((value & G_TCON_TIMER_ENABLE) > (old_val &
                 G_TCON_TIMER_ENABLE)) {
-            exynos4210_gfrc_start(&s->g_timer);
+            exynos4210_gfrc_restart(s);
         }
         if ((value & G_TCON_TIMER_ENABLE) < (old_val &
                 G_TCON_TIMER_ENABLE)) {
-- 
2.20.1


