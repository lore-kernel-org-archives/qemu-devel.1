Received: from eggs.gnu.org ([2001:4830:134:3::10]:50957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRw6C-0003ay-5k
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRw69-0004Lu-Fb
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:04 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43098
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRw69-0004En-7z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:01 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 21 Dec 2017 08:20:29 +0000
Message-Id: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 00/16] sun4u: tidy-up CPU, APB and ebus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This patchset for 2.12 continues with tidying up the sun4u CPU, APB and
ebus devices by encapsulating the ebus ISA bus within the ebus QOM device,
allowing APB and ebus devices to be instantiated directly via QOM, and
formally wiring up the device IRQs using qdev GPIOs rather than passing
around arrays of qemu_irq via various _init() functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v3:
- Rebase onto master
- Split patch 11 into 2 patches, move busA configuration to pci_pbm_reset()
  (based upon further discussions with Artyom off-list)

v2:
- Rebase onto master
- Add R-Bs from Artyom/Phillipe
- Use ISA_NUM_IRQS for sizing ISA bus IRQ arrays
- Add more detail to busA comment in patch 11 as suggested by Artyom


Mark Cave-Ayland (16):
  apb: move QOM macros and typedefs from apb.c to apb.h
  sun4u: ebus QOMify tidy-up
  sun4u: move ISABus inside of EBusState
  sun4u: remove pci_ebus_init() function
  sun4u: move initialisation of all ISABus devices into ebus_realize()
  apb: APB QOMify tidy-up
  apb: return APBState from pci_apb_init() rather than PCIBus
  apb: use gpios to wire up the apb device to the SPARC CPU IRQs
  apb: move the two secondary PCI bridges objects into APBState
  apb: remove pci_apb_init() and instantiate APB device using qdev
  apb: split pci_pbm_map_irq() into separate functions for bus A and bus
    B
  apb: remove busA property from PBMPCIBridge state
  ebus: wire up OBIO interrupts to APB pbm via qdev GPIOs
  apb: replace OBIO interrupt numbers in pci_pbmA_map_irq() with
    constants
  sparc64: introduce trace-events for hw/sparc64
  sun4u: switch from EBUS_DPRINTF() macro to trace-events

 Makefile.objs              |   1 +
 hw/pci-host/apb.c          | 297 +++++++++++++++------------------------------
 hw/sparc64/sparc64.c       |   2 +
 hw/sparc64/sun4u.c         | 185 ++++++++++++++++------------
 hw/sparc64/trace-events    |   4 +
 include/hw/pci-host/apb.h  | 101 ++++++++++++++-
 include/hw/sparc/sparc64.h |   2 +
 7 files changed, 309 insertions(+), 283 deletions(-)
 create mode 100644 hw/sparc64/trace-events

-- 
2.11.0
