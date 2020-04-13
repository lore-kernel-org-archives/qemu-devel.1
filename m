Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA30C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB6B206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBchVB2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB6B206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO1y6-00086I-2F
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 12:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jO1xR-0007h0-C7
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jO1xP-0002fj-5J
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:29:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jO1xO-0002fE-V5
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:29:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id s8so10748631wrt.7
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Id+cHu3gu2qAiuSLCFFi8CPTKHAmNC6c9dlENjQZqvY=;
 b=VBchVB2ba0IXSMZ/L08qIDjyHDq3PDAAqR48HnDYyOrucosuBktpgpE2jbBqHX2Wb/
 eDwIQIqe9BbDggEVC+Toeldng3YbM5ymWuT2kaWMO+tYFZAd3Obrqjc7XboGJeDDXG37
 Eo/M3JqIHoGYnKddFXE/5yrlg6HMcJyXBujP2pUNHF3PYrZajYHKnbyVGL6WIasB26wc
 vsWyZ9zX/kd6elHiTCurCwgE7uPIequoWDaJ5iidi0ol6toHLxi4MyikgKKSBld1hCVp
 ypfsNP5udAGJSFHHY5J7/5bOM4+pxSxUBj3fESHZNuSMftt6/y1qxGNK34Rmz+1AitDn
 MPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Id+cHu3gu2qAiuSLCFFi8CPTKHAmNC6c9dlENjQZqvY=;
 b=dnt97D971DnS5wfVAxOP0xC5wj87TPPoJjC1oecCM4CakKK+hPBzXCegmgx5lNYVq4
 PFsFCSIuckTG297CeOMI1kI1MDhi0MILs8T2cPa/d+1iP170BPd75PtcomHTJUA7NBhi
 6pCKbRomHa2UAKvzWqq/cZZ/XxITgEO8TawEiVwWD0VfnL7RIEknko9hN+xcf5z/iHEo
 y162SYPDQSEf2ef1yrCvvj0yNa3y1LGBejrdx8uKpgI+bJoS1Wzmw4r3wp5IUPlP1wjL
 DI9S8auU49cIz4rfKG9704e+89rOgzNWCo16wqxYrHVrbcmKGb1h8vgkSHPMXx4ZXdNx
 5CLg==
X-Gm-Message-State: AGi0PuZWWMoaVE5CjsbPfA98Pwt9n5JRCCnzUp1uRH5Nl3d950NpRlup
 Aq2HzKq1r7p2qk35AtgO2vgOJg==
X-Google-Smtp-Source: APiQypIQJXRjgRS7yFqToH20kZSnCmrFs/9BFriNZwsCaNBMCFJRVZ74S3+a/80qdy2BU4hyGqV2Xg==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr20135390wru.92.1586795349682; 
 Mon, 13 Apr 2020 09:29:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i97sm16678298wri.1.2020.04.13.09.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 09:29:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B83D91FF7E;
 Mon, 13 Apr 2020 17:29:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .gitignore: include common build sub-directories
Date: Mon, 13 Apr 2020 17:29:02 +0100
Message-Id: <20200413162902.7985-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As out-of-tree builds become more common (or rather building in a
subdir) we can add a lot of load to "git ls-files" as it hunts down
sub-directories that are irrelevant to the source tree. This is
especially annoying if you have a prompt that attempts to summarise
the current git status on command completion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 0c5af83aa74..7757dc08a08 100644
--- a/.gitignore
+++ b/.gitignore
@@ -141,6 +141,8 @@ cscope.*
 tags
 TAGS
 docker-src.*
+build
+builds
 *~
 *.ast_raw
 *.depend_raw
-- 
2.20.1


