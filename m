Received: from eggs.gnu.org ([2001:4830:134:3::10]:34402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gZbPZ-0006VE-CY
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gZbPW-0007gW-4F
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:57:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50292
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gZbPU-0007e7-55
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:57:12 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBJCnYfn070763
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 07:57:10 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pfmnkdgxf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 07:57:10 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 19 Dec 2018 12:57:09 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 19 Dec 2018 13:57:04 +0100
Message-Id: <1545224225-24267-1-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v5] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

After the last review round I corrected the commit message
and use the sizeof of the target entries in the fmb_di_update()
function.

Regards,
Pierre

Yi Min Zhao (1):
  s390x/pci: add common function measurement block

 hw/s390x/s390-pci-bus.c  |   4 +-
 hw/s390x/s390-pci-bus.h  |  29 +++++++++++
 hw/s390x/s390-pci-inst.c | 129 +++++++++++++++++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.h |   1 +
 4 files changed, 159 insertions(+), 4 deletions(-)

-- 
2.7.4

Changelog:

from v4:
- commit message
- use sizeof target of the fmb_do_update

from v3:
- changed commit message according to Conny's comments

In s390-pci-inst.c
- simplify the fmb_do_update() to handle
  all cases from byte to quad. (Conny)

from v2:
In s390-pci-bus:
- Initialize the FMB Format.

In s390-pci-bus.h
- re-organization of the internal counters, having a table for the
  internal counters.

In s390-pci-inst.c
- Internal counters update (LD/ST/STB/RPCIT) is done always.
  even if the FMB if fmb_addr is NULL.
  AFAIU this respect the documentation which only states that FMB
  update is stopped.
- in mpcifc_service_call(), moved the setting of fmb_addr after
  the timer has been stopped.
- fmb_update((), use address_space_stq_be() to handle endianness
  when storing the FMB.
- define the format with 32 bits instead of one char and reserved
  chars, this is easier to handle the FMB copy.
- No update of the DMA fields inside the FMB, as stipulated by the
  documentation when format32 is 0.
