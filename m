Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1EECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1FC20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1FC20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPgw-0000iI-65
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPfQ-00084G-JN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPfN-00046B-MK
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPfN-00045e-E9
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:27:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 287453084051;
 Tue, 15 Oct 2019 16:27:20 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB09319C58;
 Tue, 15 Oct 2019 16:27:08 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/32] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
Date: Tue, 15 Oct 2019 18:26:33 +0200
Message-Id: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 15 Oct 2019 16:27:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is a rework of "piix4: cleanup and improvements" [1]
from Herv=C3=A9, and my "remove i386/pc dependency: PIIX cleanup" [2].

Still trying to remove the strong X86/PC dependency 2 years later,
one step at a time.
Here we split the PIIX3 southbridge from i440FX northbridge.
The i440FX northbridge is only used by the PC machine, while the
PIIX southbridge is also used by the Malta MIPS machine.

This is also a step forward using KConfig with the Malta board.
Without this split, it was impossible to compile the Malta without
pulling various X86 pieces of code.

The overall design cleanup is not yet perfect, but enough to post
as a series.

Now that the PIIX3 code is extracted, the code duplication with the
PIIX4 chipset is obvious. Not worth improving for now because it
isn't broken.

Next step is probably:

1/ Extract i8259 from "pc.h" and sort all the places where we call
   pic_*() using global variables
2/ Refactor common PIIX code from hw/i386/pc_*.c to piix*.c

Please review,

Phil.

Series available here:
branch pc_split_i440fx_piix-v1 on https://gitlab.com/philmd/qemu.git

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg500737.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg504081.html

Herv=C3=A9 Poussineau (9):
  mc146818rtc: move structure to header file
  mc146818rtc: always register rtc to rtc list
  piix4: rename some variables in realize function
  piix4: add Reset Control Register
  piix4: add a i8259 interrupt controller as specified in datasheet
  piix4: rename PIIX4 object to piix4-isa
  piix4: convert reset function to QOM
  piix4: add a i8257 dma controller as specified in datasheet
  piix4: add a i8254 pit controller as specified in datasheet

Philippe Mathieu-Daud=C3=A9 (23):
  hw/i386: Remove obsolete LoadStateHandler::load_state_old handlers
  hw/i386/pc: Move kvm_i8259_init() declaration to sysemu/kvm.h
  mc146818rtc: Move RTC_ISA_IRQ definition
  mc146818rtc: Include "mc146818rtc_regs.h" directly in mc146818rtc.c
  MAINTAINERS: Keep PIIX4 South Bridge separate from PC Chipsets
  Revert "irq: introduce qemu_irq_proxy()"
  piix4: add a mc146818rtc controller as specified in datasheet
  hw/mips/mips_malta: Create IDE hard drive array dynamically
  hw/mips/mips_malta: Extract the PIIX4 creation code as piix4_create()
  hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
  hw/i386/pc: Extract pc_gsi_create()
  hw/i386/pc: Reduce gsi_handler scope
  hw/i386/pc: Move gsi_state creation code
  hw/i386/pc: Extract pc_i8259_create()
  hw/i386/pc: Remove kvm_i386.h include
  hw/pci-host/piix: Extract piix3_create()
  hw/pci-host/piix: Move RCR_IOPORT register definition
  hw/pci-host/piix: Define and use the PIIX IRQ Route Control Registers
  hw/pci-host/piix: Move i440FX declarations to hw/pci-host/i440fx.h
  hw/pci-host/piix: Fix code style issues
  hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c
  hw/pci-host: Rename incorrectly named 'piix' as 'i440fx'
  hw/pci-host/i440fx: Remove the last PIIX3 traces

 MAINTAINERS                         |  14 +-
 hw/acpi/pcihp.c                     |   2 +-
 hw/acpi/piix4.c                     |  42 +--
 hw/core/irq.c                       |  14 -
 hw/i386/Kconfig                     |   3 +-
 hw/i386/acpi-build.c                |   3 +-
 hw/i386/pc.c                        |  36 ++-
 hw/i386/pc_piix.c                   |  33 +--
 hw/i386/pc_q35.c                    |  28 +-
 hw/i386/xen/xen-hvm.c               |   5 +-
 hw/intc/apic_common.c               |  49 ----
 hw/isa/Kconfig                      |   4 +
 hw/isa/Makefile.objs                |   1 +
 hw/isa/piix3.c                      | 399 ++++++++++++++++++++++++++
 hw/isa/piix4.c                      | 155 ++++++++--
 hw/mips/gt64xxx_pci.c               |   5 +-
 hw/mips/mips_malta.c                |  46 +--
 hw/pci-host/Kconfig                 |   3 +-
 hw/pci-host/Makefile.objs           |   2 +-
 hw/pci-host/{piix.c =3D> i440fx.c}    | 424 +---------------------------
 hw/timer/i8254_common.c             |  40 ---
 hw/timer/mc146818rtc.c              |  39 +--
 include/hw/acpi/piix4.h             |   6 -
 include/hw/i386/pc.h                |  41 +--
 include/hw/irq.h                    |   5 -
 include/hw/isa/isa.h                |   2 +
 include/hw/pci-host/i440fx.h        |  36 +++
 include/hw/southbridge/piix.h       |  74 +++++
 include/hw/timer/mc146818rtc.h      |  36 ++-
 include/hw/timer/mc146818rtc_regs.h |   2 -
 include/sysemu/kvm.h                |   1 +
 stubs/pci-host-piix.c               |   3 +-
 tests/rtc-test.c                    |   1 +
 33 files changed, 781 insertions(+), 773 deletions(-)
 create mode 100644 hw/isa/piix3.c
 rename hw/pci-host/{piix.c =3D> i440fx.c} (58%)
 delete mode 100644 include/hw/acpi/piix4.h
 create mode 100644 include/hw/pci-host/i440fx.h
 create mode 100644 include/hw/southbridge/piix.h

--=20
2.21.0


