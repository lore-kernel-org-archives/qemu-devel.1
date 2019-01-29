Received: from eggs.gnu.org ([209.51.188.92]:60424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSm-0000GL-OP
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSl-0000U7-LN
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goTSl-0008T0-BE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:03 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDT60q072900
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:33 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qapyttvck-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:32 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 13:29:26 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 08:29:07 -0500
Message-Id: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

This is to support booting from vfio-ccw dasd devices. We basically implement
the real hardware ipl procedure. This allows for booting Linux guests on
vfio-ccw devices.

vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
channel programs dynamically modify themselves. Details on the ipl process and
how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.

This version brings better error handling, namely retrying I/O operations in the
event of some transient failure conditions. I've also renamed the sense data
structures and error output to indicate that they are for eckd dasd only. A few
other fixups as well, see changelog for details.

Changelog
==========
v2
---------
01/15: s390 vfio-ccw: Add bootindex property and IPLB data
- Remove accidental changes to roms/SLOF
- Fix bad include in hw/vfio/ccw.c
- ipl.c: Rename vc to vfio_ccw_dev

10/15: s390-bios: Support for running format-0/1 channel programs
- cio.c: Retry ssch on cc=1 or interface-control-check status
- cio.c: SLI now used instead of special code in irb_error
- Rename CU_TYPE_DASD to CU_TYPE_DASD_3990
- Rename dasd sense data structures and constants
- cio.c: Fix comment typos

11/15: s390-bios: cio error handling
- - Rename dasd sense data structures and constants

12/15: s390-bios: Refactor virtio to run channel programs via cio
- Use SLI for Sense ID ccws.

rfc -> v1
---------
- Retry start subchannel operations on unexpected unit check status
- Print more complete state information on i/o error
- Fixed asm constraints (Q -> QS)
- Align lowcore to 8k boundary
- Initialize next_cpa in run_dynamic_ccw_program to avoid compiler warning
- Cleanup: Rework handling of i/o interrupts in assembler
- Fix netboot image (include cio.o in make file)
- Misc cleanups

Jason J. Herne (15):
  s390 vfio-ccw: Add bootindex property and IPLB data
  s390-bios: decouple cio setup from virtio
  s390-bios: decouple common boot logic from virtio
  s390-bios: Extend find_dev() for non-virtio devices
  s390-bios: Factor finding boot device out of virtio code path
  s390-bios: Clean up cio.h
  s390-bios: Decouple channel i/o logic from virtio
  s390-bios: Map low core memory
  s390-bios: ptr2u32 and u32toptr
  s390-bios: Support for running format-0/1 channel programs
  s390-bios: cio error handling
  s390-bios: Refactor virtio to run channel programs via cio
  s390-bios: Use control unit type to determine boot method
  s390-bios: Add channel command codes/structs needed for dasd-ipl
  s390-bios: Support booting from real dasd device

 docs/devel/s390-dasd-ipl.txt     | 132 ++++++++++++++
 hw/s390x/ipl.c                   |  14 ++
 hw/s390x/s390-ccw.c              |   9 +
 hw/vfio/ccw.c                    |  13 +-
 include/hw/s390x/s390-ccw.h      |   1 +
 include/hw/s390x/vfio-ccw.h      |  38 ++++
 pc-bios/s390-ccw/Makefile        |   2 +-
 pc-bios/s390-ccw/cio.c           | 380 +++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h           | 239 +++++++++++++++++++-----
 pc-bios/s390-ccw/dasd-ipl.c      | 249 +++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h      |  16 ++
 pc-bios/s390-ccw/libc.h          |  23 +++
 pc-bios/s390-ccw/main.c          | 161 +++++++++++------
 pc-bios/s390-ccw/netboot.mak     |   2 +-
 pc-bios/s390-ccw/netmain.c       |   1 +
 pc-bios/s390-ccw/s390-arch.h     | 113 ++++++++++++
 pc-bios/s390-ccw/s390-ccw.h      |  10 +-
 pc-bios/s390-ccw/start.S         |  33 +++-
 pc-bios/s390-ccw/virtio-blkdev.c |   1 +
 pc-bios/s390-ccw/virtio.c        |  73 +++-----
 tests/boot-serial-test.c         |   2 +-
 21 files changed, 1332 insertions(+), 180 deletions(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 include/hw/s390x/vfio-ccw.h
 create mode 100644 pc-bios/s390-ccw/cio.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
 create mode 100644 pc-bios/s390-ccw/s390-arch.h

--
2.7.4
