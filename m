Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA1820863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odBLknpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA1820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bw2-0006N6-EG
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkl-0003Mw-G9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkk-0006Kx-FX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkk-0006K1-4l
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id l11so18361835wrx.5
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oNXTVMOLmuMeTRVHdN8w2fyWiwCfikFPr8AkyJlesM8=;
 b=odBLknpLVDgkCmPwBjy5pfqjSiavZhY53iEeA1hN+uEQRhXBfhZ4hWuCh9nXpi07wT
 NuEPB3x/7Uf/S3eK3BStjm/tBtUevAZ/8kB7jPu5H8ngBmfHa8KUoCcYBnsVwGwQpY7+
 BN7n11O9oNaMBEsTOY0YN2bBWWk2N5XYGEBJScQ6rGuQfBEUKs0abdK4irusAFVKelWh
 WHRpxiTYywn6vTZugy3aUvXKpyYaV40PSFkw0nkI8Kl+OFfyjuMkq9y6YyWZlTwQylYt
 xQXN7XbTEGbjjygzYMLNMQmDwDi6gOIw3Odf6YoA7+ExXtBo2R3FlMLsm6AZ4Oj9wTRF
 gPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oNXTVMOLmuMeTRVHdN8w2fyWiwCfikFPr8AkyJlesM8=;
 b=nAcM/KC9sjJsxGzLTvTtP61w3wcvgmjscQys9wpZHH2ZcdQL9duCIArOGPmT19wZPj
 YMapQZOa9CgUXYIwXgZ59DKZHX00Ay4n2EMyX2PUz5/8jVLXgaNi2Dj7nmJFzH4usJYS
 r8ILudfFNuN+Z3sfQBIbGLF2jv0rgoMcdE4rD3F6cITi42qvYa0Kjk+nMeDxyCs3Mo2f
 ycNO8m97w1cIviLdMcer6lc80zFWhFTh+jRQKNrb+LE6NkDY8QlA5AYbnN9nIg56KE3b
 H+a4ip3VzSHuk3oeCy8Sorf8+FyZ9wzs3ipIxJ1meQRZDn+NvejQqy3urWee2cW0uYBF
 Ps2A==
X-Gm-Message-State: APjAAAWkHtJypvignFpZCuCNiP/et7OMxNpO5Bx1QHHGMd8VavaPAM2J
 i7UWdmWZ0e2MDMFb1DrjimoY9A==
X-Google-Smtp-Source: APXvYqxfSMe/rT5rcYNBJaG5Z1Pt+ik7nIcPfC2rb75Tva9qhI09m4KLT+JXR1PGsZJkRR4PtNq/mA==
X-Received: by 2002:a5d:698d:: with SMTP id g13mr14154902wru.338.1568105036954; 
 Tue, 10 Sep 2019 01:43:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm2042769wmb.28.2019.09.10.01.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 754CA1FF9A;
 Tue, 10 Sep 2019 09:43:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:14 +0100
Message-Id: <20190910084349.28817-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 10/45] tests/tcg: add .gitignore for in source
 builds
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

This hides the new build artefacts from the re-organised TCG tests when
you are doing an in-source build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/.gitignore b/tests/tcg/.gitignore
new file mode 100644
index 00000000000..84d7541b286
--- /dev/null
+++ b/tests/tcg/.gitignore
@@ -0,0 +1,5 @@
+# These are build artefacts which only appear when you are doing
+# builds directly in the source tree.
+config-*.mak
+*-softmmu/
+*-linux-user/
-- 
2.20.1


