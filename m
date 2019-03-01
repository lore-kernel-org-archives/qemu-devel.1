Received: from eggs.gnu.org ([209.51.188.92]:53737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznR6-0008Vc-IQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznR4-0007sI-77
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:03:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45462
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gznQy-0007jE-H4
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:03:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21J2YuJ172832
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 14:02:58 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qy88vnv64-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 14:02:04 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 1 Mar 2019 18:59:42 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri,  1 Mar 2019 13:59:20 -0500
Message-Id: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 00/16] s390: vfio-ccw dasd ipl support
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

Note to Connie: In the v2 review you mentioned some issues with the error
handling code involving printing of the eckd dasd sense data. I've addressed
those concerns in a new patch just to make those changes clearly stand out from
the rest of the code. I can squash them into patches 10, 11, and 15 if you
prefer that to having it as a separate patch.

Changelog
==========
v3
01/16: s390 vfio-ccw: Add bootindex property and IPLB data
- Refactored s390_get_ccw_device() to return device type
- Made VFIOCCWDevice private
- Fixed copyright date
- ipl.c: Remove unneeded cast
- Add new file to maintainers

05/16: s390-bios: Factor finding boot device out of virtio code path
- main.c: Remove redundant condition from assert statement

06/16: s390-bios: Clean up cio.h
- Switch formating of bit fields to make checkpatch happy

07/16: s390-bios: Decouple channel i/o logic from virtio
- Fixed copyright statement
- Remove unneeded include in virtio-blkdev.c

08/16: s390-bios: Map low core memory
- Removed packed attribute from psw structs, added static size asserts
- Fix copyright date

09/16: s390-bios: ptr2u32 and u32toptr
- Move new functions out of stdlib.h and into helper.h

10/16: s390-bios: Support for running format-0/1 channel programs
- Rework do_cio (create __do_cio) to avoid possible infinite recursion in error
  cases.
- Switch formating of bit fields to make checkpatch happy
- cio.c: Include helper.c for new pointer conversion functions
- cio.c: Rename sense_data_eckd_dasd to SenseDataEckdDasd

11/16: s390-bios: cio error handling
- Only print dasd sense data if we have a dasd device, or on initial query of
  control unit type
- Fixed ccw casting

12/16: s390-bios: Refactor virtio to run channel programs via cio
- Include helper.c for new pointer conversion functions

15/16: s390-bios: Support booting from real dasd device
- dasd-ipl.c: Fix sizeof's
- s390-dasd-ipl.c: Fix section "How this all pertains to QEMU" to detail
  vfio-ccw driver's role.
- s390-dasd-ipl.c: Replace all instances of Qemu with QEMU
- Added docs/devel/s390-dasd-ipl.txt to MAINTAINERS
- s390-dasd-ipl.c: Include helper.c for new pointer conversion functions

Jason J. Herne (16):
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
  s390-bios: dasd-ipl: Use control unit type to customize error data

 MAINTAINERS                  |   2 +
 docs/devel/s390-dasd-ipl.txt | 133 ++++++++++++++
 hw/s390x/ipl.c               |  39 +++-
 hw/s390x/s390-ccw.c          |   9 +
 hw/vfio/ccw.c                |   2 +-
 include/hw/s390x/s390-ccw.h  |   1 +
 include/hw/s390x/vfio-ccw.h  |  28 +++
 pc-bios/s390-ccw/Makefile    |   2 +-
 pc-bios/s390-ccw/cio.c       | 418 +++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h       | 307 +++++++++++++++++++++++--------
 pc-bios/s390-ccw/dasd-ipl.c  | 250 ++++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h  |  16 ++
 pc-bios/s390-ccw/helper.h    |  16 ++
 pc-bios/s390-ccw/libc.h      |  11 ++
 pc-bios/s390-ccw/main.c      | 159 ++++++++++------
 pc-bios/s390-ccw/netboot.mak |   2 +-
 pc-bios/s390-ccw/netmain.c   |   1 +
 pc-bios/s390-ccw/s390-arch.h | 115 ++++++++++++
 pc-bios/s390-ccw/s390-ccw.h  |  10 +-
 pc-bios/s390-ccw/start.S     |  31 ++++
 pc-bios/s390-ccw/virtio.c    |  74 +++-----
 tests/boot-serial-test.c     |   2 +-
 22 files changed, 1422 insertions(+), 206 deletions(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 include/hw/s390x/vfio-ccw.h
 create mode 100644 pc-bios/s390-ccw/cio.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
 create mode 100644 pc-bios/s390-ccw/helper.h
 create mode 100644 pc-bios/s390-ccw/s390-arch.h

--
2.7.4
