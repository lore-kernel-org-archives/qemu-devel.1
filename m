Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71446CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B992070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjWyH5by"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B992070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtGp-0000co-Od
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDt-0002zW-AJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDs-0008Ms-9g
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDs-0008MX-3r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id g7so756191wmk.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yblh+Oppt2iwvTtsCKOox3v37OMPEfvHfRdTq2vJFiQ=;
 b=fjWyH5byVP69EJAiUClMw6cdLxt3NpFMSoix//VxL1XiNcvMGLdSfI6Pa1lO3KFs2O
 mKdSzyOGi9jzyl644guVpZTpsySPNoPeMWCr7xaPvTC1pVMAfNE5OcrC9PhTlvk1g1NK
 bcclD3FGlAkOwdRwJWF/rmq75M3KTGt5CYmOr+lYgvDoLVqLeXLlYKUAIqEoVFi4m4sm
 dQ1shoY4kBcWhMU0B5IFjLKip6aJHcxsq4NedDpo6dRrgr2vjXIw8sLcqRhEasZi+YY0
 p6ZmlqCTVgCQKa8nGGpAbUcZWys9kfObCDhL29CY+s1vFagYSM7sWBIRNCX0+Zgwdv3J
 UVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yblh+Oppt2iwvTtsCKOox3v37OMPEfvHfRdTq2vJFiQ=;
 b=YGgqBcCEs9WbW79K71p2rqmpmxO3VVNTRxc30x3ZcoJ3SN6i64Nj6t51RT5Z+DvL82
 ie6LZJ/ft2jRGegzIm0eTjiepGXajilL9MCL1bxXhjdrTsQQuSQtPnsPoRUGUOyEpCXT
 hrKMBBJU991Ber0dLII3xzZh8OM5pFZep6b2QAR0cC9ozBVfBs7pWWo3AQFGw/6X7rLf
 eacuXW+96mY/EGB4GXj8xXYMAcFfnV14un2n9H6ZV8KUn271SgGZTbtXFxK282aBUuoG
 EhVytY5iiUgSobzlhEFhbZSgcXmU7Fg/HCJTxeMpUEkb1NMT4bs0MnOPfhnOeWidJzFL
 hO/w==
X-Gm-Message-State: APjAAAVQmlS4xYEWPldlq2mVUIoQcx7AE4uxqBAt828Udz8T8joHDwgS
 x6gls6n0wuB+gw4Iz1AS7bU1e2My4oY=
X-Google-Smtp-Source: APXvYqxphQrWTsfJ6YkhV8qsTOlCVuzCaeftewKuZ5/j1lglfCRO+6LyxNT+FMaAF71WZnASmM4YAQ==
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr1884489wme.147.1571985439065; 
 Thu, 24 Oct 2019 23:37:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 36sm3277624wrj.42.2019.10.24.23.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A1F11FF91;
 Fri, 25 Oct 2019 07:37:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 04/73] travis.yml: Use newer version of libgnutls and libpng
Date: Fri, 25 Oct 2019 07:36:04 +0100
Message-Id: <20191025063713.23374-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

libgnutls-dev and libpng12-dev are not available in newer versions
of Ubuntu anymore, so installing these packages fails e.g. in the
new arm64 containers on Travis. Let's use newer versions of these
packages by default instead. (The old versions still get tested in
the "gcc-9" build).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index b446e04e8ae..e65e53f3d7e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -29,7 +29,7 @@ addons:
       - libcap-dev
       - libcap-ng-dev
       - libgcc-4.8-dev
-      - libgnutls-dev
+      - libgnutls28-dev
       - libgtk-3-dev
       - libiscsi-dev
       - liblttng-ust-dev
@@ -37,7 +37,7 @@ addons:
       - libnfs-dev
       - libnss3-dev
       - libpixman-1-dev
-      - libpng12-dev
+      - libpng-dev
       - librados-dev
       - libsdl2-dev
       - libsdl2-image-dev
-- 
2.20.1


