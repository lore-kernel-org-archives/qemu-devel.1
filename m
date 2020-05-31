Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA4CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF8920707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF8920707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfQmN-0005d4-1I
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1jfQlL-0004DE-59
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:39 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:48254)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jfQlJ-0004Jy-Uy
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:38 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id C62DFECD35;
 Mon,  1 Jun 2020 01:24:32 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id EFBC91C05D2;
 Mon,  1 Jun 2020 01:24:31 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] Add RX hardware emulation
Date: Mon,  1 Jun 2020 01:24:17 +0900
Message-Id: <20200531162427.57410-1-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.15;
 envelope-from=ysato@users.sourceforge.jp; helo=mail03.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:24:33
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

This series add to hardware emulation module for RX target.

Details below.
Interrupt controller, 8bit timer, 16bit comapare match timer and
SCI is RX62N integrated peripheral.
rx-virt - RX62N MCU and external RAM. It like gdb simulator.

The compare match timer has a CPU interface similar to the SH4 timer.
sh_timer will be deprecated and integrated into this module.
SCI is also implemented in sh_serial, but the functionality is omitted.
I implemented the complete one as renesas_sci.

git repository here.
git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/hw-rx-20200601

Yoshinori Sato (10):
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: Renesas 8bit timer module.
  hw/timer: Renesas TMU/CMT module.
  hw/char: Renesas SCI module.
  hw/rx: RX MCU and target
  Add rx-softmmu
  hw/sh4: Convert renesas_sci.
  hw/char: remove sh_serial.c
  hw/sh4: Convert to renesas_timer.c
  hw/timer: remove sh_timer.c

 default-configs/rx-softmmu.mak    |   1 +
 include/hw/char/renesas_sci.h     |  77 +++
 include/hw/intc/rx_icu.h          |  56 +++
 include/hw/rx/rx.h                |   7 +
 include/hw/rx/rx62n.h             |  91 ++++
 include/hw/sh4/sh.h               |  21 -
 include/hw/timer/renesas_8timer.h |  61 +++
 include/hw/timer/renesas_timer.h  |  59 +++
 hw/char/renesas_sci.c             | 786 ++++++++++++++++++++++++++++++
 hw/char/sh_serial.c               | 431 ----------------
 hw/intc/rx_icu.c                  | 379 ++++++++++++++
 hw/rx/rx-virt.c                   | 143 ++++++
 hw/rx/rx62n.c                     | 240 +++++++++
 hw/sh4/sh7750.c                   |  78 ++-
 hw/timer/renesas_8timer.c         | 466 ++++++++++++++++++
 hw/timer/renesas_timer.c          | 421 ++++++++++++++++
 hw/timer/sh_timer.c               | 341 -------------
 hw/Kconfig                        |   1 +
 hw/char/Kconfig                   |   3 +
 hw/char/Makefile.objs             |   3 +-
 hw/intc/Makefile.objs             |   1 +
 hw/rx/Kconfig                     |  13 +
 hw/rx/Makefile.objs               |   2 +
 hw/sh4/Kconfig                    |   3 +-
 hw/timer/Kconfig                  |   6 +
 hw/timer/Makefile.objs            |   4 +-
 26 files changed, 2891 insertions(+), 803 deletions(-)
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_8timer.h
 create mode 100644 include/hw/timer/renesas_timer.h
 create mode 100644 hw/char/renesas_sci.c
 delete mode 100644 hw/char/sh_serial.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/rx-virt.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/timer/renesas_8timer.c
 create mode 100644 hw/timer/renesas_timer.c
 delete mode 100644 hw/timer/sh_timer.c
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs

-- 
2.20.1


