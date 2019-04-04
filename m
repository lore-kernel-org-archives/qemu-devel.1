Received: from eggs.gnu.org ([209.51.188.92]:43525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3S8-000761-5q
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3S7-0003vP-3U
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:34:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hC3S6-0003j8-Mu
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:34:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x34EQaN6005698
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 10:34:43 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rnk2m2v2m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 10:34:42 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 4 Apr 2019 15:34:41 +0100
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  4 Apr 2019 10:34:19 -0400
Message-Id: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v6 00/16] s390: vfio-ccw dasd ipl support
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

Changelog
==========
v6
- Added patch #16 to fix regression whereby we attempted to boot from console
  devices when no default boot device was specified.
- Bug fix: Referencing a byte past end of sense data status array
- Reorganized patch order slightly
- Other misc wording/spelling fixups

Jason J. Herne (16):
  s390 vfio-ccw: Add bootindex property and IPLB data
  s390-bios: decouple cio setup from virtio
  s390-bios: decouple common boot logic from virtio
  s390-bios: Clean up cio.h
  s390-bios: Decouple channel i/o logic from virtio
  s390-bios: Map low core memory
  s390-bios: ptr2u32 and u32toptr
  s390-bios: Support for running format-0/1 channel programs
  s390-bios: cio error handling
  s390-bios: Extend find_dev() for non-virtio devices
  s390-bios: Factor finding boot device out of virtio code path
  s390-bios: Refactor virtio to run channel programs via cio
  s390-bios: Use control unit type to determine boot method
  s390-bios: Add channel command codes/structs needed for dasd-ipl
  s390-bios: Support booting from real dasd device
  s390-bios: Use control unit type to find bootable devices

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
 pc-bios/s390-ccw/dasd-ipl.c  | 235 ++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h  |  16 ++
 pc-bios/s390-ccw/helper.h    |  31 ++++
 pc-bios/s390-ccw/libc.h      |  11 ++
 pc-bios/s390-ccw/main.c      | 185 +++++++++++++------
 pc-bios/s390-ccw/netboot.mak |   2 +-
 pc-bios/s390-ccw/netmain.c   |   2 +
 pc-bios/s390-ccw/s390-arch.h | 103 +++++++++++
 pc-bios/s390-ccw/s390-ccw.h  |  10 +-
 pc-bios/s390-ccw/start.S     |  29 +++
 pc-bios/s390-ccw/virtio.c    |  81 +++------
 tests/boot-serial-test.c     |   2 +-
 22 files changed, 1438 insertions(+), 200 deletions(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 include/hw/s390x/vfio-ccw.h
 create mode 100644 pc-bios/s390-ccw/cio.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
 create mode 100644 pc-bios/s390-ccw/helper.h
 create mode 100644 pc-bios/s390-ccw/s390-arch.h

--
2.7.4
