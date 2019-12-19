Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A086BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677F724650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuTieeeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677F724650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtUm-0001HK-B3
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNR-0006pq-52
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNP-0000fg-Sc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:52 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNP-0000af-JO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:51 -0500
Received: by mail-wr1-x431.google.com with SMTP id c9so5472894wrw.8
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E6nvW6fexsDWMN+ZoXwp4ZNbLiQ7+yB+XmIDWRZJcu8=;
 b=TuTieeeY7X2UgCrzy2VBnkgGbRR3n+E/SMAGMjPPGsubYnWuu51pI/0G3YP6Y5I7nX
 S19PZQeorNFIyo8XmJPDuDsAKKgyqPDCP54TWOYVZ/By5Xdx5RWNslTRarKbDP++KxmY
 jynEZ7zkCIZdjdrDM4WCg7Nvw0o+B4ukc57N5narWgF8YlxNqA90vSRF40Eq3RLVTDF0
 BYrQ+OUCNWZiXvkr2zDptem0idI3AdLT7/KENQAHV+DceDlpoiZWTO53k22mES9uVwk/
 E7pmuk87BngzP1yZyXHfhPIdLUu9SZMo4ZetBKlTreoRMX5n2EbBXrRUO7WVh0Y/zIKd
 w2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E6nvW6fexsDWMN+ZoXwp4ZNbLiQ7+yB+XmIDWRZJcu8=;
 b=sZMCxSRfz90o9ejVqKWbLd7/7I9VUuOdaD1IJaM1p16b9VmCCQuTtjoQcnFw3P9WZI
 9jIqO0MWjoa8iLsrOOKHRf9/lzTD8v+Vk97CLM6g1HhxULE5MSxgzCPuKBeu9EfQ96uw
 iOBjTHwFarFHrVPglmQWo12GLA0BoalNmnIk2kVbYnccdr+MMemIVAHbvsDsTrHEPhxU
 8mQSslpww+Bgz4dFFbWfrx6x1bOCfqxH5Vk1jSD5L0EtU/ijpdqeIuLc1mSG8TC10dy6
 lWMFjAHdP6qNYXgyPQfYplHho0oRoDCGqCpb/xbc/fsRHoGuW4lnoyrHC6Y8plG/TVoA
 XkKw==
X-Gm-Message-State: APjAAAWmmpejmS1bTm4MUR6Q8DPYDnq07W8Q+qYKd5mqiQnbh38NrWpV
 d1VR43uF3DnOWLmN0vnwAyTRKw==
X-Google-Smtp-Source: APXvYqyEiM0dM5dBuTbDrBMtbD/5dE4m9tTQW6bukUUqF7YBXkc7mPnGL0835XfUwplNh3ujevUOmg==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr8424770wrn.386.1576752590648; 
 Thu, 19 Dec 2019 02:49:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h17sm6193828wrs.18.2019.12.19.02.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:42 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 749FF1FF9B;
 Thu, 19 Dec 2019 10:49:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/25] Fix double free issue in qemu_set_log_filename().
Date: Thu, 19 Dec 2019 10:49:20 +0000
Message-Id: <20191219104934.866-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 qemu-devel@nongnu.org, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

After freeing the logfilename, we set logfilename to NULL, in case of an
error which returns without setting logfilename.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191118211528.3221-2-robert.foley@linaro.org>

diff --git a/util/log.c b/util/log.c
index 1ca13059eef..4316fe74eee 100644
--- a/util/log.c
+++ b/util/log.c
@@ -113,6 +113,7 @@ void qemu_set_log_filename(const char *filename, Error **errp)
 {
     char *pidstr;
     g_free(logfilename);
+    logfilename = NULL;
 
     pidstr = strstr(filename, "%");
     if (pidstr) {
-- 
2.20.1


