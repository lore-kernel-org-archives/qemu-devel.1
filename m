Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54DACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B93214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmuN1wU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B93214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP97a-00050L-Fg
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iP7yy-0001ub-Pk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iP7yw-00078x-58
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iP7yv-00077c-GC
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572280500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NYGM2NbhADHumbNnWcUtGGZR/qGWxvEWF4HGJ3p2NN4=;
 b=gmuN1wU6BgcYqhFjjSOKzL41JUpbIK3Ti/3GYtv6Bp7Biwih7sRlDvDLIOLR7dnrx9nyQQ
 +/uNQLx/ZKW/3NnCap2ByVe9JPEbxHIAT5SBgVC0ENEa0mUC9/XRTsngdA61B1c0LGYTtv
 whU9gjh0Kmp0afRrj9No0pGnikg1E+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-whsInTdbOsi_qNEq5h7HTA-1; Mon, 28 Oct 2019 12:34:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 091651800E07;
 Mon, 28 Oct 2019 16:34:55 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-87.brq.redhat.com [10.40.204.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D17E91C95A;
 Mon, 28 Oct 2019 16:34:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
Date: Mon, 28 Oct 2019 17:34:27 +0100
Message-Id: <20191028163447.18541-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: whsInTdbOsi_qNEq5h7HTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

This is a X86/MIPS pull, Paolo and Aleksandar are OK I send it:

  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html

Regards,

Phil.

The following changes since commit 9bb73502321d46f4d320fa17aa38201445783fc4=
:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging=
 (2019-10-28 13:32:40 +0000)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/pc_split_i440fx_piix-pull-request

for you to fetch changes up to d1389352cde824ce8dab7c1a2ded150df6add124:

  hw/pci-host/i440fx: Remove the last PIIX3 traces (2019-10-28 16:12:29 +01=
00)

----------------------------------------------------------------
The i440FX northbridge is only used by the PC machine, while the
PIIX southbridge is also used by the Malta MIPS machine.

Split the PIIX3 southbridge from i440FX northbridge.

----------------------------------------------------------------

Herv=C3=A9 Poussineau (5):
  piix4: Add the Reset Control Register
  piix4: Add an i8259 Interrupt Controller as specified in datasheet
  piix4: Rename PIIX4 object to piix4-isa
  piix4: Add an i8257 DMA Controller as specified in datasheet
  piix4: Add an i8254 PIT Controller as specified in datasheet

Philippe Mathieu-Daud=C3=A9 (15):
  MAINTAINERS: Keep PIIX4 South Bridge separate from PC Chipsets
  Revert "irq: introduce qemu_irq_proxy()"
  piix4: Add a MC146818 RTC Controller as specified in datasheet
  hw/mips/mips_malta: Create IDE hard drive array dynamically
  hw/mips/mips_malta: Extract the PIIX4 creation code as piix4_create()
  hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
  hw/i386: Remove obsolete LoadStateHandler::load_state_old handlers
  hw/pci-host/piix: Extract piix3_create()
  hw/pci-host/piix: Move RCR_IOPORT register definition
  hw/pci-host/piix: Define and use the PIIX IRQ Route Control Registers
  hw/pci-host/piix: Move i440FX declarations to hw/pci-host/i440fx.h
  hw/pci-host/piix: Fix code style issues
  hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c
  hw/pci-host: Rename incorrectly named 'piix' as 'i440fx'
  hw/pci-host/i440fx: Remove the last PIIX3 traces

 MAINTAINERS                      |  14 +-
 hw/acpi/pcihp.c                  |   2 +-
 hw/acpi/piix4.c                  |  42 +--
 hw/core/irq.c                    |  14 -
 hw/i386/Kconfig                  |   3 +-
 hw/i386/acpi-build.c             |   5 +-
 hw/i386/pc_piix.c                |  10 +-
 hw/i386/xen/xen-hvm.c            |   5 +-
 hw/intc/apic_common.c            |  49 ----
 hw/isa/Kconfig                   |   4 +
 hw/isa/Makefile.objs             |   1 +
 hw/isa/piix3.c                   | 399 +++++++++++++++++++++++++++++
 hw/isa/piix4.c                   | 151 ++++++++++-
 hw/mips/gt64xxx_pci.c            |   5 +-
 hw/mips/mips_malta.c             |  46 +---
 hw/pci-host/Kconfig              |   3 +-
 hw/pci-host/Makefile.objs        |   2 +-
 hw/pci-host/{piix.c =3D> i440fx.c} | 424 +------------------------------
 hw/timer/i8254_common.c          |  40 ---
 include/hw/acpi/piix4.h          |   6 -
 include/hw/i386/pc.h             |  37 ---
 include/hw/irq.h                 |   5 -
 include/hw/isa/isa.h             |   2 +
 include/hw/pci-host/i440fx.h     |  36 +++
 include/hw/southbridge/piix.h    |  74 ++++++
 stubs/pci-host-piix.c            |   3 +-
 26 files changed, 699 insertions(+), 683 deletions(-)
 create mode 100644 hw/isa/piix3.c
 rename hw/pci-host/{piix.c =3D> i440fx.c} (58%)
 delete mode 100644 include/hw/acpi/piix4.h
 create mode 100644 include/hw/pci-host/i440fx.h
 create mode 100644 include/hw/southbridge/piix.h

--=20
2.21.0


