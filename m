Received: from eggs.gnu.org ([2001:4830:134:3::10]:60090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5Z5-0007DS-V0
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5Z2-0000KA-Rk
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cc5Z2-0000JU-IG
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1A7Iinq028753
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:14 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28h4cn90kp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:14 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 10 Feb 2017 17:24:11 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 10 Feb 2017 12:53:04 +0530
Message-Id: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/7] POWER9 TCG and softfloat enablements -
 part16 + s390 float fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

This series contains 2 new instructions (xscvqpudz, xscvqpuwz) and
round-to-odd variants of 6 instructions (xsaddqpo, xsmulqpo, xsdivqpo,
xscvqpdpo, xssqrtqpo, xssubqpo)
 
This also includes softfloat enhancements that are needed by
the above instructions. These softfloat patches have been posted
separately earlier and reviewed. Including them here as the new
instructions here depend on them.

I also saw that target-s390 also needs float128_to_uint64() and
float128_to_uint32(). Implemented the latter in this series and
made fixes in s390 code to use them. Note that s390 changes have
been compile-tested only. The last two patches ideally needn't
be part of this series, but included them here as s390 fixes
depend on the softfloat changes that are part of this patchset.

Bharata B Rao (7):
  softfloat: Add round-to-odd rounding mode
  softfloat: Add float128_to_uint64_round_to_zero()
  softfloat: Add float128_to_uint32_round_to_zero()
  target-ppc: Implement round to odd variants of quad FP instructions
  target-ppc: Add xscvqpudz and xscvqpuwz instructions
  softfloat: Add float128_to_uint32()
  target-s390: Use float128_to_uint[64/32] where required

 fpu/softfloat.c                     | 125 +++++++++++++++++++++++++++++++++++-
 include/fpu/softfloat.h             |   6 ++
 target/ppc/fpu_helper.c             |  44 ++++++-------
 target/ppc/helper.h                 |   2 +
 target/ppc/translate/vsx-impl.inc.c |   2 +
 target/ppc/translate/vsx-ops.inc.c  |   4 +-
 target/s390x/fpu_helper.c           |   6 +-
 7 files changed, 161 insertions(+), 28 deletions(-)

-- 
2.7.4
