Received: from eggs.gnu.org ([2001:4830:134:3::10]:57279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sl-0004us-4Y
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7si-00020H-1W
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36496
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eb7sh-0001zr-SO
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:07 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FGdgmk141942
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:06 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fgupdvtvc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:05 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 09:45:04 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:44:17 -0500
Message-Id: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/8] Interactive Boot Menu for DASD and SCSI
 Guests on s390x
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

--- [v3] ---

In an effort to make review less overwhelming, I've split up the larger commit 
into 4 patches. It should be obvious how they all relate. This is for review 
purposes unless it makes sense to keep them this way.

Patch "read input" contains the original commit message.

bootmap.c

    In an effort to protect ourselves from the possible expansion of stage2 in
    the future, I've changed the way that we read stage2 (described below). This 
    took some experimentation to find a somewhat efficient and easiest-to-read 
    approach without having to start from the beginning.

      Previous Versions:
        - define a scratch space to be as large as the current stage2 size (3 blks)
        - load stage2 entirely in the defined space and parse it
        - con: if stage2 expands, we'd have to update the Qemu code to accomodate
            the new size (gross!)

      Now:
        - define a scratch space to be 4 blocks large (same size as "sec")
        - load stage2 one-block-at-a-time, and parse each individual block
        - if found, load the previous and next blocks (if possible)
        - pro: we will be prepared to find the boot menu data if the stage2
            bootloader expands toward its 24 block limit

      Why load the previous block?
        - the "flag" and "timeout" values that are stored by the zipl tool are 
            found at offsets prior to the boot menu banner

      Why load the next block?
        - this is a "just in case" measure when the boot menu entries span 
            multiple blocks (it *should not* span more than two)

menu.c

  - separated some things into separate functions and added a few comments

menu.h

  - defined offsets for the zipl flag and timeout values

libc.c

  - created a wrapper for itostr that throws an assertion if provided array
      is too small

ipl.c

  - timeout is now stored as big endian

  - set_boot_menu function is passed the iplb and now has a single
      invocation (instead of one for each device type)

  - loadparm interpretation is reverted to a similar design in v1. i.e.
      we compare its value in pc-bios. This makes the most sense when 
      compared to the design in v2.

--- [Summary] ---

These patches implement a boot menu for ECKD DASD and SCSI guests on s390x. 
The menu will only appear if the disk has been configured for IPL with the 
zIPL tool and with the following QEMU command line options:

    -boot menu=on[,splash-time=X] and/or -machine loadparm='prompt'

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

A loadparm other than 'prompt' will disable the menu and just boot 
the specified entry.

If no boot options are specified, we will attempt to use the values
provided by zipl (ECKD DASD only).

Collin L. Walling (8):
  s390-ccw: update libc
  s390-ccw: ipl structs for eckd cdl/ldl
  s390-ccw: parse and set boot menu options
  s390-ccw: interactive boot menu for eckd dasd (menu setup)
  s390-ccw: interactive boot menu for eckd dasd (read stage2 data)
  s390-ccw: interactive boot menu for eckd dasd (print menu)
  s390-ccw: interactive boot menu for eckd dasd (read input)
  s390-ccw: interactive boot menu for scsi

 hw/s390x/ipl.c              |  54 ++++++++++
 hw/s390x/ipl.h              |  11 +-
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  | 145 ++++++++++++++++++++++----
 pc-bios/s390-ccw/bootmap.h  |  72 +++++++------
 pc-bios/s390-ccw/iplb.h     |  11 +-
 pc-bios/s390-ccw/libc.c     |  83 +++++++++++++++
 pc-bios/s390-ccw/libc.h     |  31 ++++++
 pc-bios/s390-ccw/main.c     |  41 +++++---
 pc-bios/s390-ccw/menu.c     | 240 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h     |  35 +++++++
 pc-bios/s390-ccw/s390-ccw.h |   2 +
 pc-bios/s390-ccw/sclp.c     |  30 ++++--
 pc-bios/s390-ccw/virtio.c   |   2 +-
 14 files changed, 679 insertions(+), 80 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.c
 create mode 100644 pc-bios/s390-ccw/menu.c
 create mode 100644 pc-bios/s390-ccw/menu.h

-- 
2.7.4
