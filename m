Received: from eggs.gnu.org ([2001:4830:134:3::10]:47335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintU-0005fK-72
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintR-0003MU-5X
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38766
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eintQ-0003LT-W0
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15KxUVL128197
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 16:01:34 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fxuj87k1e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 16:01:32 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 16:01:32 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon,  5 Feb 2018 15:57:14 -0500
Message-Id: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 00/12]Interactive Boot Menu for DASD and
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

--- [v5] ---

Note: some areas outside of this patch series could use some 
cleanup/refactoring/revisiting, but I'd like to defer that to a different
series that touches on those areas (if we try to address them all, then
this series will never be finished!)

As for the irq drain solution introduced with this version, it is invoked 
where the possibility of pending irqs is most likely. Ideally we'd like 
to call this somewhere toward the end of the IPL process, but it requires 
some refactoring of code that is better suited for another patch series.

*** - introduced Viktor's patch which includes a QEMU IPLB
      - boot menu options are stored here
*** - we now drain all pending irqs after getting boot index
*** - lib.c functions will not handle negative numbers and are documented as such
      - reason: negative number conversions are not needed in s390-ccw bios
      - it just bloats the code -- it's easier to just maintain the cases we need
      - removed wrapper for itostr and placed asserts inside itostr
    - various code cleanups
      - removed superfluous parens
      - eckd_block_num now uses CHS ptr
      - cleaned up read_prompt (moved buffer add and echo to default case)
      - cleaned up zipl configuration parameter logic
      - condensed scsi program table entries counter
      - moved stage1, 1b, and seekarg structs to patch "read stage2 boot..."
      - s/BOOT_MENU_FLAG_BOOT_OPTS/BOOT_MENU_FLAG_CMD_OPTS
        - this makes a little more sense as to where these fields came from
      - moved loadparm defines to main.c, as that is the only file that needs them
      - s/2017/2018 :)


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
  s390-ccw: clear pending irqs
  s390-ccw: interactive boot menu for scsi

 hw/s390x/ipl.c              |  70 +++++++++++-
 hw/s390x/ipl.h              |  16 ++-
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  | 175 +++++++++++++++++++++---------
 pc-bios/s390-ccw/bootmap.h  |  89 ++++++++++------
 pc-bios/s390-ccw/iplb.h     |  14 ++-
 pc-bios/s390-ccw/libc.c     |  91 ++++++++++++++++
 pc-bios/s390-ccw/libc.h     |  35 +++++-
 pc-bios/s390-ccw/main.c     |  48 ++++++---
 pc-bios/s390-ccw/menu.c     | 252 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h     |  25 +++++
 pc-bios/s390-ccw/s390-ccw.h |   3 +
 pc-bios/s390-ccw/sclp.c     |  41 +++++--
 pc-bios/s390-ccw/virtio.c   |   2 +-
 14 files changed, 746 insertions(+), 117 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.c
 create mode 100644 pc-bios/s390-ccw/menu.c
 create mode 100644 pc-bios/s390-ccw/menu.h

-- 
2.7.4
