Received: from eggs.gnu.org ([2001:4830:134:3::10]:51173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNRy-0006S1-Pf
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNRv-000259-MK
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:10 -0500
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:36577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNRv-00024c-GO
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:07 -0500
Received: by mail-qk0-x233.google.com with SMTP id d21so1558445qkj.3
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:07 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:29 -0300
Message-Id: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 00/29] remove i386/pc dependency: generic
 SuperIO, PIIX cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Hi,

This series could be the 'part 2' of my previous "remove i386/pc dependency
from non-PC world" I started around 2.9.

As Hervé sent a PIIX4 series [1], I awoke this old branch to reduce duplicated
effort and added Hervé patches.

Hervé: what is missing from your series is the 'user_creatable' part, I'll
fix this when I find more spare time.

Regards,

Phil.

[1]: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg01028.html

Hervé Poussineau (8):
  mc146818rtc: always register rtc to rtc list
  piix4: rename some variables in realize function
  piix4: convert reset function to QOM
  piix4: add Reset Control Register
  piix4: add a i8259 interrupt controller as specified in datasheet
  piix4: add a i8257 dma controller as specified in datasheet
  piix4: add a i8254 pit controller as specified in datasheet
  piix4: add a speaker as specified in datasheet

Philippe Mathieu-Daudé (21):
  hw/acpi: add mem/nvdimm.h dependency
  pci/pci_host: move generic definitions out of i386/pc.h
  hw/isa: extract parallel-isa specific code
  hw/dma/i8257: rename DMA_init() to i8257_dma_init()
  hw/input/i8042: extract declarations from i386/pc.h into input/i8042.h
  hw/isa: add a generic isa_superio_init()
  hw/i386/pc: use isa_superio_init()
  hw/mips/fulong2e: use isa_superio_init()
  hw/mips/malta: code movement
  hw/mips/malta: add fdc37m81x_init() which uses isa_superio_init()
  Revert "irq: introduce qemu_irq_proxy()"
  piix: move piix4 declaration into new southbridge/i82371_piix.h
  piix: move southbridge related declarations/definitions to i82371_piix.h
  piix3: extract piix3_init() from i440fx_init()
  hw/i386: extract i440fx related declarations/definitions to i440fx.h
  hw/i386: extract i440fx code from piix.c into i440fx.c
  hw/i386: move piix from hw/pci-host to hw/southbridge
  configs/mips-softmmu: use common CONFIG_PCI_PIIX instead of CONFIG_PIIX4
  piix3: convert reset function to QOM
  piix: merge common code from isa/piix4.c with southbridge piix3
  piix4: add isa_superio_init

 default-configs/i386-softmmu.mak        |   1 +
 default-configs/mips-softmmu-common.mak |   2 +-
 default-configs/x86_64-softmmu.mak      |   1 +
 include/hw/acpi/piix4.h                 |   6 -
 include/hw/char/parallel.h              |  14 +
 include/hw/{isa => dma}/i8257.h         |   6 +
 include/hw/i386/pc.h                    |  63 ----
 include/hw/input/i8042.h                |  25 ++
 include/hw/irq.h                        |   5 -
 include/hw/isa/isa.h                    |   2 -
 include/hw/isa/superio.h                |  17 +
 include/hw/pci-host/i440fx.h            |  51 +++
 include/hw/pci/pci_host.h               |   8 +
 include/hw/southbridge/i82371_piix.h    |  38 +++
 hw/acpi/ich9.c                          |   1 +
 hw/acpi/pcihp.c                         |   2 +-
 hw/acpi/piix4.c                         |   3 +-
 hw/alpha/dp264.c                        |   3 +-
 hw/char/parallel-isa.c                  |  29 ++
 hw/char/parallel.c                      |   2 +-
 hw/core/irq.c                           |  14 -
 hw/dma/i82374.c                         |   3 +-
 hw/dma/i8257.c                          |   4 +-
 hw/i386/acpi-build.c                    |   2 +-
 hw/i386/pc.c                            |  22 +-
 hw/i386/pc_piix.c                       |   2 +
 hw/i386/vmmouse.c                       |   1 +
 hw/i386/vmport.c                        |   1 +
 hw/input/pckbd.c                        |   2 +-
 hw/isa/isa-bus.c                        |  26 --
 hw/isa/isa-superio.c                    |  45 +++
 hw/isa/piix4.c                          | 146 --------
 hw/mips/gt64xxx_pci.c                   |   1 +
 hw/mips/mips_fulong2e.c                 |  12 +-
 hw/mips/mips_jazz.c                     |   5 +-
 hw/mips/mips_malta.c                    |  71 ++--
 hw/mips/mips_r4k.c                      |   3 +-
 hw/pci-host/{piix.c => i440fx.c}        | 409 +---------------------
 hw/ppc/prep.c                           |   5 +-
 hw/southbridge/piix.c                   | 586 ++++++++++++++++++++++++++++++++
 hw/sparc/sun4m.c                        |   4 -
 hw/sparc64/sun4u.c                      |   8 +-
 hw/timer/mc146818rtc.c                  |   6 +-
 hw/unicore32/puv3.c                     |   1 +
 stubs/pci-host-piix.c                   |   3 +-
 MAINTAINERS                             |  14 +-
 hw/Makefile.objs                        |   1 +
 hw/char/Makefile.objs                   |   1 +
 hw/isa/Makefile.objs                    |   2 +-
 hw/pci-host/Makefile.objs               |   2 +-
 hw/southbridge/Makefile.objs            |   1 +
 51 files changed, 923 insertions(+), 759 deletions(-)
 delete mode 100644 include/hw/acpi/piix4.h
 create mode 100644 include/hw/char/parallel.h
 rename include/hw/{isa => dma}/i8257.h (86%)
 create mode 100644 include/hw/input/i8042.h
 create mode 100644 include/hw/isa/superio.h
 create mode 100644 include/hw/pci-host/i440fx.h
 create mode 100644 include/hw/southbridge/i82371_piix.h
 create mode 100644 hw/char/parallel-isa.c
 create mode 100644 hw/isa/isa-superio.c
 delete mode 100644 hw/isa/piix4.c
 rename hw/pci-host/{piix.c => i440fx.c} (59%)
 create mode 100644 hw/southbridge/piix.c
 create mode 100644 hw/southbridge/Makefile.objs

-- 
2.15.1
