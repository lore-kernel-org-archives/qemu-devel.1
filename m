Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC2BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E75520870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i25f1saG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E75520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8pj-0006zw-9l
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8j1-0007nE-Ez
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 21:03:35 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8j0-0000ft-00
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 21:03:35 -0400
Received: by mail-pg1-x544.google.com with SMTP id r10so16198690pgb.10
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 18:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lgTEIoGQTMBZd1KdzUKViOu+UKgD2OOzWkZKgsEYCHM=;
 b=i25f1saGFbASYorST2u5zLIwOUqeDTp2APQLG68BxxExKMXjv1RT3SAT5zpeb5ONbv
 N2VmgdceJAublsLMfEcw4UH4U63dQzwTjcJXnYGNqWveAw4HPyvv6Y71oAOdeIssucSf
 vxwH7nHwsM9aEC9YYqxGyB2HaW74umNylXAjfz86b/fgecZYZBmBRABs2DPSaN6HQqlu
 hefW2dwhzOIq9h/f3PmougH4Sq0OR2l3OpLJ8QA5JbdIUphNBLbguNc8Aumwg9KQG0cU
 rjU/bOCnCd6adW6aC+gmcBMF1h3z91D85Brve0+mWE1wPJgEAmf7/AqTEU8S/LD7jAJI
 Qpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lgTEIoGQTMBZd1KdzUKViOu+UKgD2OOzWkZKgsEYCHM=;
 b=kYCi6o0niAK00VDnHdTc2VanEFOWd09tVCehLzejKJbqoxHJymEcZdIGOS+Kp7O3g9
 sFCh/oqfs5zcqH0RHqSewUCPfdVMYnaPlIoqbvLWYtjJwsSW/1lFq9f5Fu24E5y9Za8F
 dWVgm6WcmR6TcbOA92wbJECRZZB1qDwUgYrYHLghLyno4aRqJ5sz/NRfYxkFTAl2dbyt
 3ym9RZQvP/5TwzYldyPIPmoqs8E/ib6spxGdsD5x7toDk8QuFbeDbqrB64QcmVISociI
 A6tDrosz7l0tZfS2O5fqunQj+CQ7e6HgngrNjY446xFaWuPQ5T4L6jS+cUFxFKK9K74f
 i5Ag==
X-Gm-Message-State: AOAM533Br13gyYuH2upt91HZdwHnN0z1Qd1zDHstE+B64tkX6aldRT+V
 g9If1XbVDlmixeUz2YCgJf8+Qkw0EmzkNQ==
X-Google-Smtp-Source: ABdhPJzR1UOWcqrdeiaWfAlQzyN8VhnexnC2QDXnuZ54UTpw4CIkrqf0yDbTwbxoKsh8yoLOKnxPog==
X-Received: by 2002:a65:6559:: with SMTP id a25mr9291026pgw.406.1602551012053; 
 Mon, 12 Oct 2020 18:03:32 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x23sm20809529pfc.47.2020.10.12.18.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 18:03:31 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] gcrypt: test_tls_psk_init should write binary file
 instead text file.
Date: Tue, 13 Oct 2020 09:03:09 +0800
Message-Id: <20201013010310.497-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201013010310.497-1-luoyonggang@gmail.com>
References: <20201013010310.497-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On windows, if open file with "w", it's will automatically convert
"\n" to "\r\n" when writing to file.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/crypto-tls-psk-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
index a8395477c3..11ae26368c 100644
--- a/tests/crypto-tls-psk-helpers.c
+++ b/tests/crypto-tls-psk-helpers.c
@@ -32,7 +32,7 @@ void test_tls_psk_init(const char *pskfile)
 {
     FILE *fp;
 
-    fp = fopen(pskfile, "w");
+    fp = fopen(pskfile, "wb");
     if (fp == NULL) {
         g_critical("Failed to create pskfile %s", pskfile);
         abort();
-- 
2.28.0.windows.1


