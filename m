Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1917C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F486208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJwu6qJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F486208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkF9-00036g-DM
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55345)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDf-00055R-H1
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDe-0004Vu-Bz
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDe-0004VC-3v
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id p74so22209326wme.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aCN/y1vsGbgbK8fKqVDDN8KS7NPTkiPqg0ffapBOPKw=;
 b=MJwu6qJgJqg4/4reyh4JQu/jD/L9r9VoL8l96xNyFsbf5CKefgC+WRHRwbRGb/9S/l
 biwDlVy1AdUORKeVBTY/4jTyBXB0KHMtRXHbdjlDFtIGbximWiShdenkLh4EIYLwxcXx
 SyOAQ9Zp80W6NW40rYpH7dxvG/XY0h7vk6Hkweh3RAZWYj5ExEPX98WrO+Tru/SZsws/
 K3Am7U+mbt9SYmvonyxyk1PxrdEZ2zVdmo2d+dOwzhJSmtOAcMr3XWWlnRnLpAUGxUDa
 lkUm4gC3N+sxfk39b9v1UGqWDmRY2XhMprWp7nYYk7Hamv7tuu1YmotPlKIhdod4jrI1
 yoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aCN/y1vsGbgbK8fKqVDDN8KS7NPTkiPqg0ffapBOPKw=;
 b=qmeMX7RDTFYx2QTm7kFCrxHZ+LE4sE+gR80BAHTfIPYshFvkZybgB2Wcs/vN7ZH0MW
 4XKTXXHMUEtAUpFu0UOB+H1vCHR/FD6Tu4Q6ibIyl0OnW+hd0r6qLUljLrA2qrDIL9Sd
 eA8631VtQwn5foA41oc/v8ecSY8A0w9TxHhe3x9Q9blK9Zs0DnFijMTqC3p3G/UyLrdU
 +r1D9iqUptuVV2/W7hGPgerZY69tGJEwLqdJYPvHZOs+mzQT2+NdNz2AXST1Xsv1Cruo
 edb2j+LUmEEbBbCLtdVpzpI9rAyThaBfP2bMU6wqiEzs8k4Mxg4TnDiw4cFhfQegS/+5
 QmeQ==
X-Gm-Message-State: APjAAAVrhiuPs5QvoqPnHdngCxRe/HpeWorRwVEKoZE2cW3dGWALw3mM
 DU5rIu4zTv0SyNw/MyCuWNjuRA==
X-Google-Smtp-Source: APXvYqwvQRNWe1WIOWIlr0gEFgCsiFjBg2cBORFw5uuKDTutaavKkrv4kmNsyxwsGX0Zcx3EsfWoCw==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr38759324wmj.31.1563371020915; 
 Wed, 17 Jul 2019 06:43:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u18sm20148321wmd.19.2019.07.17.06.43.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 642E81FF93;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:18 +0100
Message-Id: <20190717134335.15351-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 06/23] tests/migration-test: don't spam the
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quite often the information about which test failed is hidden by the
wall of repeated failures for each page. Stop outputting the error
after 10 bad pages and just summarise the total damage at the end.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
v2
  - bad - 10
---
 tests/migration-test.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index a4feb9545d9..c1968740abe 100644
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
+        fprintf(stderr, "and in another %d pages", bad - 10);
+    }
+    g_assert(bad == 0);
 }
 
 static void cleanup(const char *filename)
-- 
2.20.1


