Received: from eggs.gnu.org ([2001:4830:134:3::10]:56476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3bpz-0000l2-6l
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3bpw-0002Ug-38
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d3bpv-0002U2-Q0
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R5IdUS135667
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:19:26 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2xcmb7xg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:19:26 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 15:19:23 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 10:48:18 +0530
Message-Id: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/6] The series enables Multi-Threaded TCG
 on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

Patch 01: Use atomic_cmpxchg in store conditional
      02: Handle first write to page during atomic operation
      03: Generate memory barriers for sync/isync and load/store conditional
      04: Fix CPU unplug in MTTCG
      05: Enable MTTCG by default on PPC64
      06: Fixes a bug in PPC where the reservation is reset 
          causing atomic operations to never succeed 

Patches are based on ppc-for-2.10

Changelog:
v2: 
* David found problem related to clang and "make check" that was 
  root caused to a tcg bug and the patch is in mainline:

  79b1af9 tcg: Initialize return value after exit_atomic

* Fixed a bug in ppc_cpu_exec_enter(), which was resetting the 
  reserve_addr, this should be done in powerpc_excp()

v1:
* Rewrote store_conditional as suggested by Richard

Bharata B Rao (1):
  cpus: Fix CPU unplug for MTTCG

Nikunj A Dadhania (5):
  target/ppc: Emulate LL/SC using cmpxchg helpers
  cputlb: handle first atomic write to the page
  target/ppc: Generate fence operations
  tcg: enable MTTCG by default for PPC64 on x86
  target/ppc: do not reset reserve_addr in exec_enter

 configure                   |  2 ++
 cpus.c                      |  6 ++++++
 cputlb.c                    |  8 +++++++-
 target/ppc/cpu.h            |  2 ++
 target/ppc/excp_helper.c    |  3 +++
 target/ppc/translate.c      | 37 +++++++++++++++++++++++++++++++------
 target/ppc/translate_init.c |  9 ---------
 7 files changed, 51 insertions(+), 16 deletions(-)

-- 
2.9.3
