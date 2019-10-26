Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700EDCA9EBD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438B020663
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7oy9efN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438B020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQQ7-0001E7-1a
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQOF-0007HK-N6
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQOC-0006v6-Db
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:02:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52321
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQO7-0006s4-Rf
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572112924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7k9FuNGkm+yzSAu3fL53bs7x6i95WxoDqk5HyIutRoI=;
 b=D7oy9efNJN0HH0XEEaqD0g2SVPDBEaf+DZLaa0fX6JspMUGdeb1oFTewMhpxljG+cvovyx
 fn/rUdT26uB+L3INiCyFbaGB+GsRFoETxD3r4GtXueEqfInKmQkdV+z5exTHvUPK98cJEc
 euJjhVtyHm4jenRGE6smIFtycOyNoXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-TDx1hdE7M12olS4o1YbWKg-1; Sat, 26 Oct 2019 14:02:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B82C5EC;
 Sat, 26 Oct 2019 18:01:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C5A960C80;
 Sat, 26 Oct 2019 18:01:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
Date: Sat, 26 Oct 2019 20:01:23 +0200
Message-Id: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TDx1hdE7M12olS4o1YbWKg-1
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v2 [0]:
- Use a #define
- Reword one description
- Added review tags (thanks all for reviewing!)

Changes since v1 [1]:
- Removed patch reintroducing DO_UPCAST() use (thuth)
- Took various patches out to reduce series (thuth)
- Added review tags (thanks all for reviewing!)

$ git backport-diff -u pc_split_i440fx_piix-v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/20:[----] [--] 'MAINTAINERS: Keep PIIX4 South Bridge separate from PC C=
hipsets'
002/20:[0004] [FC] 'piix4: Add the Reset Control Register'
003/20:[0002] [FC] 'piix4: Add an i8259 Interrupt Controller as specified i=
n datasheet'
004/20:[----] [--] 'Revert "irq: introduce qemu_irq_proxy()"'
005/20:[----] [--] 'piix4: Rename PIIX4 object to piix4-isa'
006/20:[----] [--] 'piix4: Add an i8257 DMA Controller as specified in data=
sheet'
007/20:[----] [-C] 'piix4: Add an i8254 PIT Controller as specified in data=
sheet'
008/20:[0004] [FC] 'piix4: Add a MC146818 RTC Controller as specified in da=
tasheet'
009/20:[----] [--] 'hw/mips/mips_malta: Create IDE hard drive array dynamic=
ally'
010/20:[----] [--] 'hw/mips/mips_malta: Extract the PIIX4 creation code as =
piix4_create()'
011/20:[----] [-C] 'hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c'
012/20:[----] [--] 'hw/i386: Remove obsolete LoadStateHandler::load_state_o=
ld handlers'
013/20:[----] [--] 'hw/pci-host/piix: Extract piix3_create()'
014/20:[0002] [FC] 'hw/pci-host/piix: Move RCR_IOPORT register definition'
015/20:[----] [--] 'hw/pci-host/piix: Define and use the PIIX IRQ Route Con=
trol Registers'
016/20:[----] [-C] 'hw/pci-host/piix: Move i440FX declarations to hw/pci-ho=
st/i440fx.h'
017/20:[----] [--] 'hw/pci-host/piix: Fix code style issues'
018/20:[----] [--] 'hw/pci-host/piix: Extract PIIX3 functions to hw/isa/pii=
x3.c'
019/20:[----] [--] 'hw/pci-host: Rename incorrectly named 'piix' as 'i440fx=
''
020/20:[0004] [FC] 'hw/pci-host/i440fx: Remove the last PIIX3 traces'

Previous cover:

This series is a rework of "piix4: cleanup and improvements" [2]
from Herv=C3=A9, and my "remove i386/pc dependency: PIIX cleanup" [3].

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

Based-on: <1572097538-18898-1-git-send-email-pbonzini@redhat.com>
to include:
mc146818rtc: Allow call object_initialize(MC146818_RTC) instead of rtc_init=
()
https://mid.mail-archive.com/20191018133547.10936-1-philmd@redhat.com

Since Aleksandar offered me to send the pull request [4] I plan to do
it once Paolo's pull [5] is merged.

Thanks,

Phil.

CI results:
https://travis-ci.org/philmd/qemu/builds/603253987
https://app.shippable.com/github/philmd/qemu/runs/550/summary/console

[0] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04662.html
[1] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg500737.html
[3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg504081.html
[4] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html
[5] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07339.html

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


