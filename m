Received: from eggs.gnu.org ([2001:4830:134:3::10]:43932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wr-0002XP-C0
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wm-0006UF-Hj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:25 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:21 +0100
Message-Id: <20180209092524.31348-27-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 26/29] s390x/pci: use the right pal and pba in
 reg_ioat()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

When registering ioat, pba should be comprised of leftmost 52 bits and
rightmost 12 binary zeros, and pal should be comprised of leftmost 52
bits and right most 12 binary ones. The lower 12 bits of words 5 and 7
of the FIB are ignored by the facility. Let's fixup this.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Message-Id: <20180205072258.5968-4-zyimin@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
2.13.6
