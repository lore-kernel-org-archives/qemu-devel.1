Received: from eggs.gnu.org ([2001:4830:134:3::10]:58363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gXqiq-0003fH-VJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gXqin-0000on-NZ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:53:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46658
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gXqil-0000kr-Hk
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:53:52 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBEGmfmm020379
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:53:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pcg7g8nd4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:53:48 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 14 Dec 2018 16:53:46 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 14 Dec 2018 17:53:41 +0100
Message-Id: <1544806422-21418-1-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3] s390x/pci: add common fmb
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

After the last review round I worked on endianness.
Doing this I found some errors in the code and in the interpretation
of the documentation.
  
The new patch changed the following from previous version:
 
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

Patch is tested (for the good case) on Z(KVM) and X(TCG).

Yi Min Zhao (1):
  s390x/pci: add common function measurement block

 hw/s390x/s390-pci-bus.c  |   4 +-
 hw/s390x/s390-pci-bus.h  |  29 ++++++++++
 hw/s390x/s390-pci-inst.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.h |   1 +
 4 files changed, 171 insertions(+), 4 deletions(-)

-- 
2.7.4
