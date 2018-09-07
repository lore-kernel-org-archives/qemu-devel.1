Received: from eggs.gnu.org ([2001:4830:134:3::10]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyGK6-0000by-3e
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyGK2-0007UQ-RW
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:57:17 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Sep 2018 13:56:50 +0100
Message-Id: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 0/3] scsi: replace lsi53c895a_create() and
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

This patchset replaces the lsi53c895a_create() and lsi53c810_create() functions
with a single lsi53c8xx_handle_legacy_cmdline() function as suggested by Thomas,
which makes the caller responsible for initing the LSI SCSI device and hence
allowing it to be configured as required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2:
- Don't split LSIState into separate lsi53c895a.h header but instead use a new
  lsi53c8xx_handle_legacy_cmdline() function as suggested by Thomas


Mark Cave-Ayland (3):
  scsi: add lsi53c8xx_handle_legacy_cmdline() function
  scsi: move lsi53c8xx_create() callers to
    lsi53c8xx_handle_legacy_cmdline()
  scsi: remove unused lsi53c895a_create() and lsi53c810_create()
    functions

 hw/arm/realview.c    |  3 ++-
 hw/arm/versatilepb.c |  3 ++-
 hw/hppa/machine.c    |  4 +++-
 hw/ppc/prep.c        |  4 +++-
 hw/scsi/lsi53c895a.c | 11 ++---------
 include/hw/pci/pci.h |  3 +--
 6 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.11.0
