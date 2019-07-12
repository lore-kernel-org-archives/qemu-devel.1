Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B36C742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120CB20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVwtNKvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120CB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltbB-0006SN-78
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47155)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZo-0000HP-HT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZn-0000M4-HH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hltZn-0000Kv-8Y
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so9622684wru.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 04:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7sHk9UapFZ1v5dGQBuJrDhUFgezgy3UNJSh8wcf07Q8=;
 b=DVwtNKvFzebPrRo/g5NVymdU8uA9cu3+l+FFIYkwvGwH3O13X5nRrhgUWIFOb8dZ99
 fDfD8c2XqO4LUU6+uFY47EX7Gmau9q3R0eYPb7ylAOuR4p/GJslGXrnGTGQ0qfUz5ScE
 FRBikuTdS3frEgr0BNQhBov5vg4QO4cH3YnfkQjCVbI2zKk/b0PBZcrosiZjP8Gh8Lhq
 Gp0BOOolA1fyTIrY1CbChelf6nIqlgPgz7kzWEV0LfOAWCHnkvHFHmVhR3cdxvvX+lIK
 mePIhHw54UuvTH1kp+III2wjUtS8uwFqu/YixPZ1W1X7uIAVVPc4xoJdTy1Pz5ZyHO1t
 yy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7sHk9UapFZ1v5dGQBuJrDhUFgezgy3UNJSh8wcf07Q8=;
 b=QCP/DzMm+MmJx0ipLZHn+9fUMggz1DCYlqOPqgLq1zJqdLBL0WulMZ0qZvWeyjnLj3
 FkDGitOqU/dqwpmk45WZQZgb2P2+xSmgvflpYsWfPayDW3e3Yq+2ABYScWT29tpV8dCa
 baZPlmFktFzR+3mC/3TMAlcHybvqfAFfjnGZ/S/Ihv4nSF4bWlsKwgdo3HjVXZCcU5SI
 I+zcLTdWYWCflNJ+p1ZUkpns2zTcjPDeCnVK+9T8oDNXt0TKqj0cDoBvvxhJtsyd+QFd
 JsOiOsQWxNgxv/862ucOE8hh27YLPm7bxf4w91n7iJsYGPwfAH+pm35t1PvACM+XXsXD
 HGDQ==
X-Gm-Message-State: APjAAAXnzWeofC80bsh/OPknBaN5RKZxD09qrwbLePXFljWQO/Xep0Rd
 KV1n57UlEcsqNxZ6eAKH6PJU0Q==
X-Google-Smtp-Source: APXvYqy3Fqt0mKVQDKxUbfEaZtPL7EMRA1PxSDimPG20oaZQ6so91mKWRbxtqUfbGxwlRqjpV71O1A==
X-Received: by 2002:adf:ec49:: with SMTP id w9mr10616595wrn.303.1562930333930; 
 Fri, 12 Jul 2019 04:18:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q1sm7089808wmq.25.2019.07.12.04.18.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 04:18:51 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F66B1FF92;
 Fri, 12 Jul 2019 12:18:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 12:18:47 +0100
Message-Id: <20190712111849.9006-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712111849.9006-1-alex.bennee@linaro.org>
References: <20190712111849.9006-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 5/7] tests/migration-test: don't spam the
 logs when we fail
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quite often the information about which test failed is hidden by the
wall of repeated failures for each page. Stop outputting the error
after 10 bad pages and just summarise the total damage at the end.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/migration-test.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index b6434628e1c..ce041f80c2a 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -308,7 +308,7 @@ static void check_guests_ram(QTestState *who)
     uint8_t first_byte;
     uint8_t last_byte;
     bool hit_edge = false;
-    bool bad = false;
+    int bad = 0;
 
     qtest_memread(who, start_address, &first_byte, 1);
     last_byte = first_byte;
@@ -327,15 +327,20 @@ static void check_guests_ram(QTestState *who)
                 hit_edge = true;
                 last_byte = b;
             } else {
-                fprintf(stderr, "Memory content inconsistency at %x"
-                                " first_byte = %x last_byte = %x current = %x"
-                                " hit_edge = %x\n",
-                                address, first_byte, last_byte, b, hit_edge);
-                bad = true;
+                bad++;
+                if (bad <= 10) {
+                    fprintf(stderr, "Memory content inconsistency at %x"
+                            " first_byte = %x last_byte = %x current = %x"
+                            " hit_edge = %x\n",
+                            address, first_byte, last_byte, b, hit_edge);
+                }
             }
         }
     }
-    g_assert_false(bad);
+    if (bad >= 10) {
+        fprintf(stderr, "and in another %d pages", bad);
+    }
+    g_assert(bad == 0);
 }
 
 static void cleanup(const char *filename)
-- 
2.20.1


