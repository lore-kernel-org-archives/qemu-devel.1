Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55787C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EFE23426
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8OEqs8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EFE23426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3i5k-00025I-1q
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 10:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3i1Z-000875-V8
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3i1Q-0001mB-Hk
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:37:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3i1Q-0001NH-9h
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:37:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id t16so7218146wra.6
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4FFsu5lg9DlLT1MAJf7wiqxdDxZVz0pUUfU/GuHFdio=;
 b=y8OEqs8m2dejAAl/UbrN+iChmGU6P2XV31xHvDBizsv/oYREbcP2/YRN7Ti/xnHvKs
 t/nTo5jkpXrIV8PO/UsEhJxlU5Ww3i4pTBbYICZ/Bb5f7FhVkTHE7OGZbggwheXlauPy
 NujzMnt9kejpsZp0QLGjqbJrwyq5q7Jy7ij8aWsHmxfSKGkAarD1yAcytm26nQt+5Sk0
 PbGIm0rIsBfkEI1jjnRZQiOWr6If8xItNY18zKREgjiKFp9/BnXSyKJ2C48HWd3/qeox
 0EgtLghQL8TjmfifC+b/IIzTs8+BAbyGRmPHc7V5dN9nHmhj/7z2jILpY5G9EJGNyYDR
 YFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4FFsu5lg9DlLT1MAJf7wiqxdDxZVz0pUUfU/GuHFdio=;
 b=BfxyzKDs303P2Zm0mNo7xSPK5/Gd55EheKYADq9jgeYCRg8i5SAm1oZvg9jrxF4/fC
 ADXln/4/aN0kdJzizBYRTAiCR1mT8v7VLuxYy/uT2KYB1eRVufSfW7RoZqx0zNa+eKaN
 KaCY7RexH3QVM0ZEKXpqn3yEuuC/QO71Bch2gKZFRMdJOyLvEAOag6vtcS4Hj0tLb1cp
 OowiL+YzaoojLpjR8KH7ORaqN/jZgJGi7zgnKGuQYqHh2F+2ZvuZW+EevSbXshDH+Dqt
 LitCFNJ6zsvjIxOXoKMAjOsaYYMcWFi3214H2RfpkW3m9m7Y0rGTLMxXD3lwTnZlZ/rD
 OLVQ==
X-Gm-Message-State: APjAAAVLFsc9M74S3dlNgDZF65hF1vYt6/hi60j9FG1l0OwNhwBIxoJr
 HUFA1VIX/NeYt8RHRjVlAZIxNg==
X-Google-Smtp-Source: APXvYqxyd7hES9JQDc3FZ0GW1gSQv0Unn63jRldH8Nia5rHpmL82YdagnuB46Nsyl5dbejg2TmvGSg==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr18160479wrs.200.1567175817317; 
 Fri, 30 Aug 2019 07:36:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u128sm3436281wmg.34.2019.08.30.07.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 07:36:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E18DA1FF87;
 Fri, 30 Aug 2019 15:36:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 15:36:48 +0100
Message-Id: <20190830143648.2967-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] linux-user: fail and report on bad dfilter
 specs
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just passing NULL means we end up ignoring the bad dfilter spec
instead of reporting it and exiting as we should.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 47917bbb20f..50a031520ca 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -236,7 +236,7 @@ static void handle_arg_log(const char *arg)
 
 static void handle_arg_dfilter(const char *arg)
 {
-    qemu_set_dfilter_ranges(arg, NULL);
+    qemu_set_dfilter_ranges(arg, &error_fatal);
 }
 
 static void handle_arg_log_filename(const char *arg)
-- 
2.20.1


