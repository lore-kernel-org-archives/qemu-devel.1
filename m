Received: from eggs.gnu.org ([2001:4830:134:3::10]:50156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1egSVn-0001v3-Vs
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1egSVk-00036n-0l
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1egSVj-00036N-PA
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:27 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0U9l5L5137477
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 04:47:26 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ftkcyqrcx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 04:47:26 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 30 Jan 2018 04:47:23 -0500
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 30 Jan 2018 10:47:15 +0100
In-Reply-To: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
Message-Id: <20180130094715.11578-4-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] s390x/pci: use the right pal and pba in
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
bits and right most 12 binary ones. Let's fixup this.

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
