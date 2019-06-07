Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853ECC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDE9208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNkOmvB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDE9208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBwp-0004tp-0a
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44959)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4z-00085p-Lh
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4y-0005ot-8Z
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB4x-0005kB-VX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id x4so1399585wrt.6
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PLY1Kb/j4Fld5ce4nXx3RXm9FLwwfldPCHeqmdO//6E=;
 b=YNkOmvB/xTWtFw4rkS42jDSIJrlEJbuOKbgNlADuND7RbCtN3IBk2ejtX6F/WFImwF
 gXQxFh71mFN0d4HoUt4/OTsG4AvGHZSIVTZmneqMQTwUubqeyaH/QuW8IdRE575f9sMN
 jU3IG0CKaz9U7Zr+sfbon1mz4P+lZY7F1QB7rBc7IG+RJFOXVpXzyHn9tW37yk94tE8f
 gH1NAqujc1Dp9LvuR+skU3MBbw1HZkdQs601CEciZXQY3l4cZOAANoLxcS3FPv4f33HM
 Hb6abWdPr8wsM7dEy1T3jgxxm7JdhOPHVqIDVr4tJ8EA1YP9AiEfDFmY5zaYqy/LnGvp
 nPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PLY1Kb/j4Fld5ce4nXx3RXm9FLwwfldPCHeqmdO//6E=;
 b=JUcrPMzxUw9yuODjGanG+QvHuXl3WhNLART23IP8d2v3IZQfcxxqfu+bVlxk+cLAxm
 SMPulgCm8BELZ0OAqXF7I4sKwX4eJ0Vmp3jMNlCVt1PZpfOl8f7fOyUCh4/WRhW3jCyB
 Ii0xFw5hHS4pmHdeDgMA5G5b4/FSv5ZWCAPSSTisQRvC3OEb6tjs/XrxErzEuXuo5XY0
 MLW9vEfLQiiHubJjCqJUjpcZVfAjtMZfHBl+C0HEbAnAptlRBl9bI/TdSyJLP1u9IasW
 b4N+MG7nx6lyXXftKmfoYlnyd0BNK6IXt1k+XjzrsOgYLwJoxfjsPs0/ebFyw4qmSKOl
 +OKg==
X-Gm-Message-State: APjAAAW88jVQYz6roOSWMaI2sdaOU0ZaZ+F94ZrcUog3hfth23Mww+cc
 hfvvtkuFqn5NxF06ww7Y2DEqNg==
X-Google-Smtp-Source: APXvYqzZbjNlQVTfO9aUjaP5ED/PqHC/QpV2YFt3xobbvwzsciJ4qr9OhL0iA6PIQUqcLwaSiRegDA==
X-Received: by 2002:adf:f246:: with SMTP id b6mr8433212wrp.92.1559899349200;
 Fri, 07 Jun 2019 02:22:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x83sm1379571wmb.42.2019.06.07.02.22.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 454781FFB3;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:27 +0100
Message-Id: <20190607090552.12434-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 28/52] tests/tcg: better detect truncated reads
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we've truncated a wider read we can detect the condition earlier by
looking at the number of zeros we've read. So we don't trip up on
cases where we have written zeros to the start of the buffer we also
ensure we only start each offset read from the right address.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index dc1d8a98ff..d124502d73 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -208,6 +208,7 @@ static bool read_test_data_u32(int offset)
 
     for (i = 0; i < max; i++) {
         uint8_t b1, b2, b3, b4;
+        int zeros = 0;
         word = *ptr++;
 
         b1 = word >> 24 & 0xff;
@@ -215,6 +216,16 @@ static bool read_test_data_u32(int offset)
         b3 = word >> 8 & 0xff;
         b4 = word & 0xff;
 
+        zeros += (b1 == 0 ? 1 : 0);
+        zeros += (b2 == 0 ? 1 : 0);
+        zeros += (b3 == 0 ? 1 : 0);
+        zeros += (b4 == 0 ? 1 : 0);
+        if (zeros > 1) {
+            ml_printf("Error @ %p, more zeros than expected: %d, %d, %d, %d",
+                      ptr - 1, b1, b2, b3, b4);
+            return false;
+        }
+
         if ((b1 < b2 && b1 != 0) ||
             (b2 < b3 && b2 != 0) ||
             (b3 < b4 && b3 != 0)) {
@@ -238,6 +249,7 @@ static bool read_test_data_u64(int offset)
 
     for (i = 0; i < max; i++) {
         uint8_t b1, b2, b3, b4, b5, b6, b7, b8;
+        int zeros = 0;
         word = *ptr++;
 
         b1 = ((uint64_t) (word >> 56)) & 0xff;
@@ -249,6 +261,20 @@ static bool read_test_data_u64(int offset)
         b7 = (word >> 8)  & 0xff;
         b8 = (word >> 0)  & 0xff;
 
+        zeros += (b1 == 0 ? 1 : 0);
+        zeros += (b2 == 0 ? 1 : 0);
+        zeros += (b3 == 0 ? 1 : 0);
+        zeros += (b4 == 0 ? 1 : 0);
+        zeros += (b5 == 0 ? 1 : 0);
+        zeros += (b6 == 0 ? 1 : 0);
+        zeros += (b7 == 0 ? 1 : 0);
+        zeros += (b8 == 0 ? 1 : 0);
+        if (zeros > 1) {
+            ml_printf("Error @ %p, more zeros than expected: %d, %d, %d, %d, %d, %d, %d, %d",
+                      ptr - 1, b1, b2, b3, b4, b5, b6, b7, b8);
+            return false;
+        }
+
         if ((b1 < b2 && b1 != 0) ||
             (b2 < b3 && b2 != 0) ||
             (b3 < b4 && b3 != 0) ||
@@ -272,7 +298,7 @@ read_ufn read_ufns[] = { read_test_data_u16,
                          read_test_data_u32,
                          read_test_data_u64 };
 
-bool do_unsigned_reads(void)
+bool do_unsigned_reads(int start_off)
 {
     int i;
     bool ok = true;
@@ -280,11 +306,11 @@ bool do_unsigned_reads(void)
     for (i = 0; i < ARRAY_SIZE(read_ufns) && ok; i++) {
 #if CHECK_UNALIGNED
         int off;
-        for (off = 0; off < 8 && ok; off++) {
+        for (off = start_off; off < 8 && ok; off++) {
             ok = read_ufns[i](off);
         }
 #else
-        ok = read_ufns[i](0);
+        ok = read_ufns[i](start_off);
 #endif
     }
 
@@ -298,11 +324,11 @@ static bool do_unsigned_test(init_ufn fn)
     int i;
     for (i = 0; i < 8 && ok; i++) {
         fn(i);
-        ok = do_unsigned_reads();
+        ok = do_unsigned_reads(i);
     }
 #else
     fn(0);
-    return do_unsigned_reads();
+    return do_unsigned_reads(0);
 #endif
 }
 
-- 
2.20.1


