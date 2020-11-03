Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2BAC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3560B206CA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="q9q40D6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3560B206CA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlIY-0005mR-IF
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Iq-gXwsKCgcozrpuultvlunvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--hskinnemoen.bounces.google.com>)
 id 1kZkut-00082g-Do
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:15:19 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649]:45198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Iq-gXwsKCgcozrpuultvlunvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--hskinnemoen.bounces.google.com>)
 id 1kZkur-0005nZ-BZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:15:19 -0500
Received: by mail-pl1-x649.google.com with SMTP id m7so6640414pls.12
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 17:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=SJM2AYQixjJryNNj/i7eG9v9yAAu5bw1l8yViAnTvj4=;
 b=q9q40D6bxBCEqS6/6skOnTYnQSFABghCHv/Qk8DturrbS5Azv0zmaWXFnTPERZJS10
 a2dZTr0XBQtaBWh8OAcWhr473g02yuPqEtRpGIzOij0z/YPjvWBH5UPyXw56Rem8AHsA
 7oeo2AfD85D072avgcpwUXyQdPMnZGjYg5EZiff+6kDckajUx4LCooDdePVQOyE/LO7a
 ecU1MhJNpOnhHxoO/Uq20XNZn+mENbmigo+QkJida+QMZR8J6HdojyyYc37v/RZDpXp1
 SASsNaRv/inLl2/trH+b2PIawvvXZ9oV+cue1QJyBCELSAbvL+5PhN+V3AC/Zj5OfZV+
 dsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=SJM2AYQixjJryNNj/i7eG9v9yAAu5bw1l8yViAnTvj4=;
 b=prM91HbnBxNoFPkJLO/k67fzRAto4h3KlHsJJI1s6+On0XGuagjwK+lgkEQTtk5T+1
 f0dgKkafpwviEDfDDEzzG5DcyPG599X4s8nQgRu9KinIQLngcdO7gkDsCijSF+0PJ0oR
 d8xDpM1wCg2L/F00fWts1QHc6yom7dVukSuiBULdZaftvGX9YVSzwF0zZ0C6PN6jzZpn
 04WJYCzwpByruUpK3SDFe9tJtlB5yF7igEMCjarBPOhOQ1pgLdrTIdwjhO7l4iKjm18K
 PlZGPy5agHeq2QemRqdguxdI5QwEiICL5yuUz6s8RZb4QkV0OanqQ/hgqecred3byqts
 iHyQ==
X-Gm-Message-State: AOAM531OhTJAGsfqVKU3oMHmCcwKjPOmcqN+DKKZ6J4b7xgkZko1AAQ5
 z9rWP0N1cFukiXGZxJcXLQJYF8bhW6y57w+6+A==
X-Google-Smtp-Source: ABdhPJzAdMIE2QxnQA19A1kQS4VEBbdymMGt035KuSl8+LgGFGBFbMfO60hljTV4XlOTPqN4qy7lt7rHT+w6rK5oDQ==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:aa7:83d7:0:b029:164:28d:f350 with SMTP
 id j23-20020aa783d70000b0290164028df350mr23235253pfn.71.1604366114522; Mon,
 02 Nov 2020 17:15:14 -0800 (PST)
Date: Mon,  2 Nov 2020 17:14:56 -0800
In-Reply-To: <20201103011457.2959989-1-hskinnemoen@google.com>
Message-Id: <20201103011457.2959989-3-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201103011457.2959989-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 2/3] tests/qtest/npcm7xx: Don't call
 g_test_set_nonfatal_assertions
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3Iq-gXwsKCgcozrpuultvlunvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--hskinnemoen.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

Even though g_test_set_nonfatal_assertions() makes test failure
reporting a lot better, no other tests currently do this so we'll turn
it off as well.

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 tests/qtest/npcm7xx_gpio-test.c           | 1 -
 tests/qtest/npcm7xx_rng-test.c            | 1 -
 tests/qtest/npcm7xx_timer-test.c          | 1 -
 tests/qtest/npcm7xx_watchdog_timer-test.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tests/qtest/npcm7xx_gpio-test.c b/tests/qtest/npcm7xx_gpio-test.c
index 1004cef812..3af49173a7 100644
--- a/tests/qtest/npcm7xx_gpio-test.c
+++ b/tests/qtest/npcm7xx_gpio-test.c
@@ -357,7 +357,6 @@ int main(int argc, char **argv)
     int i;
 
     g_test_init(&argc, &argv, NULL);
-    g_test_set_nonfatal_assertions();
 
     qtest_add_func("/npcm7xx_gpio/dout_to_din", test_dout_to_din);
     qtest_add_func("/npcm7xx_gpio/pullup_pulldown", test_pullup_pulldown);
diff --git a/tests/qtest/npcm7xx_rng-test.c b/tests/qtest/npcm7xx_rng-test.c
index 57787c5ffc..d7e42cf062 100644
--- a/tests/qtest/npcm7xx_rng-test.c
+++ b/tests/qtest/npcm7xx_rng-test.c
@@ -261,7 +261,6 @@ int main(int argc, char **argv)
     int ret;
 
     g_test_init(&argc, &argv, NULL);
-    g_test_set_nonfatal_assertions();
 
     qtest_add_func("npcm7xx_rng/enable_disable", test_enable_disable);
     qtest_add_func("npcm7xx_rng/rosel", test_rosel);
diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index f08b0cd62a..77e6e0d472 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -530,7 +530,6 @@ int main(int argc, char **argv)
     int i, j;
 
     g_test_init(&argc, &argv, NULL);
-    g_test_set_nonfatal_assertions();
 
     for (i = 0; i < ARRAY_SIZE(timer_block); i++) {
         for (j = 0; j < ARRAY_SIZE(timer); j++) {
diff --git a/tests/qtest/npcm7xx_watchdog_timer-test.c b/tests/qtest/npcm7xx_watchdog_timer-test.c
index 54d5d6d8f2..426303ecfa 100644
--- a/tests/qtest/npcm7xx_watchdog_timer-test.c
+++ b/tests/qtest/npcm7xx_watchdog_timer-test.c
@@ -303,7 +303,6 @@ static void watchdog_add_test(const char *name, const Watchdog* wd,
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    g_test_set_nonfatal_assertions();
 
     for (int i = 0; i < ARRAY_SIZE(watchdog_list); ++i) {
         const Watchdog *wd = &watchdog_list[i];
-- 
2.29.1.341.ge80a0c044ae-goog


