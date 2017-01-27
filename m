Received: from eggs.gnu.org ([2001:4830:134:3::10]:46486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cX1WQ-0006FP-OH
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cX1WN-0001P0-JU
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cX1WN-0001OO-Aw
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0R7xjxv103615
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:04:33 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 287vabb40y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:04:33 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 27 Jan 2017 18:04:31 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 13:33:31 +0530
Message-Id: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/2] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

Hi,

Here is the next version of round-to-odd rounding mode implementation.

In this version I have addressed the reveiw comments from v1 and added
a new patch to take care of 64 bit rounding in underflow case. This
fix was found necessary when comparing the result of PowerPC ISA 3.0
instruction xscvqpdp between QEMU implementation and a known-good
implementation.

I have tested these patches and compared the results of
xsaddqp[o], xsmulqp[o], xsdivqp[o] and xscvqpdp[0] between QEMU
implementation and a known-good implementation.

I wanted to test with RISU to check if any older floating point
instructions (prior to PowerPC ISA v3.0) were affected by these
rounding changes. But even without my patchset, I am seeing RISU
reporting failures between QEMU implementation and P8 hardware.
While I am investigating the cause for these failures, I also plan
to do RISU verification for ISA 3.0 instructions with a known good
implementation.

Changes in v2:
-------------
- Do odd or even for the right precision bit in 64bit rounding. (Peter Maydell)
- Handle the overflow case correctly in 64bit rounding. (Peter Maydell)
- Add a patch to handle underflow case correctly in 64bit rounding.
 
v1: http://patchwork.ozlabs.org/patch/717562/

Bharata B Rao (2):
  softfloat: Handle float64 rounding properly for underflow case
  softfloat: Add round-to-odd rounding mode

 fpu/softfloat.c         | 34 +++++++++++++++++++++++++++++++++-
 include/fpu/softfloat.h |  2 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.7.4
