Received: from eggs.gnu.org ([2001:4830:134:3::10]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwN4w-0005e1-BC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwN4r-0000y0-O2
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:09:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cwN4r-0000xd-DX
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:08:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3763xpS081860
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 02:08:54 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29p4qphkkf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 02:08:54 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 7 Apr 2017 16:08:51 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  7 Apr 2017 11:37:49 +0530
Message-Id: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Enable MTTCG on PPC64
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

Changelog:
v1:
* Rewrote store_conditional as suggested by Richard

Tested using following:
./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic -machine pseries,usb=off -m 2G  -smp 8,cores=8,threads=1 -accel tcg,thread=multi  f23.img

Todo:
* Implement lqarx and stqcx
* Enable other machine types and PPC32.
* More testing for corner cases.

Nikunj A Dadhania (3):
  target/ppc: Emulate LL/SC using cmpxchg helpers
  cputlb: handle first atomic write to the page
  target/ppc: Generate fence operations

 cputlb.c               |  8 +++++++-
 target/ppc/translate.c | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.9.3
