Received: from eggs.gnu.org ([2001:4830:134:3::10]:43262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emoAt-0006mm-L0
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emoAo-0005Jc-Ls
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58014
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emoAo-0005JI-GD
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:06 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GM6UDC086018
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:08:05 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g63hs149g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:08:04 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 17:08:04 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 17:07:47 -0500
Message-Id: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v7 00/12] Interactive Boot Menu for DASD and
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

Sorry for posting this version so close to the previous posting. The requested
changes are getting smaller and smaller and I'm hoping to get these patches
satisfactory soon.

--- [v7] ---

 - fixed alignment mistake in QemuIplParameters
 	- also added comment explaining this

 - fixed rebasing error with _strlen and _memcmp

 - dropped reserved2 field in ScsiMbr

 - r-b's and signoffs aded where suggested

--- [v6] ---

 - cleaned up libc.c

 - expanded timeout field in QemuIPLB from 2 bytes to 4 bytes
	- we can now store the timeout value from command line as ms

 - sclp_set_write_mask now accepts two parameters:
	- receive_mask
	- send_mask

 - the write mask for receive is only set when we need it (reading user inp)
	and cleared	when we no longer need it (no longer reading user inp)

 - pending irq code cleaned up

 - bootmap code for scsi fixed up -- it has the same limitations as DASD,
    so I added some similar checks in ipl_scsi

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


Collin L. Walling (12):
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
  s390-ccw: interactive boot menu for scsi

 hw/s390x/ipl.c              |  67 +++++++++++-
 hw/s390x/ipl.h              |  24 ++++-
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  | 184 +++++++++++++++++++++++----------
 pc-bios/s390-ccw/bootmap.h  |  91 ++++++++++-------
 pc-bios/s390-ccw/iplb.h     |  22 +++-
 pc-bios/s390-ccw/libc.c     |  89 ++++++++++++++++
 pc-bios/s390-ccw/libc.h     |  37 ++++++-
 pc-bios/s390-ccw/main.c     |  48 +++++----
 pc-bios/s390-ccw/menu.c     | 241 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h     |  25 +++++
 pc-bios/s390-ccw/s390-ccw.h |   3 +
 pc-bios/s390-ccw/sclp.c     |  39 ++++---
 pc-bios/s390-ccw/virtio.c   |   2 +-
 14 files changed, 748 insertions(+), 126 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.c
 create mode 100644 pc-bios/s390-ccw/menu.c
 create mode 100644 pc-bios/s390-ccw/menu.h

-- 
2.7.4
