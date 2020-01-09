Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78792C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1292067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2wX8TzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1292067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYfz-0002XE-W7
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeQ-000113-JX
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeP-0005bf-6U
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeO-0005Wp-RM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:04 -0500
Received: by mail-wr1-x42a.google.com with SMTP id g17so7587611wro.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RreiDFWAgBaYdbu2re73P++/htxJ+ip65wj1qxfYgSU=;
 b=v2wX8TzLPERxshZqNtLXatNE7rx7GJGWdClz7PXfCki/5ciQO4UEHmMbGFpa4I2EPt
 zFxDRDuL+blazpBFDeAxqx/cwFBf+teWzY3syQSl6zktU1kIQhKxWMv2IJ5/VPM8yqtH
 nLcf1yuMF3sKwtqAL2h7iQSOmroxcNOpX8QwpgpfyHkIbboC5qr8U/ZH47PhYubw0Ved
 LQPfOAVC+aUGCmqlVrcP0cfBvLyYBkFPSU0Zx1ghT8QSTOYF61sXhUJeZs5eFMJXJb1r
 yeUuxI6fwh+FIeQiYHPW38vN/PRfEhbN0cQEA+5BoWkSiUUkFR0XpaiWi6eGFK7n5t7M
 9VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RreiDFWAgBaYdbu2re73P++/htxJ+ip65wj1qxfYgSU=;
 b=qVvxZLg+Wyl/NBCzr2Dtlw0BF44bg74EZ+H2v4JuQExQOgHLyQ29L5XExFjJHl3lxV
 jRoYbt+pPP3w4ZMlmCx9HYhfTKXXn8gdP1xz4uJTwzywDfpKf+OhGPsKkLhZQkeo4UG5
 ynlVdxLAWB5ITekxk7SBVdGTP+SAQtrwNrM3AW5wMghbvrmMelTAc4AVW0TsVBYCMDhk
 O9tZ/HfzrxNkEp8pLSleKfSRiKPzDeBE5b2OgLYWvf+mI8pv/4Oiet5f58ScopBQDWjP
 Z9sAX9nJQg9NMy5piVKrbgXd6nU0/T60NH7o6GiPEkCGyjXFE8rprYOAq1Jei3ahSfmT
 4URA==
X-Gm-Message-State: APjAAAWR+e2K6bBUGyPrUoe/G2EkhcM5eBUe6KxFalOVD721OJEhYCcv
 89bbiaLsHEL2RDwX4QKZZ/+81w==
X-Google-Smtp-Source: APXvYqx3zLPyqh92pD57Fq8JjThO6RtK1435dxvY8CZ3NeMnAXSwosHHMQvLxeTHmn7zk6sp2p5OGw==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr11847455wrn.320.1578579543682; 
 Thu, 09 Jan 2020 06:19:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 18sm2928287wmf.1.2020.01.09.06.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:18:59 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EC2921FF87;
 Thu,  9 Jan 2020 14:18:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 00/14] testing fixes and semihosting console support
Date: Thu,  9 Jan 2020 14:18:44 +0000
Message-Id: <20200109141858.14376-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f:

  Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-request' into staging (2020-01-07 17:08:21 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-semihosting-090120-2

for you to fetch changes up to 486e58b188c1b093a8f64d4b5cd11ff5c3514cb2:

  tests/tcg: add user version of dumb-as-bricks semiconsole test (2020-01-09 11:41:29 +0000)

----------------------------------------------------------------
Testing fixes and semiconsole support:

  - build fix (missing x86-iommu stubs)
  - python fixes for freebsd and OSX
  - nicer reporting of acceptance failures
  - fix build nesting of fp-test (breaks bsds)
  - semihosting clean-ups
  - support for blocking semihosting console

----------------------------------------------------------------
Alex Bennée (8):
      travis.yml: duplicate before_script for MacOSX
      travis.yml: install homebrew python for OS X
      testing: don't nest build for fp-test
      target/arm: remove unused EXCP_SEMIHOST leg
      target/arm: only update pc after semihosting completes
      tests/tcg: add a dumb-as-bricks semihosting console test
      tests/tcg: extract __semi_call into a header and expand
      tests/tcg: add user version of dumb-as-bricks semiconsole test

Gerd Hoffmann (2):
      tests/vm: update openbsd to release 6.6
      freebsd: use python37

Keith Packard (1):
      semihosting: add qemu_semihosting_console_inc for SYS_READC

Philippe Mathieu-Daudé (1):
      hw/i386/x86-iommu: Add missing stubs

Wainer dos Santos Moschetta (2):
      travis.yml: avocado: Print logs of non-pass tests only
      travis.yml: Detach build and test steps

 include/hw/semihosting/console.h          | 16 +++++++
 include/hw/semihosting/semihost.h         |  4 ++
 tests/tcg/arm/semicall.h                  | 35 ++++++++++++++
 hw/i386/x86-iommu-stub.c                  |  9 ++++
 hw/semihosting/console.c                  | 79 +++++++++++++++++++++++++++++++
 linux-user/aarch64/cpu_loop.c             |  1 +
 linux-user/arm/cpu_loop.c                 |  1 +
 linux-user/arm/semihost.c                 | 27 +++++++++++
 stubs/semihost.c                          |  4 ++
 target/arm/arm-semi.c                     |  3 +-
 target/arm/helper.c                       |  8 +---
 target/arm/m_helper.c                     |  1 +
 target/arm/translate-a64.c                |  2 +-
 target/arm/translate.c                    |  6 +--
 tests/tcg/aarch64/system/semiconsole.c    | 38 +++++++++++++++
 tests/tcg/arm/semiconsole.c               | 27 +++++++++++
 tests/tcg/arm/semihosting.c               | 21 +-------
 vl.c                                      |  3 ++
 .travis.yml                               | 30 +++++++-----
 tests/Makefile.include                    |  2 +-
 tests/fp/Makefile                         | 14 +++---
 tests/tcg/aarch64/Makefile.softmmu-target | 11 ++++-
 tests/tcg/aarch64/Makefile.target         |  7 +++
 tests/tcg/arm/Makefile.target             | 28 +++++++++++
 tests/vm/freebsd                          |  3 +-
 tests/vm/openbsd                          |  4 +-
 26 files changed, 328 insertions(+), 56 deletions(-)
 create mode 100644 tests/tcg/arm/semicall.h
 create mode 100644 tests/tcg/aarch64/system/semiconsole.c
 create mode 100644 tests/tcg/arm/semiconsole.c

-- 
2.20.1


