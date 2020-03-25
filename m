Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD441C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61C320409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRVSDPpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61C320409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7wC-0004eF-P5
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7lC-0003tB-U6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7lB-00088V-W1
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7lB-00087y-Pu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id m3so3158712wmi.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5layH9MhNA52soaJZfTnDM8L+LTws1H3akJM1O6X96g=;
 b=ZRVSDPpx+T7iLlCmRC4wKzGj/5iUc6p4Js6A3w+MQaBQmzd8SPe8hlwyEH8Vx/tiuR
 u0bzeuPC6EaO1Jm0pbQDY6yViICQcWa7s2lVUTYYmNB7EvHgsQx/2arrpgEHmU8RGnKL
 Ggh7gYwceGb+F6rjbeK8jZOuI0TPtwx/AjWdptWrDFQQPsue3oNZN2BsCjCuFNThCHjb
 LHraMlkJpvGZpsHR2C3nxS5i90P45zGA3JxJD2vFKOu4L2XJYCZjBXklx+Hcu+gKBLnh
 uQRqerwlKr4WNfyIHJaruF1Jq/Qhbs4/8Gr92cWvj30UCYQkVdyNBWLNynAuDaheNUrH
 1izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5layH9MhNA52soaJZfTnDM8L+LTws1H3akJM1O6X96g=;
 b=TXl7FmdeZQyHcRxcdeyEA4xbkocuoiJfiKMGINA4AXIBXvOT8D1nRJ1y/oYjLq3psb
 7mRdhMaDs9zkoVcrQ/0FXvcjYK9yDdlX6ewxIVm3YUOAa7pyFAy2IwXtkjwhK+1ZZSuc
 SLXHhCrim13HzGvqyFjp5xq3HjGdPTtni0vPURXy+fFtj4aOD2D7f2O1gq06ats1wjR9
 lkWoburFW9J3SAod18kGTGawoO8PZP2SQhG4aBt838/UqHS/E7k/CugBVL4HWN3AW1rm
 ZPMlSZwuZwAvjmipjcAR7mD6BsxLA7Ce5tMHVWgoEISOZb+ySObVLoDEAsr+t0j2vuwt
 HJ6w==
X-Gm-Message-State: ANhLgQ2lfnYtQQfh4DHA+1pjOmzanUJYvW/6kOYJG15xNkdIS+27PbDv
 dp6aSF/fp7FGjUrDh3tp5uMAvg==
X-Google-Smtp-Source: ADFU+vsrNekDvRdqWwoRaSr64zbhLHs1XsOIvB7ZFER4YNE59iDGs2xus8tZYmiBdpX53TDWQj3GPw==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr3925718wmf.11.1585149360628; 
 Wed, 25 Mar 2020 08:16:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s127sm8920219wmf.28.2020.03.25.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 26D481FF99;
 Wed, 25 Mar 2020 15:15:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/11] tests/docker: Add libepoxy and libudev packages to the
 Fedora image
Date: Wed, 25 Mar 2020 15:15:42 +0000
Message-Id: <20200325151543.32478-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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


