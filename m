Received: from eggs.gnu.org ([2001:4830:134:3::10]:46690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1epFVj-000160-Ms
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1epFVg-0007Q8-Hx
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:43:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50746
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1epFVg-0007Op-Ch
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:43:44 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NFdrVT073171
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:43:43 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gam3kn6ux-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:43:42 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 10:43:41 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 10:43:06 -0500
Message-Id: <1519400599-21081-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v9 00/13] Interactive Boot Menu for DASD and
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
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

--- [v9] ---

 - only set boot menu opts if a bootindex was specified on cmd

 - Menus for guests with an IPL device that chooses to use the SCSI scheme are
   only enabled explicitly for -boot menu=on options (i.e. it will appropriately
   and cleanly ignore the zipl flag)

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

Collin L. Walling (13):
  s390-ccw: refactor boot map table code
  s390-ccw: refactor eckd_block_num to use CHS
  s390-ccw: refactor IPL structs
  s390-ccw: update libc
  s390-ccw: move auxiliary IPL data to separate location
  s390-ccw: parse and set boot menu options
  s390-ccw: set up interactive boot menu parameters
  s390-ccw: read stage2 boot loader data to find menu
  s390-ccw: print zipl boot menu
  s390-ccw: read user input for boot index via the SCLP console
  s390-ccw: set cp_receive mask only when needed and consume pending
    service irqs
  s390-ccw: use zipl values when no boot menu options are present
  s390-ccw: interactive boot menu for scsi

 hw/s390x/ipl.c              |  76 +++++++++++++-
 hw/s390x/ipl.h              |  31 +++++-
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  | 184 +++++++++++++++++++++++---------
 pc-bios/s390-ccw/bootmap.h  |  91 ++++++++++------
 pc-bios/s390-ccw/iplb.h     |  24 ++++-
 pc-bios/s390-ccw/libc.c     |  88 ++++++++++++++++
 pc-bios/s390-ccw/libc.h     |  37 ++++++-
 pc-bios/s390-ccw/main.c     |  49 ++++++---
 pc-bios/s390-ccw/menu.c     | 249 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |  10 ++
 pc-bios/s390-ccw/sclp.c     |  39 ++++---
 pc-bios/s390-ccw/virtio.c   |   2 +-
 13 files changed, 756 insertions(+), 126 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.c
 create mode 100644 pc-bios/s390-ccw/menu.c

-- 
2.7.4
