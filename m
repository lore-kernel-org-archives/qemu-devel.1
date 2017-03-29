Received: from eggs.gnu.org ([2001:4830:134:3::10]:50800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1ct5ki-0006ZG-9j
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1ct5kh-0005Os-BL
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:02:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1ct5kh-0005NN-1o
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:02:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2T4wuOt078475
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 01:02:30 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ft0byv4u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 01:02:30 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Wed, 29 Mar 2017 15:02:27 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Wed, 29 Mar 2017 16:01:27 +1100
Message-Id: <cover.1490763676.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] target/ppc: Improve accuracy of guest HTM
 availability on P8s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, thuth@redhat.com


Hi QEMU,

See the patch itself for a description of the issue it's fixing.

Additionally, I've done some investigation on the effect of the patch on older
kernels. The discussion below only refers to the situation in which the
existing workaround would have an effect (system is P8, KVM is HV and KVM does
not indicate support for HTM):

PPC_FEATURE2_HTM has existed since mid 2013 [1], and at that time it was
unconditionally set for P8: nothing will change here because the new test will
always be true, always allowing the workaround to activate. The patch doesn't
help here.

In early 2016 [2] PPC_FEATURE2_HTM was linked to the HTM bit of
ibm,pa-features: the patch will help from here onwards.

So the patch doesn't fix all situations but it doesn't break any either, and it
fixes versions going forward.

Cheers,
Sam.

1: Around kernel commit cbbc6f1b1433ef553d57826eee87a84ca49645ce (v3.10-rc1)
2: Around kernel commit 4705e02498d6d5a7ab98dfee9595cd5e91db2017 (v4.6-rc1)


Sam Bobroff (1):
  target/ppc: Improve accuracy of guest HTM availability on P8s

 target/ppc/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.12.1.382.gc0f9c7058
