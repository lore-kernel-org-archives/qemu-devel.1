Received: from eggs.gnu.org ([2001:4830:134:3::10]:58953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eC3md-0003Fq-TX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eC3md-0008O6-1I
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:19:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1eC3mc-0008Ll-PJ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:19:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7DIm1i110472
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 08:19:08 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3b239ed5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 08:19:08 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Tue, 7 Nov 2017 13:19:05 -0000
From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Date: Tue,  7 Nov 2017 18:48:58 +0530
Message-Id: <1510060738-25975-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1] spapr_pci: fix the path while fetching
 loc-code from host DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: s1seetee@linux.vnet.ibm.com

The function spapr_phb_vfio_get_loc_code uses wrong path for
fetching loc-code from host DT

this is the call that needs to be fixed:
/* Construct and read from host device tree the loc-code */
path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 hw/ppc/spapr_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5a3122a..ae86322 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -762,7 +762,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice *pdev)
     g_free(path);
 
     /* Construct and read from host device tree the loc-code */
-    path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
+    path = g_strdup_printf("/proc/device-tree/%s/ibm,loc-code", buf);
     g_free(buf);
     if (!g_file_get_contents(path, &buf, NULL, NULL)) {
         goto err_out;
-- 
1.8.3.1
