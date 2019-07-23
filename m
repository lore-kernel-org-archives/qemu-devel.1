Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA9C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F61C223DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZyu/5LH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F61C223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsAS-0000pV-7N
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9b-0005ju-Pz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9a-0007NQ-Pm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9a-0007Mb-FZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id a15so37978516wmj.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wpS9ypdTER3emr4GCEit5LCtD2h8CLnhaQIkW9n2/iM=;
 b=IZyu/5LHqg3UAbgcm0cRQOd1YJtA8M6QU032N0m6lbKIP3jmrzPAEG3eRgMqMOo+M3
 TOjPy4sreJEstrWbJ4ftCU845TLFm8W+b/iGr96Pw3XfSTCKW/5DlWL1/JgKGRnnKLPy
 Ueh1YZu5rDHxwA1se3fbievXcZkgmyLtKAL0E6nraH7m6oIYBtsq4WoGk5xHhyo/QnD7
 0c7lByeaq4d4fQxr87YzIlPgklexOgJPTADzIYJgdbqXXXJmMPVSrjkwGZB3jdTnw0Rj
 c9IL+9UUjKLw8fBgBDtuX2w3Z301TxfQpuLYXWJdU56vgPZP97k9rYCCnGg9EMS+uXx4
 d9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wpS9ypdTER3emr4GCEit5LCtD2h8CLnhaQIkW9n2/iM=;
 b=TQkUVmbjkIvC5O/oceQ7RZhHhG1VyT+bl/sVXxunxWHpJw15T3rpF4Oo4Hes3Uyl0x
 4s04MxWVQ+xBy+AwxWHEN4mmSziB/Nt2nrRjUxcpMaboXR5swnnP+erEtKSEBU8OKiFu
 w9GIEz7DcydOLDIiRTCf/QGQgGDiTRSM8o5leVxbnhIQd2aku89uWJQRgL48yNeb0gsp
 m0YNacz9zesg6ttplP8vOyvZRUCfMkkRg+gDIjAqVivj8tyQHwboKkWOr2cHVKtHdU+E
 AFIZKZGxlZlVbSsj5z0/+Q08xhqGLMYFi54igHVtHsHAdoAR3KMW/7h6gPh64Vimbnra
 0v5w==
X-Gm-Message-State: APjAAAWy8fQSv0FiSBJ1CX31oL9K5aPAXxNT5GJBzUzndFcsplaz68xf
 mC1TLU6ukSI0xts8OzjjLA1JdQ==
X-Google-Smtp-Source: APXvYqydnqrt09adbZTYNURvHY8rDRe+fEuXnYyDJ78oGvGmakUz9ZJNwxErUzh42fa7d6LS0LHDrw==
X-Received: by 2002:a1c:1f4e:: with SMTP id f75mr66838930wmf.137.1563878177334; 
 Tue, 23 Jul 2019 03:36:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 32sm35835652wrh.76.2019.07.23.03.36.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DCA981FF93;
 Tue, 23 Jul 2019 11:36:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:55 +0100
Message-Id: <20190723103612.5600-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 06/23] tests/migration-test: don't spam the logs
 when we fail
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
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
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


