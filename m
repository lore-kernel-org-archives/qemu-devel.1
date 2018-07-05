Received: from eggs.gnu.org ([2001:4830:134:3::10]:48407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb80u-000062-HO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb80r-00013u-CI
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52716
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb80r-00010y-6n
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNgsd034222
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:25:47 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1npswhaa-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:25:47 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:25:47 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:28 -0400
Message-Id: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

This is to support booting from vfio-ccw dasd devices. We basically implement
the real hardware ipl procedure. This allows for booting Linux guests on
vfio-ccw devices.

vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
channel programs dynamically modify themselves. Details on the ipl process and
how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.

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
  s390-bios: Refactor virtio to run channel programs via cio
  s390-bios: Use control unit type to determine boot method
  s390-bios: Add channel command codes/structs needed for dasd-ipl
  s390-bios: Support booting from real dasd device
  s390-bios: Use sense ccw to ensure consistent device state at boot
    time

 docs/devel/s390-dasd-ipl.txt     | 132 +++++++++++++++++++++
 hw/s390x/ipl.c                   |  15 +++
 hw/s390x/s390-ccw.c              |   9 ++
 hw/vfio/ccw.c                    |  13 +-
 hw/vfio/ccw.h                    |  38 ++++++
 include/hw/s390x/s390-ccw.h      |   1 +
 pc-bios/s390-ccw/Makefile        |   2 +-
 pc-bios/s390-ccw/cio.c           | 181 ++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h           | 150 ++++++++++++++++-------
 pc-bios/s390-ccw/dasd-ipl.c      | 249 +++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h      |  16 +++
 pc-bios/s390-ccw/libc.h          |  12 ++
 pc-bios/s390-ccw/main.c          | 162 ++++++++++++++++---------
 pc-bios/s390-ccw/netmain.c       |   1 +
 pc-bios/s390-ccw/s390-arch.h     | 113 ++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h      |   9 --
 pc-bios/s390-ccw/virtio-blkdev.c |   1 +
 pc-bios/s390-ccw/virtio.c        |  46 +-------
 18 files changed, 986 insertions(+), 164 deletions(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 hw/vfio/ccw.h
 create mode 100644 pc-bios/s390-ccw/cio.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
 create mode 100644 pc-bios/s390-ccw/s390-arch.h

-- 
2.7.4
