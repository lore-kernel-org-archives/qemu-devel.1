Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVbF7-0006Qk-Ij
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVbF6-0003sP-ND
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:48:53 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 23 Jan 2017 10:48:37 +0100
Message-Id: <1485164923-17736-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] More sensible default for -drive interface
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

Block backends defined with -drive if=T, T!=none are meant to be
picked up by machine initialization code: a suitable frontend gets
created and wired up automatically.

if=T drives not picked up that way can still be used with -device as
if they had if=none, but that's unclean and best avoided.  Unused ones
produce an "Orphaned drive without device" warning.

Many machine types default to if=ide, even though they don't actually
have an IDE controller.  A few default to if=scsi, even though they
lack a SCSI HBA.  Change their default to if=none.

While their, fix handling of index and unit for a few boards with AHCI
controllers, and stop auto-creating the thoroughly obsolete lsi SCSI
HBAs for new PC machine types.

Markus Armbruster (6):
  hw: Default -drive to if=ide explicitly where it works
  hw/arm/cubieboard hw/arm/xlnx-ep108: Fix units_per_default_bus
  hw: Default -drive to if=none instead of ide when ide cannot work
  hw: Default -drive to if=none instead of scsi when scsi cannot work
  hw/arm/highbank: Default -drive to if=ide instead of if=scsi
  hw/i386/i386: Stop auto-creating lsi53c895a SCSI HBAs

 hw/alpha/dp264.c          |  1 +
 hw/arm/cubieboard.c       |  4 ++++
 hw/arm/highbank.c         |  8 ++++++--
 hw/arm/realview.c         |  1 -
 hw/arm/spitz.c            |  3 +++
 hw/arm/tosa.c             |  1 +
 hw/arm/vexpress.c         |  1 -
 hw/arm/xilinx_zynq.c      |  1 -
 hw/arm/xlnx-ep108.c       |  6 ++++++
 hw/i386/pc.c              |  1 +
 hw/i386/pc_piix.c         | 15 ++++++++++++++-
 hw/i386/pc_q35.c          |  7 ++++++-
 hw/mips/mips_fulong2e.c   |  1 +
 hw/mips/mips_malta.c      |  1 +
 hw/mips/mips_r4k.c        |  1 +
 hw/ppc/mac_newworld.c     |  1 +
 hw/ppc/mac_oldworld.c     |  1 +
 hw/ppc/prep.c             |  1 +
 hw/sh4/r2d.c              |  1 +
 hw/sparc64/sun4u.c        |  2 ++
 include/hw/i386/pc.h      |  3 +++
 include/sysemu/blockdev.h |  9 ++++-----
 22 files changed, 58 insertions(+), 12 deletions(-)

-- 
2.7.4
