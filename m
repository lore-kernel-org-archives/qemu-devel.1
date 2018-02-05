Received: from eggs.gnu.org ([2001:4830:134:3::10]:44122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eib7k-0007YB-HL
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eib7g-0000sK-He
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39312
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1eib7g-0000s5-CK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:28 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w157JY4r082799
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 02:23:24 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fxepxqdky-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 02:23:23 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 02:23:23 -0500
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon,  5 Feb 2018 15:22:58 +0800
In-Reply-To: <20180205072258.5968-1-zyimin@linux.vnet.ibm.com>
References: <20180205072258.5968-1-zyimin@linux.vnet.ibm.com>
Message-Id: <20180205072258.5968-4-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/3] s390x/pci: use the right pal and pba in
 reg_ioat()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, marcel@redhat.com, zyimin@linux.vnet.ibm.com

When registering ioat, pba should be comprised of leftmost 52 bits and
rightmost 12 binary zeros, and pal should be comprised of leftmost 52
bits and right most 12 binary ones. The lower 12 bits of words 5 and 7
of the FIB are ignored by the facility. Let's fixup this.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 997a9cc2e9..3fcc330fe3 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -865,6 +865,8 @@ static int reg_ioat(CPUS390XState *env, S390PCIIOMMU *iommu, ZpciFib fib,
     uint8_t dt = (g_iota >> 2) & 0x7;
     uint8_t t = (g_iota >> 11) & 0x1;
 
+    pba &= ~0xfff;
+    pal |= 0xfff;
     if (pba > pal || pba < ZPCI_SDMA_ADDR || pal > ZPCI_EDMA_ADDR) {
         s390_program_interrupt(env, PGM_OPERAND, 6, ra);
         return -EINVAL;
-- 
2.14.3 (Apple Git-98)
