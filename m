Received: from eggs.gnu.org ([2001:4830:134:3::10]:41404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxnIn-0008Eo-D1
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxnIi-0008OI-C3
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:58:01 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  6 Sep 2018 06:57:33 +0100
Message-Id: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/3] scsi: remove lsi53c895a_create() and
 lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

As part of an upcoming 40p patchset I have a requirement to change the PCI
configuration of the LSI SCSI. However since commits a64aa5785d "hw: Deprecate -drive
if=scsi with non-onboard HBAs" and b891538e81 "hw/ppc/prep: Fix implicit creation of
"-drive if=scsi", the lsi53c8*_create() wrapper functions don't return the device
state itself.

Rather than altering these functions to return PCIDevice I simply went ahead and split
the LSIState structure and QOM types into a new lsi53c895a.h file, as is fairly
standard QEMU practice.

Not only does this enable me to change the PCI configuration of the LSI SCSI device
in an upcoming patchset, but it also allows full access to LSIState if required
(which is fairly similar to how the code was arranged before a64aa5785d).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (3):
  scsi: move lsi53c895a structures and defines into separate
    lsi53c895a.h file
  scsi: move lsi53c895a_create() and lsi53c810_create() callers to
    pci_create_simple()
  scsi: remove unused lsi53c895a_create() and lsi53c810_create()
    functions

 hw/arm/realview.c            |   5 +-
 hw/arm/versatilepb.c         |   5 +-
 hw/hppa/machine.c            |   5 +-
 hw/ppc/prep.c                |   6 +-
 hw/scsi/lsi53c895a.c         | 130 +---------------------------------------
 include/hw/pci/pci.h         |   3 -
 include/hw/scsi/lsi53c895a.h | 137 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 155 insertions(+), 136 deletions(-)
 create mode 100644 include/hw/scsi/lsi53c895a.h

-- 
2.11.0
