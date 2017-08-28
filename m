Received: from eggs.gnu.org ([2001:4830:134:3::10]:55388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2l-000813-DB
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2f-00062J-1d
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36184
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmF2e-000620-Sv
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S844RG094354
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:04 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmb2r25yw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:03 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:05:00 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v7S84xEV41418986
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:04:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v7S84n3p025809
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:04:50 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 10:04:44 +0200
In-Reply-To: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
Message-Id: <1503907487-2764-2-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/4] s390x/pci: fixup trap_msix()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, agraf@suse.de, richard.henderson@linaro.org, zyimin@linux.vnet.ibm.com

The function trap_msix() is to check if pcistg instruction would access
msix table entries. The correct boundary condition should be
[table_offset, table_offset+entries*entry_size). But the current
condition calculated misses the last entry. So let's fixup it.

Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b7beb8c36a..eba9ffb5f2 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -440,8 +440,8 @@ static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
 {
     if (pbdev->msix.available && pbdev->msix.table_bar == pcias &&
         offset >= pbdev->msix.table_offset &&
-        offset <= pbdev->msix.table_offset +
-                  (pbdev->msix.entries - 1) * PCI_MSIX_ENTRY_SIZE) {
+        offset < (pbdev->msix.table_offset +
+                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
         return 1;
     } else {
         return 0;
-- 
2.11.0 (Apple Git-81)
