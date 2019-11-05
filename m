Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA0FC5DF62
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABB8206BA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4ev862j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABB8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS7ji-0004UX-DO
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 17:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iS7iK-0003Yu-Lw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iS7iH-0005Gd-Om
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:54:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iS7iH-0005CV-Cr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572994451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d2K76DcNWGxM0x87p5gs9tVDgzKqAi2WAXFsp/3uNWM=;
 b=F4ev862jNdZEw9MoPYPHv9Km2ViZ3CZZ/4zewpSdrDFUzk+q4W3aicIz24Mg28RI78wA3A
 PmHp7aDUeSu6Q5tpuOyiAEMxkWB76Sg7M4HUngNrfpDvg/y+NfAtik+0qLfAW46YyPYeCs
 JKwlixh6xwbenlbhBNTCbATJohRyBy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-FHhFqpUJMnSvj10IE9YzHA-1; Tue, 05 Nov 2019 17:54:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5573B800C73;
 Tue,  5 Nov 2019 22:54:07 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-20.brq.redhat.com [10.40.204.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2CED1001B00;
 Tue,  5 Nov 2019 22:54:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/21] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
Date: Tue,  5 Nov 2019 23:53:52 +0100
Message-Id: <20191105225353.9900-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: FHhFqpUJMnSvj10IE9YzHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

This is a X86/MIPS pull, Paolo and Aleksandar are OK I send it:

  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html

Since v1: Fixed the Kconfig bug you reported here:

  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00125.html

This is not a new feature, and the series was already posted before
soft freeze.

Regards,

Phil.

The following changes since commit 412fbef3d076c43e56451bacb28c4544858c66a3=
:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-next-pull=
-request' into staging (2019-11-05 20:17:11 +0000)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/mips-next-20191105

for you to fetch changes up to 48bc99a09cb160a3a2612c4bd5a8a225ed7bf6fb:

  hw/pci-host/i440fx: Remove the last PIIX3 traces (2019-11-05 23:33:12 +01=
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

Philippe Mathieu-Daud=C3=A9 (16):
  Makefile: Fix config-devices.mak not regenerated when Kconfig updated
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
 Makefile                         |   3 +-
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
 27 files changed, 701 insertions(+), 684 deletions(-)
 create mode 100644 hw/isa/piix3.c
 rename hw/pci-host/{piix.c =3D> i440fx.c} (58%)
 delete mode 100644 include/hw/acpi/piix4.h
 create mode 100644 include/hw/pci-host/i440fx.h
 create mode 100644 include/hw/southbridge/piix.h

--=20
2.21.0


