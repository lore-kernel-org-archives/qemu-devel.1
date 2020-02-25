Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34290C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000BD218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nid8GJYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000BD218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bNk-0001fF-59
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6bMx-000178-AT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6bMt-0005Wv-8g
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:39:31 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6bMt-0005VQ-1I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:39:27 -0500
Received: by mail-wr1-x442.google.com with SMTP id l5so10774913wrx.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CxC7+57klu/2mln+X9DRHhYMcaLTR/a8a6mDU1Kkwh0=;
 b=nid8GJYAJPYBPm/sS1dx1DsWD7C33KyCs1UYpq/bGeHkJz2ohx55kYP6MoXAx/BfDD
 z22K2c68MTFWY/PHKVJAo6uKWVPNnDe4TlnYTRiH0M8F+BJkj2Tt2JwgdsLZK0UBUL4y
 9szs8FDdtVH0lkl2VeGbZBA0PcgUkX28PklCZncEnqPnf4AAOXTFCKx27Hp25TWmwxi8
 3DNJ7H5WSOaBcVfqfb3cpORSUJ0UMlvDVMmpgnW5TLruY10o9kH+Z+AWlIHFYPTo5qIc
 M3L1E7bXZXShVFoXfrzv7Qri7bMVL4+UTx7Y1qvRzd5WxYuHnt9kkiTuU1/k5v7ukUOq
 XbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CxC7+57klu/2mln+X9DRHhYMcaLTR/a8a6mDU1Kkwh0=;
 b=bYE3SYhbGncOT6U6USjLquHjxHpDKEEWTdTYLOupI3u82MYNug+zcJ/6X4yz1N2A6v
 ZqeInllLFi+4zqfQos82ReMXUgiOZNo2Taj0bKwxaVvYyEk07BKYM9g1DRQMY7G92nzN
 8YzW52EC3UuUbhGC+UpO2cRJcKFGhfD8oDKQMXif8T8GKKHMZiFQiIIAxYB7sJ1Jg8UT
 zOts7CzsPzci5EMTkpTQSziThJVpWswuNUQL9ey4PiezdMMcijG4YaaHXnpM7AUbtxmD
 5960VkH/wVNPSf4WVJdzneggHuwcsG4k64nDr725m0Nh1K6R8ufaz10BeQKP3cv+VGu7
 uM8w==
X-Gm-Message-State: APjAAAWDIzyqMaaDk8Gdis1Dy2YMv4gNWTfYQcrxmV7HFIHFYag1ISX4
 xbPdNxaqVRWZ0p6QxsaZkza5ZA==
X-Google-Smtp-Source: APXvYqwU4yLh/xJKjVASihiQSNbsM8wOJz7/8WYgkpIVwqsMHUF+1qKnjy77ISI080QbkY4waVrv5g==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr1369390wrb.60.1582641565849; 
 Tue, 25 Feb 2020 06:39:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w8sm4388820wmm.0.2020.02.25.06.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 06:39:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH RISU] aarch64.risu: Add patterns for v8.3-RCPC and v8.4-RCPC
 insns
Date: Tue, 25 Feb 2020 14:39:23 +0000
Message-Id: <20200225143923.22297-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add patterns for the new instructions in the v8.3-RCPC and
v8.4-RCPC extensions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is what I used for testing the RCPC QEMU patches I sent out
the other day. Did I get the @ section syntax here right?


 aarch64.risu | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/aarch64.risu b/aarch64.risu
index c4eda7a..8f08cd0 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -3019,3 +3019,35 @@ SM3TT2B A64_V 1100 1110 010 rm:5 10 imm:2 11 rn:5 rd:5
 XAR A64_V 1100 1110 100 rm:5 imm:6 rn:5 rd:5
 
 @
+
+# v8.3-RCPC instructions
+@v8_3_rcpc
+
+# LDAPR, LDAPRH, LDAPRB
+# As usual, the $rn != $rt constraint is risu-imposed, not architectural
+LDAPR A64 sz:2 111000 101 11111 1100 00 rn:5 rt:5 \
+!constraints { $rn != 31 && $rn != $rt } \
+!memory { align(1 << $sz); reg_plus_imm($rn, 0); }
+
+@
+
+# v8.4-RCPC instructions
+# As usual, the $rn != $rt constraint is risu-imposed, not architectural
+@v8_4_rcpc
+STLUR A64 sz:2 011001 00 0 imm:9 00 rn:5 rt:5 \
+!constraints { $rn != 31 && $rn != $rt } \
+!memory { align(1 << $sz); reg_plus_imm($rn, $imm); }
+
+LDAPUR A64 sz:2 011001 01 0 imm:9 00 rn:5 rt:5 \
+!constraints { $rn != 31 && $rn != $rt } \
+!memory { align(1 << $sz); reg_plus_imm($rn, $imm); }
+
+LDAPURS64 A64 sz:2 011001 10 0 imm:9 00 rn:5 rt:5 \
+!constraints { $rn != 31 && $rn != $rt && $sz != 3 } \
+!memory { align(1 << $sz); reg_plus_imm($rn, $imm); }
+
+LDAPURS32 A64 sz:2 011001 11 0 imm:9 00 rn:5 rt:5 \
+!constraints { $rn != 31 && $rn != $rt && $sz < 2 } \
+!memory { align(1 << $sz); reg_plus_imm($rn, $imm); }
+
+@
-- 
2.20.1


