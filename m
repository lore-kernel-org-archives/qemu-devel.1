Received: from eggs.gnu.org ([2001:4830:134:3::10]:56372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1f46UA-0001Pc-I9
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1f46U7-0007v6-E6
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57432
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1f46U7-0007ua-7r
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35F3IZP144696
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 11:07:29 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h5nuu9b6y-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 11:07:29 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Thu, 5 Apr 2018 16:07:27 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu,  5 Apr 2018 17:07:21 +0200
Message-Id: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/3] s390: Fix virtio-scsi IPL quirks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

IPL from virtio-scsi currently uses a non-standard parameter
type definition to pass boot parameters from QEMU to the
BIOS.

There are two potential issues with this approach:
o If the guest operating systems requests a re-ipl of type CCW
  where the boot device is a virtio-scsi HBA, this goes unnoticed
  by QEMU. The BIOS will detect that it's IPLing from a SCSI
  device, but it will boot the first LUN found, which might not
  be the one used for the initial boot.
o The guest operating system can be confused by an unknown
  IPL parameter block type. If the OS hasn't previously used 
  diag308 to store the IPL info but is changed to do so, a
  user-observable change in behavior will happen.

The following patches address the issues above. 

Viktor Mihajlovski (3):
  s390: Refactor IPL parameter block generation
  s390: Ensure IPL from SCSI works as expected
  s390: Do not pass inofficial IPL type to the guest

 hw/s390x/ipl.c             | 112 ++++++++++++++++++++++++++++++++-------------
 pc-bios/s390-ccw/bootmap.c |   7 +++
 pc-bios/s390-ccw/iplb.h    |  15 +++++-
 3 files changed, 100 insertions(+), 34 deletions(-)

-- 
1.9.1
