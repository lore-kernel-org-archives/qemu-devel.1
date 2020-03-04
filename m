Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85421C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D312072D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHn3qVAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D312072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Qrq-00085o-I2
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqn-0006zh-PU
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqm-0000Nf-7b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqm-0000KF-1V
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id g134so1281703wme.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R+IMXKNPp1TjKUvo3JZiEksdBVVEhlX642QAD/dF1yE=;
 b=MHn3qVAOe+AvK29K5AjGmZ94Mi9IZY19+ZNTtLOcHzXghrRs3U4Slrb+8pfsP3Mfo0
 ukyLW2fxJIo0NkfXVyfmKlkFBB+OziLw+0shHEEJ4XCUqppBrkcwDLSsjUC8ZF6M9eSW
 QX84Aokix9cwauR2uw/OGFc8LAmBpsnFRP1ZMgQnmeKks38J/wAFMAbRlOhbhGZzEbKC
 F/HDH/Q3m7cS+X+yBW5QaY1zDGUMAng8Rd3HCKHBLORAtc9uxI5vq3b05Zv0Ewaq9OJC
 xDJNFM+qwtJJghj8YiuSoDdDdIq9fmDZJTHY54BiFITMA0FagnbmzR5ZvDeRBwFpWFgK
 sm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R+IMXKNPp1TjKUvo3JZiEksdBVVEhlX642QAD/dF1yE=;
 b=BKf5uONDVGZizvOUp+eTuD6h8wdfm9aXsUeFAH81X4NfCwKJPd37ocij90Ldb2afza
 KWIk/ZvBVfXEhgRX6sGLAsh1c+8ynyLpKvTCB+JBm0rfoIaWrqfBmtNldT0MxpITPu3e
 mG4qAyFrTIq8Mq47OZn2mdxyHksVES5WGUL/nsQbZBjjFyHY0Eglh92gyytwK/RORsOZ
 FePVe7cquZhWZdmfpPEmPBkrABjdYjm6KldcZuDMjvyIc3kwhMmcP24p1BjNCV91dhtF
 +mTeV27EkGPQM7dD+nzGZbljyjt08vESWNVOHnMI5dareapi4e0TE3o+6qBksCz3hBmi
 Sflg==
X-Gm-Message-State: ANhLgQ1594jEXt1R0UxJ72pOf4GNc3UirDEIcE721eTtT7IdKaSHxwwv
 Metaoss7jO4gZCxADZTqCoypAw==
X-Google-Smtp-Source: ADFU+vt0NVqiwrxn75MdIpmiah0cAUaBRIkqmZ2s/8L8vwX5W+0pVyM2b72lKc/uZl2UXYY8hvjeqA==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr2988056wmy.104.1583316118143; 
 Wed, 04 Mar 2020 02:01:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 19sm3777340wma.3.2020.03.04.02.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:01:55 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E36101FF87;
 Wed,  4 Mar 2020 10:01:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 0/9] testing updates (tests/vm and acceptance tweaks)
Date: Wed,  4 Mar 2020 10:01:45 +0000
Message-Id: <20200304100154.14822-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit abfa865014ab17941eb1fcb7cc2fa293a25843c4:

  Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200303' into staging (2020-03-03 15:20:12 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-040320-1

for you to fetch changes up to c2e09ad8cdf4705a91eb6c20a9f3d4d90a0f46aa:

  travis.yml: install python3 numpy and opencv libraries (2020-03-04 09:57:33 +0000)

----------------------------------------------------------------
Testing updates

  - some clean-ups for tests/vm
  - enable tools build for MacOSX
  - bump avocado to a newer version
  - bump travis env for avocado

----------------------------------------------------------------
Alex Bennée (3):
      configure: detect and report genisoimage
      tests/acceptance: bump avocado requirements to 76.0
      travis.yml: install python3 numpy and opencv libraries

Laurent Vivier (1):
      travis: enable tools build on OS X

Robert Foley (5):
      tests/vm: use $(PYTHON) consistently
      tests/vm: Debug mode shows ssh output.
      tests/vm: increased max timeout for vm boot.
      tests/vm: give wait_ssh() option to wait for root
      tests/vm: Added gen_cloud_init_iso() to basevm.py

 configure                 | 13 ++++++++++
 .travis.yml               |  6 ++++-
 tests/requirements.txt    |  2 +-
 tests/vm/Makefile.include | 16 +++++++++----
 tests/vm/basevm.py        | 61 ++++++++++++++++++++++++++++++++++++++++++++---
 tests/vm/centos           | 33 +------------------------
 tests/vm/ubuntu.i386      | 37 +---------------------------
 7 files changed, 91 insertions(+), 77 deletions(-)

-- 
2.20.1


