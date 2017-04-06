Received: from eggs.gnu.org ([2001:4830:134:3::10]:58031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cw4aI-0002tb-8m
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cw4aD-0004EG-C4
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47160
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cw4aD-0004Ds-5e
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36ANu2p049127
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 06:24:03 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ngh2kqb2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 06:24:03 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 6 Apr 2017 20:24:00 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  6 Apr 2017 15:52:46 +0530
Message-Id: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

The series enables Multi-Threaded TCG on PPC64

Patch 01: Use atomic_cmpxchg in store conditional
      02: Handle first write to page during atomic operation
      03: Generate memory barriers for sync/isync and load/store conditional

Patches are based on ppc-for-2.10

Tested using following:
./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic -machine pseries,usb=off -m 2G  -smp 8,cores=8,threads=1 -accel tcg,thread=multi  f23.img

Todo:
* Enable other machine types and PPC32.
* More testing for corner cases.

Nikunj A Dadhania (3):
  target/ppc: Emulate LL/SC using cmpxchg helpers
  cputlb: handle first atomic write to the page
  target/ppc: Generate fence operations

 cputlb.c               |  8 +++++++-
 target/ppc/translate.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.9.3
