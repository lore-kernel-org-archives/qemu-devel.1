Received: from eggs.gnu.org ([2001:4830:134:3::10]:56201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Cc-0006iR-P2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4CZ-0003oO-Km
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:39:58 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4CZ-0003o2-Af
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:39:55 -0500
Received: by mail-wr0-x22c.google.com with SMTP id v18so7255257wrv.0
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 14:39:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:21 +0100
Message-Id: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/25] remove i386/pc dependency: generic
 SuperIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@mips.com>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Hi Paolo, Michael, Hervé and Yongbok.

This series could be the 'part 2' of my previous "remove i386/pc dependency
from non-PC world" I started around 2.9.

The goal is to unify the Super I/O device pattern.

In this rewrite I:
- extract the common SuperIO code from pc87312.c
- use it in few MIPS boards
- as example, easily add a new SuperIO chipset (SMC37C669) to the DP264 machine.

The SMC37C669 is very easily modeled and understandable in the "Add the SMC
FDC37C669 Super I/O" patch. Once used by the DP264 machine, the machine direcly
inherits of the parallel port and two floppy drives without any effort in the
machine code (therefore, easier to qtest and maintain).
The emphasis of the differences is show in the link [2].

Since RFC v2:
- fixed missing .class_size of abstract class in "Add a Super I/O template"
- fixed ptrdiff_t Werror=format string (patchew)
- fixed incorrect/missing MAINTAINERS entries
- only use "discarded-" in device name when no backend provided
- added R-b tags (David Gibson)

tested on:
- Q35
- alpha DP264 [1], [2]
- mips Malta
- mips Fuloong (only monitor, no image to test) [3]
- PReP (only monitor, no image to test)

Paolo: I tested the series and think it is ready to go and shouldn't break
upstream, but I'd like more testing for the Fuloong/PReP machines and
eventually an Ack-by from Michael S. Tsirkin since his area is well touched
by this series.

diff between master and this series here replied to previous thread there:
[1] http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg02510.html
[2] http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg02516.html
[3] http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg02515.html

Since RFC v1:
- complete rewrite, split out the PIIX devices for another series

More devices are being converted but I'm running out of time for the soft
freeze (mips_r4k, hppa_dino, and the PC ones).

Regards,

Phil.

$ git backport-diff -u rfc_v2
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/25:[----] [--] 'hw/isa: Move parallel_hds_isa_init() to hw/char/parallel-isa.c'
002/25:[----] [--] 'hw/dma/i8257: Rename DMA_init() to i8257_dma_init()'
003/25:[----] [--] 'hw/input/i8042: Extract declarations from i386/pc.h into input/i8042.h'
004/25:[down] 'MAINTAINERS: Fix the PC87312 include path'
005/25:[----] [--] 'hw/isa/pc87312: Rename the device type as TYPE_PC87312_SUPERIO'
006/25:[----] [--] 'hw/isa/pc87312: Use uint16_t for the ISA I/O base address'
007/25:[----] [--] 'hw/isa/pc87312: Use 'unsigned int' for the irq value'
008/25:[0003] [FC] 'hw/isa/superio: Add a Super I/O template based on the PC87312 device'
009/25:[----] [--] 'hw/isa/pc87312: Inherit from the abstract TYPE_ISA_SUPERIO'
010/25:[0006] [FC] 'hw/isa/superio: Factor out the parallel code from pc87312.c'
011/25:[0006] [FC] 'hw/isa/superio: Factor out the serial code from pc87312.c'
012/25:[----] [--] 'hw/isa/superio: Factor out the floppy disc controller code from pc87312.c'
013/25:[----] [--] 'hw/isa/superio: Add a keyboard/mouse controller (8042)'
014/25:[----] [--] 'hw/isa/superio: Factor out the IDE code from pc87312.c'
015/25:[----] [--] 'hw/mips/malta: Code movement'
016/25:[0001] [FC] 'hw/isa/superio: Factor out the FDC37M817 Super I/O from mips_malta.c'
017/25:[----] [--] 'hw/mips/mips_fulong2e: Factor out vt82c686b_southbridge_init()'
018/25:[----] [--] 'hw/isa/vt82c686: Rename vt82c686b_init() -> vt82c686b_isa_init()'
019/25:[----] [--] 'hw/isa/vt82c686: Add the TYPE_VT82C686B_SUPERIO'
020/25:[down] 'MAINTAINERS: Add entries for the VT82C686B Super I/O'
021/25:[down] 'MAINTAINERS: Split the Alpha TCG/machine section'
022/25:[0001] [FC] 'hw/isa/superio: Add the SMC FDC37C669 Super I/O'
023/25:[----] [--] 'hw/alpha/dp264: Add the ISA DMA controller'
024/25:[----] [--] 'hw/alpha/dp264: Use the TYPE_SMC37C669_SUPERIO'
025/25:[----] [--] 'hw/i386/pc: Factor out the superio code'

Philippe Mathieu-Daudé (25):
  hw/isa: Move parallel_hds_isa_init() to hw/char/parallel-isa.c
  hw/dma/i8257: Rename DMA_init() to i8257_dma_init()
  hw/input/i8042: Extract declarations from i386/pc.h into input/i8042.h
  MAINTAINERS: Fix the PC87312 include path
  hw/isa/pc87312: Rename the device type as TYPE_PC87312_SUPERIO
  hw/isa/pc87312: Use uint16_t for the ISA I/O base address
  hw/isa/pc87312: Use 'unsigned int' for the irq value
  hw/isa/superio: Add a Super I/O template based on the PC87312 device
  hw/isa/pc87312: Inherit from the abstract TYPE_ISA_SUPERIO
  hw/isa/superio: Factor out the parallel code from pc87312.c
  hw/isa/superio: Factor out the serial code from pc87312.c
  hw/isa/superio: Factor out the floppy disc controller code from pc87312.c
  hw/isa/superio: Add a keyboard/mouse controller (8042)
  hw/isa/superio: Factor out the IDE code from pc87312.c
  hw/mips/malta: Code movement
  hw/isa/superio: Factor out the FDC37M817 Super I/O from mips_malta.c
  hw/mips/mips_fulong2e: Factor out vt82c686b_southbridge_init()
  hw/isa/vt82c686: Rename vt82c686b_init() -> vt82c686b_isa_init()
  hw/isa/vt82c686: Add the TYPE_VT82C686B_SUPERIO
  MAINTAINERS: Add entries for the VT82C686B Super I/O
  MAINTAINERS: Split the Alpha TCG/machine section
  hw/isa/superio: Add the SMC FDC37C669 Super I/O
  hw/alpha/dp264: Add the ISA DMA controller
  hw/alpha/dp264: Use the TYPE_SMC37C669_SUPERIO
  hw/i386/pc: Factor out the superio code

 default-configs/alpha-softmmu.mak |   5 +
 include/hw/char/parallel.h        |  14 +++
 include/hw/{isa => dma}/i8257.h   |   6 ++
 include/hw/i386/pc.h              |  17 ---
 include/hw/input/i8042.h          |  24 +++++
 include/hw/isa/isa.h              |   2 -
 include/hw/isa/pc87312.h          |  24 ++---
 include/hw/isa/superio.h          |  60 +++++++++++
 include/hw/isa/vt82c686.h         |   4 +-
 hw/alpha/dp264.c                  |  13 ++-
 hw/char/parallel-isa.c            |  36 +++++++
 hw/char/parallel.c                |   2 +-
 hw/dma/i82374.c                   |   3 +-
 hw/dma/i8257.c                    |   4 +-
 hw/i386/pc.c                      |  77 ++++++++------
 hw/i386/vmmouse.c                 |   1 +
 hw/i386/vmport.c                  |   1 +
 hw/input/pckbd.c                  |   2 +-
 hw/isa/isa-bus.c                  |  26 -----
 hw/isa/isa-superio.c              | 214 ++++++++++++++++++++++++++++++++++++++
 hw/isa/pc87312.c                  | 178 ++++++++++++++-----------------
 hw/isa/smc37c669-superio.c        | 115 ++++++++++++++++++++
 hw/isa/vt82c686.c                 |  22 +++-
 hw/mips/mips_fulong2e.c           |  85 +++++++--------
 hw/mips/mips_jazz.c               |   5 +-
 hw/mips/mips_malta.c              |  48 ++++-----
 hw/mips/mips_r4k.c                |   3 +-
 hw/ppc/prep.c                     |   6 +-
 hw/sparc/sun4m.c                  |   4 -
 hw/sparc64/sun4u.c                |   6 +-
 hw/unicore32/puv3.c               |   1 +
 MAINTAINERS                       |  20 +++-
 hw/char/Makefile.objs             |   1 +
 hw/isa/Makefile.objs              |   1 +
 hw/isa/trace-events               |  10 +-
 35 files changed, 737 insertions(+), 303 deletions(-)
 create mode 100644 include/hw/char/parallel.h
 rename include/hw/{isa => dma}/i8257.h (86%)
 create mode 100644 include/hw/input/i8042.h
 create mode 100644 include/hw/isa/superio.h
 create mode 100644 hw/char/parallel-isa.c
 create mode 100644 hw/isa/isa-superio.c
 create mode 100644 hw/isa/smc37c669-superio.c

-- 
2.16.2
