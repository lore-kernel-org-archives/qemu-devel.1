Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79202CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433E02053B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBK2R4bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433E02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuIq-0004Dy-MT
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGE-00020T-1j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGC-00016D-5B
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:41 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGB-00015t-V0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id r1so8296125wrs.9
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LR4rIgmQXvfQk5CDJ7hzF1Z4lq3e4Ysz7dPKYncsVAE=;
 b=rBK2R4bVHPkJoMgyP7l4oDpByVsGvt6A1lI/f9B5s57blyyrjcu9WoA68K8u7ualsr
 UoJ6lxI2lxpKwkcRhdKEjS6mSb7+nATxUgAPEKj975mxcMgCuy/339fp52F4+qpVpkNu
 /Xkqe4uPb2OM4ZrtxQfx+NQSIZWzyjBU+5JnOFayVZRbr9Dz13qtVTRS4JAzO86Qzrh2
 U5Hknr3ja9c0WCyO69aFdst/K1IW0Uucx6Avpn6qdhM4G6ePnVOdwjHkhO4wnuVt2jW7
 R9EN4wMD33B6nunFsfMydghPmzFtgEUMdcFJWPCqim+QJB/2f1eOGiq7s3gAQVZNOVDk
 5C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LR4rIgmQXvfQk5CDJ7hzF1Z4lq3e4Ysz7dPKYncsVAE=;
 b=YaEbchTC1rZhkZTtDulYzcnqND4qM0l1Sla/LXY/coAreibgOaSSYiosuAsnDuu58m
 j5u06vWoCF48Z2MFoxG2OOF1oqDru7SoIUCxtnea7J5HArb+YjyrHkiEjmz5s3teSGH0
 oagSkXjaf6XdkMzt99vWYf2uMGPpKxP5Ee0b77KaCxWdF2KHdDoDv8ORI0cNQQUCE2et
 diNDYfwPfq4Qsyws4oab3LvKahRpi3c/q+xRphdE4Xs0zZQtnTN2NWb5P54RMdPhJw6G
 Q3hAKEVe9ePZZDtPVKR4+/CN1VKZbgMXes7vfZoKjiXb1FiYB9WQpwbdEXJAZtctTvhO
 BX7g==
X-Gm-Message-State: APjAAAW08CHGr/+wQM5+UhFMPjtwPc70MRA/4zK8QjgUxr7ziy51aZJU
 WW9ERMddbNIuBtmmUKn/ewyYX7fqSWQ=
X-Google-Smtp-Source: APXvYqw+0v27MOM1DF/Zdkv45QcpMUIy0H7Yz5gzrZY3mDEFo4fd5tGLyS1rlAmWF8GjFQaWVOc+Sg==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr3640764wrw.176.1571751097693; 
 Tue, 22 Oct 2019 06:31:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] target-arm queue
Date: Tue, 22 Oct 2019 14:30:53 +0100
Message-Id: <20191022133134.14487-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

The big thing in here is RTH's caching-of-tb-flags patchset
which should improve TCG performance.

thanks
-- PMM

The following changes since commit 2152e740a8938b3bad73bfe1a01f8b94dab02d41:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-10-22 12:03:03 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191022

for you to fetch changes up to 833043a060f7d0e95ded88e61e992466305c0345:

  hw/arm/digic4: Inline digic4_board_setup_ram() function (2019-10-22 14:21:57 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix sign-extension for SMLAL* instructions
 * aspeed: Add an AST2600 eval board
 * Various ptimer device conversions to new transaction API
 * Cache TB flags to avoid expensively recomputing them every time
 * Add a dummy Samsung SDHCI controller model to exynos4 boards
 * Minor refactorings of RAM creation for some arm boards

----------------------------------------------------------------
Cédric Le Goater (1):
      aspeed: Add an AST2600 eval board

Guenter Roeck (1):
      hw/timer/exynos4210_mct: Initialize ptimer before starting it

Peter Maydell (7):
      hw/timer/arm_mptimer.c: Undo accidental rename of arm_mptimer_init()
      hw/timer/puv3_ost.c: Switch to transaction-based ptimer API
      hw/timer/sh_timer: Switch to transaction-based ptimer API
      hw/timer/lm32_timer: Switch to transaction-based ptimer API
      hw/timer/altera_timer.c: Switch to transaction-based ptimer API
      hw/watchdog/etraxfs_timer.c: Switch to transaction-based ptimer API
      hw/m68k/mcf5208.c: Switch to transaction-based ptimer API

Philippe Mathieu-Daudé (9):
      hw/sd/sdhci: Add a comment to distinct the i.MX eSDHC functions
      hw/sd/sdhci: Add dummy Samsung SDHCI controller
      hw/arm/exynos4210: Use the Samsung s3c SDHCI controller
      hw/arm/xilinx_zynq: Use the IEC binary prefix definitions
      hw/arm/mps2: Use the IEC binary prefix definitions
      hw/arm/collie: Create the RAM in the board
      hw/arm/omap2: Create the RAM in the board
      hw/arm/omap1: Create the RAM in the board
      hw/arm/digic4: Inline digic4_board_setup_ram() function

Richard Henderson (23):
      target/arm: Fix sign-extension for SMLAL*
      target/arm: Split out rebuild_hflags_common
      target/arm: Split out rebuild_hflags_a64
      target/arm: Split out rebuild_hflags_common_32
      target/arm: Split arm_cpu_data_is_big_endian
      target/arm: Split out rebuild_hflags_m32
      target/arm: Reduce tests vs M-profile in cpu_get_tb_cpu_state
      target/arm: Split out rebuild_hflags_a32
      target/arm: Split out rebuild_hflags_aprofile
      target/arm: Hoist XSCALE_CPAR, VECLEN, VECSTRIDE in cpu_get_tb_cpu_state
      target/arm: Simplify set of PSTATE_SS in cpu_get_tb_cpu_state
      target/arm: Hoist computation of TBFLAG_A32.VFPEN
      target/arm: Add arm_rebuild_hflags
      target/arm: Split out arm_mmu_idx_el
      target/arm: Hoist store to cs_base in cpu_get_tb_cpu_state
      target/arm: Add HELPER(rebuild_hflags_{a32, a64, m32})
      target/arm: Rebuild hflags at EL changes
      target/arm: Rebuild hflags at MSR writes
      target/arm: Rebuild hflags at CPSR writes
      target/arm: Rebuild hflags at Xscale SCTLR writes
      target/arm: Rebuild hflags for M-profile
      target/arm: Rebuild hflags for M-profile NVIC
      target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 hw/arm/strongarm.h         |   4 +-
 include/hw/arm/aspeed.h    |   1 +
 include/hw/arm/omap.h      |  10 +-
 include/hw/sd/sdhci.h      |   2 +
 target/arm/cpu.h           |  84 ++++++----
 target/arm/helper.h        |   4 +
 target/arm/internals.h     |   9 ++
 hw/arm/aspeed.c            |  23 +++
 hw/arm/collie.c            |   8 +-
 hw/arm/digic_boards.c      |   9 +-
 hw/arm/exynos4210.c        |   2 +-
 hw/arm/mps2-tz.c           |   3 +-
 hw/arm/mps2.c              |   3 +-
 hw/arm/nseries.c           |  10 +-
 hw/arm/omap1.c             |  12 +-
 hw/arm/omap2.c             |  13 +-
 hw/arm/omap_sx1.c          |   8 +-
 hw/arm/palm.c              |   8 +-
 hw/arm/strongarm.c         |   7 +-
 hw/arm/xilinx_zynq.c       |   3 +-
 hw/intc/armv7m_nvic.c      |  22 +--
 hw/m68k/mcf5208.c          |   9 +-
 hw/sd/sdhci.c              |  68 +++++++-
 hw/timer/altera_timer.c    |  13 +-
 hw/timer/arm_mptimer.c     |   4 +-
 hw/timer/etraxfs_timer.c   |  23 +--
 hw/timer/exynos4210_mct.c  |   2 +-
 hw/timer/lm32_timer.c      |  13 +-
 hw/timer/puv3_ost.c        |   9 +-
 hw/timer/sh_timer.c        |  13 +-
 linux-user/syscall.c       |   1 +
 target/arm/cpu.c           |   1 +
 target/arm/helper-a64.c    |   3 +
 target/arm/helper.c        | 393 +++++++++++++++++++++++++++++----------------
 target/arm/m_helper.c      |   6 +
 target/arm/machine.c       |   1 +
 target/arm/op_helper.c     |   4 +
 target/arm/translate-a64.c |  13 +-
 target/arm/translate.c     |  37 ++++-
 39 files changed, 588 insertions(+), 270 deletions(-)

