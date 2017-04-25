Received: from eggs.gnu.org ([2001:4830:134:3::10]:53382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2xza-00008J-8A
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2xzW-00015M-4U
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d2xzV-00013x-SK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PAcvvD041385
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:46:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a206kypjd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:46:39 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 25 Apr 2017 11:46:37 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 25 Apr 2017 12:46:22 +0200
Message-Id: <20170425104633.6130-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 00/11] s390x: support for LOADPARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Cornelia Huck <cornelia.huck@de.ibm.com>

This patchset implements the LOADPARM machine property. This is
exposed via SCLP and diagnose 308 to the guest. It will be used
by the bios to select a boot entry; guest operating systems can
use it as well.

Cornelia Huck (1):
  pc-bios/s390-ccw.img: update image

Eugene (jno) Dvurechenski (2):
  pc-bios/s390-ccw: Make ebcdic/ascii conversion public
  pc-bios/s390-ccw: add boot entry selection to El Torito routine

Farhan Ali (8):
  hw/s390x: provide loadparm property for the machine
  hw/s390x/ipl: enable LOADPARM in IPIB for a boot device
  hw/s390x/sclp: update LOADPARM in SCP Info
  util/qemu-config: Add loadparm to qemu machine_opts
  pc-bios/s390-ccw: get LOADPARM stored in SCP Read Info
  pc-bios/s390-ccw: provide a function to interpret LOADPARM value
  pc-bios/s390-ccw: provide entry selection on LOADPARM for SCSI disk
  pc-bios/s390-ccw: add boot entry selection for ECKD DASD

 hw/s390x/ipl.c                            |  31 ++++++++++++++++++++++--
 hw/s390x/ipl.h                            |   3 +++
 hw/s390x/s390-virtio-ccw.c                |  37 +++++++++++++++++++++++++++++
 hw/s390x/sclp.c                           |   9 +++++++
 include/hw/s390x/s390-virtio-ccw.h        |   1 +
 pc-bios/s390-ccw.img                      | Bin 26456 -> 26472 bytes
 pc-bios/s390-ccw/Makefile                 |   2 +-
 pc-bios/s390-ccw/bootmap.c                |  34 +++++++++++++++++---------
 pc-bios/s390-ccw/bootmap.h                |  24 +------------------
 pc-bios/s390-ccw/main.c                   |  38 +++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/s390-ccw.h               |  17 ++++++++++++-
 pc-bios/s390-ccw/{sclp-ascii.c => sclp.c} |  12 ++++++++++
 pc-bios/s390-ccw/sclp.h                   |   2 ++
 util/qemu-config.c                        |   6 +++++
 14 files changed, 177 insertions(+), 39 deletions(-)
 rename pc-bios/s390-ccw/{sclp-ascii.c => sclp.c} (87%)

-- 
2.11.0
