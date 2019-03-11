Received: from eggs.gnu.org ([209.51.188.92]:42215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h3Mwb-0005vi-Cp
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h3MkI-0006me-O8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:21:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h3MkI-0006iB-Bw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:21:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x2BFGbkx073441
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:21:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r5rh6p5c6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:21:40 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 11 Mar 2019 15:21:38 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Mon, 11 Mar 2019 11:21:18 -0400
Message-Id: <1552317693-21979-1-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

This is to support booting from vfio-ccw dasd devices. We basically implement
the real hardware ipl procedure. This allows for booting Linux guests on
vfio-ccw devices.

vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
channel programs dynamically modify themselves. Details on the ipl process and
how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.

*********************
NOTE: Newer DASD units which initially present as control unit type 3990 may in
fact really be 2107. Some operating systems may enable 2107 features for these
devices thereby making sense id return a control unit type of 2107. I've added
support for control unit type 2107 so we can ipl from these devices.
*********************

Changelog
==========
v4
01/16: s390 vfio-ccw: Add bootindex property and IPLB data
- Adding CCW_DEVTYPE_VIRTIO_NET type.
- s390_get_ccw_device can now accept a NULL devtype argument
- Other minor refactors

06/16: s390-bios: Clean up cio.h
- Remove whitespace changes to cmd_orb struct

07/16: s390-bios: Decouple channel i/o logic from virtio
- Fix copyright line

08/16: s390-bios: Map low core memory
- Remove Lowcore entries >= 0x200
- Repositioned const keywords

09/16: s390-bios: ptr2u32 and u32toptr
- Add assert to ensure pointer being converted to u32 is below 32 bits in length
- Add missing copyright comment

10/16: s390-bios: Support for running format-0/1 channel programs
- basic_sense now calls __do_cio instead of do_cio. Further protection from
  infinite recursion.
- __do_cio now asks for retry for subchannel busy case.
- Minor fixups to comments and message wording
- start.S: Formating and register naming cleanups
- Added CU_TYPE_DASD_2107

11/16: s390-bios: cio error handling
- Only print sense data when it is provided

15/16:
- Added support for CU_TYPE_DASD_2107

16/16:
- Merged with various earlier patches

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

 MAINTAINERS                  |   2 +
 docs/devel/s390-dasd-ipl.txt | 133 ++++++++++++++
 hw/s390x/ipl.c               |  61 +++++--
 hw/s390x/s390-ccw.c          |   9 +
 hw/vfio/ccw.c                |   2 +-
 include/hw/s390x/s390-ccw.h  |   1 +
 include/hw/s390x/vfio-ccw.h  |  28 +++
 pc-bios/s390-ccw/Makefile    |   2 +-
 pc-bios/s390-ccw/cio.c       | 423 +++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h       | 270 +++++++++++++++++++++------
 pc-bios/s390-ccw/dasd-ipl.c  | 250 +++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h  |  16 ++
 pc-bios/s390-ccw/helper.h    |  31 ++++
 pc-bios/s390-ccw/libc.h      |  11 ++
 pc-bios/s390-ccw/main.c      | 161 ++++++++++------
 pc-bios/s390-ccw/netboot.mak |   2 +-
 pc-bios/s390-ccw/netmain.c   |   2 +
 pc-bios/s390-ccw/s390-arch.h | 103 +++++++++++
 pc-bios/s390-ccw/s390-ccw.h  |  10 +-
 pc-bios/s390-ccw/start.S     |  29 +++
 pc-bios/s390-ccw/virtio.c    |  73 ++------
 tests/boot-serial-test.c     |   2 +-
 22 files changed, 1425 insertions(+), 196 deletions(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 include/hw/s390x/vfio-ccw.h
 create mode 100644 pc-bios/s390-ccw/cio.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
 create mode 100644 pc-bios/s390-ccw/helper.h
 create mode 100644 pc-bios/s390-ccw/s390-arch.h

--
2.7.4
