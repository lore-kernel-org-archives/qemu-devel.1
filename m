Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D081FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08662083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yMIBHLg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08662083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtZf-0002Ba-P6
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtUE-00026S-2E
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtUD-00012F-4V
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtUC-0000xg-U5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:41 -0400
Received: by mail-wr1-x433.google.com with SMTP id s1so12550891wrv.5
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5layH9MhNA52soaJZfTnDM8L+LTws1H3akJM1O6X96g=;
 b=yMIBHLg2xpgD1kZnJHr1cRZ01hZ8KfBxFZ6a3G9s3ua2HUFDBQFbiU0ibSpf4V18KS
 pqoUA/68RDU65Uw8VAhqSBd4PXR8rsj/VW9yWBafUOULLmnfp1e0plJRkLtlzYSargX+
 4kG4IVReJdYKrKyIE+z8ioGVgSccUVBG8BHfu4cmfc1aza5zGrdTy0tp0tTSri2iD9vj
 Ro+JcBNivW6f9mNE7ohPxD+sEFUs4Frde2NFZ4qrpY06OfTpjjCQVaRZe8STi27wvy7k
 ACVoa61Og2+UPxYmD9gyYirywyCirvqoV4KdZPDVxTolRbhWz+oUztfxZCPI7HcBOeh4
 GNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5layH9MhNA52soaJZfTnDM8L+LTws1H3akJM1O6X96g=;
 b=L5ZRld+Dm7cEYq/Y4vnHGUuHjnliUbbSaURJqxt2mbg0CEMQxetuEZ0TFiASwABWpb
 NGNHjlSWZzuxdMz+sPSNEsWdRXqmnSGYSDfAvr0acWQsEdWfQUGK/+axPb7fynkEmOA/
 sTyQsFl74bST2YR/5RscDK60VBYcG2K2ZuXuCTr05LhiJFLXNLzhv81ZGZr5zgmQ+19q
 b9ubg3o1Nlg0v1J8p+lj5z/Q6XpDRbJ2Mve4pavWWU9OqDJGqugAE/xbskBEv+LScsDk
 wtvKCRg6ssJBGnHARwcmE3nYLrLMNAjYjseWeZJ5KVBvvTPITDnRZOXZ1AN4ZoenoWD2
 smSw==
X-Gm-Message-State: ANhLgQ0rZb8+jIyzQR0rHy5+WjHRSeHeY46qL9D9T5U6jAsej3DNvjr3
 gmeGKCicO2FNESLMI8+ckLi87A==
X-Google-Smtp-Source: ADFU+vtwBriMdQJYtGQDax40+54RKNDOlcjaNYU80vuUjND7mkhKSGIZz2XQ1yo8rmIEc1mdKR31Cw==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr693398wrt.126.1585332817951; 
 Fri, 27 Mar 2020 11:13:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g127sm9202508wmf.10.2020.03.27.11.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 44D021FF9A;
 Fri, 27 Mar 2020 18:13:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 11/12] tests/docker: Add libepoxy and libudev packages to
 the Fedora image
Date: Fri, 27 Mar 2020 18:13:19 +0000
Message-Id: <20200327181320.23329-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Install optional dependencies of QEMU to get better coverage.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200322120104.21267-5-philmd@redhat.com>
Message-Id: <20200323161514.23952-11-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 174979c7af4..4bd2c953af8 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -29,6 +29,7 @@ ENV PACKAGES \
     libblockdev-mpath-devel \
     libcap-ng-devel \
     libcurl-devel \
+    libepoxy-devel \
     libfdt-devel \
     libiscsi-devel \
     libjpeg-devel \
@@ -38,6 +39,7 @@ ENV PACKAGES \
     libseccomp-devel \
     libssh-devel \
     libubsan \
+    libudev-devel \
     libusbx-devel \
     libxml2-devel \
     libzstd-devel \
-- 
2.20.1


