Received: from eggs.gnu.org ([2001:4830:134:3::10]:47837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eXce9-0000Vj-2G
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 19:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eXce4-0002IY-WA
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 19:47:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eXce4-0002GY-FW
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 19:47:32 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w060i2gw004395
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 19:47:30 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fajpmar6k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:47:29 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 19:47:28 -0500
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Fri,  5 Jan 2018 22:47:21 -0200
Message-Id: <20180106004722.1152-1-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] Check SMT based on KVM_CAP_PPC_SMT_POSSIBLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

If one defines a P9 guest like -smp sockets=1,cores=1,threads=8 QEMU will silently changes threads to 4:

(guest) # lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    4
Core(s) per socket:    1
Socket(s):             1
NUMA node(s):          1
...
(qemu) info cpus
* CPU #0: nip=0xc0000000000db9cc thread_id=9440
  CPU #1: nip=0xc0000000000db9cc thread_id=9441
  CPU #2: nip=0xc0000000000db9cc thread_id=9442
  CPU #3: nip=0xc0000000000db9cc thread_id=9443
  CPU #4: nip=0x0000000000000100 (halted) thread_id=9444
  CPU #5: nip=0x0000000000000100 (halted) thread_id=9445
  CPU #6: nip=0x0000000000000100 (halted) thread_id=9446
  CPU #7: nip=0x0000000000000100 (halted) thread_id=9447

This behavior is causing confusion and QEMU will crash if one tries to hotplug a CPU. QEMU already has a number of SMT sane checking and this patch adds another one: it verifies if KVM supports (KVM_CAP_PPC_SMT_POSSIBLE) the required number of threads instead of impose a value defined in the compat table.

Result:
(guest) # lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-7
Thread(s) per core:    8
Core(s) per socket:    1
Socket(s):             1
...
(qemu) info cpus
* CPU #0: nip=0xc0000000000d30ac thread_id=80197
  CPU #1: nip=0xc0000000000d30ac thread_id=80198
  CPU #2: nip=0xc0000000000d30ac thread_id=80199
  CPU #3: nip=0xc0000000000d30ac thread_id=80200
  CPU #4: nip=0xc0000000000d30ac thread_id=80201
  CPU #5: nip=0xc0000000000d30ac thread_id=80202
  CPU #6: nip=0xc0000000000d30ac thread_id=80203
  CPU #7: nip=0xc0000000000d30ac thread_id=80204

This patch is based on ppc-for-2.12

Jose Ricardo Ziviani (1):
  spapr: Check SMT based on KVM_CAP_PPC_SMT_POSSIBLE

 hw/ppc/spapr.c       | 14 +++++++++++++-
 hw/ppc/trace-events  |  1 +
 target/ppc/kvm.c     |  5 +++++
 target/ppc/kvm_ppc.h |  6 ++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.14.1
