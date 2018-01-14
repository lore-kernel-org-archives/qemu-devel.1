Received: from eggs.gnu.org ([2001:4830:134:3::10]:33656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eant5-0000mD-E8
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eant2-0005Qy-8f
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eant2-0005QA-1E
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:08 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0EJNvl4071843
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:24:06 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fg00k71um-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:24:05 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sun, 14 Jan 2018 14:24:04 -0500
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sun, 14 Jan 2018 17:23:47 -0200
Message-Id: <20180114192349.22212-1-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Small fixes for SMT guests in Power9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, lvivier@redhat.com

v2:
 - divided in two patches:
    (1) enables smt8 mode to P9 guests
    (2) checks if host supports the # of threads/core required
        limitation: doesn't check guest running in compat mode

This patchset contains 2 changes:

(1) A P9 guest defined like -smp sockets=1,cores=1,threads=8 will be silently
changed to threads=4:

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

This patch enables P9 guests to use emulated smt because KVM supports it:

(guest) # lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-7
Thread(s) per core:    8
Core(s) per socket:    1
Socket(s):             1
NUMA node(s):          1

(qemu) info cpus
* CPU #0: nip=0xc0000000000d30ac thread_id=68400
  CPU #1: nip=0xc0000000000d30ac thread_id=68401
  CPU #2: nip=0xc0000000000d30ac thread_id=68402
  CPU #3: nip=0xc0000000000d30ac thread_id=68403
  CPU #4: nip=0xc0000000000d30ac thread_id=68404
  CPU #5: nip=0xc0000000000d30ac thread_id=68405
  CPU #6: nip=0xc0000000000d30ac thread_id=68406
  CPU #7: nip=0xc0000000000d30ac thread_id=68407

CPU hotplugging also works as expected:

(qemu) device_add host-spapr-cpu-core,id=core8,core-id=8
(qemu) info cpus
* CPU #0: nip=0xc0000000000d30ac thread_id=68400
  CPU #1: nip=0xc0000000000d30ac thread_id=68401
  CPU #2: nip=0xc0000000000d30ac thread_id=68402
  CPU #3: nip=0xc0000000000d30ac thread_id=68403
  CPU #4: nip=0xc0000000000d30ac thread_id=68404
  CPU #5: nip=0xc0000000000d30ac thread_id=68405
  CPU #6: nip=0xc0000000000d30ac thread_id=68406
  CPU #7: nip=0xc0000000000d30ac thread_id=68407
  CPU #8: nip=0xc0000000000d30ac thread_id=68492
  CPU #9: nip=0xc0000000000d30ac thread_id=68493
  CPU #10: nip=0xc0000000000d30ac thread_id=68494
  CPU #11: nip=0xc0000000000d30ac thread_id=68495
  CPU #12: nip=0xc0000000000d30ac thread_id=68496
  CPU #13: nip=0xc0000000000d30ac thread_id=68497
  CPU #14: nip=0xc0000000000d30ac thread_id=68498
  CPU #15: nip=0xc0000000000d30ac thread_id=68499

(guest) # lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    8
Core(s) per socket:    2
Socket(s):             1
NUMA node(s):          1

(2) Checks if KVM supports the number of threads required

If users try to pass more threads/core than the host supports it displays an
error message and quits:

qemu-system-ppc64: KVM does not support 8 threads/core.
Available VSMT modes: 4 2 1.

Jose Ricardo Ziviani (2):
  ppc: Change Power9 compat table to support at most 8 threads/core
  ppc: spapr: Check if thread argument is supported by host KVM

 hw/ppc/spapr.c       | 10 ++++++++++
 target/ppc/compat.c  |  2 +-
 target/ppc/kvm.c     |  5 +++++
 target/ppc/kvm_ppc.h |  6 ++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.14.3
