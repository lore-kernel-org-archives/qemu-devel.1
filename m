Received: from eggs.gnu.org ([2001:4830:134:3::10]:53582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3I2-0003p6-VO
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3Hz-0006MA-R0
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32968
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ee3Hz-0006Lh-LX
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NIPL3f136989
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:17 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fp7dg0y1y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:16 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 11:27:16 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 13:26:43 -0500
Message-Id: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 00/10] Interactive Boot Menu for DASD and
 SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

--- [v4] ---

This round mostly includes some general cleanup to bootmap.c. Checkpatch did 
not like any variation of "strtoi", so I properly implemented atoi instead.

  - itostr and atoi now handle negative numbers (though not necessary 
      for these patches, it is available for robustness)
  - refactored boot map code to use c/h/s struct
  - refactored boot map code to use BootMapTable struct (not a critical change)
  - fixed commit messages for eckd dasd boot menu patches
  - clock comparator is set using timeout * TOD_CLOCK_SECOND instead
  - general cleanup based on feedback from v3
  - note: added extra info to cover letter summary about bootindex option

--- [Summary] ---

These patches implement a boot menu for ECKD DASD and SCSI guests on s390x. 
The menu will only appear if the disk has been configured for IPL with the 
zIPL tool and with the following QEMU command line options:

    -boot menu=on[,splash-time=X] and/or -machine loadparm='prompt'

The following must be specified for the device to be IPL'd from:

    -device ...,bootindex=1

or via the following libvirt domain xml:

    <os>
      <bootmenu enable='yes' timeout='X'/>
    </os>

    or
	
    <disk>
      ...
      <boot order='1' loadparm='PROMPT'/>
    </disk>

Where X is some positive integer representing time in milliseconds.

<boot order='1' ... > must be specified for the device to be IPL'd from

A loadparm other than 'prompt' will disable the menu and just boot 
the specified entry.

If no boot options are specified, we will attempt to use the values
provided by zipl (ECKD DASD only).

Collin L. Walling (10):
  s390-ccw: refactor boot map table code
  s390-ccw: refactor eckd_block_num to use CHS
  s390-ccw: refactor IPL structs
  s390-ccw: update libc
  s390-ccw: parse and set boot menu options
  s390-ccw: set up interactive boot menu parameters
  s390-ccw: read stage2 boot loader data to find menu
  s390-ccw: print zipl boot menu
  s390-ccw: read user input for boot index via the SCLP console
  s390-ccw: interactive boot menu for scsi

 hw/s390x/ipl.c              |  55 ++++++++++
 hw/s390x/ipl.h              |  11 +-
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  | 183 +++++++++++++++++++++++----------
 pc-bios/s390-ccw/bootmap.h  |  89 +++++++++-------
 pc-bios/s390-ccw/iplb.h     |  11 +-
 pc-bios/s390-ccw/libc.c     | 116 +++++++++++++++++++++
 pc-bios/s390-ccw/libc.h     |  35 ++++++-
 pc-bios/s390-ccw/main.c     |  41 +++++---
 pc-bios/s390-ccw/menu.c     | 240 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h     |  25 +++++
 pc-bios/s390-ccw/s390-ccw.h |   2 +
 pc-bios/s390-ccw/sclp.c     |  30 ++++--
 pc-bios/s390-ccw/virtio.c   |   2 +-
 14 files changed, 722 insertions(+), 120 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.c
 create mode 100644 pc-bios/s390-ccw/menu.c
 create mode 100644 pc-bios/s390-ccw/menu.h

-- 
2.7.4
