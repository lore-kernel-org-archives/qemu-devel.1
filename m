Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5426C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0683206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLXbKMre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0683206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8DN-0006bN-OM
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89q-0001JO-OY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89p-0008Ut-Sb
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:50 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix89p-0008TM-Ko
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id z7so3558271wrl.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LP91f4MtUHw75/kCQwX5FCufKaJO1CfZqed34Em/4IU=;
 b=uLXbKMreasIcs0YX/Hj3z9VjaO3mESwVRmi6uT8SpvGNF4LPNONySRrwQ2bvZsEj/Q
 NBhMk9zu3AylwJ+XmDSu5l/r9zL8ok3wIQEnNm7CSIFh8Nn3zvNPBuY9AGidd43S3PoM
 H3TH+qSONmPj0gJNMlfQEs0qzQb+xr56QZBbavEaE5iE0K/iNwZ6LJ3S8Uyn7KN4I2Em
 R2J3i+mjrqtPbx2/tSSksrPcvLcsnSMyLIkj9yIBlJSh7FNFWoYErK4HGcA86FDFxnPN
 Rxc6CdQGlJT8V9Nkhgoxi+b8SxedObH9RgORQcoLEDgcBcP6TAnjd93pl2jglwD5Uo7y
 hNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LP91f4MtUHw75/kCQwX5FCufKaJO1CfZqed34Em/4IU=;
 b=QgGOve621dnQOgktnSO2/1HWLsDHSCPSnJl2LXKmnvsSHsI4PRQftUDAxNY00X3mvY
 8eeXqdJb82tHncrIyP7gAkJpMzrfCE4s5zwU+JaQj0M/PaYF6zC3pDHPcGiUE6XNIAQL
 lpmFbijNoqNdlA+UUiTfAi6WSnWsAKv7mJhfnoDDuESWkasAXGpFbEbDN1WKDSjR2bDa
 sOGRHFFU4qUK5mwlJCSC1KcTnlNSuMBOn0ksR+VuNfix7WLQRtVs1vYcNYOK7njET9J3
 vYmuZMYNe9vyhbF9Uet12VPX16LJmF2XErOdu7K/DvbyI9iG/seUqTDBSGYwDBQvZReD
 Ks+Q==
X-Gm-Message-State: APjAAAWkX9wiI8vxZuCwzoFe+i43VNqCSz8IFLbSn45RXqCXnA6GAygG
 my4oKYpuCavOpC+McWnFmKawPQ==
X-Google-Smtp-Source: APXvYqwAErwqm8oZMbySX82QTatem8iCun2cYoOgqLkjZMSDSQGRyHhwpe7R6qok5lKZm4Kv04jw9w==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr5037524wrs.222.1580384327952; 
 Thu, 30 Jan 2020 03:38:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c9sm6026058wmc.47.2020.01.30.03.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:43 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 004FF1FF99;
 Thu, 30 Jan 2020 11:32:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 09/12] .travis.yml: build documents under bionic
Date: Thu, 30 Jan 2020 11:32:20 +0000
Message-Id: <20200130113223.31046-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130113223.31046-1-alex.bennee@linaro.org>
References: <20200130113223.31046-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It looks like the xenial tooling doesn't like something in our setup.
We should probably be moving to bionic for everything soon
anyway (libssh aside).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 056db1adac..f245765cfe 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -165,7 +165,8 @@ matrix:
 
 
     # Check we can build docs and tools (out of tree)
-    - name: "[x86] tools and docs"
+    - name: "tools and docs (bionic)"
+      dist: bionic
       env:
         - BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
         - BASE_CONFIG="--enable-tools --enable-docs"
-- 
2.20.1


