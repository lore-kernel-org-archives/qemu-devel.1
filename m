Received: from eggs.gnu.org ([2001:4830:134:3::10]:39179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg4-0000CK-3a
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg3-0006EV-5C
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:28 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:38271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eUvg2-00063q-Qo
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:27 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Fri, 29 Dec 2017 15:29:06 +0100
Message-Id: <20171229142922.31701-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/16] piix4: cleanup and improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Hi,

This patchset is a cleanup of the PIIX4 PCI-ISA bridge. Lots of devices
are moved from MIPS Malta board (which has a PIIX4) to PIIX4, where devices
belong. This lets us reuse PIIX4 in other machines, while not loosing any
functionality.

Last patch allows adding a new PIIX4 device directly from command line.
Note that this will work only as long no other ISA bus already exist on the
machine.

Hervé

Changes v2 -> v3:
- rebased on master and fixed conflicts
- added patch 14 (convert reset function to QOM)
- use TYPE_PIIX4_PCI_DEVICE in Malta board (patch 15, Philippe Mathieu-Daudé)

Changes v1 -> v2:
- fixed compilation on CentOS 6 (patch 1)
- automatically create serial/parallel chardevs if not provided (patch 11)

Hervé Poussineau (16):
  fdc: move object structures to header file
  serial/parallel: move object structures to header file
  mc146818rtc: move structure to header file
  mc146818rtc: always register rtc to rtc list
  piix4: rename some variables in realize function
  piix4: add Reset Control Register
  piix4: add a i8259 interrupt controller as specified in datasheet
  piix4: add a i8257 dma controller as specified in datasheet
  piix4: add a i8254 pit controller as specified in datasheet
  piix4: add a i8042 keyboard/mouse controller as specified in datasheet
  piix4: add a floppy controller, 1 parallel port and 2 serial ports
  piix4: add a mc146818rtc controller as specified in datasheet
  piix4: add a speaker as specified in datasheet
  piix4: convert reset function to QOM
  piix4: rename PIIX4 object to piix4-isa
  piix4: we can now instanciate a PIIX4 with -device

 hw/block/fdc.c                 | 102 -----------------------
 hw/char/parallel.c             |  31 +------
 hw/char/serial-isa.c           |  13 +--
 hw/isa/piix4.c                 | 183 ++++++++++++++++++++++++++++++++++++-----
 hw/mips/mips_malta.c           |  74 +++++++----------
 hw/ppc/pnv.c                   |   2 +-
 hw/timer/mc146818rtc.c         |  43 ++--------
 include/hw/block/fdc.h         | 103 +++++++++++++++++++++++
 include/hw/char/isa.h          |  50 +++++++++++
 include/hw/char/serial.h       |   1 -
 include/hw/i386/pc.h           |   1 -
 include/hw/isa/isa.h           |   3 +
 include/hw/timer/mc146818rtc.h |  29 +++++++
 13 files changed, 389 insertions(+), 246 deletions(-)
 create mode 100644 include/hw/char/isa.h

-- 
2.11.0
