Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648EDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2C020748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rb9xo580"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2C020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrxt-0004Dv-EU
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31NTGXgsKCpU6H97CC3BD3C5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlT-0005Te-RD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:21:59 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:35664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31NTGXgsKCpU6H97CC3BD3C5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlT-0001iy-1R
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:21:59 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id 207so6558841ybl.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=tGxrjpstm4I7PAN/kuQkbl2KdvRqWXweBxIWEzXPUS0=;
 b=Rb9xo580Cp4PkbnfGEYMeoLvbnxzM/jWkefINiY4AQhk+CTvp0DwP79x9bjZuKkztD
 iL2s1AokqH+yB7byGWfGE/FHIFItjUFyTtCQ4AX9+BGBL33flQNdxUoTKR2TyXEMA3CJ
 6ZXXT+U5gey0Xg0Chw2NiQPfzBSDFGc6vLcXDC8xVpfiCnhhYHBED0DTakRNuPMHKWo0
 SVWpGfceoA9LYq9wZCDrnPIZDEbKgd4t2tZC1YJ3/fR7puc5hncR1ml1+YzrS0/PC3OP
 6Z6UuXvaK+Bsz5xZ9RNjEQGqY4mkrSwzO7f2qWuevtb+SFVx5PcvQHDSl7coUP/b/ID1
 weXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=tGxrjpstm4I7PAN/kuQkbl2KdvRqWXweBxIWEzXPUS0=;
 b=bWaxPTQYjSLrtQBKSQ2x5uoFAoy1inH7Z80ZDH2bMYGnMwvR1yxYrTNedondwJeapR
 1juTiuKdTVfGXRuOJW1y4Q+82j5ktoQA+K8KEf665Av5s6/ncHhmPLcWgEtMpXFiG9Rd
 EU5c4N55x+xgL7seibzDMw/wc07un6giA5rNh/OTYwe4mZzujvvQBvlKTejGwMw5uIbw
 lGB+GAscJvdS3GZEXKSYxyMLRwkO1YPs4gPD0F0kn6vgYxjPq9CgwjKlaJYPFfpKb83r
 LL3reKnhjAybwZVcUtPYZ4hW/MN9THzJzEi6QtcrOjcXpIO9XVNA9Yfjgxgoz9ov+1zR
 Yuew==
X-Gm-Message-State: AOAM531XeyGkVOJLEyUlLBqx/CZYHmivwT1+UzEJqfL9KCYO1cpUptGb
 R1QfdFLQhpoVmom0pWxHXPzKPjs4jwog3dRbKA==
X-Google-Smtp-Source: ABdhPJyPME2bFg9M885rGZZI0rHS1DImpGoixn0MHCePFhXGI5w3H138E3V+16uvY6NoHKS7Lzt9REync16BsslJTQ==
X-Received: by 2002:a25:8808:: with SMTP id c8mr18042665ybl.159.1590088916644; 
 Thu, 21 May 2020 12:21:56 -0700 (PDT)
Date: Thu, 21 May 2020 12:21:27 -0700
Message-Id: <20200521192133.127559-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 0/6] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=31NTGXgsKCpU6H97CC3BD3C5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2020 16:37:38 -0400
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

This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
a minimal Linux kernel. This includes device models for:

  - Global Configuration Registers
  - Clock Control
  - Timers

These modules, along with the existing Cortex A9 CPU cores and built-in
peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in turn form
the foundation for the quanta-gsj and npcm750-evb machines, respectively. The
two SoCs are very similar; the only difference is that NPCM730 is missing some
peripherals that NPCM750 has, and which are not considered essential for
datacenter use (e.g. graphics controllers). For more information, see

https://www.nuvoton.com/products/cloud-computing/ibmc/

Both quanta-gsj and npcm750-evb correspond to real boards supported by OpenBMC.
While this initial series uses a stripped-down kernel for testing, future
series will be tested using OpenBMC images built from public sources. I'm
currently putting the finishing touches on flash controller support, which is
necessary to boot a full OpenBMC image, and will be enabled by the next series.

The patches in this series were developed by Google and reviewed by Nuvoton. We
will be maintaining the machine and peripheral support together.

The data sheet for these SoCs is not generally available. Please let me know if
more comments are needed to understand the device behavior.

Thanks for reviewing,

Havard

Havard Skinnemoen (6):
  npcm7xx: Add config symbol
  hw/misc: Add NPCM7xx System Global Control Registers device model
  hw/misc: Add NPCM7xx Clock Controller device model
  hw/timer: Add NPCM7xx Timer device model
  hw/arm: Add NPCM730 and NPCM750 SoC models
  hw/arm: Add two NPCM7xx-based machines

 MAINTAINERS                      |  12 +
 default-configs/arm-softmmu.mak  |   1 +
 hw/arm/Kconfig                   |   8 +
 hw/arm/Makefile.objs             |   1 +
 hw/arm/npcm7xx.c                 | 328 +++++++++++++++++++++++
 hw/arm/npcm7xx_boards.c          | 108 ++++++++
 hw/misc/Makefile.objs            |   2 +
 hw/misc/npcm7xx_clk.c            | 210 +++++++++++++++
 hw/misc/npcm7xx_gcr.c            | 160 +++++++++++
 hw/misc/trace-events             |   8 +
 hw/timer/Makefile.objs           |   1 +
 hw/timer/npcm7xx_timer.c         | 437 +++++++++++++++++++++++++++++++
 hw/timer/trace-events            |   5 +
 include/hw/arm/npcm7xx.h         |  98 +++++++
 include/hw/misc/npcm7xx_clk.h    |  65 +++++
 include/hw/misc/npcm7xx_gcr.h    |  74 ++++++
 include/hw/timer/npcm7xx_timer.h |  95 +++++++
 17 files changed, 1613 insertions(+)
 create mode 100644 hw/arm/npcm7xx.c
 create mode 100644 hw/arm/npcm7xx_boards.c
 create mode 100644 hw/misc/npcm7xx_clk.c
 create mode 100644 hw/misc/npcm7xx_gcr.c
 create mode 100644 hw/timer/npcm7xx_timer.c
 create mode 100644 include/hw/arm/npcm7xx.h
 create mode 100644 include/hw/misc/npcm7xx_clk.h
 create mode 100644 include/hw/misc/npcm7xx_gcr.h
 create mode 100644 include/hw/timer/npcm7xx_timer.h

-- 
2.27.0.rc0.183.gde8f92d652-goog


