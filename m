Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF9C606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285C1204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNXprbSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285C1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkTd2-0007Hn-VE
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52245)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkTbO-00060u-1f
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkTbM-0003wc-VP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkTbM-0003w1-NH
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id g67so10232034wme.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MLOZGrFnYC2EQGNmEQhBH73Q9zu0yBRbLKf9tNDYTAU=;
 b=FNXprbSqn9B5bkmQnzvucHU8kqTd6tweejjsjKqfQ1K3LA+SL+l1WDbFEyrpBZcWEs
 vx2J7K5bIUsD0UYHQ1gNYRAPAIwTRisfFKY7JT8pdZmGp02aqgJTYIAzKhWf1w8Jybgg
 mvMQoRAwSp1jdPUYmYU/HaiS2bRX6fuBT1dqfPfXkqWRSbdEJ6QTNdpB3Mzcw+dCbJAE
 tJwGVNoCJl3prY37HptByNCZGTEGRfDPWDDYg6sfqYwh00PTUaaL7fWuW1j+q0D7WOvL
 RFGWKwYA7CyHlKeMk8RZHK7fCbzC+E9ZyTREgh4aE9arSafPiwxj6g9Yv9Q427z9qD7t
 IYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MLOZGrFnYC2EQGNmEQhBH73Q9zu0yBRbLKf9tNDYTAU=;
 b=Ge8M5oOVw/+XfruMYQPZmn5M5MqN6Fb10q2fQror20u/cTK9ymkLjZulZSjPB5fdm+
 PnBnnHdLJegBk1p6ePNkyCmP6tLGiy4iFNWKoeKUaeOgjPD3xg516cQjnv2y4fUNFi3S
 4o25rgN03845chLedJ61NhGjajpOV4QJ/SKfOVfqM/u3naEBwtREcSIZqXqcWd0ywgfN
 OBw8N8JJh69I6myzje0cs+ZQxTu1jM7NeAT0RrJ0szV80ZB0gOBy9ilJCBeZ8rbPLyUC
 5reH6gBbCnLoZL4H1BoAwD26Inn1qMbzJwSSmG9BiO4C5Y6f/jI3eEDsbVBP7ONQWrGI
 TosA==
X-Gm-Message-State: APjAAAWplX/rBex/YQzTQ5x5Soe+O+Te3EqDln1iR5FmSw1DBWesYXaB
 LA0g+zqZSdZyx0Bv/cQMXAsz0eHqQSexgQ==
X-Google-Smtp-Source: APXvYqwyeKFLLWjPDHvSA1NRAo4tYR9CJzA1utOnypM03ioVceWRZllzKlKuz+2LEDVeZImIgEzaZA==
X-Received: by 2002:a1c:4803:: with SMTP id v3mr17230387wma.49.1562592159237; 
 Mon, 08 Jul 2019 06:22:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v15sm13773744wrt.25.2019.07.08.06.22.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 06:22:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 14:22:33 +0100
Message-Id: <20190708132237.7911-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 0/4] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A last handful of patches before the rc0. These are all bugfixes
so they could equally well go into rc1, but since my pullreq
queue is otherwise empty I might as well push them out. The
FPSCR bugfix is definitely one I'd like in rc0; the rest are
not really user-visible I think.

thanks
-- PMM

The following changes since commit c4107e8208d0222f9b328691b519aaee4101db87:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-07-08 10:26:18 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190708

for you to fetch changes up to 85795187f416326f87177cabc39fae1911f04c50:

  target/arm/vfp_helper: Call set_fpscr_to_host before updating to FPSCR (2019-07-08 14:11:31 +0100)

----------------------------------------------------------------
target-arm queue:
 * tests/migration-test: Fix read off end of aarch64_kernel array
 * Fix sve_zcr_len_for_el off-by-one error
 * hw/arm/sbsa-ref: Silence Coverity nit
 * vfp_helper: Call set_fpscr_to_host before updating to FPSCR

----------------------------------------------------------------
Peter Maydell (2):
      tests/migration-test: Fix read off end of aarch64_kernel array
      hw/arm/sbsa-ref: Remove unnecessary check for secure_sysmem == NULL

Philippe Mathieu-Daudé (1):
      target/arm/vfp_helper: Call set_fpscr_to_host before updating to FPSCR

Richard Henderson (1):
      target/arm: Fix sve_zcr_len_for_el

 hw/arm/sbsa-ref.c       |  8 ++------
 target/arm/helper.c     |  4 ++--
 target/arm/vfp_helper.c |  4 ++--
 tests/migration-test.c  | 22 +++++++---------------
 4 files changed, 13 insertions(+), 25 deletions(-)

