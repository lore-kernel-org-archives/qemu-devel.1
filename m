Received: from eggs.gnu.org ([2001:4830:134:3::10]:58648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlgZ-0006dz-Q9
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlgY-0004uf-I2
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:10:03 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Jan 2017 16:09:40 +0100
Message-Id: <1485443388-27253-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/8] More sensible default for -drive
 interface type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Block backends defined with -drive if=3DT, T!=3Dnone are meant to be
picked up by machine initialization code: a suitable frontend gets
created and wired up automatically.

if=3DT drives not picked up that way can still be used with -device as
if they had if=3Dnone, but that's unclean and best avoided.  Unused ones
produce an "Orphaned drive without device" warning.

Many machine types default to if=3Dide, even though they don't actually
have an IDE controller.  A few default to if=3Dscsi, even though they
lack a SCSI HBA.  Change their default to if=3Dnone.

While their, fix handling of index and unit for a few machines with
AHCI controllers.

With the improved default, unintentional definition of orphaned drives
should be unlikely.  Improve the "orphaned drive" warning and turn it
into an error.  Drop a few special cases of this error that are now
redundant.

v2:
* PATCH v1 6/6 dropped; if=3Dscsi eccentricities will be addressed in a
  series of its own
* PATCH 6-8 new

Markus Armbruster (8):
  hw: Default -drive to if=3Dide explicitly where it works
  hw/arm/cubieboard hw/arm/xlnx-ep108: Fix units_per_default_bus
  hw: Default -drive to if=3Dnone instead of ide when ide cannot work
  hw: Default -drive to if=3Dnone instead of scsi when scsi cannot work
  hw/arm/highbank: Default -drive to if=3Dide instead of if=3Dscsi
  blockdev: Improve message for orphaned -drive
  blockdev: Make orphaned -drive fatal
  hw: Drop superfluous special checks for orphaned -drive

 blockdev.c                | 21 +++++++++++----------
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
 hw/ide/core.c             | 17 -----------------
 hw/mips/mips_fulong2e.c   |  1 +
 hw/mips/mips_jazz.c       |  4 ----
 hw/mips/mips_malta.c      |  1 +
 hw/mips/mips_r4k.c        |  1 +
 hw/ppc/mac_newworld.c     |  1 +
 hw/ppc/mac_oldworld.c     |  1 +
 hw/ppc/prep.c             |  1 +
 hw/sh4/r2d.c              |  1 +
 hw/sparc/sun4m.c          |  5 -----
 hw/sparc64/sun4u.c        |  2 ++
 include/sysemu/blockdev.h | 11 +++++------
 23 files changed, 47 insertions(+), 47 deletions(-)

--=20
2.7.4
