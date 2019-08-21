Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C4C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E8322D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdBKrHhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E8322D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UM1-0000TA-2P
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UKm-0007Fi-H5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UKl-0008S7-6c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:44 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:44856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i0UKl-0008Rf-2V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:43 -0400
Received: by mail-qt1-x831.google.com with SMTP id 44so3939628qtg.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+vvZYuuVlHTxGDY7y2++QOH4uC33vkRVmcTZx2ZakD0=;
 b=pdBKrHhzlmzKpy1bEYYY9DkUbnj87KV8hZUPBc0MfILDvlW/7d1egyaND3GA8BtBqz
 wjNLbHkIKWFj8FbVLWkDt5aSLcnY/OVwP8pe9FlK2N+aKfcwQpYmep2wWJV2ivKsnYY1
 k3B8OVQrtMQlbto1gLOxx9WUjgStHWCc0+f+UegxEd0ag749JAnjZ3RM0X26N7VqheEl
 UIJUK/VQEBwUXgTTcy7hUE1YjGStBxoDbBy3Hcj0KSlnbybGgaoNyQIAqqNotSAm6Jmh
 rDYXNB96YVJaRhaD9NC6lVGP6MYbNEUJaLFq82lMllg5uQdHhbRnpzItuW1DYcICY4nk
 XPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+vvZYuuVlHTxGDY7y2++QOH4uC33vkRVmcTZx2ZakD0=;
 b=sOPcAKY18l6n2dQ7cJLqzglUqkxGuVCHoJG6MoMDLkT3+/o3bIXNgXeKFYoNPu6+nZ
 4vkbm00NLUK439NvUQu+hTWwADPKV8+8+FIL5TtQ/bokcZHgfk2qO66zzHag5Fw88wRJ
 TwJSF6Rmr01OJlRSyR6riwj4SJOAKSaF2C6bzpV16WoJXEBjLgzXyNwYYzLBqbcop0NF
 7Lz1Yh9nO6NCzcYs/cKNyTh09Dgnu5Ny9lPtsOAKPvEJ8u3LjxP3y1qCjDAQp+5wrG+n
 qL/fERtgsaPdr+iBwiVKF/gnEfH5wxMgRu7bu0RHWTdKI97nZzpmlu00jsAhi94UnGZ/
 ARFA==
X-Gm-Message-State: APjAAAWMw2CKrG5iEEetQZWVjD4hIUkkaeRJn+E0oiLXbuRVLJZtUtMT
 CUAhdF4fEop6mr7CqHyj9wnxr3NH1NXxXw==
X-Google-Smtp-Source: APXvYqxwTj4iUhvvmUTtuIKilp7TMwdxsiNAFMjelheF4Dk8MfDbQ88tVloBUZqia8FaWPi2sFiwuA==
X-Received: by 2002:a0c:b251:: with SMTP id k17mr14818989qve.132.1566408221934; 
 Wed, 21 Aug 2019 10:23:41 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id a3sm9623998qtp.10.2019.08.21.10.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:23:41 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 14:23:19 -0300
Message-Id: <20190821172329.2062-1-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::831
Subject: [Qemu-devel] [PATCH v6 00/10] Measure Tiny Code Generation Quality
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is part of Google Summer of Code (GSoC) 2019.
More about the project can be found in:
https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality

The goal of this patch is to add infrastructure to collect
execution and JIT statistics during the emulation with accel/TCG.
The statistics are stored in TBStatistic structures (TBStats)
with each TB having its respective TBStats.

We added -d tb_stats and HMP tb_stats commands to allow the control
of this statistics collection. And info tb, tbs, and coverset commands
were also added to allow dumping and exploring all this information
while emulating.

Collecting these statistics and information is useful to understand
qemu performance and to help to add the support for traces to QEMU.

v6:
 - applying comments from V5.
 - change info tbs to info tb-list
 - fix crash when dumping tb's targets
 - fix "liveness/code time" calculation
v5:
 - full replacement of CONFIG_PROFILER
 - several fixes
 - adds "info cfg"
 - adds TB's targets to dump

vandersonmr (10):
  accel: introducing TBStatistics structure
  accel: collecting TB execution count
  accel: collecting JIT statistics
  accel: replacing part of CONFIG_PROFILER with TBStats
  accel: adding TB_JIT_TIME and full replacing CONFIG_PROFILER
  log: adding -d tb_stats to control tbstats
  monitor: adding tb_stats hmp command
  Adding info [tb-list|tb|coverset] commands to HMP.
  monitor: adding new info cfg command
  linux-user: dumping hot TBs at the end of the execution

 accel/tcg/Makefile.objs      |   2 +-
 accel/tcg/cpu-exec.c         |   4 +
 accel/tcg/perf/Makefile.objs |   1 +
 accel/tcg/tb-stats.c         | 877 +++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.c      |   7 +
 accel/tcg/tcg-runtime.h      |   2 +
 accel/tcg/translate-all.c    | 132 ++++--
 accel/tcg/translator.c       |   6 +
 configure                    |   3 -
 cpus.c                       |  14 +-
 disas.c                      |  31 +-
 hmp-commands-info.hx         |  31 ++
 hmp-commands.hx              |  17 +
 include/exec/exec-all.h      |  15 +-
 include/exec/gen-icount.h    |  10 +
 include/exec/tb-context.h    |  12 +
 include/exec/tb-hash.h       |   7 +
 include/exec/tb-stats.h      | 144 ++++++
 include/qemu-common.h        |  16 +
 include/qemu/log-for-trace.h |   4 +
 include/qemu/log.h           |   3 +
 include/qemu/timer.h         |   5 +-
 linux-user/exit.c            |   4 +
 monitor/misc.c               | 171 ++++++-
 tcg/tcg.c                    | 231 +++------
 tcg/tcg.h                    |  22 +-
 util/log.c                   |  90 +++-
 vl.c                         |   8 +-
 28 files changed, 1585 insertions(+), 284 deletions(-)
 create mode 100644 accel/tcg/perf/Makefile.objs
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 include/exec/tb-stats.h

-- 
2.22.0


