Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9085C83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCD52073C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLEdVGPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCD52073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTFv4-0004La-Lu
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 22:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTFtn-0002Iv-Uh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTFtj-0003JN-Nj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:23:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jTFtj-0003Az-BJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:22:59 -0400
Received: by mail-pl1-x642.google.com with SMTP id t16so7733591plo.7
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 19:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GAZXAPUw9CMmVwPwZSKhW/EFKtfHa6UqXDRMtlKuEVg=;
 b=gLEdVGPWuiPpzaXAEVeFHMitja6f5bLBRppXQmmHsqoDkh+AxUiY6VXuVecuyEiogA
 kqT0Y9UMHqOBDEmaGsp6jpBlnkaAUX/N6EiBmDo4HGQ3SI4IDRYDC8i3mT+530sZKGsS
 vKYTTQFJYdeVRqRrJw01x803bNaVNCO2doQdUtPa83/5xBwGLqEdvIUzgEL1ROHT4Ed4
 5GXhTg30vJEYIH1wK2/QI36K5pbl0udw2ZVyoZyyNTAu3kBLFVlKy4aeeVf3+YhFMruF
 ECz39VrGAUceFLRAgLKotE0gfYRfYvgYrAiKjMpddC+8f8k/IaswDcywxGBd+f3c3H9Q
 rgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GAZXAPUw9CMmVwPwZSKhW/EFKtfHa6UqXDRMtlKuEVg=;
 b=Yp5IWcQNNhAgJKPizboWeBs9NgJwpjz3gPPvCBwSN/p+d9u4Fn/gkOTkTpjJJE+e3h
 CT5FUrdonOVLHSSQiqtQCxeoK068i/QJI2VlZPpcLq3cBTOhyFFZ+26UmDqABJ7rlG3J
 Ot7Ub3x23cGK7OAMZgNsq43R6M+3qkNDNpmaBf/0I631ISA+hkLSgX24hxS9LjDVk8UH
 tpB0XDhg+vM2H+BBDPNll66VWaB4Ue6YdqVNW8qTc4L2E/u7wVwH4IGJhOX+OTHMWk6L
 P6UUytZeYECl+hxnC8xQbIwVJgJ2OM72gmHw3F2KJsT7BW42eXncQIZlJrlGkmmBCbdk
 zjtg==
X-Gm-Message-State: AGi0PuYTGYvP82tim1SOeSaQJyDZfmJHLwclGm1oAjqsz2O5zTIsoB6Y
 W731k6J1wpG0VOsi5qVCjQo=
X-Google-Smtp-Source: APiQypLAqINSxmgJgFGOxuvslMnJl9emWWVUqzpOpThGRUVKb3RfLiTs/dI5/6aMPMYVXYEWv/BiTA==
X-Received: by 2002:a17:902:8688:: with SMTP id
 g8mr27322224plo.268.1588040576725; 
 Mon, 27 Apr 2020 19:22:56 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id z190sm11695649pgz.73.2020.04.27.19.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 19:22:56 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
Date: Mon, 27 Apr 2020 19:22:25 -0700
Message-Id: <20200428022232.18875-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
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

Changes v3-v4:
  - Reworked the memory region / register access code according to
    an example patch from Felippe Mathieu-Daudé.
  - Moved the Makefile/Kconfig changes for this file into this
    patch, per Felipe.
  - Fixed a missing DEFINE_PROP_END_OF_LIST() in dwc2_usb_properties.

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
  raspi2 acceptance test: add test for dwc-hsotg (dwc2) USB host

 hw/arm/bcm2835_peripherals.c           |   38 +-
 hw/misc/Makefile.objs                  |    1 +
 hw/misc/bcm2835_mphi.c                 |  190 ++++
 hw/usb/Kconfig                         |    5 +
 hw/usb/Makefile.objs                   |    1 +
 hw/usb/dev-storage.c                   |   15 +-
 hw/usb/hcd-dwc2.c                      | 1378 ++++++++++++++++++++++++
 hw/usb/hcd-dwc2.h                      |  173 +++
 hw/usb/trace-events                    |   47 +
 include/hw/arm/bcm2835_peripherals.h   |    5 +-
 include/hw/misc/bcm2835_mphi.h         |   48 +
 include/hw/usb/dwc2-regs.h             |  895 +++++++++++++++
 tests/acceptance/boot_linux_console.py |    9 +-
 13 files changed, 2800 insertions(+), 5 deletions(-)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 hw/usb/hcd-dwc2.c
 create mode 100644 hw/usb/hcd-dwc2.h
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 include/hw/usb/dwc2-regs.h

-- 
2.17.1


