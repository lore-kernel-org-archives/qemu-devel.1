Received: from eggs.gnu.org ([209.51.188.92]:51238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1grnTs-0005Bn-3u
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1grnTr-0005zU-Aa
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:28:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1grnTq-0005tK-Vh
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:28:55 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x17HOZxC038407
	for <qemu-devel@nongnu.org>; Thu, 7 Feb 2019 12:28:45 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qgqnhw8vy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 12:28:44 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Feb 2019 17:28:42 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 07 Feb 2019 18:28:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154956051753.218871.1505640778712413716.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH] spapr_pci: Fix interrupt leak in
 rtas_ibm_change_msi() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org

Now that IRQ allocation has been split in two (first allocate IRQ numbers,
then claim them), if the claiming fails, we must release the IRQs.

Fixes: 4fe75a8ccd80 "spapr: split the IRQ allocation sequence"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 41d81f4a8500..6fe3c10c8d4c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -393,6 +393,12 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     for (i = 0; i < req_num; i++) {
         spapr_irq_claim(spapr, irq + i, false, &err);
         if (err) {
+            if (i) {
+                spapr_irq_free(spapr, irq, i + 1);
+            }
+            if (!smc->legacy_irq_allocation) {
+                spapr_irq_msi_free(spapr, irq, req_num);
+            }
             error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                               config_addr);
             rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
