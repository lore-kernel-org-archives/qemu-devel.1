Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70212177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70212177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHFR-0007qt-UY
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBQ-0007xK-PQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:12 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:39205)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBN-0005u4-UP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:12 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 60E8126938;
 Thu, 27 Aug 2020 21:39:05 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id CFEF01C0696;
 Thu, 27 Aug 2020 21:39:04 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/20] RX target update
Date: Thu, 27 Aug 2020 21:38:39 +0900
Message-Id: <20200827123859.81793-1-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.15;
 envelope-from=ysato@users.sourceforge.jp; helo=mail03.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello.
This series Renesas RX updates.

It consists of the following contents.
* Update firmware loader.
* Rewrite peripheal modules (Timer and SCI).
  - Unified SH4 module.
  - Using clock API
* New peripheal modules.
  - On-chip clock generator.
  - Multi-function timer.
  - Ethernet MAC.
* New real hardware target.
  - TokushudenshiKairo TKDN-RX62N-BRD.
  - CQ publishing CQ-FRK-RX62N

Yoshinori Sato (20):
  loader.c: Add support Motrola S-record format.
  include/elf.h: Add EM_RX.
  hw/rx: Firmware and kernel loader.
  hw/rx: New firmware loader.
  hw/rx: Add RX62N Clock generator
  hw/timer: Renesas 8bit timer emulation.
  hw/rx: RX62N convert new 8bit timer.
  hw/timer: Renesas TMU/CMT module.
  hw/timer: Remove renesas_cmt.
  hw/rx: Convert to renesas_timer
  hw/char: Renesas SCI module.
  hw/rx/rx62n: Use New SCI module.
  hw/timer: Add Renesas MTU2
  hw/rx/rx62n: RX62N Add MTU module
  hw/net: Add generic Bit-bang MDIO PHY.
  hw/net: Add Renesas On-chip Ethernet MAC
  hw/rx/rx62n: Add Ethernet support.
  hw/rx: Add Tokudenkairo TKDN-RX62N-BRD
  hw/rx: Add CQ-FRK-RX62N target
  MAINTAINERS: Update RX entry

 default-configs/rx-softmmu.mak   |    2 +
 include/elf.h                    |    2 +
 include/hw/char/renesas_sci.h    |  129 ++-
 include/hw/loader.h              |   14 +
 include/hw/net/mdio.h            |  126 +++
 include/hw/net/renesas_eth.h     |   57 ++
 include/hw/rx/loader.h           |   35 +
 include/hw/rx/rx62n-cpg.h        |   72 ++
 include/hw/rx/rx62n.h            |   36 +-
 include/hw/timer/renesas_cmt.h   |   40 -
 include/hw/timer/renesas_mtu.h   |   90 ++
 include/hw/timer/renesas_timer.h |  103 +++
 include/hw/timer/renesas_tmr.h   |   55 --
 include/hw/timer/renesas_tmr8.h  |   67 ++
 hw/char/renesas_sci.c            | 1040 ++++++++++++++++++-----
 hw/core/loader.c                 |  208 +++++
 hw/net/mdio.c                    |  264 ++++++
 hw/net/renesas_eth.c             |  875 ++++++++++++++++++++
 hw/rx/cq-frk-rx62n.c             |   94 +++
 hw/rx/loader.c                   |  182 +++++
 hw/rx/rx-gdbsim.c                |   98 +--
 hw/rx/rx62n-cpg.c                |  344 ++++++++
 hw/rx/rx62n.c                    |  140 ++--
 hw/rx/tkdn-rx62n.c               |  192 +++++
 hw/timer/renesas_cmt.c           |  283 -------
 hw/timer/renesas_mtu.c           | 1312 ++++++++++++++++++++++++++++++
 hw/timer/renesas_timer.c         |  639 +++++++++++++++
 hw/timer/renesas_tmr.c           |  477 -----------
 hw/timer/renesas_tmr8.c          |  540 ++++++++++++
 MAINTAINERS                      |    2 +
 hw/net/Kconfig                   |    8 +
 hw/net/meson.build               |    3 +
 hw/rx/Kconfig                    |   16 +-
 hw/rx/meson.build                |    5 +-
 hw/timer/Kconfig                 |    9 +-
 hw/timer/meson.build             |    5 +-
 36 files changed, 6391 insertions(+), 1173 deletions(-)
 create mode 100644 include/hw/net/mdio.h
 create mode 100644 include/hw/net/renesas_eth.h
 create mode 100644 include/hw/rx/loader.h
 create mode 100644 include/hw/rx/rx62n-cpg.h
 delete mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_mtu.h
 create mode 100644 include/hw/timer/renesas_timer.h
 delete mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 include/hw/timer/renesas_tmr8.h
 create mode 100644 hw/net/mdio.c
 create mode 100644 hw/net/renesas_eth.c
 create mode 100644 hw/rx/cq-frk-rx62n.c
 create mode 100644 hw/rx/loader.c
 create mode 100644 hw/rx/rx62n-cpg.c
 create mode 100644 hw/rx/tkdn-rx62n.c
 delete mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_mtu.c
 create mode 100644 hw/timer/renesas_timer.c
 delete mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 hw/timer/renesas_tmr8.c

-- 
2.20.1


