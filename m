Received: from eggs.gnu.org ([2001:4830:134:3::10]:53082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJOV6-00065E-El
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJOV3-0005Fr-DW
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60296
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJOV3-0005Fd-7O
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vARIn5gv110656
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 13:51:21 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2egqhejcpp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 13:51:21 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 13:51:20 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 13:50:55 -0500
Message-Id: <1511808659-8846-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/4] Interactive Boot Menu for DASD and SCSI
 Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

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

Loadparm will override all boot options.

Collin L. Walling (4):
  s390-ccw: ipl structs for eckd cdl/ldl
  s390-ccw: parse and set boot menu options
  s390-ccw: interactive boot menu for eckd dasd
  s390-ccw: interactive boot menu for scsi

 hw/s390x/ipl.c              |  20 +++++++
 hw/s390x/ipl.h              |   8 ++-
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  | 106 ++++++++++++++++++++++++++++++-----
 pc-bios/s390-ccw/bootmap.h  |  57 ++++++++++++++-----
 pc-bios/s390-ccw/iplb.h     |   8 ++-
 pc-bios/s390-ccw/main.c     |  18 +++++-
 pc-bios/s390-ccw/menu.c     | 122 ++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |   7 +++
 pc-bios/s390-ccw/sclp.c     | 132 ++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 444 insertions(+), 36 deletions(-)
 create mode 100644 pc-bios/s390-ccw/menu.c

-- 
2.7.4
