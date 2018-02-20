Received: from eggs.gnu.org ([2001:4830:134:3::10]:36479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrt-000543-Oj
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrr-0000TC-61
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:21 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 20 Feb 2018 18:41:48 +0000
Message-Id: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 00/11] macio: remove legacy macio_init()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This patchset eliminates the legacy macio_init() function used to setup the
ESCC and PIC memory regions and instead allows the macio device to be
instantiated directly via qdev, wiring up the ESCC internally using sysbus MMIO
memory regions and the PIC via QOM object links.

The biggest surprise in this patchset was the need to QOMify the heathrow
device which apparently up until now has never required any of these new-fangled
APIs from the last decade such as qdev and QOM.

There's still some follow-up work to do with the PCI host bridge wiring but it
seems to me that this is a good preparation step.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2:
- Rebase onto master
- Add R-B tags from David
- Rework patch 4 ("heathrow: convert to trace-events") as suggested by David


Mark Cave-Ayland (11):
  macio: embed DBDMA device directly within macio
  macio: move ESCC device within the macio device
  heathrow: QOMify heathrow PIC
  heathrow: convert to trace-events
  heathrow: change heathrow_pic_init() to return the heathrow device
  macio: move macio related structures and defines into separate macio.h
    file
  mac_oldworld: use object link to pass heathrow PIC object to macio
  openpic: move OpenPIC state and related definitions to openpic.h
  mac_newworld: use object link to pass OpenPIC object to macio
  macio: move setting of CUDA timebase frequency to
    macio_common_realize()
  macio: remove macio_init() function

 hw/intc/heathrow_pic.c         | 166 +++++++++++++++++++++--------------------
 hw/intc/openpic.c              | 157 --------------------------------------
 hw/intc/trace-events           |   5 ++
 hw/misc/macio/macio.c          | 150 +++++++++++++++++--------------------
 hw/ppc/mac.h                   |  10 +--
 hw/ppc/mac_newworld.c          |  56 +++++---------
 hw/ppc/mac_oldworld.c          |  50 +++++--------
 include/hw/intc/heathrow_pic.h |  49 ++++++++++++
 include/hw/misc/macio/macio.h  |  79 ++++++++++++++++++++
 include/hw/ppc/openpic.h       | 160 ++++++++++++++++++++++++++++++++++++++-
 10 files changed, 486 insertions(+), 396 deletions(-)
 create mode 100644 include/hw/intc/heathrow_pic.h
 create mode 100644 include/hw/misc/macio/macio.h

-- 
2.11.0
