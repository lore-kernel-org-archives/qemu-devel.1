Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29195CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC83222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC83222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSdn-0004W9-PA
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSby-00031Q-JX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSbw-0005WQ-8t
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSbw-0005Vf-12
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EBD93078468;
 Fri, 18 Oct 2019 13:48:06 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2DF260BF4;
 Fri, 18 Oct 2019 13:47:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
Date: Fri, 18 Oct 2019 15:47:34 +0200
Message-Id: <20191018134754.16362-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 18 Oct 2019 13:48:06 +0000 (UTC)
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v1 [0]:
- Removed patch reintroducing DO_UPCAST() use (thuth)
- Took various patches out to reduce series (thuth)
- Added review tags (thanks all for reviewing!)

$ git backport-diff -u pc_split_i440fx_piix-v1 -r mc146818rtc_init..
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/20:[----] [--] 'MAINTAINERS: Keep PIIX4 South Bridge separate from PC=
 Chipsets'
002/20:[0011] [FC] 'piix4: add Reset Control Register'
003/20:[0014] [FC] 'piix4: add a i8259 interrupt controller as specified =
in datasheet'
004/20:[----] [--] 'Revert "irq: introduce qemu_irq_proxy()"'
005/20:[----] [--] 'piix4: rename PIIX4 object to piix4-isa'
006/20:[----] [-C] 'piix4: add a i8257 dma controller as specified in dat=
asheet'
007/20:[----] [-C] 'piix4: add a i8254 pit controller as specified in dat=
asheet'
008/20:[----] [-C] 'piix4: add a mc146818rtc controller as specified in d=
atasheet'
009/20:[----] [--] 'hw/mips/mips_malta: Create IDE hard drive array dynam=
ically'
010/20:[----] [--] 'hw/mips/mips_malta: Extract the PIIX4 creation code a=
s piix4_create()'
011/20:[----] [--] 'hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c'
012/20:[----] [--] 'hw/i386: Remove obsolete LoadStateHandler::load_state=
_old handlers'
013/20:[----] [--] 'hw/pci-host/piix: Extract piix3_create()'
014/20:[0010] [FC] 'hw/pci-host/piix: Move RCR_IOPORT register definition=
'
015/20:[----] [--] 'hw/pci-host/piix: Define and use the PIIX IRQ Route C=
ontrol Registers'
016/20:[----] [--] 'hw/pci-host/piix: Move i440FX declarations to hw/pci-=
host/i440fx.h'
017/20:[----] [--] 'hw/pci-host/piix: Fix code style issues'
018/20:[0012] [FC] 'hw/pci-host/piix: Extract PIIX3 functions to hw/isa/p=
iix3.c'
019/20:[----] [--] 'hw/pci-host: Rename incorrectly named 'piix' as 'i440=
fx''
020/20:[----] [-C] 'hw/pci-host/i440fx: Remove the last PIIX3 traces'

Previous cover:

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

[0] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg500737.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg504081.html

Based-on: <20191018133547.10936-1-philmd@redhat.com>
mc146818rtc: Allow call object_initialize(MC146818_RTC) instead of rtc_in=
it()
https://mid.mail-archive.com/20191018133547.10936-1-philmd@redhat.com

Herv=C3=A9 Poussineau (5):
  piix4: Add the Reset Control Register
  piix4: Add a i8259 Interrupt Controller as specified in datasheet
  piix4: Rename PIIX4 object to piix4-isa
  piix4: Add a i8257 DMA Controller as specified in datasheet
  piix4: Add a i8254 PIT Controller as specified in datasheet

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


