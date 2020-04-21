Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9EC38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471F12078C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZgACKX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471F12078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQi13-0005oy-5y
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQhzl-0004zF-Df
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQhzi-0002kM-VX
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:46:40 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQhzi-0002hY-Iy
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:46:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id b8so5876694pfp.8
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 18:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=DeaBBNccBsxKwa1DBmtWLzNxQiDSBmBraKPWAiPilN8=;
 b=vZgACKX6MAw1EgH8dOnh7YyKxxqSfiWMjJOsVty35BU3O+qb2lE/9lftTdQJYShHm0
 7CHdyCPIzq7VxHF4blTDeGWA7g5GktLR6IjdNwyTOOxHK466NDXn83yacEJAJmaNE1Tm
 /tyxfIypTDHD1Qu1QlZOMyQWJZFymBhLt6LqpwY1fxB8JGBxolekZc46CiQbjS127WgF
 lXqZTSO0qfmgpwUxQgF3fTedmkTqjlLYPK1fP4bhfGn8HFx5/1xXoKlD2yu+t6An9pBI
 npcL0QEd+XWJlG3umZC9h0a1IYVDq8+CwD3jUPYRlSZDkk9cVrkx6DRx3eoiw05qWug7
 XxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DeaBBNccBsxKwa1DBmtWLzNxQiDSBmBraKPWAiPilN8=;
 b=DXPicFIT9r4hFmjcvB5sxYBwFBvjamCYwyogSVfxQUNnR0lPO/82cjqqpMpaSF6uvH
 eIgUoKhWBy/llvUvY1ub9+jZRsOaDpxeALPwoRbBufTpkzt2+3+GhfShQR4yHXwQCvmu
 N9+ULHib23oiJW5BTIP51VqSlBSS8JCb3OhjMZpZYsNZ8DHGRsScwYqKx5CccE6b6KqQ
 FY5Fetr5la5rIud2QDt1Ex9eyesr640PrImPiXvion5ecrqMAnJZxWtN/EpLtn9MQ+ie
 Pm8YDZyNxaasZAx4Xi00uawZG5EPrOYGErf2vABujs83qcBP0Jd7lSZo89mMk3oMnAHr
 qoNg==
X-Gm-Message-State: AGi0Pua8UmXNy+Z8QT+Rt6Fd9Gc3IK4YyeZEYxEnQOyMMnw++L2zVL/q
 HzTZIqLxtJBXcCuu2oAAwwY=
X-Google-Smtp-Source: APiQypJX6cu5/yX39qqA/ZaqP9PJaKn/LQST3dg/aivoKFmLkfRHjV+kTz2YUnHtQcYhNiNerRsfYA==
X-Received: by 2002:a62:1a0d:: with SMTP id a13mr2375035pfa.229.1587433595841; 
 Mon, 20 Apr 2020 18:46:35 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id q11sm654868pgs.25.2020.04.20.18.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 18:46:35 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
Date: Mon, 20 Apr 2020 18:45:44 -0700
Message-Id: <20200421014551.10426-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=pauldzim@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since I'm sure everyone is just sitting around waiting for 5.0 to
release ;) I thought I would submit v3 of my dwc-hsotg series. I
think I have taken everyone's requests/comments into account, except
for Peter's request to use the macros from registerfields.h to access
the registers. I think that would be more work than I'm willing to
put in at the moment.

This patch series adds emulation for the dwc-hsotg USB controller,
which is used on the Raspberry Pi 3 and earlier, as well as a number
of other development boards. The main benefit for Raspberry Pi is that
this enables networking on these boards, since the network adapter is
attached via USB.

The emulation is working quite well, I have tested with USB network,
mass storage, mouse, keyboard, and tablet. I have tested with the dwc2
driver in the upstream Linux kernel, and with the dwc-otg driver in the
Raspbian kernel.

One remaining issue is that USB host passthrough does not work. I tried
connecting to a USB stick on the host, but the device generates babble
errors and does not work. This is because the dwc-hsotg controller only
has one root port, so a full-speed dev-hub device is always connected
to it, and high-speed USB devices on the host do not work at full-speed
on the guest. (I have WIP code to add high-speed support to dev-hub to
fix this.)

The patch series also includes a very basic emulation of the MPHI
device on the Raspberry Pi SOC, which provides the FIQ interrupt that
is used by the dwc-otg driver in the Raspbian kernel. But that driver
still does not work in full FIQ mode, so it is necessary to add a
parameter to the kernel command line ("dwc_otg.fiq_fsm_enable=0") to
make it work.

I have used some online sources of information while developing this
emulation, including:

http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
which has a pretty complete description of the controller starting
on page 370.

https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf
which has a description of the controller registers starting on
page 130.

Changes v2-v3:
  - Fixed the high-speed frame time emulation so that high-speed
    mouse/tablet will work correctly once we have high-speed hub
    support.
  - Added a "usb_version" property to the dwc-hsotg controller, to
    allow choosing whether the controller emulates a USB 1 full-speed
    host or a USB 2 high-speed host.
  - Added a test for a working dwc-hsotg controller to the raspi2
    acceptance test, requested by Philippe M.
  - Added #defines for the register array sizes, instead of hard-
    coding them in multiple places.
  - Removed the NB_PORTS #define and the associated iteration code,
    since the controller only supports a single root port.
  - Removed some unused fields from the controller state struct.
  - Added pointers to some online documentation to the top of
    hcd-dwc2.c, requested by Peter M.
  - Reworked the init/realize code to remove some confusing function
    names, requested by Peter M.
  - Added VMStateDescription structs for the controller and MPHI
    state, requested by Peter M (untested).

Changes v1-v2:
  - Fixed checkpatch errors/warnings, except for dwc2-regs.h since
    that is a direct import from the Linux kernel.
  - Switched from debug printfs to tracepoints in hcd-dwc2.c, on the
    advice of Gerd. I just dropped the debug prints in bcm2835_mphi.c,
    since I didn't consider them very useful.
  - Updated a couple of the commit messages with more info.

Thanks for your time,
Paul

---

Paul Zimmerman (7):
  raspi: add BCM2835 SOC MPHI emulation
  dwc-hsotg (dwc2) USB host controller register definitions
  dwc-hsotg (dwc2) USB host controller state definitions
  dwc-hsotg (dwc2) USB host controller emulation
  usb: add short-packet handling to usb-storage driver
  wire in the dwc-hsotg (dwc2) USB host controller emulation
  raspi2 acceptance test: add check for functional dwc-hsotg (dwc2) USB host

 hw/arm/bcm2835_peripherals.c           |   38 +-
 hw/misc/Makefile.objs                  |    1 +
 hw/misc/bcm2835_mphi.c                 |  190 ++++
 hw/usb/Kconfig                         |    5 +
 hw/usb/Makefile.objs                   |    1 +
 hw/usb/dev-storage.c                   |   15 +-
 hw/usb/hcd-dwc2.c                      | 1372 ++++++++++++++++++++++++
 hw/usb/hcd-dwc2.h                      |  184 ++++
 hw/usb/trace-events                    |   47 +
 include/hw/arm/bcm2835_peripherals.h   |    5 +-
 include/hw/misc/bcm2835_mphi.h         |   48 +
 include/hw/usb/dwc2-regs.h             |  895 ++++++++++++++++
 tests/acceptance/boot_linux_console.py |    9 +-
 13 files changed, 2805 insertions(+), 5 deletions(-)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 hw/usb/hcd-dwc2.c
 create mode 100644 hw/usb/hcd-dwc2.h
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 include/hw/usb/dwc2-regs.h

-- 
2.17.1

